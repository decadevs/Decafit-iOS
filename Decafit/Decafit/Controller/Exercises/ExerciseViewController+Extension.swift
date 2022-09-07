//
//  ExerciseViewController+Extension.swift
//  Decafit
//
//  Created by Decagon on 06/09/2022.
//

import Foundation

extension ExerciseViewController: ExerciseCellDelegate {
    func startExercise() {
        guard let selectedWorkoutIndex = selectedWorkoutIndex else { fatalError() }

        defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?[currentIndex.row].started = true
        
 
    }
    
    // MARK: - NEXT EXERCISE
    
    func gotoNextExercise(pauseTime: TimeInterval) {
        
        let endTime = defaults.double(forKey: UserDefaultKeys.time)
        self.pauseTime = pauseTime
        
        guard let selectedWorkoutIndex = selectedWorkoutIndex else { fatalError() }
        var thisExercise = defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?.filter({ $0.excerciseId ==  currentExerciseId })[0]
        
        if pauseTime > 0 {
            
            thisExercise?.completed = false
            thisExercise?.paused = true
            self.pauseTime = pauseTime
            thisExercise?.limit = "\(pauseTime)"
        } else {
            thisExercise?.completed = true
            thisExercise?.paused = false
            thisExercise?.limit = "\(pauseTime)"
        }
        
        thisExercise?.limit = "\(pauseTime)"
        thisExercise?.progress = Float(pauseTime/endTime)
        
        var contained = defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?.filter({ $0.excerciseId == thisExercise?.excerciseId })
        
        defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?.remove(at: (contained?.startIndex)! )
        defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?.append(thisExercise!)
        
        delegate?.reload()
        updateReportInCacheAndServer()

        scrollViewWillEndDragging(collectionView, withVelocity: collectionView.contentOffset, targetContentOffset: &collectionView.contentOffset)
        
    }
    
    func updatePauseTime(pauseTime: TimeInterval, resumeTapped: Bool) {
        self.pauseTime = pauseTime
        let endTime = defaults.double(forKey: UserDefaultKeys.time)
        
        guard let selectedWorkoutIndex = selectedWorkoutIndex else { fatalError() }
        
        var thisExercise = defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?.filter({ $0.excerciseId ==  currentExerciseId })[0]
        
        if thisExercise?.started == true {
            if resumeTapped == false {
                
                thisExercise?.paused = true
                thisExercise?.progress = Float(pauseTime/endTime)
                thisExercise?.excerciseId = exercises[currentIndex.row].id
                thisExercise?.type = exercises[currentIndex.row].type.rawValue
                thisExercise?.limit = "\(String(describing: self.pauseTime))"
                
            }
            delegate?.reload()
        }
        
    }
    
    func updateReportInCacheAndServer() {
        let selectedWorkoutIndex = defaults.integer(forKey: UserDefaultKeys.selectedWorkoutIndex)
        let currentExercise = exercises[currentIndex.row]
        
        var thisExercise = defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?.filter({ $0.excerciseId ==  currentExerciseId })[0]
        
        delegate?.reload()
        
        let exid = currentExercise.id
        let type = currentExercise.type
        let limit = thisExercise?.limit
        let progress = thisExercise?.progress ?? 0.5
        let paused = thisExercise?.paused
        let completed = thisExercise?.completed
        
        guard let selectedId = selectedWorkoutId else { fatalError() }
        let reps = defaults.integer(forKey: UserDefaultKeys.reps)
        let sets = defaults.integer(forKey: UserDefaultKeys.sets)
        let count = defaults.integer(forKey: UserDefaultKeys.count)
        guard let time = defaults.string(forKey: UserDefaultKeys.time) else { fatalError()}
        
        // update cache
        let exercise = WorkoutData.Exercise(excerciseId: exid, type: type, paused: paused, limit: limit, completed: completed, progress: Int(progress))
        
        if workoutExercisesList.contains(where: { $0.excerciseId == exercise.excerciseId }) == true {
            
            let contained =  workoutExercisesList.filter({ $0.excerciseId == exercise.excerciseId })
            workoutExercisesList.remove(at: contained.startIndex)
            workoutExercisesList.insert(exercise, at: contained.startIndex)
        } else {
            workoutExercisesList.append(exercise)
        }
        let workout = WorkoutData(workoutId: selectedId, workoutReps: reps, workoutSet: sets, workoutTime: time, workoutCount: count, exercises: workoutExercisesList)
        data.updateCacheQuery(workouts: workout, userId: view.getUserID(), workoutId: selectedId)
        
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
        //        data.createReport(userId: view.getUserID(), workout: reportWorkoutInput)
        
    }
    
}
