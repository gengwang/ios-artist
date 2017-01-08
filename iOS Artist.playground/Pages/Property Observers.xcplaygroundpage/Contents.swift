/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Property Observers
 */

import Foundation

//:### `willSet(newValue)` and `didSet(oldValue)`
var k = 2 {
    willSet(newValue) {
        print("k: newValue: \(newValue); current value: \(k)")
    }
    didSet(oldValue) {
        print("k: oldValue: \(oldValue); current value: \(k)")
    }
}

k = 3

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */

