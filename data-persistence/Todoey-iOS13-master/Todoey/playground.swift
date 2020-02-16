import UIKit

//Singleton

class Car {
    var color = "Red"
    
    static let singletonCar = Car()
}


class A {
    init(){
        Car.singletonCar.color = "Brown"
    }
}

class B {
    init(){
        print(Car.singletonCar.color)
    }
}
