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
class StartWorkoutViewController: UIViewController, UIGestureRecognizerDelegate {
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
        view.register(StartWorkoutCell.self, forCellReuseIdentifier: StartWorkoutCell.identifier)
        return view
    }()
    var startWorkoutButton: DecaButton = {
        let button = createPurpleButton(title: "Start Workout")
        button.layer.shadowOffset = CGSize(width: 0, height: 8)
        button.layer.shadowOpacity = 0.1
        button.addTarget(self, action: #selector(workoutButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var topView: WorkoutPageTopview = {
       let view = WorkoutPageTopview()
        view.backButton.addTarget(self, action: #selector(clickNavBackButton), for: .touchUpInside)
        return view
    }()
    lazy var modalView: WorkoutModalView = {
        let popup = WorkoutModalView()
        popup.layer.shadowOffset = CGSize(width: 5, height: 12)
        popup.layer.shadowOpacity = 0.2
        popup.workoutModalButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        return popup
    }()
    @objc func dismissModal() {
        modalView.removeFromSuperview()
    }
    @objc func clickNavBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [topView, tableView, startWorkoutButton, modalView].forEach { view.addSubview($0)}
        setupSubviews()
        navigationController?.navigationBar.isHidden = true 
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        displayModal()
    }
}
extension StartWorkoutViewController {
    func displayModal() {
        view.addoverlay(color: .black, alpha: 0.6)
        view.addSubview(modalView)
        modalView.isHidden = false
    }
    @objc func workoutButtonTapped() {
        startWorkoutButton.setTitle("Continue Workout", for: .normal)
        let firstIndex = tableView.indexPathsForVisibleRows?.first
        let firstRow = tableView.cellForRow(at: firstIndex!) as? StartWorkoutCell
        firstRow?.completeButton.isHidden = false
        let secondIndex = tableView.indexPathsForVisibleRows?[1]
        let secondRow = tableView.cellForRow(at: secondIndex!) as? StartWorkoutCell
        secondRow?.completeButton.setTitle("Incomplete", for: .normal)
        secondRow?.completeButton.setTitleColor(DecaColor.red.color, for: .normal)
        secondRow?.completeButton.backgroundColor = DecaColor.lightRed.color
        secondRow?.progressbar.isHidden = false
        secondRow?.progressbar.progress = 0.4
//        secondRow?.backgroundView = secondRow?.progressbar
        secondRow?.completeButton.isHidden = false
    }
    func setupSubviews() {
        NSLayoutConstraint.activate([
            // topview
            topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            topView.heightAnchor.constraint(equalToConstant: 288),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            // tableview
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.height*0.65)),
            startWorkoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.86),
            startWorkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            startWorkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modalView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            modalView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)

        ])
    }
}
extension StartWorkoutViewController {
    func createModalView() {
    }
}
