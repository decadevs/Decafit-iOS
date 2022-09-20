import UIKit
class LogHeader: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(allStack)
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - TITLE LABELS
    var dateLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 26, font: .poppinsBold),
                            textColor: DecaColor.black.color,
                            numberOfLines: 1, text: "17", kerning: nil))
        return label
    }()
    var dateLabel2: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 14, font: .poppinsMedium),
                            textColor: DecaColor.black.color,
                            numberOfLines: 1, text: "THU", kerning: nil))
        return label
    }()
    
    lazy var dateStack: DecaStack = {
       let stackview = DecaStack(arrangedSubviews: [dateLabel, dateLabel2])
        stackview.configure(with: DecaStackViewModel(
                                axis: .vertical, alignment: .center,
                                spacing: 0, distribution: .equalSpacing ))
       return stackview
    }()
    
    let dayLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 20, font: .poppinsMedium).bold(), textColor: DecaColor.black.color,
                            numberOfLines: 1, text: "Today", kerning: 1.4))
        return label
    }()
    
    let numberOfWorkoutLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 12, font: .poppinsMedium),
                            textColor: DecaColor.gray.color, numberOfLines: 1,
                            text: "2 Workouts and 13 Exercises", kerning: nil))
        return label
    }()
    // MARK: - Middle Stack
    lazy var midStack: DecaStack = {
       let stackview = DecaStack(arrangedSubviews: [dayLabel, numberOfWorkoutLabel])
        stackview.configure(with: DecaStackViewModel(
                                axis: .vertical, alignment: .leading,
                                spacing: 5, distribution: .equalSpacing ))
       return stackview
    }()
    
    let percentageLabel: UIButton = {
        let button = UIButton()
        button.setTitle("65%", for: .normal)
        button.setTitleColor(DecaColor.purple.color, for: .normal)
        button.titleLabel?.font = decaFont(size: 16, font: .poppinsMedium)
        
        button.contentEdgeInsets = UIEdgeInsets(
            top: 12, left: 50, bottom: 12, right: 2)
        return button
    }()
    
    
    lazy var titleStack: DecaStack = {
        let stackview = DecaStack(arrangedSubviews: [dateStack, midStack, percentageLabel])

        stackview.configure(with: DecaStackViewModel(
                                axis: .horizontal, alignment: .leading,
                                spacing: 20, distribution: .equalSpacing))
       return stackview
    }()
    // MARK: - time and line Stack
    let timeLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 12, font: .poppinsMedium),
                            textColor: DecaColor.darkGray.color, numberOfLines: 1,
                            text: "12:00", kerning: nil))
        label.textAlignment = .left
        return label
    }()
    lazy var timeLine: UIView = {
        let line = UIView()
        line.backgroundColor = DecaColor.gray.color
        line.translatesAutoresizingMaskIntoConstraints = false
        line.widthAnchor.constraint(equalToConstant: 270).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
    
        return line
    }()

    lazy var dividerStack: DecaStack = {
       let stackview = DecaStack(arrangedSubviews: [timeLabel, timeLine])
        stackview.configure(with: DecaStackViewModel(
            axis: .horizontal, alignment: .center,
                                spacing: 20, distribution: .fill ))
       return stackview
    }()
    // MARK: - All Stacks
    lazy var allStack: DecaStack = {
       let stackview = DecaStack(arrangedSubviews: [titleStack, dividerStack])
        stackview.configure(with: DecaStackViewModel(
                                axis: .vertical, alignment: .leading,
                                spacing: 10, distribution: .fillProportionally ))
       return stackview
    }()
    
}
extension LogHeader {
    func setupSubviews() {
        NSLayoutConstraint.activate([
            allStack.topAnchor.constraint(equalTo: topAnchor),
            allStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            allStack.trailingAnchor.constraint(equalTo: trailingAnchor)
  
        ])
    }
}
