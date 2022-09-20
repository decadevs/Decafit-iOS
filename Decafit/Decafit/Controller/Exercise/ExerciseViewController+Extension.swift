//
//  ExerciseViewController+Extension.swift
//  Decafit
//
//  Created by Decagon on 06/09/2022.
//

import Foundation

extension ExerciseViewController: ExerciseCellDelegate {
    func startExercise() {
        try! realm.write({
            currentExerciseReport.setValue(true, forKey: "started")
        })
        // change button text to repeat
        exerciseView.nextExerciseButton.setTitle(viewModel.nextExerciseBtnTitle, for: .normal)
    }
    
    // MARK: - NEXT EXERCISE
    func gotoNextExercise(pauseTime: TimeInterval) {
    
        self.pauseTime = pauseTime
        if currentExerciseReport.started == true {
            switch pauseTime > 0 && pauseTime < endTime {
            case true:
                try! realm.write({
                    currentExerciseReport.setValue(true, forKey: "paused")
                    currentExerciseReport.setValue("\(pauseTime.round(to: 2))", forKey: "limit")
                })
            default:
                try! realm.write({
                    currentExerciseReport.setValue(false, forKey: "paused")
                    currentExerciseReport.setValue(true, forKey: "completed")
                })

            }

            try! realm.write({
                currentExerciseReport.setValue("\(pauseTime.round(to: 2))", forKey: "limit")
                currentExerciseReport.setValue(Float(pauseTime.round(to: 2)/endTime), forKey: "progress")

            })
            
        }
        delegate?.showCompletionTag()
        
        delegate?.reloadData()
        updateReportInCacheAndServer()
        scrollViewWillEndDragging(collectionView, withVelocity: collectionView.contentOffset, targetContentOffset: &collectionView.contentOffset)
        
    }
    
    func updatePauseTime(pauseTime: TimeInterval, resumeTapped: Bool) {
        self.pauseTime = pauseTime
        if currentExerciseReport.started == true {
            try! realm.write({
                currentExerciseReport.setValue(true, forKey: "paused")
                currentExerciseReport.setValue("\(pauseTime.round(to: 2))", forKey: "limit")
                currentExerciseReport.setValue(Float(pauseTime.round(to: 2)/endTime), forKey: "progress")
                print("Limit", currentExerciseReport.limit)
                print("Progress", currentExerciseReport.progress)
            })

        }
        
    }
    
    func updateReportInCacheAndServer() {
        let currentExercise = exercises[currentIndex.row]
        delegate?.reloadData()
        
        let exid = currentExercise.id
        let type = currentExercise.type
        let limit = currentExerciseReport.limit
        let progress = currentExerciseReport.progress
        let paused = currentExerciseReport.paused
        let completed = currentExerciseReport.completed
        
        guard let selectedId = selectedWorkoutid else { fatalError() }
        let reps = viewModel.currentWorkoutReport.reps
        let sets = viewModel.currentWorkoutReport.sets
        let count = viewModel.currentWorkoutReport.count
        let time = viewModel.currentWorkoutReport.time
        
        // update cache
//        let exercise = WorkoutData.Exercise(excerciseId: exid, type: type, paused: paused, limit: limit, completed: completed, progress: Int(progress))
//        
//        if workoutExercisesList.contains(where: { $0.excerciseId == exercise.excerciseId }) == true {
//            
//            let contained =  workoutExercisesList.filter({ $0.excerciseId == exercise.excerciseId })
//            workoutExercisesList.remove(at: contained.startIndex)
//            workoutExercisesList.insert(exercise, at: contained.startIndex)
//        } else {
//            workoutExercisesList.append(exercise)
//        }
//        let workout = WorkoutData(workoutId: selectedId, workoutReps: reps, workoutSet: sets, workoutTime: time, workoutCount: count, exercises: workoutExercisesList)
//        data.updateCacheQuery(workouts: workout, userId: view.getUserID(), workoutId: selectedId)
        
        // update server reports
        let savedExercises = ReportExcerciseProgressInput(excerciseId: exid, type: type, paused: paused, limit: limit, completed: completed, progress: Int(progress))
        
        if savedExercisesList.contains(where: { $0.excerciseId == savedExercises.excerciseId }) == true {
            let contained =  savedExercisesList.filter({ $0.excerciseId == savedExercises.excerciseId })
            savedExercisesList.remove(at: contained.startIndex)
            savedExercisesList.insert(savedExercises, at: contained.startIndex)
        } else {
            savedExercisesList.append(savedExercises)
        }
        
        let reportWorkoutInput = ReportWorkoutInput(workoutId: selectedId, workoutReps: reps, workoutSet: sets, workoutTime: time, workoutCount: count, exercises: savedExercisesList)
        data.createReport(userId: view.getUserID(), workout: reportWorkoutInput)
        
    }
}
