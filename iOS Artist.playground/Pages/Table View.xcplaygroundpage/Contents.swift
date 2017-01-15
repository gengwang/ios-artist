/*:
 [Previous](@previous) | [Next](@next)
 ****
 # A Table View
 */
import UIKit
import PlaygroundSupport

typealias PRSHand = (name: String, glyphs: [String])

let PRSGlyphs = [
    PRSHand("paper", ["📰", "📖", "📝", "💶", "💸", "💴", "💵", "💷", "🔖", "✉️", "📩", "📨", "📧", "💌", "📜", "📃", "📑", "📄", "📋", "🗒", "🗞", "📊", "📈", "📉", "📅", "📆", "🗓", "📇", "🗃", "📁", "📂", "🗂", "📓", "📕", "📗", "📘", "📙", "📔", "📒", "📚", "🎴"]),
    PRSHand("rock", ["🗿", "💍", "🌑", "🌘", "🌚", "🌋", "🗽", "💎", "🛡", "📿"]),
    PRSHand("scissors", ["✂️", "🔪", "🗡", "⚔"])
]

class MyTableViewController: UITableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return PRSGlyphs.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PRSGlyphs[section].glyphs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let text = PRSGlyphs[indexPath.section].glyphs[indexPath.row]
        cell.textLabel?.text = text
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return PRSGlyphs[section].name
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24.0
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return PRSGlyphs.map{$0.name}
    }
}

PlaygroundPage.current.liveView = MyTableViewController(style: .grouped)

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */


