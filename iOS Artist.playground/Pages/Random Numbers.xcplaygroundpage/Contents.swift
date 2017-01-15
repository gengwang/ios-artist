/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Rock-Paper-Scissors: Random Numbers
 See [Wikipedia](https://en.wikipedia.org/wiki/Rock%E2%80%93paper%E2%80%93scissors) for details of this game.
 */

import Foundation

enum RPSElement: String {
    case rock = "🗿"
    case paper = "📜"
    case scissors = "✂️"
}

/// Stores the Rock-Paper-Scissors enumerations in an array so that we can access them by index
let RPSHands = [ RPSElement.rock,
                 RPSElement.paper,
                 RPSElement.scissors ]

for i in 0...9 {
    /// Generate a UInt32 in the range of [0, 2] and wrap it in an Int so that we can use it as an index for the array
    let index = Int(arc4random_uniform(3))
    let hand = RPSHands[ index ]
}
/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
