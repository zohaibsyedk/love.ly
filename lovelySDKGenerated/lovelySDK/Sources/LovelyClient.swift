
import Foundation

import FirebaseCore
import FirebaseDataConnect
public extension DataConnect {

  static let lovelyConnector: LovelyConnector = {
    let dc = DataConnect.dataConnect(connectorConfig: LovelyConnector.connectorConfig, callerSDKType: .generated)
    return LovelyConnector(dataConnect: dc)
  }()

}

public class LovelyConnector {

  let dataConnect: DataConnect

  public static let connectorConfig = ConnectorConfig(serviceId: "lovely-45188-service", location: "us-central1", connector: "lovely")

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect

    // init operations 
    self.createComplimentProductMutation = CreateComplimentProductMutation(dataConnect: dataConnect)
    self.linkProductToCreatorMutation = LinkProductToCreatorMutation(dataConnect: dataConnect)
    self.linkProductToReceiverMutation = LinkProductToReceiverMutation(dataConnect: dataConnect)
    self.linkReceiverToProductMutation = LinkReceiverToProductMutation(dataConnect: dataConnect)
    self.toggleActivateUserProductMutation = ToggleActivateUserProductMutation(dataConnect: dataConnect)
    self.startComplimentProductMutation = StartComplimentProductMutation(dataConnect: dataConnect)
    self.updateComplimentStoreMutation = UpdateComplimentStoreMutation(dataConnect: dataConnect)
    self.updateComplimentsMutation = UpdateComplimentsMutation(dataConnect: dataConnect)
    self.getOtherUserQuery = GetOtherUserQuery(dataConnect: dataConnect)
    self.getUserQuery = GetUserQuery(dataConnect: dataConnect)
    self.getGiftQuery = GetGiftQuery(dataConnect: dataConnect)
    
  }

  public func useEmulator(host: String = DataConnect.EmulatorDefaults.host, port: Int = DataConnect.EmulatorDefaults.port) {
    self.dataConnect.useEmulator(host: host, port: port)
  }

  // MARK: Operations
public let createComplimentProductMutation: CreateComplimentProductMutation
public let linkProductToCreatorMutation: LinkProductToCreatorMutation
public let linkProductToReceiverMutation: LinkProductToReceiverMutation
public let linkReceiverToProductMutation: LinkReceiverToProductMutation
public let toggleActivateUserProductMutation: ToggleActivateUserProductMutation
public let startComplimentProductMutation: StartComplimentProductMutation
public let updateComplimentStoreMutation: UpdateComplimentStoreMutation
public let updateComplimentsMutation: UpdateComplimentsMutation
public let getOtherUserQuery: GetOtherUserQuery
public let getUserQuery: GetUserQuery
public let getGiftQuery: GetGiftQuery


}
