//
//  StartWorkoutViewController.swift
//  Decafit
//
//  Created by Decagon on 01/08/2022.
//

import UIKit
struct StartWorkoutModel {
    let exerciseName, duration, image: String
}
class StartWorkoutViewController: UIViewController {
    static var shared: StartWorkoutViewController?
    static func getWorkoutView() -> StartWorkoutViewController {
        return shared ?? StartWorkoutViewController()
    }
    var data: [StartWorkoutModel] = [
        StartWorkoutModel(exerciseName: "Jumping jacks", duration: "00:20", image: "profile"),
        StartWorkoutModel(exerciseName: "Push ups", duration: "X10", image: "window"),
        StartWorkoutModel(exerciseName: "Knee Push-ups", duration: "X10", image: "profile"),
        StartWorkoutModel(exerciseName: "Incline Push-ups", duration: "X10", image: "window"),
        StartWorkoutModel(exerciseName: "Planks", duration: "X10", image: "profile"),
        StartWorkoutModel(exerciseName: "Push ups", duration: "X10", image: "window"),
        StartWorkoutModel(exerciseName: "Push ups", duration: "X10", image: "profile"),
        StartWorkoutModel(exerciseName: "Push ups", duration: "X10", image: "window")
    ]
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .red
        view.register(StartWorkoutCell.self, forCellReuseIdentifier: StartWorkoutCell.identifier)
        return view
    }()
    var startWorkoutButton: DecaButton = {
        let button = createPurpleButton(title: "Start Workout")
//        button.addTarget(self, action: #selector(gotoStartWorkout), for: .touchUpInside)
        return button
    }()
    lazy var topView = WorkoutPageTopview()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [topView, tableView, startWorkoutButton].forEach { view.addSubview($0)}
        setupSubviews()
        print(startWorkoutButton.titleLabel?.font )
    }

}
extension StartWorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: StartWorkoutCell.identifier, for: indexPath)
                as? StartWorkoutCell else { return UITableViewCell()}
        cell.configure(with: data[indexPath.row])
        return cell
    }
}
extension StartWorkoutViewController {
    func setupSubviews() {
        NSLayoutConstraint.activate([
            // topview
            topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            topView.heightAnchor.constraint(equalToConstant: 288),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            // tableview
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            startWorkoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            startWorkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            startWorkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
