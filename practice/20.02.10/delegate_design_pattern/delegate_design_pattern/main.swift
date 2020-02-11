//1. protocol을 만든다.
protocol LifeSupportCeriticate {
    func performCPR()
}

//2. Handler를 지정
class EmergencyAgent {
    
    var delegate:LifeSupportCeriticate?
        
    func assesseSituation(){
        print("Could You Tell Me What happend?")
    }
    
    func delegatePerfromCPR(){
        delegate?.performCPR()
    }
    
}

//3. delegate 받을 object 지정
class Doctor:LifeSupportCeriticate {

    init(handler:EmergencyAgent){
        handler.delegate = self
    }
    
    func performCPR() {
        print("Perform CPR")
    }
    
}

struct Surgeon:LifeSupportCeriticate{
    
    init(handler:EmergencyAgent){
        handler.delegate = self
    }
    
    func performCPR() {
        print("Perform CPR")
        print("Singing the song")
    }
    
}


var brian = EmergencyAgent()
var thomas = Doctor(handler:brian)
var jordan = Surgeon(handler: brian)

//brian.delegatePerfromCPR()

thomas.performCPR()
jordan.performCPR()

