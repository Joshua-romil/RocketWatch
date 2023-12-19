// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ShipsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Ships {
      ships {
        __typename
        image
        model
        name
      }
    }
    """

  public let operationName: String = "Ships"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("ships", type: .list(.object(Ship.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(ships: [Ship?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "ships": ships.flatMap { (value: [Ship?]) -> [ResultMap?] in value.map { (value: Ship?) -> ResultMap? in value.flatMap { (value: Ship) -> ResultMap in value.resultMap } } }])
    }

    public var ships: [Ship?]? {
      get {
        return (resultMap["ships"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Ship?] in value.map { (value: ResultMap?) -> Ship? in value.flatMap { (value: ResultMap) -> Ship in Ship(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Ship?]) -> [ResultMap?] in value.map { (value: Ship?) -> ResultMap? in value.flatMap { (value: Ship) -> ResultMap in value.resultMap } } }, forKey: "ships")
      }
    }

    public struct Ship: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Ship"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("image", type: .scalar(String.self)),
          GraphQLField("model", type: .scalar(String.self)),
          GraphQLField("name", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(image: String? = nil, model: String? = nil, name: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Ship", "image": image, "model": model, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var image: String? {
        get {
          return resultMap["image"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image")
        }
      }

      public var model: String? {
        get {
          return resultMap["model"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "model")
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
