import Foundation
import CryptoKit

print("Hello Testing")

let message = "The quick brown fox jumps over the lazy dog".data(using: .utf8)!

let hash = message.digest(using:.sha256)

extension Data {
    var hexString: String {
        return self.map { String(format: "%02x", $0) }.joined(separator: "")
    }
    
    init(hexString: String) {
        var bytes: [UInt8] = []
        
        // Divide into groups of 2 characters
        
        var lowerBoundIndex = hexString.startIndex
        var upperBoundIndex = hexString.startIndex
        
        repeat {
            lowerBoundIndex = upperBoundIndex
            upperBoundIndex = hexString.index(upperBoundIndex, offsetBy: 2, limitedBy: hexString.endIndex) ?? hexString.endIndex
            
            let characterCount = hexString.distance(from: lowerBoundIndex, to: upperBoundIndex)
            
            // Pad with 0 if only 1 character (Data is stored by bytes)
            let pad = characterCount < 2 ? "0" : ""
            
            let substring = hexString.substring(with: lowerBoundIndex ..< upperBoundIndex) + pad
            
            // Decode byte and append to bytes
            bytes.append(UInt8(substring, radix: 16) ?? 0x00)
        } while upperBoundIndex < hexString.endIndex
        
        self.init(bytes: bytes)
    }
}

print("sha256 of \(message) is \(hash.hexString)")
