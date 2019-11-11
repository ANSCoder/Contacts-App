# Contacts-App

[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org)

This repository contains a Contact-App based on Web APIs. User can see pre fetch contacts list and able to create new contact 
with this application.

<p align="left">
  <img src="https://user-images.githubusercontent.com/19596311/68592310-c1321580-04b8-11ea-969d-6923cba4f4df.png" width="250">
  <img src="https://user-images.githubusercontent.com/19596311/68595210-01949200-04bf-11ea-881e-36863f0cbbc9.png" width="250">
  <img src="https://user-images.githubusercontent.com/19596311/68595208-01949200-04bf-11ea-818f-1b31a3ac40b2.png" width="250">
  <img src="https://user-images.githubusercontent.com/19596311/68595209-01949200-04bf-11ea-8354-650d21ea8863.png" width="250">
  <img src="https://user-images.githubusercontent.com/19596311/68595206-00fbfb80-04bf-11ea-9678-0a938288ce66.png" width="250">
</p>
<br>
<br>



## Features

- [x] Contact List 
- [x] Create New Contact
- [x] Contact Detail
- [x] Add to favourite
- [x] Edit Details
- [x] Choose Image for Contact
- [x] Swipe to Delete Contact
- [x] Email
- [x] Call
- [x] Messahe

## Requirements

- iOS 13.1+
- Xcode 11.1

### Project Structure
 
 
    ├─ Common (LoadingViewController, ImageProvider, Endpoints)
    ├─ Extensions
    ├─ Entities (Model)
    ├─ Remote
    ├─ Interactor
    ├─ WireFrame
    ├─ Protocols
    ├─ Presentor
    ├─ View (ViewController, Cell, HeaderView)
    
    
## Swift Package Manager
    
    - Alamofire
    
```swift
    dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.0.0-rc.3")
    ]
```
    - IQKeyboardManagerSwift
    
```swift
    dependencies: [
        .package(url: "https://github.com/hackiftekhar/IQKeyboardManager.git", from: "6.5.0")
    ]
```

## Architecture

* [View-Interactor-Presenter-Entity-Routing (VIPER)][viper]
    * Main Parts of VIPER
    
The main parts of VIPER are:

- View: displays what it is told to by the Presenter and relays user input back to the Presenter.
- Interactor: contains the business logic as specified by a use case.
- Presenter: contains view logic for preparing content for display (as received from the Interactor) and for reacting to user inputs (by requesting new data from the Interactor).
- Entity: contains basic model objects used by the Interactor.
- Routing: contains navigation logic for describing which screens are shown in which order.

[viper]: https://www.objc.io/issues/13-architecture/viper/


## Image Downloading  

```swift
import UIKit


struct ImageProvider {
    
    fileprivate let downloadQueue = DispatchQueue(label: "Images cache", qos: DispatchQoS.background)
    internal var cache = NSCache<NSURL, UIImage>()

    
    //MARK: - Fetch image from URL and Images cache
    func loadImages(from url: NSURL, completion: @escaping (_ image: UIImage) -> Void) {
        downloadQueue.async(execute: { () -> Void in
            if let image = self.cache.object(forKey: url) {
                DispatchQueue.main.async {
                    completion(image)
                }
                return
            }
            
            do{
                let data = try Data(contentsOf: url as URL)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.cache.setObject(image, forKey: url)
                        completion(image)
                    }
                } else {
                    print("Could not decode image")
                }
            }catch {
                print("Could not load URL: \(url): \(error)")
            }
        })
    }
}

```




