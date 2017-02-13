/*:
[Previous](@previous) | [Next](@next)
****
# A WebKit View
 
References: 
 - [Introducing the Modern WebKit API - Apple WWDC 2014](https://youtu.be/ZC_rNie61IQ)
*/

import UIKit
import WebKit
import PlaygroundSupport

class AppController: UIViewController, UIGestureRecognizerDelegate {
    
    let config = WKWebViewConfiguration()
    var webView: WKWebView!
    var promptLabel: UILabel!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        
        // Display a local HTML file with the Webkit view
        let rect = CGRect(origin: self.view.bounds.origin, size: self.view.bounds.size)
        webView = WKWebView(frame: rect, configuration: config)
        do {
            let fileURL = Bundle.main.url(forResource: "index", withExtension: "html")
            let fileString = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
            webView.loadHTMLString(fileString, baseURL: fileURL)
        } catch let error {
            print("Error loading local html file: \(error)")
        }
        
//        webView.loadFileURL(fileURL!, allowingReadAccessTo: fileURL!)
        
        // Inject user script at document onload
        let source = "document.body.style.background = \"yellow\";show(\"♧\");"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        config.userContentController.addUserScript(script)
        self.view = webView
        
        promptLabel = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 44)))
        
        promptLabel.numberOfLines = 0
        promptLabel.textAlignment = .center
        promptLabel.font = UIFont.systemFont(ofSize: 24.0)
        promptLabel.textColor = UIColor.gray
        promptLabel.text = "Tap to see some emojis 🙃\n👆👆Double tap to zoom"
        self.view.addSubview(promptLabel)
        
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        let vConstraint = NSLayoutConstraint(item: promptLabel, attribute: .centerY, relatedBy: .equal, toItem: promptLabel.superview, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        let hConstraint = NSLayoutConstraint(item: promptLabel, attribute: .centerX, relatedBy: .equal, toItem: promptLabel.superview, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([vConstraint, hConstraint])
        
        // User interaction setup
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        tapGesture.addTarget(self, action: #selector(AppController.webViewTapped(gestureRecognizer:)))
        webView.scrollView.addGestureRecognizer(tapGesture)
    }
    func showRandomEmojiInWebView() {
        let minTimes:UInt32 = 1
        let maxTimes = arc4random_uniform(16) + minTimes
        (minTimes...maxTimes).forEach({
            (Int) in
            // Execute user script at run-time
            let emoji = EmojiUtil.randomEmoji()
            let source = "show('\(emoji)');"
            webView.evaluateJavaScript(source, completionHandler: nil)
        })
    }
    func webViewTapped(gestureRecognizer:UIGestureRecognizer) {
        UIView.animate(withDuration: 0.25, animations: {
            self.promptLabel.alpha = 0
        }, completion: {
            (value: Bool) in
            self.promptLabel.removeFromSuperview()
            
            let source = "document.body.style.background = \"black\";"
            self.webView.evaluateJavaScript(source, completionHandler: {
                (d, error)->Void in
                self.showRandomEmojiInWebView()
            }
            )
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

let controller = AppController()

PlaygroundPage.current.liveView = controller

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
