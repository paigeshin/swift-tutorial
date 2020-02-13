import Foundation

class Animal {
    var name: String
    
    init(n: String){
        name = n
    }
}

class Human: Animal {
    func code(){
        print("Typing away...")
    }
}

class Fish: Animal{
    func breathUnderWater(){
        print("Breathing under water.")
    }
}

let angela = Human(n: "Angela Yu")
let jack = Human(n: "Jack Bauer")
let nemo = Fish(n: "Nemo")
let num: NSNumber = 12

let neighbours:[Any] = [angela, jack, nemo, num]
print(neighbours)
