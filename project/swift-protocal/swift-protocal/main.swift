protocol CanFly { //Everything that can fly, java의 interface같은 것이다. 강제로 function을 가지게 만듬
    func fly()
}

class Bird {
    var isFemale = true
    func layEgg(){
        if(isFemale){
            print("The bird makes a new bird in a shell.")
        } else {
            
        }
    }
}

class Eagle: Bird, CanFly {
    func fly() {
        <#code#>
    }
    func soar(){
        print("The eagle glides in the air using air currents.")
    }
}

class Penguin: Bird, CanFly {
    func fly() {
        <#code#>
    }
    func swim(){
        print("The penguin paddles through the water.")
    }
}

struct FlyingMuseum: CanFly {
    func fly() {
        <#code#>
    }
}

class AirPlane: Bird, CanFly {
    func fly() {
        <#code#>
    }
}

let myEagle = Eagle()
let myPenguin = Penguin()
let myPlane = AirPlane()
let meseum = FlyingMuseum()



