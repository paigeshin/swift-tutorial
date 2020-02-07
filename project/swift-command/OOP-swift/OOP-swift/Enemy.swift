import Foundation

class Enemy {
    
    var health = 100
    var attackStrength = 10
    
    init(health:Int, attackStrength:Int){
        self.health = health
        self.attackStrength = attackStrength
    }
    
    func takeDamage(amount: Int){
        health = health - amount
    }
    
    func move(){
        print("Walk forwards.")
    }
    
    func attack(){
        print("Land a hit, does \(attackStrength) damage.")
    }
    
}


