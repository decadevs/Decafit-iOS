
import UIKit
struct DecaButtonViewModel {
    let title: String?
    let font: UIFont?
    let backgroundColor, titleColor: UIColor?
    let image: UIImage?
    let borderWidth, cornerRadius: CGFloat?
    let borderColor: CGColor?
    let contentEdgeInsets: UIEdgeInsets?
    let isEnabled, tarmic: Bool
}
final class DecaButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    static func createSocialButton(image: String) -> Self {
        let btn = Self()
        btn.setImage(UIImage(named: image), for: .normal)
        btn.layer.cornerRadius = 3
        btn.layer.borderWidth = 1
        btn.layer.borderColor =  DecaColor.decafitGray.color.cgColor
        btn.contentEdgeInsets = UIEdgeInsets(
            top: 14, left: 16, bottom: 14, right: 16)
        return btn
    }
    static func createPurpleButton(title: String) -> Self {
        let btn = Self()
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = decaFont(size: 24, font: .ubuntuMedium)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = DecaColor.decafitPurple.color
        btn.layer.cornerRadius = 5
        btn.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return btn
    }
    static func createOrangeButtonLink(title: String) -> Self {
        let btn = Self()
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = decaFont(size: 16, font: .poppinsRegular)
        btn.setTitleColor(DecaColor.decafitOrange.color, for: .normal)
        btn.backgroundColor = .clear
        return btn
    }
    func configure(with viewModel: DecaButtonViewModel) {
        setTitle(viewModel.title, for: .normal)
        titleLabel?.font = viewModel.font
        setTitleColor(viewModel.titleColor, for: .normal)
        setImage(viewModel.image, for: .normal)
        backgroundColor = viewModel.backgroundColor
        layer.cornerRadius = viewModel.cornerRadius ?? 0
        layer.borderWidth = viewModel.borderWidth ?? 0
        translatesAutoresizingMaskIntoConstraints = viewModel.tarmic
        isEnabled = viewModel.isEnabled
        layer.borderColor = viewModel.borderColor
        contentEdgeInsets = viewModel.contentEdgeInsets ??
            UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
