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
        let view = UITableView(frame: view.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(StartWorkoutCell.self, forCellReuseIdentifier: StartWorkoutCell.identifier)
        return view
    }()
    var startWorkoutButton: DecaButton = {
        let button = createPurpleButton(title: "Next")
//        button.addTarget(self, action: #selector(gotoStartWorkout), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
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
