import Foundation

import FirebaseCore
import FirebaseDataConnect




















// MARK: Common Enums

public enum OrderDirection: String, Codable, Sendable {
  case ASC = "ASC"
  case DESC = "DESC"
  }

public enum SearchQueryFormat: String, Codable, Sendable {
  case QUERY = "QUERY"
  case PLAIN = "PLAIN"
  case PHRASE = "PHRASE"
  case ADVANCED = "ADVANCED"
  }


// MARK: Connector Enums

// End enum definitions









public class CreateComplimentProductMutation{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "CreateComplimentProduct"

  public typealias Ref = MutationRef<CreateComplimentProductMutation.Data,CreateComplimentProductMutation.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
senderId: UUID

  
        @OptionalVariable
        public var
compliments: [String]?

  
        @OptionalVariable
        public var
complimentsStore: [String]?


    
    
    
    public init (
        
senderId: UUID

        
        
        ,
        _ optionalVars: ((inout Variables)->())? = nil
        ) {
        self.senderId = senderId
        

        
        if let optionalVars {
            optionalVars(&self)
        }
        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.senderId == rhs.senderId && 
              lhs.compliments == rhs.compliments && 
              lhs.complimentsStore == rhs.complimentsStore
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(senderId)
  
  hasher.combine(compliments)
  
  hasher.combine(complimentsStore)
  
}

    enum CodingKeys: String, CodingKey {
      
      case senderId
      
      case compliments
      
      case complimentsStore
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(senderId, forKey: .senderId, container: &container)
      
      
      if $compliments.isSet { 
      try codecHelper.encode(compliments, forKey: .compliments, container: &container)
      }
      
      if $complimentsStore.isSet { 
      try codecHelper.encode(complimentsStore, forKey: .complimentsStore, container: &container)
      }
      
    }

  }

  public struct Data: Decodable, Sendable {



public var 
complimentProduct_insert: ComplimentProductKey

  }

  public func ref(
        
senderId: UUID

        
        ,
        _ optionalVars: ((inout CreateComplimentProductMutation.Variables)->())? = nil
        ) -> MutationRef<CreateComplimentProductMutation.Data,CreateComplimentProductMutation.Variables>  {
        var variables = CreateComplimentProductMutation.Variables(senderId:senderId)
        
        if let optionalVars {
            optionalVars(&variables)
        }
        

        let ref = dataConnect.mutation(name: "CreateComplimentProduct", variables: variables, resultsDataType:CreateComplimentProductMutation.Data.self)
        return ref as MutationRef<CreateComplimentProductMutation.Data,CreateComplimentProductMutation.Variables>
   }

  @MainActor
   public func execute(
        
senderId: UUID

        
        ,
        _ optionalVars: (@MainActor (inout CreateComplimentProductMutation.Variables)->())? = nil
        ) async throws -> OperationResult<CreateComplimentProductMutation.Data> {
        var variables = CreateComplimentProductMutation.Variables(senderId:senderId)
        
        if let optionalVars {
            optionalVars(&variables)
        }
        
        
        let ref = dataConnect.mutation(name: "CreateComplimentProduct", variables: variables, resultsDataType:CreateComplimentProductMutation.Data.self)
        
        return try await ref.execute()
        
   }
}






public class LinkProductToCreatorMutation{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "LinkProductToCreator"

  public typealias Ref = MutationRef<LinkProductToCreatorMutation.Data,LinkProductToCreatorMutation.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
userId: UUID

  
        
        public var
productId: UUID


    
    
    
    public init (
        
userId: UUID
,
        
productId: UUID

        
        ) {
        self.userId = userId
        self.productId = productId
        

        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.userId == rhs.userId && 
              lhs.productId == rhs.productId
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(userId)
  
  hasher.combine(productId)
  
}

    enum CodingKeys: String, CodingKey {
      
      case userId
      
      case productId
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(userId, forKey: .userId, container: &container)
      
      
      
      try codecHelper.encode(productId, forKey: .productId, container: &container)
      
      
    }

  }

  public struct Data: Decodable, Sendable {



public var 
user_update: UserKey?

  }

  public func ref(
        
userId: UUID
,
productId: UUID

        ) -> MutationRef<LinkProductToCreatorMutation.Data,LinkProductToCreatorMutation.Variables>  {
        var variables = LinkProductToCreatorMutation.Variables(userId:userId,productId:productId)
        

        let ref = dataConnect.mutation(name: "LinkProductToCreator", variables: variables, resultsDataType:LinkProductToCreatorMutation.Data.self)
        return ref as MutationRef<LinkProductToCreatorMutation.Data,LinkProductToCreatorMutation.Variables>
   }

  @MainActor
   public func execute(
        
userId: UUID
,
productId: UUID

        ) async throws -> OperationResult<LinkProductToCreatorMutation.Data> {
        var variables = LinkProductToCreatorMutation.Variables(userId:userId,productId:productId)
        
        
        let ref = dataConnect.mutation(name: "LinkProductToCreator", variables: variables, resultsDataType:LinkProductToCreatorMutation.Data.self)
        
        return try await ref.execute()
        
   }
}






public class LinkProductToReceiverMutation{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "LinkProductToReceiver"

  public typealias Ref = MutationRef<LinkProductToReceiverMutation.Data,LinkProductToReceiverMutation.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
userId: UUID

  
        
        public var
productId: UUID


    
    
    
    public init (
        
userId: UUID
,
        
productId: UUID

        
        ) {
        self.userId = userId
        self.productId = productId
        

        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.userId == rhs.userId && 
              lhs.productId == rhs.productId
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(userId)
  
  hasher.combine(productId)
  
}

    enum CodingKeys: String, CodingKey {
      
      case userId
      
      case productId
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(userId, forKey: .userId, container: &container)
      
      
      
      try codecHelper.encode(productId, forKey: .productId, container: &container)
      
      
    }

  }

  public struct Data: Decodable, Sendable {



public var 
user_update: UserKey?

  }

  public func ref(
        
userId: UUID
,
productId: UUID

        ) -> MutationRef<LinkProductToReceiverMutation.Data,LinkProductToReceiverMutation.Variables>  {
        var variables = LinkProductToReceiverMutation.Variables(userId:userId,productId:productId)
        

        let ref = dataConnect.mutation(name: "LinkProductToReceiver", variables: variables, resultsDataType:LinkProductToReceiverMutation.Data.self)
        return ref as MutationRef<LinkProductToReceiverMutation.Data,LinkProductToReceiverMutation.Variables>
   }

  @MainActor
   public func execute(
        
userId: UUID
,
productId: UUID

        ) async throws -> OperationResult<LinkProductToReceiverMutation.Data> {
        var variables = LinkProductToReceiverMutation.Variables(userId:userId,productId:productId)
        
        
        let ref = dataConnect.mutation(name: "LinkProductToReceiver", variables: variables, resultsDataType:LinkProductToReceiverMutation.Data.self)
        
        return try await ref.execute()
        
   }
}






public class LinkReceiverToProductMutation{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "LinkReceiverToProduct"

  public typealias Ref = MutationRef<LinkReceiverToProductMutation.Data,LinkReceiverToProductMutation.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
userId: UUID

  
        
        public var
productId: UUID


    
    
    
    public init (
        
userId: UUID
,
        
productId: UUID

        
        ) {
        self.userId = userId
        self.productId = productId
        

        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.userId == rhs.userId && 
              lhs.productId == rhs.productId
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(userId)
  
  hasher.combine(productId)
  
}

    enum CodingKeys: String, CodingKey {
      
      case userId
      
      case productId
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(userId, forKey: .userId, container: &container)
      
      
      
      try codecHelper.encode(productId, forKey: .productId, container: &container)
      
      
    }

  }

  public struct Data: Decodable, Sendable {



public var 
complimentProduct_update: ComplimentProductKey?

  }

  public func ref(
        
userId: UUID
,
productId: UUID

        ) -> MutationRef<LinkReceiverToProductMutation.Data,LinkReceiverToProductMutation.Variables>  {
        var variables = LinkReceiverToProductMutation.Variables(userId:userId,productId:productId)
        

        let ref = dataConnect.mutation(name: "LinkReceiverToProduct", variables: variables, resultsDataType:LinkReceiverToProductMutation.Data.self)
        return ref as MutationRef<LinkReceiverToProductMutation.Data,LinkReceiverToProductMutation.Variables>
   }

  @MainActor
   public func execute(
        
userId: UUID
,
productId: UUID

        ) async throws -> OperationResult<LinkReceiverToProductMutation.Data> {
        var variables = LinkReceiverToProductMutation.Variables(userId:userId,productId:productId)
        
        
        let ref = dataConnect.mutation(name: "LinkReceiverToProduct", variables: variables, resultsDataType:LinkReceiverToProductMutation.Data.self)
        
        return try await ref.execute()
        
   }
}






public class ToggleActivateUserProductMutation{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "ToggleActivateUserProduct"

  public typealias Ref = MutationRef<ToggleActivateUserProductMutation.Data,ToggleActivateUserProductMutation.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
userId: UUID

  
        
        public var
activate: Bool


    
    
    
    public init (
        
userId: UUID
,
        
activate: Bool

        
        ) {
        self.userId = userId
        self.activate = activate
        

        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.userId == rhs.userId && 
              lhs.activate == rhs.activate
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(userId)
  
  hasher.combine(activate)
  
}

    enum CodingKeys: String, CodingKey {
      
      case userId
      
      case activate
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(userId, forKey: .userId, container: &container)
      
      
      
      try codecHelper.encode(activate, forKey: .activate, container: &container)
      
      
    }

  }

  public struct Data: Decodable, Sendable {



public var 
user_update: UserKey?

  }

  public func ref(
        
userId: UUID
,
activate: Bool

        ) -> MutationRef<ToggleActivateUserProductMutation.Data,ToggleActivateUserProductMutation.Variables>  {
        var variables = ToggleActivateUserProductMutation.Variables(userId:userId,activate:activate)
        

        let ref = dataConnect.mutation(name: "ToggleActivateUserProduct", variables: variables, resultsDataType:ToggleActivateUserProductMutation.Data.self)
        return ref as MutationRef<ToggleActivateUserProductMutation.Data,ToggleActivateUserProductMutation.Variables>
   }

  @MainActor
   public func execute(
        
userId: UUID
,
activate: Bool

        ) async throws -> OperationResult<ToggleActivateUserProductMutation.Data> {
        var variables = ToggleActivateUserProductMutation.Variables(userId:userId,activate:activate)
        
        
        let ref = dataConnect.mutation(name: "ToggleActivateUserProduct", variables: variables, resultsDataType:ToggleActivateUserProductMutation.Data.self)
        
        return try await ref.execute()
        
   }
}






public class StartComplimentProductMutation{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "StartComplimentProduct"

  public typealias Ref = MutationRef<StartComplimentProductMutation.Data,StartComplimentProductMutation.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
productId: UUID


    
    
    
    public init (
        
productId: UUID

        
        ) {
        self.productId = productId
        

        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.productId == rhs.productId
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(productId)
  
}

    enum CodingKeys: String, CodingKey {
      
      case productId
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(productId, forKey: .productId, container: &container)
      
      
    }

  }

  public struct Data: Decodable, Sendable {



public var 
complimentProduct_update: ComplimentProductKey?

  }

  public func ref(
        
productId: UUID

        ) -> MutationRef<StartComplimentProductMutation.Data,StartComplimentProductMutation.Variables>  {
        var variables = StartComplimentProductMutation.Variables(productId:productId)
        

        let ref = dataConnect.mutation(name: "StartComplimentProduct", variables: variables, resultsDataType:StartComplimentProductMutation.Data.self)
        return ref as MutationRef<StartComplimentProductMutation.Data,StartComplimentProductMutation.Variables>
   }

  @MainActor
   public func execute(
        
productId: UUID

        ) async throws -> OperationResult<StartComplimentProductMutation.Data> {
        var variables = StartComplimentProductMutation.Variables(productId:productId)
        
        
        let ref = dataConnect.mutation(name: "StartComplimentProduct", variables: variables, resultsDataType:StartComplimentProductMutation.Data.self)
        
        return try await ref.execute()
        
   }
}






public class UpdateComplimentStoreMutation{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "updateComplimentStore"

  public typealias Ref = MutationRef<UpdateComplimentStoreMutation.Data,UpdateComplimentStoreMutation.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
productId: UUID

  
        @OptionalVariable
        public var
newComplimentStore: [String]?


    
    
    
    public init (
        
productId: UUID

        
        
        ,
        _ optionalVars: ((inout Variables)->())? = nil
        ) {
        self.productId = productId
        

        
        if let optionalVars {
            optionalVars(&self)
        }
        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.productId == rhs.productId && 
              lhs.newComplimentStore == rhs.newComplimentStore
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(productId)
  
  hasher.combine(newComplimentStore)
  
}

    enum CodingKeys: String, CodingKey {
      
      case productId
      
      case newComplimentStore
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(productId, forKey: .productId, container: &container)
      
      
      if $newComplimentStore.isSet { 
      try codecHelper.encode(newComplimentStore, forKey: .newComplimentStore, container: &container)
      }
      
    }

  }

  public struct Data: Decodable, Sendable {



public var 
complimentProduct_update: ComplimentProductKey?

  }

  public func ref(
        
productId: UUID

        
        ,
        _ optionalVars: ((inout UpdateComplimentStoreMutation.Variables)->())? = nil
        ) -> MutationRef<UpdateComplimentStoreMutation.Data,UpdateComplimentStoreMutation.Variables>  {
        var variables = UpdateComplimentStoreMutation.Variables(productId:productId)
        
        if let optionalVars {
            optionalVars(&variables)
        }
        

        let ref = dataConnect.mutation(name: "updateComplimentStore", variables: variables, resultsDataType:UpdateComplimentStoreMutation.Data.self)
        return ref as MutationRef<UpdateComplimentStoreMutation.Data,UpdateComplimentStoreMutation.Variables>
   }

  @MainActor
   public func execute(
        
productId: UUID

        
        ,
        _ optionalVars: (@MainActor (inout UpdateComplimentStoreMutation.Variables)->())? = nil
        ) async throws -> OperationResult<UpdateComplimentStoreMutation.Data> {
        var variables = UpdateComplimentStoreMutation.Variables(productId:productId)
        
        if let optionalVars {
            optionalVars(&variables)
        }
        
        
        let ref = dataConnect.mutation(name: "updateComplimentStore", variables: variables, resultsDataType:UpdateComplimentStoreMutation.Data.self)
        
        return try await ref.execute()
        
   }
}






public class UpdateComplimentsMutation{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "updateCompliments"

  public typealias Ref = MutationRef<UpdateComplimentsMutation.Data,UpdateComplimentsMutation.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
productId: UUID

  
        @OptionalVariable
        public var
newCompliments: [String]?


    
    
    
    public init (
        
productId: UUID

        
        
        ,
        _ optionalVars: ((inout Variables)->())? = nil
        ) {
        self.productId = productId
        

        
        if let optionalVars {
            optionalVars(&self)
        }
        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.productId == rhs.productId && 
              lhs.newCompliments == rhs.newCompliments
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(productId)
  
  hasher.combine(newCompliments)
  
}

    enum CodingKeys: String, CodingKey {
      
      case productId
      
      case newCompliments
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(productId, forKey: .productId, container: &container)
      
      
      if $newCompliments.isSet { 
      try codecHelper.encode(newCompliments, forKey: .newCompliments, container: &container)
      }
      
    }

  }

  public struct Data: Decodable, Sendable {



public var 
complimentProduct_update: ComplimentProductKey?

  }

  public func ref(
        
productId: UUID

        
        ,
        _ optionalVars: ((inout UpdateComplimentsMutation.Variables)->())? = nil
        ) -> MutationRef<UpdateComplimentsMutation.Data,UpdateComplimentsMutation.Variables>  {
        var variables = UpdateComplimentsMutation.Variables(productId:productId)
        
        if let optionalVars {
            optionalVars(&variables)
        }
        

        let ref = dataConnect.mutation(name: "updateCompliments", variables: variables, resultsDataType:UpdateComplimentsMutation.Data.self)
        return ref as MutationRef<UpdateComplimentsMutation.Data,UpdateComplimentsMutation.Variables>
   }

  @MainActor
   public func execute(
        
productId: UUID

        
        ,
        _ optionalVars: (@MainActor (inout UpdateComplimentsMutation.Variables)->())? = nil
        ) async throws -> OperationResult<UpdateComplimentsMutation.Data> {
        var variables = UpdateComplimentsMutation.Variables(productId:productId)
        
        if let optionalVars {
            optionalVars(&variables)
        }
        
        
        let ref = dataConnect.mutation(name: "updateCompliments", variables: variables, resultsDataType:UpdateComplimentsMutation.Data.self)
        
        return try await ref.execute()
        
   }
}






public class GetOtherUserQuery{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "GetOtherUser"

  public typealias Ref = QueryRefObservation<GetOtherUserQuery.Data,GetOtherUserQuery.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
id: UUID


    
    
    
    public init (
        
id: UUID

        
        ) {
        self.id = id
        

        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.id == rhs.id
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
}

    enum CodingKeys: String, CodingKey {
      
      case id
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(id, forKey: .id, container: &container)
      
      
    }

  }

  public struct Data: Decodable, Sendable {




public struct User: Decodable, Sendable ,Hashable, Equatable, Identifiable {
  


public var 
id: UUID



public var 
email: String



public var 
dateCreated: Timestamp



public var 
productActive: Bool



public var 
productFinished: Bool





public struct ComplimentProduct: Decodable, Sendable ,Hashable, Equatable, Identifiable {
  


public var 
id: UUID


  
  public var complimentProductKey: ComplimentProductKey {
    return ComplimentProductKey(
      
      id: id
    )
  }

  
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
}
public static func == (lhs: ComplimentProduct, rhs: ComplimentProduct) -> Bool {
    
    return lhs.id == rhs.id 
        
  }

  

  
  enum CodingKeys: String, CodingKey {
    
    case id
    
  }

  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()

    
    
    self.id = try codecHelper.decode(UUID.self, forKey: .id, container: &container)
    
    
  }
}
public var 
productHolder: ComplimentProduct?





public struct ComplimentProduct: Decodable, Sendable ,Hashable, Equatable, Identifiable {
  


public var 
id: UUID


  
  public var complimentProductKey: ComplimentProductKey {
    return ComplimentProductKey(
      
      id: id
    )
  }

  
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
}
public static func == (lhs: ComplimentProduct, rhs: ComplimentProduct) -> Bool {
    
    return lhs.id == rhs.id 
        
  }

  

  
  enum CodingKeys: String, CodingKey {
    
    case id
    
  }

  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()

    
    
    self.id = try codecHelper.decode(UUID.self, forKey: .id, container: &container)
    
    
  }
}
public var 
productReceiving: ComplimentProduct?


  
  public var userKey: UserKey {
    return UserKey(
      
      id: id
    )
  }

  
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
}
public static func == (lhs: User, rhs: User) -> Bool {
    
    return lhs.id == rhs.id 
        
  }

  

  
  enum CodingKeys: String, CodingKey {
    
    case id
    
    case email
    
    case dateCreated
    
    case productActive
    
    case productFinished
    
    case productHolder
    
    case productReceiving
    
  }

  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()

    
    
    self.id = try codecHelper.decode(UUID.self, forKey: .id, container: &container)
    
    
    
    self.email = try codecHelper.decode(String.self, forKey: .email, container: &container)
    
    
    
    self.dateCreated = try codecHelper.decode(Timestamp.self, forKey: .dateCreated, container: &container)
    
    
    
    self.productActive = try codecHelper.decode(Bool.self, forKey: .productActive, container: &container)
    
    
    
    self.productFinished = try codecHelper.decode(Bool.self, forKey: .productFinished, container: &container)
    
    
    
    self.productHolder = try codecHelper.decode(ComplimentProduct?.self, forKey: .productHolder, container: &container)
    
    
    
    self.productReceiving = try codecHelper.decode(ComplimentProduct?.self, forKey: .productReceiving, container: &container)
    
    
  }
}
public var 
user: User?

  }

  public func ref(
        
id: UUID

        ) -> QueryRefObservation<GetOtherUserQuery.Data,GetOtherUserQuery.Variables>  {
        var variables = GetOtherUserQuery.Variables(id:id)
        

        let ref = dataConnect.query(name: "GetOtherUser", variables: variables, resultsDataType:GetOtherUserQuery.Data.self, publisher: .observableMacro)
        return ref as! QueryRefObservation<GetOtherUserQuery.Data,GetOtherUserQuery.Variables>
   }

  @MainActor
   public func execute(
        
id: UUID

        ) async throws -> OperationResult<GetOtherUserQuery.Data> {
        var variables = GetOtherUserQuery.Variables(id:id)
        
        
        let ref = dataConnect.query(name: "GetOtherUser", variables: variables, resultsDataType:GetOtherUserQuery.Data.self, publisher: .observableMacro)
        
        let refCast = ref as! QueryRefObservation<GetOtherUserQuery.Data,GetOtherUserQuery.Variables>
        return try await refCast.execute()
        
   }
}






public class GetUserQuery{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "GetUser"

  public typealias Ref = QueryRefObservation<GetUserQuery.Data,GetUserQuery.Variables>

  public struct Variables: OperationVariable {

    
    
  }

  public struct Data: Decodable, Sendable {




public struct User: Decodable, Sendable ,Hashable, Equatable, Identifiable {
  


public var 
id: UUID



public var 
email: String



public var 
productActive: Bool



public var 
productFinished: Bool



public var 
dateCreated: Timestamp





public struct ComplimentProduct: Decodable, Sendable ,Hashable, Equatable, Identifiable {
  


public var 
id: UUID


  
  public var complimentProductKey: ComplimentProductKey {
    return ComplimentProductKey(
      
      id: id
    )
  }

  
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
}
public static func == (lhs: ComplimentProduct, rhs: ComplimentProduct) -> Bool {
    
    return lhs.id == rhs.id 
        
  }

  

  
  enum CodingKeys: String, CodingKey {
    
    case id
    
  }

  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()

    
    
    self.id = try codecHelper.decode(UUID.self, forKey: .id, container: &container)
    
    
  }
}
public var 
productHolder: ComplimentProduct?





public struct ComplimentProduct: Decodable, Sendable ,Hashable, Equatable, Identifiable {
  


public var 
id: UUID


  
  public var complimentProductKey: ComplimentProductKey {
    return ComplimentProductKey(
      
      id: id
    )
  }

  
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
}
public static func == (lhs: ComplimentProduct, rhs: ComplimentProduct) -> Bool {
    
    return lhs.id == rhs.id 
        
  }

  

  
  enum CodingKeys: String, CodingKey {
    
    case id
    
  }

  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()

    
    
    self.id = try codecHelper.decode(UUID.self, forKey: .id, container: &container)
    
    
  }
}
public var 
productReceiving: ComplimentProduct?


  
  public var userKey: UserKey {
    return UserKey(
      
      id: id
    )
  }

  
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
}
public static func == (lhs: User, rhs: User) -> Bool {
    
    return lhs.id == rhs.id 
        
  }

  

  
  enum CodingKeys: String, CodingKey {
    
    case id
    
    case email
    
    case productActive
    
    case productFinished
    
    case dateCreated
    
    case productHolder
    
    case productReceiving
    
  }

  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()

    
    
    self.id = try codecHelper.decode(UUID.self, forKey: .id, container: &container)
    
    
    
    self.email = try codecHelper.decode(String.self, forKey: .email, container: &container)
    
    
    
    self.productActive = try codecHelper.decode(Bool.self, forKey: .productActive, container: &container)
    
    
    
    self.productFinished = try codecHelper.decode(Bool.self, forKey: .productFinished, container: &container)
    
    
    
    self.dateCreated = try codecHelper.decode(Timestamp.self, forKey: .dateCreated, container: &container)
    
    
    
    self.productHolder = try codecHelper.decode(ComplimentProduct?.self, forKey: .productHolder, container: &container)
    
    
    
    self.productReceiving = try codecHelper.decode(ComplimentProduct?.self, forKey: .productReceiving, container: &container)
    
    
  }
}
public var 
user: User?

  }

  public func ref(
        
        ) -> QueryRefObservation<GetUserQuery.Data,GetUserQuery.Variables>  {
        var variables = GetUserQuery.Variables()
        

        let ref = dataConnect.query(name: "GetUser", variables: variables, resultsDataType:GetUserQuery.Data.self, publisher: .observableMacro)
        return ref as! QueryRefObservation<GetUserQuery.Data,GetUserQuery.Variables>
   }

  @MainActor
   public func execute(
        
        ) async throws -> OperationResult<GetUserQuery.Data> {
        var variables = GetUserQuery.Variables()
        
        
        let ref = dataConnect.query(name: "GetUser", variables: variables, resultsDataType:GetUserQuery.Data.self, publisher: .observableMacro)
        
        let refCast = ref as! QueryRefObservation<GetUserQuery.Data,GetUserQuery.Variables>
        return try await refCast.execute()
        
   }
}






public class GetGiftQuery{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "GetGift"

  public typealias Ref = QueryRefObservation<GetGiftQuery.Data,GetGiftQuery.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
id: UUID


    
    
    
    public init (
        
id: UUID

        
        ) {
        self.id = id
        

        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.id == rhs.id
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
}

    enum CodingKeys: String, CodingKey {
      
      case id
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(id, forKey: .id, container: &container)
      
      
    }

  }

  public struct Data: Decodable, Sendable {




public struct ComplimentProduct: Decodable, Sendable  {
  


public var 
started: Bool



public var 
compliments: [String]?



public var 
complimentStore: [String]?





public struct User: Decodable, Sendable ,Hashable, Equatable, Identifiable {
  


public var 
id: UUID


  
  public var userKey: UserKey {
    return UserKey(
      
      id: id
    )
  }

  
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
}
public static func == (lhs: User, rhs: User) -> Bool {
    
    return lhs.id == rhs.id 
        
  }

  

  
  enum CodingKeys: String, CodingKey {
    
    case id
    
  }

  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()

    
    
    self.id = try codecHelper.decode(UUID.self, forKey: .id, container: &container)
    
    
  }
}
public var 
sender: User





public struct User: Decodable, Sendable ,Hashable, Equatable, Identifiable {
  


public var 
id: UUID


  
  public var userKey: UserKey {
    return UserKey(
      
      id: id
    )
  }

  
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
}
public static func == (lhs: User, rhs: User) -> Bool {
    
    return lhs.id == rhs.id 
        
  }

  

  
  enum CodingKeys: String, CodingKey {
    
    case id
    
  }

  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()

    
    
    self.id = try codecHelper.decode(UUID.self, forKey: .id, container: &container)
    
    
  }
}
public var 
receiver: User?


  

  
  enum CodingKeys: String, CodingKey {
    
    case started
    
    case compliments
    
    case complimentStore
    
    case sender
    
    case receiver
    
  }

  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()

    
    
    self.started = try codecHelper.decode(Bool.self, forKey: .started, container: &container)
    
    
    self.compliments = try codecHelper.decode([String]?.self, forKey: .compliments, container: &container)
    
    
    self.complimentStore = try codecHelper.decode([String]?.self, forKey: .complimentStore, container: &container)
    
    
    
    self.sender = try codecHelper.decode(User.self, forKey: .sender, container: &container)
    
    
    
    self.receiver = try codecHelper.decode(User?.self, forKey: .receiver, container: &container)
    
    
  }
}
public var 
complimentProduct: ComplimentProduct?

  }

  public func ref(
        
id: UUID

        ) -> QueryRefObservation<GetGiftQuery.Data,GetGiftQuery.Variables>  {
        var variables = GetGiftQuery.Variables(id:id)
        

        let ref = dataConnect.query(name: "GetGift", variables: variables, resultsDataType:GetGiftQuery.Data.self, publisher: .observableMacro)
        return ref as! QueryRefObservation<GetGiftQuery.Data,GetGiftQuery.Variables>
   }

  @MainActor
   public func execute(
        
id: UUID

        ) async throws -> OperationResult<GetGiftQuery.Data> {
        var variables = GetGiftQuery.Variables(id:id)
        
        
        let ref = dataConnect.query(name: "GetGift", variables: variables, resultsDataType:GetGiftQuery.Data.self, publisher: .observableMacro)
        
        let refCast = ref as! QueryRefObservation<GetGiftQuery.Data,GetGiftQuery.Variables>
        return try await refCast.execute()
        
   }
}


