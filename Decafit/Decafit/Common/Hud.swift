import Foundation
import SVProgressHUD

final class HUD {
    static func show(status: String) {
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultStyle(.custom)
            SVProgressHUD.setDefaultMaskType(.custom)
            SVProgressHUD.setForegroundColor(DecaColor.decafitPurple.color)
            SVProgressHUD.setBackgroundColor(.black)
            SVProgressHUD.setBackgroundLayerColor(.clear)
            SVProgressHUD.show(withStatus: status)
        }
    }
    
    class func hide() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
