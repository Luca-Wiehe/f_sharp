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
        print("parsedObjects: \(parsedObjects)")
        
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
    
    var currentIntDuration: Int?
    var currentNoteDuration: NoteDuration = .unknown
    var isCurrentNoteDotted: Bool = false
    var currentTone: String?
    var isRest: Bool = false
    
    var currentDivisions: Int?
    
    var currentBeats: Int?
    var currentBeatType: Int?
    var currentClefSign: String?
    var currentClefType: ClefType = .unknown
    
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
            currentIntDuration = 0
            currentTone = nil
            isRest = false
        } else if elementName == "attributes" {
            // Reset the currentDivisions value for each new <attributes> element
            currentDivisions = nil
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
            print("Obtaining beats: \(trimmedString)")
            self.currentBeats = Int(trimmedString)
        case "beat-type":
            currentBeatType = Int(trimmedString)
        case "sign":
            currentClefSign = trimmedString
        case "duration":
            currentIntDuration = Int(trimmedString)
        case "divisions":
            // Here we capture the divisions value when we are within the <divisions> element
            if currentDivisions == nil { // Only set if not already set, or reset based on your needs
                currentDivisions = Int(trimmedString)
            }
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
            }
        } else if elementName == "clef" {
            if let sign = currentClefSign {
                switch sign {
                case "G":
                    currentClefType = .treble
                case "F":
                    currentClefType = .bass
                case "C":
                    currentClefType = .violin
                default:
                    currentClefType = .unknown
                }
                
                let clef = Clef(clefType: currentClefType, keySignature: "N/A") // Key signature not handled here
                parsedObjects.append(clef)
                currentClefSign = nil
            }
        } else if elementName == "rest" {
            isRest = true
        } else if elementName == "note" && currentIntDuration != nil {
            print("currentIntDuration: \(String(describing: currentIntDuration)), currentDivisions: \(String(describing: currentDivisions))")
            calcNoteDuration(duration: currentIntDuration ?? 0, divisions: currentDivisions ?? 1)
            if currentNoteDuration != .unknown {
                let note = isRest ? Rest(duration: currentNoteDuration) : MusicNote(duration: currentNoteDuration, tone: currentTone, isDotted: isCurrentNoteDotted)
                parsedObjects.append(note)
            }
        } else if elementName == "measure" {
            let barline = Barline(barlineType: .single) // Simplified, assuming a single barline type
            parsedObjects.append(barline)
        }
        
        currentElement = ""
    }
    
    private func calcNoteDuration(duration: Int, divisions: Int) {
        let beats = Double(duration) / Double(divisions)
        
        print("Int(beats): \(Int(beats)), currentBeats: \(String(describing: currentBeats))")
        
        if Int(beats) == currentBeats {
            currentNoteDuration = .full
            return
        }
        
        switch beats {
        case 0.25:
            currentNoteDuration = .sixteenth
            isCurrentNoteDotted = false
        case 0.5:
            currentNoteDuration = .eighth
            isCurrentNoteDotted = false
        case 0.75:
            currentNoteDuration = .eighth
            isCurrentNoteDotted = true
        case 1:
            currentNoteDuration = .quarter
            isCurrentNoteDotted = false
        case 1.5:
            currentNoteDuration = .quarter
            isCurrentNoteDotted = true
        case 2:
            currentNoteDuration = .half
            isCurrentNoteDotted = false
        case 3:
            currentNoteDuration = .half
            isCurrentNoteDotted = true
        case 4:
            currentNoteDuration = .full
            isCurrentNoteDotted = false
        default:
            currentNoteDuration = .unknown
        }
    }
}
