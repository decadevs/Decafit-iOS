import UIKit
class Navbar: UINavigationBar {
    let customView = UIBarButtonItem(customView: CustomNavView())
    let navitem = UINavigationItem(title: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
