// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

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

public final class RegisterMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Register($user: RegisterInput) {
      register(user: $user) {
        __typename
        fullName
        email
        phoneNumber
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
        GraphQLField("register", arguments: ["user": GraphQLVariable("user")], type: .nonNull(.object(Register.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(register: Register) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "register": register.resultMap])
    }

    public var register: Register {
      get {
        return Register(unsafeResultMap: resultMap["register"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "register")
      }
    }

    public struct Register: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserRegistration"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("fullName", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("phoneNumber", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(fullName: String, email: String, phoneNumber: String) {
        self.init(unsafeResultMap: ["__typename": "UserRegistration", "fullName": fullName, "email": email, "phoneNumber": phoneNumber])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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
    }
  }
}
