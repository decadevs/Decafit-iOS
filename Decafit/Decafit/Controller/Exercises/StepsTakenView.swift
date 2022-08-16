import UIKit
import CoreMotion

class StepsTakenView: UIView {
    let pedometer = CMPedometer()
    let activityManager = CMMotionActivityManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .systemPink
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    func startStepCount() {
        if CMPedometer.isStepCountingAvailable() {
//            let calendar = Calendar.current
//            pedometer.queryPedometerData(from: calendar.startOfDay(for: Date()), to: Date()) { (data, error) in
//                print(data)
//
//            }
            pedometer.startUpdates(from: Date()) { (data, error) in
//                print(data)
                if error == nil {
                    DispatchQueue.main.async {
                        self.stepsData.text = "\(String(describing: data?.numberOfSteps)) Steps"
                    }
                }
            }
       }
    }
    lazy var stepsTaken: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 16, font: .poppinsMedium),
                            textColor: DecaColor.decafitGray.color,
                            numberOfLines: 1, text: "Steps taken",
                            kerning: 0))
        label.textAlignment = .center
        return label
    }()
    lazy var stepsData: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 32, font: .poppinsMedium),
                            textColor: DecaColor.decafitBlack.color,
                            numberOfLines: 1, text: "110 Steps",
                            kerning: 0))
        label.textAlignment = .center
        return label
    }()
    lazy var stepStack: DecaStack = {
        let stack = DecaStack(arrangedSubviews: [stepsTaken, stepsData])
        stack.configure(with: DecaStackViewModel(
                            axis: .vertical,
                            alignment: .center,
                            spacing: 5,
                            distribution: .fillProportionally))
        return stack
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
    lazy var timeStack: DecaStack = {
        let stack = DecaStack(arrangedSubviews: [timeLeft, timeData])
        stack.configure(with: DecaStackViewModel(
                            axis: .vertical,
                            alignment: .center,
                            spacing: 5,
                            distribution: .fillProportionally))
        return stack
    }()
    func setupSubviews() {
        [stepStack, timeStack].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            stepStack.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            stepStack.centerXAnchor.constraint(equalTo: centerXAnchor),

            timeStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            timeStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
