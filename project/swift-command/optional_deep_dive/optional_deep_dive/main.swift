struct MyOptional {
    var property = 123
    func method(){
        print("I am the struct's method.")
    }
}

let myOptional: MyOptional?

myOptional = nil

//If this optional isn't `nil`, continue

print(myOptional?.property)
myOptional?.method()
