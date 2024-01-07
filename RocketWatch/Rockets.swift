// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class RocketsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Rockets {
      rockets {
        __typename
        name
      }
    }
    """

  public let operationName: String = "Rockets"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("rockets", type: .list(.object(Rocket.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(rockets: [Rocket?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "rockets": rockets.flatMap { (value: [Rocket?]) -> [ResultMap?] in value.map { (value: Rocket?) -> ResultMap? in value.flatMap { (value: Rocket) -> ResultMap in value.resultMap } } }])
    }

    public var rockets: [Rocket?]? {
      get {
        return (resultMap["rockets"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Rocket?] in value.map { (value: ResultMap?) -> Rocket? in value.flatMap { (value: ResultMap) -> Rocket in Rocket(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Rocket?]) -> [ResultMap?] in value.map { (value: Rocket?) -> ResultMap? in value.flatMap { (value: Rocket) -> ResultMap in value.resultMap } } }, forKey: "rockets")
      }
    }

    public struct Rocket: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Rocket"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Rocket", "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }
  }
}
