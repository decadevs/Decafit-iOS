import UIKit
import KeychainSwift

class FitConfigViewController: UIViewController {
    static let shared =  FitConfigViewController()
    var selectedWorkoutid: String?
    let data = DataManager.shared
    lazy var topImageView = ConfigTopView()
    var defaults = UserDefaults.standard
    
    lazy var labelStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews:
                                [inputVCTitleLabel, inputVCSubTitleLabel])
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        return stack
    }()
    lazy var textfieldStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews:
                                [setsTextField, repsTextField,
                                 timeTextField, countTextField])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.contentHuggingPriority(for: .vertical)
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupSubviews()
        nextButton.addTarget(self, action: #selector(gotoStartWorkout),
                             for: .touchUpInside)
        backButton.addTarget(self, action: #selector(clickNavBackButton),
                             for: .touchUpInside)
    }
}

extension FitConfigViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    @objc func clickNavBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    /**
     mutation ReportCreate($input: ReportCreateInput) {
       reportCreate(input: $input) {
         userID
         workouts {
           workoutId
           workoutReps
           workoutSet
           workoutTime
           workoutCount
           exercises {
             excerciseId
             type
             paused
             pausedTime
             completed
           }
         }
       }
     }
     */
    func getConfigInput() {
        guard let reps = repsTextField.text, let sets = setsTextField.text, let time = timeTextField.text, let count = countTextField.text, !reps.isEmpty, !sets.isEmpty, !time.isEmpty, !count.isEmpty else {
            Alert.showAlert(self, title: Constants.alertTitleError, message: Constants.blankTextFieldError)
            return
        }
        
        // Save the data
        defaults.setValue(reps, forKey: "reps")
        defaults.setValue(sets, forKey: "sets")
        defaults.setValue(time, forKey: "time")
        defaults.setValue(count, forKey: "count")
        
        defaults.set(count, forKey: "count")
        defaults.set(time, forKey: "time")

        let keychain = KeychainSwift()
        guard let userID = keychain.get("userID") else { return }
        
        let workout = Workout1(workoutId: selectedWorkoutid, workoutTime: time, workoutReps: Int(reps)!, workoutSet: Int(sets)!, workoutCount: Int(count)!, exercises: nil)
        let report = ReportCreate(userID: userID, workouts: [workout])
   
        let reportExcerciseProgressInput = ReportExcerciseProgressInput(excerciseId: "", type: .count, paused: false, pausedTime: "", completed: false)
        
        let reportWorkout = ReportWorkoutInput(workoutId: selectedWorkoutid ?? "", workoutReps: Int(reps)!, workoutSet: Int(sets)!, workoutTime: time, workoutCount: Int(count)!, exercises: [reportExcerciseProgressInput])
        
//        data.updateReport(userId: userID, workout: reportWorkout)
        
        print(report)
        UserDefaults.standard.workoutReport = report
    }
    @objc func gotoStartWorkout() {
        getConfigInput()
        let screen = WorkoutViewController.getWorkoutView()
        let img = topImageView.fitConfigImage.image
        screen.topView.topImage.image = img
        screen.selectedId = selectedWorkoutid
        
        self.navigationController?.pushViewController(screen, animated: true)
    }
}

extension FitConfigViewController: UIGestureRecognizerDelegate {
    func setupNavigation() {
        let cview = UIView(frame: CGRect(x: 20, y: 40, width: 350, height: 50))
        cview.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.bottomAnchor.constraint(equalTo: cview.bottomAnchor).isActive = true
        view.addSubview(cview)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.backButtonTitle = " "
        navigationItem.backButtonDisplayMode = .minimal
    }
}

extension FitConfigViewController {
    func setupSubviews() {
        let contentViewSize = CGSize(width: view.frame.width, height: view.frame.height/1.18)
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews: [topImageView,
                                                         labelStack,
                                                         textfieldStack,
                                                         nextButton])
            stackView.configure(with: DecaStackViewModel(
                                    axis: .vertical, alignment: .center,
                                    spacing: 20, distribution: .fillProportionally))
            stackView.frame.size = contentViewSize
            return stackView
        }()
        view.addSubview(parentStack)
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            topImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topImageView.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.height * 0.21)),
            topImageView.bottomAnchor.constraint(equalTo: labelStack.topAnchor, constant: -40),
            
            labelStack.heightAnchor.constraint(equalToConstant: 50),
            labelStack.leadingAnchor.constraint(equalTo: setsTextField.leadingAnchor, constant: 0),
            setsTextField.heightAnchor.constraint(equalToConstant: 56),
            repsTextField.heightAnchor.constraint(equalToConstant: 56),
            timeTextField.heightAnchor.constraint(equalToConstant: 56),
            countTextField.heightAnchor.constraint(equalToConstant: 56),
            nextButton.heightAnchor.constraint(equalToConstant: 64),
            setsTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            repsTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            timeTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            countTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            nextButton.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
}
