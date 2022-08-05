
import UIKit

class StepsTakenView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    var stepsTaken: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 16, font: .poppinsMedium),
                            textColor: DecaColor.decafitGray.color,
                            numberOfLines: 1, text: "Steps taken",
                            kerning: 0))
        label.textAlignment = .center
        return label
    }()
    var stepsData: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 32, font: .poppinsMedium),
                            textColor: DecaColor.decafitBlack.color,
                            numberOfLines: 1, text: "110 Steps",
                            kerning: 0))
        label.textAlignment = .center
        return label
    }()
    var timeLeft: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 16, font: .poppinsMedium),
                            textColor: DecaColor.decafitGray.color,
                            numberOfLines: 1, text: "Time remaining",
                            kerning: 0))
        label.textAlignment = .center
        return label
    }()
    
    var timeData: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 32, font: .poppinsMedium),
                            textColor: DecaColor.decafitBlack.color,
                            numberOfLines: 1, text: "01:43",
                            kerning: 0))
        label.textAlignment = .center
        return label
    }()
    func setupSubviews() {
        [stepsTaken, stepsData, timeLeft, timeData].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
        ])
    }
}
