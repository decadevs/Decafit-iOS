//
//  FocusAreaView.swift
//  Decafit
//
//  Created by Decagon on 27/07/2022.
//

import UIKit

protocol FocusAreaViewDelegate: AnyObject {
    func didDisplayFitConfigScreen(_ screen: FitConfigViewController, image: UIImage?, title: String, workoutId: String)
}
class FocusAreaView: UIView, UICollectionViewDataSource,
                     UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    weak var delegate: FocusAreaViewDelegate?
    let data = DataManager.shared
    var allWorkouts = [WorkoutListQuery.Data.Workout]()
    var defaults = UserDefaults.standard

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

        data.fetchWorkouts()
        data.fetchWorkoutsCompletion = { [self] graphQLResult in
            if let workouts = graphQLResult.data?.workouts.compactMap({ $0 }) {
                allWorkouts = workouts
                collectionView.reloadData()
                createLocalWorkoutReport()
            }
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    
    func createLocalWorkoutReport() {
        if defaults.object(forKey: UserDefaultKeys.workoutReport) == nil {
            let exerciseReport = ExerciseReport(excerciseId: "", type: "", paused: false, completed: false, limit: "", progress: 0)
            defaults.workoutReport = SavedWorkoutReport(workout: [])

            var arr = [ExerciseReport]()
            for workout in allWorkouts {
                guard let exercises = workout.exercises else {
                    fatalError("Cant find this workout's exercises")
                }
                for _ in 0..<exercises.count {
                    arr.append(exerciseReport)
                }
                defaults.workoutReport?.workout.append(SavedWorkout(workoutId: workout.id, exerciseArr: arr))
                arr = []
            }
            
        }
    }

    func setupSubviews() {
        collectionView.register(FocusAreaCollectionViewCell.self,
                             forCellWithReuseIdentifier: FocusAreaCollectionViewCell.identifier)
        [focusAreaViewTitle, collectionView].forEach { self.addSubview($0) }
        NSLayoutConstraint.activate([
            focusAreaViewTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            focusAreaViewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            focusAreaViewTitle.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: focusAreaViewTitle.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allWorkouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                                                        withReuseIdentifier: FocusAreaCollectionViewCell.identifier,
                                                        for: indexPath) as?
                FocusAreaCollectionViewCell else { return UICollectionViewCell() }
        let workouts = allWorkouts[indexPath.row]
        cell.focusAreaCell = workouts
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width/2.4, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let workouts = allWorkouts[indexPath.row]
        let selectedWorkoutIndex = indexPath.row
        defaults.set(selectedWorkoutIndex, forKey: UserDefaultKeys.selectedWorkoutIndex)
        defaults.workoutReport?.workout[selectedWorkoutIndex].workoutId = workouts.id
        defaults.set(workouts.id, forKey: UserDefaultKeys.workoutID)
        
        let screen = FitConfigViewController.shared
        let selectedCell = collectionView.cellForItem(at: indexPath) as? FocusAreaCollectionViewCell
        let image = selectedCell?.workoutImage.image
        let title = selectedCell?.workoutTitle.text ?? "Full Body"
        delegate?.didDisplayFitConfigScreen(screen, image: image, title: title, workoutId: workouts.id)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 5, bottom: 10, right: 5)
    }
}
