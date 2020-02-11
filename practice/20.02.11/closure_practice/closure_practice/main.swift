protocol LifeCertificate {
    func performCPR()
}

class EmergencyReceiver {
    
    var delegate:LifeCertificate?
    
    func performCPR(){
        delegate?.performCPR()
    }
    
}

struct Doctor:LifeCertificate {
    
    init(handler:EmergencyReceiver){
        handler.delegate = self
    }
    
    func performCPR() {
        print("Doctor performs CPR")
    }
    
}


struct PoliceOfficer:LifeCertificate {
    
    init(handler:EmergencyReceiver){
        handler.delegate = self
    }
    
    func performCPR(){
        print("Docter performs CPR")
    }
    
}

var emergencyReceiver = EmergencyReceiver()
var doctor = Doctor(handler: emergencyReceiver)
doctor.performCPR()

