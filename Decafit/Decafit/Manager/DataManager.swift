//
//  DataManager.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import Foundation
import Apollo

final class DataManager {
    static let shared = DataManager()
    private var activeRequest: Cancellable?
    typealias WorkoutData = WorkoutListQuery.Data.Workout
    var workouts = [WorkoutData?]()
    var completion: ((GraphQLResult<WorkoutListQuery.Data>) -> Void)?
    var exerciseCompletion: (([WorkoutData.Exercise]) -> Void)?
    
    func fetchData() {
        Network.shared.apolloSQLite.watch(query: WorkoutListQuery(), cachePolicy: .returnCacheDataAndFetch, callbackQueue: .main) { result in
            switch result {
            case .failure(let error):
              print("Failure! Error: \(error)")
            case .success(let graphQLResult):
              print("Success! Result: ")
              self.completion?(graphQLResult)
            }
        }
    }
    func getExerciseList(workoutId: String) {
        fetchData()
        self.completion = { [self] graphQLResult in
            if let workouts = graphQLResult.data?.workouts.compactMap({ $0 }) {
                let workout = workouts.filter({ $0.id == workoutId})
                if let exercises = workout[0].exercises?.compactMap({ $0 }) {
                    exerciseCompletion?(exercises)
                }
            }
        }
    }
    func getTodayData() -> [TodaySessionModel] {
        return todayData
    }
    
    public func updateReport(userId: String, workout: ReportWorkoutInput) {
        let reportWorkoutInput = ReportWorkoutInput(workoutId: workout.workoutId, workoutReps: workout.workoutReps, workoutSet: workout.workoutSet, workoutTime: workout.workoutTime, workoutCount: workout.workoutCount, exercises: workout.exercises)
        let reportCreateInput = ReportCreateInput(userId: userId, workouts: reportWorkoutInput)
        Network.shared.apolloSQLite.perform(mutation: UpdateReportMutation(input: reportCreateInput)) { result in
            HUD.hide()
            switch result {
            case .failure(let error):
                print("Errors", error.localizedDescription)
                return
            case .success(let graphQLResult):
                if let errors = graphQLResult.errors {
                    
                    let message = errors
                                   .map { $0.localizedDescription }
                                   .joined(separator: "\n")
                    print(message)
                    return
                }
                if graphQLResult.data?.reportUpdate != nil {
                    print(graphQLResult.data?.reportUpdate)
                }
            }
            
        }

        
    }
}
