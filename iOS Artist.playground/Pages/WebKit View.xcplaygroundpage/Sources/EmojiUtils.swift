//
// This file (and all other Swift source files in the Sources directory of this playground) will be precompiled into a framework which is automatically made available to MyPlayground.playground.
//
import Darwin

public extension Array {
    func sample() -> Element {
        let randomIndex = Int(arc4random()) % count
        return self[randomIndex]
    }
}
public class EmojiUtil {
    static func emoji(at index:Int) -> String {
        let emojiDescription = UnicodeScalar(index)?.description
        let emoji = emojiDescription ?? "x"
        return emoji
    }
    
    static func commonEmojis() -> [String] {
        let emoticons = (0x1F601...0x1F64F).map({ emoji(at: $0) })
        let dingbats = (0x2702...0x27B0).map({ emoji(at: $0) })
        let transports = (0x1F680...0x1F6C0).map({ emoji(at: $0) })
        let transports2 = (0x1F681...0x1F6C5).map({ emoji(at: $0) })
//        let chars = (0x1F170...0x1F251).map({ emoji(at: $0) })
//        let uncategorized2 = (0x2122...0x3299).map({ emoji(at: $0) })
//        let uncategorized = (0x1F004...0x1F5FF).map({ emoji(at: $0) })
//        let others = (0x1F30D...0x1F567).map({ emoji(at: $0) })
        
        let commonEmojis = emoticons
                        + dingbats
                        + transports
                        + transports2
                        //+ chars
                        //+ uncategorized
                        //+ uncategorized2
                        //+ others
        return commonEmojis
    }
    
    public static func randomEmoji() -> String {
        return commonEmojis().sample()
    }
}
