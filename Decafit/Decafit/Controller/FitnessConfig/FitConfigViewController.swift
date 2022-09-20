import UIKit
import RealmSwift

class FitConfigViewController: UIViewController {
    static let shared =  FitConfigViewController()
    var selectedWorkoutid: String?
    let data = DataManager.shared
    let realmDb = StorageManager.shared
    let realm = try! Realm()

    lazy var topImageView = ConfigTopView()
    var defaults = UserDefaults.standard
    var reps, sets, count, time: String?
    
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
        
        // check if workout exists in device
        guard let selectedWorkoutId = selectedWorkoutid else {
            return
        }

        let userWorkout = realmDb.fetchAllWorkouts().where({ $0.workoutId == selectedWorkoutId })
        if userWorkout.count > 0 {
            reps = String(describing: userWorkout[0].reps)
            sets = String(describing: userWorkout[0].sets)
            count = String(describing: userWorkout[0].count)
            time = userWorkout[0].time
            
            repsTextField.text = reps
            setsTextField.text = sets
            countTextField.text = count
            timeTextField.text = time
        }
    
    }
    
    // Text Fields
    let setsTextField: DecaTextField =
        DecaTextField.createNormalTextField(text: Constants.sets, keyboardType: .numberPad)
    let repsTextField: DecaTextField
        = DecaTextField.createNormalTextField(text: Constants.reps, keyboardType: .numberPad)
    let timeTextField: DecaTextField =
        DecaTextField.createNormalTextField(text: Constants.time, keyboardType: .numberPad)
    let countTextField: DecaTextField
        = DecaTextField.createNormalTextField(text: Constants.count, keyboardType: .numberPad)
    
    var textFields: [UITextField] {
        return [setsTextField, repsTextField, timeTextField, countTextField]
    }

}
   
extension FitConfigViewController {
    @objc func clickNavBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    func getConfigInput() {
        guard let reps = repsTextField.text, let sets = setsTextField.text, let time = timeTextField.text, let count = countTextField.text, !reps.isEmpty, !sets.isEmpty, !time.isEmpty, !count.isEmpty else {
            Alert.showAlert(self, title: Constants.alertTitleError, message: Constants.blankTextFieldError)
            return
        }

        guard let selectedWorkoutId = selectedWorkoutid else {
            fatalError()
        }
//        defaults.set(reps, forKey: UserDefaultKeys.reps)
//        defaults.set(sets, forKey: UserDefaultKeys.sets)
        defaults.set(count, forKey: UserDefaultKeys.count)
        defaults.set(time, forKey: UserDefaultKeys.time)

        let workoutConfig = DbWorkout(workoutId: selectedWorkoutId, sets: Int(sets)!, reps: Int(reps)!, count: Int(count)!, time: time, workoutDate: Date())
        realmDb.saveWorkout(workoutConfig)
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
extension FitConfigViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let selectedTextFieldIndex =
            textFields.firstIndex(of: textField), selectedTextFieldIndex < textFields.count - 1 {
            textFields[selectedTextFieldIndex + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    func setupKeyboardDismissRecognizer() {
            let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self, action: #selector(self.dismissKeyboard))
            self.view.addGestureRecognizer(tapRecognizer)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
