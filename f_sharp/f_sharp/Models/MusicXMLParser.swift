import Foundation

/**
 A parser for MusicXML files, converting XML string data into structured MusicSymbol objects.

 This parser utilizes the Foundation XMLParser and implements a delegate pattern
 to process MusicXML elements such as notes, rests, clefs, and time signatures,
 and convert them into corresponding Swift objects for further use in the application.
 */
class MusicXMLParser {
    
    /**
     Parses a MusicXML string and returns an array of MusicSymbol objects.
     
     - Parameters:
        - xmlString: The MusicXML data as a string.
     
     - Returns: An array of MusicSymbol objects representing the parsed XML data.
     */
    func parseMusicXML(_ xmlString: String) -> [MusicSymbol] {
        var parsedObjects: [MusicSymbol] = []
        
        let parser = XMLParser(data: xmlString.data(using: .utf8)!)
        let delegate = MusicXMLParserDelegate()
        parser.delegate = delegate
        
        parser.parse()
        
        parsedObjects.append(contentsOf: delegate.parsedObjects)
        print(parsedObjects)
        
        return parsedObjects
    }
}

/**
 Delegate for the MusicXMLParser, implementing the XMLParserDelegate protocol.
 
 This class is responsible for the detailed processing of the XML elements encountered
 by the XMLParser, constructing MusicSymbol objects based on the element data.
 */
class MusicXMLParserDelegate: NSObject, XMLParserDelegate {
    var parsedObjects: [MusicSymbol] = []
    var currentElement = ""
    var currentAttributes: [String: String] = [:]
    
    var currentDuration: Int?
    var currentTone: String?
    var isRest: Bool = false
    
    var currentBeats: Int?
    var currentBeatType: Int?
    var currentClefSign: String?
    var currentClefLine: Int?
    
    /**
     Called by the parser object when it encounters the start of an element.
     
     - Parameters:
        - parser: The parser calling the method.
        - elementName: The name of the encountered element.
        - namespaceURI: The namespace URI of the element.
        - qName: The qualified name of the element.
        - attributeDict: A dictionary containing any attributes associated with the element.
     */
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        currentElement = elementName
        currentAttributes = attributeDict
        
        if elementName == "note" {
            currentDuration = nil
            currentTone = nil
            isRest = false
        }
    }
    
    /**
     Called by the parser object when it encounters characters between the start and end tags of an element.
     
     - Parameters:
        - parser: The parser calling the method.
        - string: The character data encountered.
     */
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
    
    /**
     Called by the parser object when it encounters the end of an element.
     
     - Parameters:
        - parser: The parser calling the method.
        - elementName: The name of the element.
        - namespaceURI: The namespace URI of the element.
        - qName: The qualified name of the element.
     */
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
