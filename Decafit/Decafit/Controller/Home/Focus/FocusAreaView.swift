//
//  FocusAreaView.swift
//  Decafit
//
//  Created by Decagon on 27/07/2022.
//

import UIKit
import RealmSwift

class FocusAreaView: UIView, UICollectionViewDataSource,
                     UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    weak var delegate: FocusAreaViewDelegate?
    let data = DataManager.shared
    var allWorkouts = [WorkoutListQuery.Data.Workout]()
    var defaults = UserDefaults.standard
    let home = HomeViewController.getHomeView()
    let realmDb = StorageManager.shared
    let realm = try! Realm()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.dataSource = self
        view.delegate = self
        return view
    }()
    var focusAreaViewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.focusAreaViewTitleText
        label.font = decaFont(size: 16, font: .poppinsMedium).bold()
        label.textColor = DecaColor.black.color
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
        backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false

        data.fetchWorkoutsCompletion = { [weak self] graphQLResult in
            if let workouts = graphQLResult.data?.workouts.compactMap({ $0 }) {
                self?.allWorkouts = workouts
                self?.collectionView.reloadData()
            }
        }

    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }

    func setupSubviews() {
        collectionView.register(FocusAreaCollectionViewCell.self,
                             forCellWithReuseIdentifier: FocusAreaCollectionViewCell.identifier)
        [focusAreaViewTitle, collectionView].forEach { self.addSubview($0) }
        NSLayoutConstraint.activate([
            focusAreaViewTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            focusAreaViewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            focusAreaViewTitle.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: focusAreaViewTitle.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allWorkouts.count
    }
    var assocArr = [DbExercise]()
    func displayStartedTag(currentWorkoutId: String, button: UIButton) {

        let associatedExercises = realmDb.fetchAllExercises().where({ $0.associatedWorkoutId == currentWorkoutId  })
        assocArr.append(contentsOf: associatedExercises)
        var notCompleteArr = [DbExercise]()
        var completeArr = [DbExercise]()

        if assocArr.count > 1 {
            for assoc in assocArr {
                if assoc.exerciseNotComplete == true {
                    notCompleteArr.append(assoc)
                } else if assoc.exerciseCompleted == true {
                    completeArr.append(assoc)
                } else {
                    print("Mthew")
                }
            }
            
            if notCompleteArr.count > 0 || ( completeArr.count > 0 && completeArr.count < assocArr.count) {
                print("show red progress tag")
                button.isHidden = false
                button.backgroundColor = DecaColor.red.color
                button.setTitle("In Progress", for: .normal)
            } else if completeArr.count == assocArr.count {
                button.setTitle("Completed", for: .normal)
                button.backgroundColor = DecaColor.green.color
                button.isHidden = false
                
            } else {
                button.isHidden = true

            }
            assocArr = []
            
        } else {
            button.isHidden = true

        }
 
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                                                        withReuseIdentifier: FocusAreaCollectionViewCell.identifier,
                                                        for: indexPath) as?
                FocusAreaCollectionViewCell else { return UICollectionViewCell() }
        let workouts = allWorkouts[indexPath.row]
        cell.focusAreaCell = workouts
        data.fetchWorkoutReportFromCache(userId: getUserID(), workoutId: workouts.id)
        displayStartedTag(currentWorkoutId: workouts.id, button: cell.startedBtn)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width/2.4, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let workouts = allWorkouts[indexPath.row]
        data.fetchWorkoutReportFromCache(userId: getUserID(), workoutId: workouts.id)
        defaults.set(workouts.id, forKey: UserDefaultKeys.workoutID)

        let associatedExercises = realmDb.fetchAllExercises().where({ $0.associatedWorkoutId == workouts.id })
        if associatedExercises.contains(where: { $0.exerciseNotComplete }) == true {
            // incomplete workouts present
            delegate?.showDialog(workoutId: workouts.id)
        }
        
        Alert.firstActionComplete = { [weak self] in
            // restart
            self?.realmDb.deleteWorkout(workoutId: workouts.id)
            self?.realmDb.deleteWorkoutExercises(workoutId: workouts.id)
            collectionView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                
                let screen = FitConfigViewController.shared
                let selectedCell = collectionView.cellForItem(at: indexPath) as? FocusAreaCollectionViewCell
                let image = selectedCell?.workoutImage.image
                let title = selectedCell?.workoutTitle.text ?? "Full Body"
                self?.delegate?.didDisplayFitConfigScreen(screen, image: image, title: title, workoutId: workouts.id)

            }
        }
        Alert.secondActionComplete = {
            // resume
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                
                let screen = FitConfigViewController.shared
                let selectedCell = collectionView.cellForItem(at: indexPath) as? FocusAreaCollectionViewCell
                let image = selectedCell?.workoutImage.image
                let title = selectedCell?.workoutTitle.text ?? "Full Body"
                self?.delegate?.didDisplayFitConfigScreen(screen, image: image, title: title, workoutId: workouts.id)

            }
        }
   
        let screen = FitConfigViewController.shared
        let selectedCell = collectionView.cellForItem(at: indexPath) as? FocusAreaCollectionViewCell
        let currentWorkoutId = workouts.id
        defaults.set(currentWorkoutId, forKey: UserDefaultKeys.currentWorkoutId)
        let image = selectedCell?.workoutImage.image
        let title = selectedCell?.workoutTitle.text ?? "Full Body"
        delegate?.didDisplayFitConfigScreen(screen, image: image, title: title, workoutId: currentWorkoutId)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 5, bottom: 10, right: 5)
    }
    
}
