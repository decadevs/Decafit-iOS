// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

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
