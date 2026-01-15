This Swift package contains the generated Swift code for the connector `lovely`.

You can use this package by adding it as a local Swift package dependency in your project.

# Accessing the connector

Add the necessary imports

```
import FirebaseDataConnect
import lovelySDK

```

The connector can be accessed using the following code:

```
let connector = DataConnect.lovelyConnector

```


## Connecting to the local Emulator
By default, the connector will connect to the production service.

To connect to the emulator, you can use the following code, which can be called from the `init` function of your SwiftUI app

```
connector.useEmulator()
```

# Queries

## GetOtherUserQuery
### Variables
#### Required
```swift

let id: UUID = ...
```




### Using the Query Reference
```
struct MyView: View {
   var getOtherUserQueryRef = DataConnect.lovelyConnector.getOtherUserQuery.ref(...)

  var body: some View {
    VStack {
      if let data = getOtherUserQueryRef.data {
        // use data in View
      }
      else {
        Text("Loading...")
      }
    }
    .task {
        do {
          let _ = try await getOtherUserQueryRef.execute()
        } catch {
        }
      }
  }
}
```

### One-shot execute
```
DataConnect.lovelyConnector.getOtherUserQuery.execute(...)
```


## GetUserQuery


### Using the Query Reference
```
struct MyView: View {
   var getUserQueryRef = DataConnect.lovelyConnector.getUserQuery.ref(...)

  var body: some View {
    VStack {
      if let data = getUserQueryRef.data {
        // use data in View
      }
      else {
        Text("Loading...")
      }
    }
    .task {
        do {
          let _ = try await getUserQueryRef.execute()
        } catch {
        }
      }
  }
}
```

### One-shot execute
```
DataConnect.lovelyConnector.getUserQuery.execute(...)
```


## GetGiftQuery
### Variables
#### Required
```swift

let id: UUID = ...
```




### Using the Query Reference
```
struct MyView: View {
   var getGiftQueryRef = DataConnect.lovelyConnector.getGiftQuery.ref(...)

  var body: some View {
    VStack {
      if let data = getGiftQueryRef.data {
        // use data in View
      }
      else {
        Text("Loading...")
      }
    }
    .task {
        do {
          let _ = try await getGiftQueryRef.execute()
        } catch {
        }
      }
  }
}
```

### One-shot execute
```
DataConnect.lovelyConnector.getGiftQuery.execute(...)
```


# Mutations
## CreateComplimentProductMutation

### Variables

#### Required
```swift

let senderId: UUID = ...
```
 

#### Optional
```swift

let compliments: String = ...
let complimentsStore: String = ...
```

### One-shot execute
```
DataConnect.lovelyConnector.createComplimentProductMutation.execute(...)
```

## LinkProductToCreatorMutation

### Variables

#### Required
```swift

let userId: UUID = ...
let productId: UUID = ...
```
 

### One-shot execute
```
DataConnect.lovelyConnector.linkProductToCreatorMutation.execute(...)
```

## LinkProductToReceiverMutation

### Variables

#### Required
```swift

let userId: UUID = ...
let productId: UUID = ...
```
 

### One-shot execute
```
DataConnect.lovelyConnector.linkProductToReceiverMutation.execute(...)
```

## LinkReceiverToProductMutation

### Variables

#### Required
```swift

let userId: UUID = ...
let productId: UUID = ...
```
 

### One-shot execute
```
DataConnect.lovelyConnector.linkReceiverToProductMutation.execute(...)
```

## ToggleActivateUserProductMutation

### Variables

#### Required
```swift

let userId: UUID = ...
let activate: Bool = ...
```
 

### One-shot execute
```
DataConnect.lovelyConnector.toggleActivateUserProductMutation.execute(...)
```

## StartComplimentProductMutation

### Variables

#### Required
```swift

let productId: UUID = ...
```
 

### One-shot execute
```
DataConnect.lovelyConnector.startComplimentProductMutation.execute(...)
```

## UpdateComplimentStoreMutation

### Variables

#### Required
```swift

let productId: UUID = ...
```
 

#### Optional
```swift

let newComplimentStore: String = ...
```

### One-shot execute
```
DataConnect.lovelyConnector.updateComplimentStoreMutation.execute(...)
```

## UpdateComplimentsMutation

### Variables

#### Required
```swift

let productId: UUID = ...
```
 

#### Optional
```swift

let newCompliments: String = ...
```

### One-shot execute
```
DataConnect.lovelyConnector.updateComplimentsMutation.execute(...)
```

