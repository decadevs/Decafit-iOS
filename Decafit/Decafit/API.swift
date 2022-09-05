// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct ReportCreateInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - userId
  ///   - workouts
  public init(userId: String, workouts: ReportWorkoutInput) {
    graphQLMap = ["userID": userId, "workouts": workouts]
  }

  public var userId: String {
    get {
      return graphQLMap["userID"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "userID")
    }
  }

  public var workouts: ReportWorkoutInput {
    get {
      return graphQLMap["workouts"] as! ReportWorkoutInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "workouts")
    }
  }
}

public struct ReportWorkoutInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - workoutId
  ///   - workoutReps
  ///   - workoutSet
  ///   - workoutTime
  ///   - workoutCount
  ///   - exercises
  public init(workoutId: String, workoutReps: Int, workoutSet: Int, workoutTime: String, workoutCount: Int, exercises: [ReportExcerciseProgressInput]) {
    graphQLMap = ["workoutId": workoutId, "workoutReps": workoutReps, "workoutSet": workoutSet, "workoutTime": workoutTime, "workoutCount": workoutCount, "exercises": exercises]
  }

  public var workoutId: String {
    get {
      return graphQLMap["workoutId"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "workoutId")
    }
  }

  public var workoutReps: Int {
    get {
      return graphQLMap["workoutReps"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "workoutReps")
    }
  }

  public var workoutSet: Int {
    get {
      return graphQLMap["workoutSet"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "workoutSet")
    }
  }

  public var workoutTime: String {
    get {
      return graphQLMap["workoutTime"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "workoutTime")
    }
  }

  public var workoutCount: Int {
    get {
      return graphQLMap["workoutCount"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "workoutCount")
    }
  }

  public var exercises: [ReportExcerciseProgressInput] {
    get {
      return graphQLMap["exercises"] as! [ReportExcerciseProgressInput]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "exercises")
    }
  }
}

public struct ReportExcerciseProgressInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - excerciseId
  ///   - type
  ///   - paused
  ///   - limit
  ///   - completed
  ///   - progress
  public init(excerciseId: Swift.Optional<String?> = nil, type: Swift.Optional<EnumType?> = nil, paused: Swift.Optional<Bool?> = nil, limit: Swift.Optional<String?> = nil, completed: Swift.Optional<Bool?> = nil, progress: Swift.Optional<Int?> = nil) {
    graphQLMap = ["excerciseId": excerciseId, "type": type, "paused": paused, "limit": limit, "completed": completed, "progress": progress]
  }

  public var excerciseId: Swift.Optional<String?> {
    get {
      return graphQLMap["excerciseId"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "excerciseId")
    }
  }

  public var type: Swift.Optional<EnumType?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<EnumType?> ?? Swift.Optional<EnumType?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }

  public var paused: Swift.Optional<Bool?> {
    get {
      return graphQLMap["paused"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "paused")
    }
  }

  public var limit: Swift.Optional<String?> {
    get {
      return graphQLMap["limit"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "limit")
    }
  }

  public var completed: Swift.Optional<Bool?> {
    get {
      return graphQLMap["completed"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "completed")
    }
  }

  public var progress: Swift.Optional<Int?> {
    get {
      return graphQLMap["progress"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "progress")
    }
  }
}

public enum EnumType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case time
  case count
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "time": self = .time
      case "count": self = .count
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .time: return "time"
      case .count: return "count"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: EnumType, rhs: EnumType) -> Bool {
    switch (lhs, rhs) {
      case (.time, .time): return true
      case (.count, .count): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [EnumType] {
    return [
      .time,
      .count,
    ]
  }
}

public struct LoginInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - email
  ///   - password
  public init(email: String, password: String) {
    graphQLMap = ["email": email, "password": password]
  }

  public var email: String {
    get {
      return graphQLMap["email"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var password: String {
    get {
      return graphQLMap["password"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "password")
    }
  }
}

public struct RegisterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - fullName
  ///   - email
  ///   - phoneNumber
  ///   - password
  public init(fullName: String, email: String, phoneNumber: String, password: String) {
    graphQLMap = ["fullName": fullName, "email": email, "phoneNumber": phoneNumber, "password": password]
  }

  public var fullName: String {
    get {
      return graphQLMap["fullName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fullName")
    }
  }

  public var email: String {
    get {
      return graphQLMap["email"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var phoneNumber: String {
    get {
      return graphQLMap["phoneNumber"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "phoneNumber")
    }
  }

  public var password: String {
    get {
      return graphQLMap["password"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "password")
    }
  }
}

public final class CreateReportMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateReport($input: ReportCreateInput) {
      reportCreate(input: $input) {
        __typename
        userID
        workouts {
          __typename
          workoutId
        }
      }
    }
    """

  public let operationName: String = "CreateReport"

  public var input: ReportCreateInput?

  public init(input: ReportCreateInput? = nil) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("reportCreate", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(ReportCreate.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(reportCreate: ReportCreate) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "reportCreate": reportCreate.resultMap])
    }

    public var reportCreate: ReportCreate {
      get {
        return ReportCreate(unsafeResultMap: resultMap["reportCreate"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "reportCreate")
      }
    }

    public struct ReportCreate: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Report"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userID", type: .nonNull(.scalar(String.self))),
          GraphQLField("workouts", type: .object(Workout.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(userId: String, workouts: Workout? = nil) {
        self.init(unsafeResultMap: ["__typename": "Report", "userID": userId, "workouts": workouts.flatMap { (value: Workout) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var userId: String {
        get {
          return resultMap["userID"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "userID")
        }
      }

      public var workouts: Workout? {
        get {
          return (resultMap["workouts"] as? ResultMap).flatMap { Workout(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "workouts")
        }
      }

      public struct Workout: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ReportWorkout"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("workoutId", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(workoutId: String) {
          self.init(unsafeResultMap: ["__typename": "ReportWorkout", "workoutId": workoutId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var workoutId: String {
          get {
            return resultMap["workoutId"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutId")
          }
        }
      }
    }
  }
}

public final class GetReportQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetReport($userId: String!) {
      report(userID: $userId) {
        __typename
        userID
        workouts {
          __typename
          workoutId
          workoutReps
          workoutSet
          workoutTime
          workoutCount
          exercises {
            __typename
            excerciseId
            type
            paused
            limit
            completed
            progress
          }
        }
      }
    }
    """

  public let operationName: String = "GetReport"

  public var userId: String

  public init(userId: String) {
    self.userId = userId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("report", arguments: ["userID": GraphQLVariable("userId")], type: .object(Report.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(report: Report? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "report": report.flatMap { (value: Report) -> ResultMap in value.resultMap }])
    }

    public var report: Report? {
      get {
        return (resultMap["report"] as? ResultMap).flatMap { Report(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "report")
      }
    }

    public struct Report: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Report"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userID", type: .nonNull(.scalar(String.self))),
          GraphQLField("workouts", type: .object(Workout.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(userId: String, workouts: Workout? = nil) {
        self.init(unsafeResultMap: ["__typename": "Report", "userID": userId, "workouts": workouts.flatMap { (value: Workout) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var userId: String {
        get {
          return resultMap["userID"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "userID")
        }
      }

      public var workouts: Workout? {
        get {
          return (resultMap["workouts"] as? ResultMap).flatMap { Workout(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "workouts")
        }
      }

      public struct Workout: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ReportWorkout"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("workoutId", type: .nonNull(.scalar(String.self))),
            GraphQLField("workoutReps", type: .nonNull(.scalar(Int.self))),
            GraphQLField("workoutSet", type: .nonNull(.scalar(Int.self))),
            GraphQLField("workoutTime", type: .nonNull(.scalar(String.self))),
            GraphQLField("workoutCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("exercises", type: .nonNull(.list(.nonNull(.object(Exercise.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(workoutId: String, workoutReps: Int, workoutSet: Int, workoutTime: String, workoutCount: Int, exercises: [Exercise]) {
          self.init(unsafeResultMap: ["__typename": "ReportWorkout", "workoutId": workoutId, "workoutReps": workoutReps, "workoutSet": workoutSet, "workoutTime": workoutTime, "workoutCount": workoutCount, "exercises": exercises.map { (value: Exercise) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var workoutId: String {
          get {
            return resultMap["workoutId"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutId")
          }
        }

        public var workoutReps: Int {
          get {
            return resultMap["workoutReps"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutReps")
          }
        }

        public var workoutSet: Int {
          get {
            return resultMap["workoutSet"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutSet")
          }
        }

        public var workoutTime: String {
          get {
            return resultMap["workoutTime"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutTime")
          }
        }

        public var workoutCount: Int {
          get {
            return resultMap["workoutCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutCount")
          }
        }

        public var exercises: [Exercise] {
          get {
            return (resultMap["exercises"] as! [ResultMap]).map { (value: ResultMap) -> Exercise in Exercise(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Exercise) -> ResultMap in value.resultMap }, forKey: "exercises")
          }
        }

        public struct Exercise: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ReportExcerciseProgress"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("excerciseId", type: .scalar(String.self)),
              GraphQLField("type", type: .scalar(EnumType.self)),
              GraphQLField("paused", type: .scalar(Bool.self)),
              GraphQLField("limit", type: .scalar(String.self)),
              GraphQLField("completed", type: .scalar(Bool.self)),
              GraphQLField("progress", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(excerciseId: String? = nil, type: EnumType? = nil, paused: Bool? = nil, limit: String? = nil, completed: Bool? = nil, progress: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "ReportExcerciseProgress", "excerciseId": excerciseId, "type": type, "paused": paused, "limit": limit, "completed": completed, "progress": progress])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var excerciseId: String? {
            get {
              return resultMap["excerciseId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "excerciseId")
            }
          }

          public var type: EnumType? {
            get {
              return resultMap["type"] as? EnumType
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }

          public var paused: Bool? {
            get {
              return resultMap["paused"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "paused")
            }
          }

          public var limit: String? {
            get {
              return resultMap["limit"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "limit")
            }
          }

          public var completed: Bool? {
            get {
              return resultMap["completed"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "completed")
            }
          }

          public var progress: Int? {
            get {
              return resultMap["progress"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "progress")
            }
          }
        }
      }
    }
  }
}

public final class GetWorkoutReportQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetWorkoutReport($userId: String!, $workoutId: String!) {
      reportWorkout(userID: $userId, workoutID: $workoutId) {
        __typename
        userID
        workouts {
          __typename
          workoutId
          workoutReps
          workoutSet
          workoutTime
          workoutCount
          exercises {
            __typename
            excerciseId
            type
            paused
            limit
            completed
            progress
          }
        }
      }
    }
    """

  public let operationName: String = "GetWorkoutReport"

  public var userId: String
  public var workoutId: String

  public init(userId: String, workoutId: String) {
    self.userId = userId
    self.workoutId = workoutId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "workoutId": workoutId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("reportWorkout", arguments: ["userID": GraphQLVariable("userId"), "workoutID": GraphQLVariable("workoutId")], type: .object(ReportWorkout.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(reportWorkout: ReportWorkout? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "reportWorkout": reportWorkout.flatMap { (value: ReportWorkout) -> ResultMap in value.resultMap }])
    }

    public var reportWorkout: ReportWorkout? {
      get {
        return (resultMap["reportWorkout"] as? ResultMap).flatMap { ReportWorkout(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "reportWorkout")
      }
    }

    public struct ReportWorkout: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Report"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userID", type: .nonNull(.scalar(String.self))),
          GraphQLField("workouts", type: .object(Workout.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(userId: String, workouts: Workout? = nil) {
        self.init(unsafeResultMap: ["__typename": "Report", "userID": userId, "workouts": workouts.flatMap { (value: Workout) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var userId: String {
        get {
          return resultMap["userID"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "userID")
        }
      }

      public var workouts: Workout? {
        get {
          return (resultMap["workouts"] as? ResultMap).flatMap { Workout(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "workouts")
        }
      }

      public struct Workout: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ReportWorkout"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("workoutId", type: .nonNull(.scalar(String.self))),
            GraphQLField("workoutReps", type: .nonNull(.scalar(Int.self))),
            GraphQLField("workoutSet", type: .nonNull(.scalar(Int.self))),
            GraphQLField("workoutTime", type: .nonNull(.scalar(String.self))),
            GraphQLField("workoutCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("exercises", type: .nonNull(.list(.nonNull(.object(Exercise.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(workoutId: String, workoutReps: Int, workoutSet: Int, workoutTime: String, workoutCount: Int, exercises: [Exercise]) {
          self.init(unsafeResultMap: ["__typename": "ReportWorkout", "workoutId": workoutId, "workoutReps": workoutReps, "workoutSet": workoutSet, "workoutTime": workoutTime, "workoutCount": workoutCount, "exercises": exercises.map { (value: Exercise) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var workoutId: String {
          get {
            return resultMap["workoutId"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutId")
          }
        }

        public var workoutReps: Int {
          get {
            return resultMap["workoutReps"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutReps")
          }
        }

        public var workoutSet: Int {
          get {
            return resultMap["workoutSet"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutSet")
          }
        }

        public var workoutTime: String {
          get {
            return resultMap["workoutTime"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutTime")
          }
        }

        public var workoutCount: Int {
          get {
            return resultMap["workoutCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutCount")
          }
        }

        public var exercises: [Exercise] {
          get {
            return (resultMap["exercises"] as! [ResultMap]).map { (value: ResultMap) -> Exercise in Exercise(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Exercise) -> ResultMap in value.resultMap }, forKey: "exercises")
          }
        }

        public struct Exercise: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ReportExcerciseProgress"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("excerciseId", type: .scalar(String.self)),
              GraphQLField("type", type: .scalar(EnumType.self)),
              GraphQLField("paused", type: .scalar(Bool.self)),
              GraphQLField("limit", type: .scalar(String.self)),
              GraphQLField("completed", type: .scalar(Bool.self)),
              GraphQLField("progress", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(excerciseId: String? = nil, type: EnumType? = nil, paused: Bool? = nil, limit: String? = nil, completed: Bool? = nil, progress: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "ReportExcerciseProgress", "excerciseId": excerciseId, "type": type, "paused": paused, "limit": limit, "completed": completed, "progress": progress])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var excerciseId: String? {
            get {
              return resultMap["excerciseId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "excerciseId")
            }
          }

          public var type: EnumType? {
            get {
              return resultMap["type"] as? EnumType
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }

          public var paused: Bool? {
            get {
              return resultMap["paused"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "paused")
            }
          }

          public var limit: String? {
            get {
              return resultMap["limit"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "limit")
            }
          }

          public var completed: Bool? {
            get {
              return resultMap["completed"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "completed")
            }
          }

          public var progress: Int? {
            get {
              return resultMap["progress"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "progress")
            }
          }
        }
      }
    }
  }
}

public final class LoginMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Login($user: LoginInput) {
      userLogin(user: $user) {
        __typename
        id
        fullName
        email
        phoneNumber
        createdAt
        message
        token
      }
    }
    """

  public let operationName: String = "Login"

  public var user: LoginInput?

  public init(user: LoginInput? = nil) {
    self.user = user
  }

  public var variables: GraphQLMap? {
    return ["user": user]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("userLogin", arguments: ["user": GraphQLVariable("user")], type: .nonNull(.object(UserLogin.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userLogin: UserLogin) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "userLogin": userLogin.resultMap])
    }

    public var userLogin: UserLogin {
      get {
        return UserLogin(unsafeResultMap: resultMap["userLogin"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "userLogin")
      }
    }

    public struct UserLogin: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserLogin"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("fullName", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("phoneNumber", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
          GraphQLField("token", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, fullName: String, email: String, phoneNumber: String, createdAt: String? = nil, message: String, token: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserLogin", "id": id, "fullName": fullName, "email": email, "phoneNumber": phoneNumber, "createdAt": createdAt, "message": message, "token": token])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var fullName: String {
        get {
          return resultMap["fullName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "fullName")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var phoneNumber: String {
        get {
          return resultMap["phoneNumber"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "phoneNumber")
        }
      }

      public var createdAt: String? {
        get {
          return resultMap["createdAt"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }

      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }
    }
  }
}

public final class RegisterMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Register($user: RegisterInput) {
      userRegister(user: $user) {
        __typename
        id
        fullName
        email
        phoneNumber
        message
      }
    }
    """

  public let operationName: String = "Register"

  public var user: RegisterInput?

  public init(user: RegisterInput? = nil) {
    self.user = user
  }

  public var variables: GraphQLMap? {
    return ["user": user]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("userRegister", arguments: ["user": GraphQLVariable("user")], type: .nonNull(.object(UserRegister.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userRegister: UserRegister) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "userRegister": userRegister.resultMap])
    }

    public var userRegister: UserRegister {
      get {
        return UserRegister(unsafeResultMap: resultMap["userRegister"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "userRegister")
      }
    }

    public struct UserRegister: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserRegistration"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("fullName", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("phoneNumber", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, fullName: String, email: String, phoneNumber: String, message: String) {
        self.init(unsafeResultMap: ["__typename": "UserRegistration", "id": id, "fullName": fullName, "email": email, "phoneNumber": phoneNumber, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var fullName: String {
        get {
          return resultMap["fullName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "fullName")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var phoneNumber: String {
        get {
          return resultMap["phoneNumber"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "phoneNumber")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}

public final class ReportUpdateMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation ReportUpdate($input: ReportCreateInput) {
      reportUpdate(input: $input) {
        __typename
        userID
        workouts {
          __typename
          workoutId
          workoutReps
          workoutSet
          workoutTime
          workoutCount
          exercises {
            __typename
            excerciseId
            type
            paused
            limit
            completed
            progress
          }
        }
      }
    }
    """

  public let operationName: String = "ReportUpdate"

  public var input: ReportCreateInput?

  public init(input: ReportCreateInput? = nil) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("reportUpdate", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(ReportUpdate.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(reportUpdate: ReportUpdate) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "reportUpdate": reportUpdate.resultMap])
    }

    public var reportUpdate: ReportUpdate {
      get {
        return ReportUpdate(unsafeResultMap: resultMap["reportUpdate"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "reportUpdate")
      }
    }

    public struct ReportUpdate: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Report"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userID", type: .nonNull(.scalar(String.self))),
          GraphQLField("workouts", type: .object(Workout.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(userId: String, workouts: Workout? = nil) {
        self.init(unsafeResultMap: ["__typename": "Report", "userID": userId, "workouts": workouts.flatMap { (value: Workout) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var userId: String {
        get {
          return resultMap["userID"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "userID")
        }
      }

      public var workouts: Workout? {
        get {
          return (resultMap["workouts"] as? ResultMap).flatMap { Workout(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "workouts")
        }
      }

      public struct Workout: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ReportWorkout"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("workoutId", type: .nonNull(.scalar(String.self))),
            GraphQLField("workoutReps", type: .nonNull(.scalar(Int.self))),
            GraphQLField("workoutSet", type: .nonNull(.scalar(Int.self))),
            GraphQLField("workoutTime", type: .nonNull(.scalar(String.self))),
            GraphQLField("workoutCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("exercises", type: .nonNull(.list(.nonNull(.object(Exercise.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(workoutId: String, workoutReps: Int, workoutSet: Int, workoutTime: String, workoutCount: Int, exercises: [Exercise]) {
          self.init(unsafeResultMap: ["__typename": "ReportWorkout", "workoutId": workoutId, "workoutReps": workoutReps, "workoutSet": workoutSet, "workoutTime": workoutTime, "workoutCount": workoutCount, "exercises": exercises.map { (value: Exercise) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var workoutId: String {
          get {
            return resultMap["workoutId"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutId")
          }
        }

        public var workoutReps: Int {
          get {
            return resultMap["workoutReps"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutReps")
          }
        }

        public var workoutSet: Int {
          get {
            return resultMap["workoutSet"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutSet")
          }
        }

        public var workoutTime: String {
          get {
            return resultMap["workoutTime"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutTime")
          }
        }

        public var workoutCount: Int {
          get {
            return resultMap["workoutCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "workoutCount")
          }
        }

        public var exercises: [Exercise] {
          get {
            return (resultMap["exercises"] as! [ResultMap]).map { (value: ResultMap) -> Exercise in Exercise(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Exercise) -> ResultMap in value.resultMap }, forKey: "exercises")
          }
        }

        public struct Exercise: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ReportExcerciseProgress"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("excerciseId", type: .scalar(String.self)),
              GraphQLField("type", type: .scalar(EnumType.self)),
              GraphQLField("paused", type: .scalar(Bool.self)),
              GraphQLField("limit", type: .scalar(String.self)),
              GraphQLField("completed", type: .scalar(Bool.self)),
              GraphQLField("progress", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(excerciseId: String? = nil, type: EnumType? = nil, paused: Bool? = nil, limit: String? = nil, completed: Bool? = nil, progress: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "ReportExcerciseProgress", "excerciseId": excerciseId, "type": type, "paused": paused, "limit": limit, "completed": completed, "progress": progress])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var excerciseId: String? {
            get {
              return resultMap["excerciseId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "excerciseId")
            }
          }

          public var type: EnumType? {
            get {
              return resultMap["type"] as? EnumType
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }

          public var paused: Bool? {
            get {
              return resultMap["paused"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "paused")
            }
          }

          public var limit: String? {
            get {
              return resultMap["limit"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "limit")
            }
          }

          public var completed: Bool? {
            get {
              return resultMap["completed"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "completed")
            }
          }

          public var progress: Int? {
            get {
              return resultMap["progress"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "progress")
            }
          }
        }
      }
    }
  }
}

public final class WorkoutListQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query WorkoutList {
      workouts {
        __typename
        id
        title
        backgroundImage
        sets
        reps
        createdAt
        exercises {
          __typename
          id
          title
          description
          image
          type
        }
      }
    }
    """

  public let operationName: String = "WorkoutList"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("workouts", type: .nonNull(.list(.object(Workout.selections)))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(workouts: [Workout?]) {
      self.init(unsafeResultMap: ["__typename": "Query", "workouts": workouts.map { (value: Workout?) -> ResultMap? in value.flatMap { (value: Workout) -> ResultMap in value.resultMap } }])
    }

    public var workouts: [Workout?] {
      get {
        return (resultMap["workouts"] as! [ResultMap?]).map { (value: ResultMap?) -> Workout? in value.flatMap { (value: ResultMap) -> Workout in Workout(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Workout?) -> ResultMap? in value.flatMap { (value: Workout) -> ResultMap in value.resultMap } }, forKey: "workouts")
      }
    }

    public struct Workout: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["WorkOut"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("backgroundImage", type: .nonNull(.scalar(String.self))),
          GraphQLField("sets", type: .scalar(Int.self)),
          GraphQLField("reps", type: .scalar(Int.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("exercises", type: .list(.object(Exercise.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, title: String, backgroundImage: String, sets: Int? = nil, reps: Int? = nil, createdAt: String? = nil, exercises: [Exercise?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "WorkOut", "id": id, "title": title, "backgroundImage": backgroundImage, "sets": sets, "reps": reps, "createdAt": createdAt, "exercises": exercises.flatMap { (value: [Exercise?]) -> [ResultMap?] in value.map { (value: Exercise?) -> ResultMap? in value.flatMap { (value: Exercise) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var backgroundImage: String {
        get {
          return resultMap["backgroundImage"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "backgroundImage")
        }
      }

      public var sets: Int? {
        get {
          return resultMap["sets"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "sets")
        }
      }

      public var reps: Int? {
        get {
          return resultMap["reps"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "reps")
        }
      }

      public var createdAt: String? {
        get {
          return resultMap["createdAt"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var exercises: [Exercise?]? {
        get {
          return (resultMap["exercises"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Exercise?] in value.map { (value: ResultMap?) -> Exercise? in value.flatMap { (value: ResultMap) -> Exercise in Exercise(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Exercise?]) -> [ResultMap?] in value.map { (value: Exercise?) -> ResultMap? in value.flatMap { (value: Exercise) -> ResultMap in value.resultMap } } }, forKey: "exercises")
        }
      }

      public struct Exercise: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Excercise"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .nonNull(.scalar(String.self))),
            GraphQLField("image", type: .nonNull(.scalar(String.self))),
            GraphQLField("type", type: .nonNull(.scalar(EnumType.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: String, description: String, image: String, type: EnumType) {
          self.init(unsafeResultMap: ["__typename": "Excercise", "id": id, "title": title, "description": description, "image": image, "type": type])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var image: String {
          get {
            return resultMap["image"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "image")
          }
        }

        public var type: EnumType {
          get {
            return resultMap["type"]! as! EnumType
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }
      }
    }
  }
}
