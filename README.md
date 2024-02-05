# Photo-gallery-challenge

## How the app works
Please follow the link to see the video: https://drive.google.com/file/d/1HAGncbYw7XmAqhMNEalHvfQB5EMJy7-f/view?usp=sharing

## Instalation
This project requires XCode 13.0, Swift 5.0 and should be run on a device with iOS 15+ then, you should execute `pod install` and `run` the photo-gallery-challenge.xcworkspace file.

## Architecture
This project uses VIPER architecture, VIPER is an application of Clean Architecture to iOS apps. The word VIPER is a backronym for View, Interactor, Presenter, Entity, and Routing.

![alt text](https://miro.medium.com/max/1021/1*6W73TuYu1DWi9JY4_Uh8aA.png)

This architecture is conformed by 5 layers which have single responsibilities, which represent an opportunity to have a project decoupled, testable, and scalable.

### View
> Contains UI logic and knows how to layout and animate itself. It displays what it's told by the Presenter and it delegates user interaction actions to the Presenter.

### Presenter
> The presenter layer is responsible to manage the communication between the View, Router and Interactor layers. Its main function is handle each visual request, retrieve information from interactor layer or, route the actual view to another one with the Router.

### Router
> This layer is responsible to manage the communication between modules, its allows us changing between views and, initalize modules for each feature on the app.

### Interactor
> Used for fetching data when requested by the Presenter, contains only business logic..

### Entity 
> Contains only business logic, but primarily data, not rules.

## Good Practices
- **Clean code**
- **SOLID Principles**
- **DRY Principle**
- **Dependency Injection**
- **Modularized architecture**

## Project Structure

### Modules
In this folder we have each app module. In this case we have a Home, and Detailmodules.

![alt text](https://github.com/brayammora/photo-gallery-challenge/blob/main/Screenshots/ModulesCapture.png)

### Common
The main idea of this folder is have a transversal module which help us with reusables functions and components.

- **Resources:** Contains strings copies and images for the app.
- **Extensions:** Contains extra functionalities to existing classes
- **Models:** Contains the entities business for the project 
- **Network:** This allows us to separate everything related to networking and web services in a single context.
- **Persistence:** This allows us to separate everything related to local storage in a single context. 
- **UI:** Contains visual reusable components.
- **Concurrency:** Helper for concurrency operations.

![alt text](https://github.com/brayammora/photo-gallery-challenge/blob/main/Screenshots/CommonCapture.png)

### Unit Test
In this section we have the unit test structure, this folder meets the Viper architecture requirements. To continue, we can find a Test Double approach where we use Mocks, and Stubs doubles to test the differents architecture layers.

![alt text](https://github.com/brayammora/photo-gallery-challenge/blob/main/Screenshots/UnitTestCapture.png)
