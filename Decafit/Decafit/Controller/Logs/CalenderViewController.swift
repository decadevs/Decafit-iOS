//
//  CalenderViewController.swift
//  Decafit
//
//  Created by Decagon on 13/09/2022.
//

import UIKit
import FSCalendar

class CalenderViewController: UIViewController {

    // update calender view from realm
    var realmDb = StorageManager.shared
    var logViewModel = LogViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Logs"
        view.backgroundColor = .white
        logViewModel.getLogs()
        logViewModel.extractWorkoutName()
        logView.delegate = self 
        
        view.addSubview(calenderView)
        
        if !logViewModel.logs.isEmpty {
            view.addSubview(logView)
        } else {
            print("No Logs to display!")
            view.addSubview(dummyLabel)
        }
        setupWorkoutView()
        
    }
    
    lazy var calenderView: FSCalendar = {
       let cview = FSCalendar()
        cview.delegate = self
        return cview
    }()
    
    let logView = LogView()
    
    let dummyLabel: UILabel = {
        let label = UILabel()
        label.text = "You did not workout on this date!"
        label.font = decaFont(size: 18, font: .poppinsRegular)
        label.numberOfLines = 0
        return label
    }()
    
    func setupWorkoutView() {
        let workouts = realmDb.fetchAllWorkouts()
        let exercises = realmDb.fetchAllExercises()

        let formatter = DateFormatter()
        // EEEE is the weekday, a is the am/pm
        formatter.dateFormat = "EEEE dd h:mm a dd-MM-YYYY"
        let dateString = formatter.string(from: workouts[0].workoutDate)
        let splitted = dateString.split(separator: " ")

        logView.logHeader.numberOfWorkoutLabel.text = "\(workouts.count) Workouts and \(exercises.count) exercises"
        logView.logHeader.dayLabel.text = "\(splitted[0])"
        logView.logHeader.timeLabel.text = "\(splitted[2])"
        logView.logHeader.dateLabel.text = "\(splitted[1])"
        logView.logHeader.dateLabel2.text = "\(splitted[0].uppercased().prefix(3))"
        logView.logHeader.percentageLabel.setTitle("60%", for: .normal)
        // I need date, date title string, time, progress as percentage,
        // and number of workouts and exercises
        
        // if i had date available, i would filter to get workouts for that date
        // and display it
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calenderView.frame = CGRect(x: 0, y: 100, width: view.bounds.width*0.95, height: view.bounds.height*0.4)
        
        dummyLabel.frame = CGRect(x: 20, y: calenderView.bounds.height+200, width: view.bounds.width*0.95, height: 30)

        logView.frame = CGRect(x: 0, y: calenderView.bounds.height+150, width: view.bounds.width*0.95, height: view.bounds.height*0.35)
    }

}

extension CalenderViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return "Wondeful"
    }
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        "Nawa o"
    }
}

extension CalenderViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        // EEEE is the weekday, a is the am/pm
        formatter.dateFormat = "EEEE dd MM YYYY h:mm dd-MM-YYYY at h:mm a"
        let dateString = formatter.string(from: date)
        print("\(dateString)")
    }
}

extension CalenderViewController: LogViewDelegate {
    func displayDetailView(screen: UIViewController) {
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
}
