
import UIKit

class ModalView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    lazy var topSwipeView = ModalTopSwipeView()
    lazy var modalTitle: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 20, font: .poppinsMedium),
                            textColor: .black, numberOfLines: 1,
                            text: Constants.exerciseLabelText, kerning: 1.0))
        return label
    }()

    lazy var scrollview: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(modalDetailText)
        return scroll
    }()
    lazy var modalDetailText: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 12, font: .poppinsRegular),
                            textColor: DecaColor.decafitDarkGray.color, numberOfLines: 0,
                            text: Constants.loremText, kerning: nil))
        label.sizeToFit()
        return label
    }()
    var modalButton: DecaButton = {
        let btn = DecaButton()
        btn.configure(with: DecaButtonViewModel(
                        title: Constants.close,
                        font: decaFont(size: 14, font: .poppinsRegular),
                        backgroundColor: .clear,
                        titleColor: DecaColor.decafitPurple.color,
                        image: nil, borderWidth: 1, cornerRadius: 4,
                        borderColor: DecaColor.decafitPurple.color.cgColor,
                        contentEdgeInsets: nil, isEnabled: true, tarmic: false))
        return btn
    }()
    func setupSubviews() {
        [topSwipeView, modalTitle, scrollview, modalButton].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            topSwipeView.topAnchor.constraint(equalTo: topAnchor),
            topSwipeView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSwipeView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSwipeView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45),
            topSwipeView.widthAnchor.constraint(equalTo: widthAnchor),
            
            modalTitle.topAnchor.constraint(equalTo: topSwipeView.bottomAnchor, constant: 0),
            modalTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            modalTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            
            scrollview.topAnchor.constraint(equalTo: modalTitle.bottomAnchor),
            scrollview.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            scrollview.widthAnchor.constraint(equalTo: widthAnchor),
            scrollview.bottomAnchor.constraint(equalTo: modalButton.topAnchor, constant: -10),

            modalDetailText.topAnchor.constraint(equalTo: scrollview.topAnchor),
            modalDetailText.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor),
            modalDetailText.widthAnchor.constraint(equalTo: scrollview.widthAnchor, multiplier: 0.85),
            modalDetailText.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor, constant: -100),

            modalButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            modalButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            modalButton.heightAnchor.constraint(equalToConstant: 38),
            modalButton.widthAnchor.constraint(equalToConstant: 104)
        ])
    }
}
