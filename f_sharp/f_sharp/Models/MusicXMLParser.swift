import Foundation

class MusicXMLParser {
    
    func parseMusicXML(_ xmlString: String) -> [MusicSymbol] {
        // Placeholder for parsed objects
        var parsedObjects: [MusicSymbol] = []
        
        // Initialize XML parser with the provided string
        let parser = XMLParser(data: xmlString.data(using: .utf8)!)
        let delegate = MusicXMLParserDelegate()
        parser.delegate = delegate
        
        // Start parsing
        parser.parse()
        
        // Retrieve parsed data from delegate
        parsedObjects.append(contentsOf: delegate.parsedObjects)
        
        return parsedObjects
    }
}

class MusicXMLParserDelegate: NSObject, XMLParserDelegate {
    var parsedObjects: [MusicSymbol] = []
    var currentElement = ""
    var currentAttributes: [String: String] = [:]
    
    var currentDuration: Int?
    var currentTone: String?
    var isRest: Bool = false
    
    // Temporary storage for Time and Clef information
    var currentBeats: Int?
    var currentBeatType: Int?
    var currentClefSign: String?
    var currentClefLine: Int?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        currentElement = elementName
        currentAttributes = attributeDict
        if elementName == "note" {
            // Prepare for a new note
            currentDuration = nil
            currentTone = nil
            isRest = false
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedString.isEmpty { return }
        
        switch currentElement {
        case "beats":
            currentBeats = Int(trimmedString)
        case "beat-type":
            currentBeatType = Int(trimmedString)
        case "sign":
            currentClefSign = trimmedString
        case "line":
            currentClefLine = Int(trimmedString)
        case "duration":
            currentDuration = Int(trimmedString)
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "time" {
            if let beats = currentBeats, let beatType = currentBeatType {
                let time = Time(beats: beats, beatType: beatType)
                parsedObjects.append(time)
                currentBeats = nil
                currentBeatType = nil
            }
        } else if elementName == "clef" {
            if let sign = currentClefSign, let line = currentClefLine {
                let clefType = (sign == "G" && line == 2) ? 0 : 1 // Simplified mapping for example
                let clef = Clef(clefType: clefType, keySignature: "N/A") // Key signature not handled here
                parsedObjects.append(clef)
                currentClefSign = nil
                currentClefLine = nil
            }
        } else if elementName == "rest" {
            isRest = true
        } else if elementName == "note" {
            if let duration = currentDuration {
                let note = isRest ? Rest(duration: duration) : MusicNote(duration: duration, tone: currentTone)
                parsedObjects.append(note)
            }
        } else if elementName == "measure" {
            let barline = Barline(barlineType: 0) // Simplified, assuming a single barline type
            parsedObjects.append(barline)
        }
        
        currentElement = ""
    }
}
