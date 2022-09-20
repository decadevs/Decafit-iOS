import UIKit
class WorkoutCell: UITableViewCell {
    static let identifier = Constants.workoutCellId
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        [exerciseImage, exerciseLabel, workoutDurationLabel, progressbar, completeButton]
            .forEach { contentView.addSubview($0)}
        setupSubviews()
        
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    
    func configure(with model: WorkoutListQuery.Data.Workout.Exercise) {
        exerciseLabel.text = model.title
        workoutDurationLabel.text = "\(model.type)"
        exerciseImage.kf.setImage(with: URL(string: model.image), placeholder: UIImage(named: "back"), options: nil, completionHandler: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        completeButton.isHidden = true 
        exerciseImage.image = nil
        exerciseLabel.text = nil
        workoutDurationLabel.text = nil 
    }
    var exerciseImage: DecaImageView = {
        let img = DecaImageView(frame: .zero)
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 10
        return img
    }()
    var exerciseLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 18, font: .poppinsMedium).bold(),
                                                 textColor: DecaColor.black.color, numberOfLines: 1,
                                                 text: Constants.exerciseLabelText, kerning: nil))
        return label
    }()
    var workoutDurationLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 16, font: .poppinsMedium),
                                                 textColor: DecaColor.gray.color, numberOfLines: 1,
                                                 text: Constants.workoutDurationLabelText, kerning: nil))
        return label
    }()
    var progressbar: UIProgressView = {
        let bar = UIProgressView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.progressTintColor = DecaColor.lightGreen.color
        bar.trackTintColor = .white
        bar.isHidden = true
        bar.isOpaque = false
        bar.alpha = 0.4
        return bar
    }()
    var completeButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Constants.completeText, for: .normal)
        btn.titleLabel?.font = decaFont(size: 12, font: .poppinsMedium)
        btn.setTitleColor(DecaColor.green.color, for: .normal)
        btn.backgroundColor = DecaColor.lightGreen.color
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 0
        btn.isHidden = true
        btn.contentEdgeInsets = UIEdgeInsets(
            top: 13, left: 12, bottom: 13, right: 12)
        return btn
    }()
    func setupSubviews() {
        contentView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 120),
            progressbar.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            progressbar.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            progressbar.topAnchor.constraint(equalTo: contentView.topAnchor),
            progressbar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            
            exerciseImage.centerYAnchor.constraint(equalTo: progressbar.centerYAnchor, constant: 0),
            exerciseImage.leadingAnchor.constraint(equalTo: progressbar.leadingAnchor, constant: 25),
            exerciseImage.heightAnchor.constraint(equalToConstant: 56),
            exerciseImage.widthAnchor.constraint(equalToConstant: 64),

            exerciseLabel.leadingAnchor.constraint(equalTo: exerciseImage.trailingAnchor, constant: 16),
            exerciseLabel.topAnchor.constraint(equalTo: exerciseImage.topAnchor, constant: 5),
            completeButton.topAnchor.constraint(equalTo: exerciseLabel.topAnchor, constant: 5),
            completeButton.trailingAnchor.constraint(equalTo: progressbar.trailingAnchor, constant: -20),
            completeButton.widthAnchor.constraint(equalToConstant: 95),
            completeButton.heightAnchor.constraint(equalToConstant: 33),
            workoutDurationLabel.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 5),
            workoutDurationLabel.leadingAnchor.constraint(equalTo: exerciseLabel.leadingAnchor, constant: 0)
        ])
    }
}
