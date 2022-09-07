//
//  DataManager.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import Foundation
import Apollo
import Network

final class DataManager {
    static let shared = DataManager()
    typealias WorkoutData = WorkoutListQuery.Data.Workout
    let apolloSQ = Network.shared.apolloSQLite
    
    var fetchWorkoutsCompletion: ((GraphQLResult<WorkoutListQuery.Data>) -> Void)?
    var exerciseCompletion: (([WorkoutData.Exercise]) -> Void)?
    var reportCompletion: ((GraphQLResult<GetWorkoutReportQuery.Data>) -> Void)?
    var workoutReportCacheCompletion: ((GetWorkoutReportQuery.Data) -> Void)?
    var updateCacheCompletion: ((GetWorkoutReportQuery.Data) -> Void)?
    var fetchReportFromCacheCompletion: ((GetReportQuery.Data) -> Void)?
    var fetchReportFromServerCompletion: ((GraphQLResult<GetReportQuery.Data>) -> Void)?

    // MARK: - Fetch From Server
    func watchServer<T: GraphQLQuery>(query: T, completion:
                                        @escaping (GraphQLResult<T.Data>) -> Void) {
        apolloSQ.watch(query: query,
                       cachePolicy: .returnCacheDataAndFetch,
                       callbackQueue: .main) { result in
            switch result {
            case .failure(let error):
                print("Failure! Error: \(error)")
            case .success(let graphQLResult):
                completion(graphQLResult)
            }
        }
    }
    
    func fetchWorkouts() {
        let query = WorkoutListQuery()
        if NetworkMonitor.shared.isConnected {
            watchServer(query: query) { [weak self] result in
                self?.fetchWorkoutsCompletion?(result)
            }
        } else {
            apolloSQ.store.load(query: query) { [weak self] result in
                switch result {
                case .failure(let error):
                    print("Failure! Error: \(error)")
                case .success(let graphQLResult):
                    DispatchQueue.main.async {
                        self?.fetchWorkoutsCompletion?(graphQLResult)
                    }
                }
                
            }
        }

    }
    
    func fetchWorkoutReportFromServer(userId: String, workoutId: String) {
        let query = GetWorkoutReportQuery(userId: userId, workoutId: workoutId)
        watchServer(query: query) {[weak self] result in
            self?.reportCompletion?(result)
        }
    }
    
    func fetchReportFromServer(userId: String) {
        let query = GetReportQuery(userId: userId)
        watchServer(query: query) {[weak self] result in 
            self?.fetchReportFromServerCompletion?(result)
        }
    }
    
    func getTodayData() -> [TodaySessionModel] {
        return todayData
    }
    
    // MARK: - Fetch from Cache
    func readCachedQuery<T: GraphQLQuery>(query: T, completion: @escaping (T.Data) -> Void) {
        apolloSQ.store.withinReadTransaction({ transaction in
            do {
                let data = try transaction.read(query: query)
                completion(data)
            } catch let error {
                print(error.localizedDescription)
            }
        })
    }
    func fetchExercisesFromCache(workoutId: String) {
        let query = WorkoutListQuery()
        readCachedQuery(query: query, completion: {[weak self] data in
            let workouts = data.workouts.compactMap({ $0 })
            let workout = workouts.filter({ $0.id == workoutId })
            if let exercises = workout[0].exercises?.compactMap({ $0 }) {
                self?.exerciseCompletion?(exercises)
            }
            
        })
    }
    func getExerciseList(workoutId: String) {
        fetchWorkouts()
        self.fetchWorkoutsCompletion = { [weak self] graphQLResult in
            if let workouts = graphQLResult.data?.workouts.compactMap({ $0 }) {
                let workout = workouts.filter({ $0.id == workoutId})
                if let exercises = workout[0].exercises?.compactMap({ $0 }) {
                    self?.exerciseCompletion?(exercises)
                }
            }
        }
    }
    func fetchWorkoutReportFromCache(userId: String, workoutId: String) {
        let query = GetWorkoutReportQuery(userId: userId, workoutId: workoutId)
        readCachedQuery(query: query, completion: {[weak self] data in
            self?.workoutReportCacheCompletion?(data)
        })
    }
    func fetchReportFromCache(userId: String) {
        let query = GetReportQuery(userId: userId)
        readCachedQuery(query: query, completion: { [weak self] data in
            self?.fetchReportFromCacheCompletion?(data)
        })
    }
    
    // MARK: - Update Cache
    func updateCacheQuery(workouts: GetWorkoutReportQuery.Data.ReportWorkout.Workout, userId: String, workoutId: String) {
        
        apolloSQ.store.withinReadWriteTransaction({ transaction in
            let query = GetWorkoutReportQuery(userId: userId, workoutId: workoutId)
            
            do {
                try transaction.update(query: query, { (data: inout GetWorkoutReportQuery.Data) in
                    data.reportWorkout?.workouts? = workouts
//                    print("After updating cache", data.reportWorkout?.workouts)
                })
                
            } catch let err {
                print(err.localizedDescription)
            }
            
        })
        
    }
    
    // MARK: - Mutations
    func createReport(userId: String, workout: ReportWorkoutInput) {
        let input = ReportCreateInput(userId: userId, workouts: workout)
        
        apolloSQ.perform(mutation: CreateReportMutation(input: input)) { result in
            switch result {
            case .failure(let error):
                print("Failure! Error: \(error)")
            case .success(let graphQLResult):
                print("Report Created Successfully: ")
                print(graphQLResult)
            }
        }
    }
    
    public func updateReport(userId: String, workout: ReportWorkoutInput) {
        let input = ReportCreateInput(userId: userId, workouts: workout)
        
        apolloSQ.perform(
            mutation: ReportUpdateMutation(input: input)) { result in
            switch result {
            case .failure(let error):
                print("Errors", error.localizedDescription)
                return
            case .success(let graphQLResult):
                if let output = graphQLResult.data {
                    print(output)
                }
                if let errors = graphQLResult.errors {
                    print(graphQLResult)
                    let message = errors
                        .map { $0.localizedDescription }
                        .joined(separator: "\n")
                    print(message)
                    return
                }
                
            }
        }
        
    }
    
}
