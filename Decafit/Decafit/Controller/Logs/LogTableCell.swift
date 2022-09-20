import UIKit

class LogTableCell: UITableViewCell {
    static let identifier = Constants.calenderCellId
    var logCell: DbWorkout? {
        didSet {
//            workoutTitleLabel.text = "Workout name"
            setsButton.setTitle(" \(logCell?.sets ?? 0)", for: .normal)
            repsButton.setTitle(" \(logCell?.reps ?? 0)", for: .normal)
            timeButton.setTitle(" \(logCell?.time ?? "0")", for: .normal)
            countButton.setTitle(" \(logCell?.count ?? 0)", for: .normal)

        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cardStack)
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    // MARK: - Workout sets, reps, time, count
    let setsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "clock.arrow.circlepath"), for: .normal)
        button.setTitle(" 1", for: .normal)
        button.setTitleColor(DecaColor.black.color, for: .normal)
        button.tintColor = DecaColor.black.color
        button.contentEdgeInsets = UIEdgeInsets(
            top: 7, left: 7, bottom: 7, right: 7)
        return button
    }()
    let repsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "repeat"), for: .normal)
        button.setTitle(" 4", for: .normal)
        button.setTitleColor(DecaColor.black.color, for: .normal)
        button.tintColor = DecaColor.black.color
        button.contentEdgeInsets = UIEdgeInsets(
            top: 7, left: 7, bottom: 7, right: 7)
        return button
    }()
    let timeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "stopwatch"), for: .normal)
        button.setTitle(" 10s", for: .normal)
        button.setTitleColor(DecaColor.black.color, for: .normal)
        button.tintColor = DecaColor.black.color
        button.contentEdgeInsets = UIEdgeInsets(
            top: 7, left: 7, bottom: 7, right: 7)
        return button
    }()
    
    let countButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "count"), for: .normal)
        button.setTitle(" 5", for: .normal)
        button.setTitleColor(DecaColor.black.color, for: .normal)
        button.tintColor = DecaColor.black.color
        button.contentEdgeInsets = UIEdgeInsets(
            top: 7, left: 7, bottom: 7, right: 7)

        return button
    }()

    // MARK: - Button Stackk

    lazy var buttonStack: DecaStack = {
       let stackview = DecaStack(arrangedSubviews: [setsButton, repsButton, timeButton, countButton])
        stackview.configure(with: DecaStackViewModel(
                                axis: .horizontal, alignment: .leading,
                                spacing: 0, distribution: .equalSpacing ))
       return stackview
    }()
    
    // MARK: - Workout Name
    let workoutTitleLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 14, font: .poppinsMedium),
                            textColor: DecaColor.black.color, numberOfLines: 1,
                            text: "Workout name", kerning: nil))
        return label
    }()
    
    lazy var workoutDataStack: DecaStack = {
       let stackview = DecaStack(arrangedSubviews: [workoutTitleLabel, buttonStack])
        stackview.configure(with: DecaStackViewModel(
                                axis: .vertical, alignment: .center,
                                spacing: 0, distribution: .equalSpacing ))
       return stackview
    }()
    // MARK: - Workout Card Image
    let workoutImageView: DecaImageView = {
        let imageView = DecaImageView(frame: .zero)
        imageView.configure(with: DecaImageViewModel(
            image: Constants.fbImg,
            contentMode: .scaleAspectFit,
                                tintColor: .white))
        
        return imageView
    }()
    // MARK: - Three dots

    let seeMoreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(
            top: 12, left: 12, bottom: 12, right: 12)
        return button
    }()
    // MARK: - Workout Card Stack
    lazy var cardStack: DecaStack = {
       let stackview = DecaStack(arrangedSubviews: [workoutImageView, workoutDataStack, seeMoreButton])
        stackview.backgroundColor = DecaColor.lightPink.color
        stackview.configure(with: DecaStackViewModel(
                                axis: .horizontal, alignment: .center,
                                spacing: 15, distribution: .equalSpacing ))
       return stackview
    }()
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 10, right: 30))
    }
    func setupSubviews() {
        NSLayoutConstraint.activate([
            
//            cardStack.widthAnchor.constraint(equalToConstant: 200),
//            cardStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
//            cardStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
            cardStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
                        
            workoutImageView.widthAnchor.constraint(equalToConstant: 50),
            workoutImageView.heightAnchor.constraint(equalToConstant: 50),
            workoutImageView.leadingAnchor.constraint(equalTo: cardStack.leadingAnchor, constant: 0)

        ])
    }
    
}
