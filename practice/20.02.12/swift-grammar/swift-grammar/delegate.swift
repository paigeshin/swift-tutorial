import Foundation

protocol LifeCertificate {
    
    func performCPR()
    
}

class EmergencyHandler: LifeCertificate {
    
    var delegate:LifeCertificate?
    
    func receiveCall(){
        print("What can I help you?")
    }
    
    func performCPR() {
        delegate?.performCPR()
    }
    
}

class Doctor: LifeCertificate {
    
    init(handler: EmergencyHandler){
        handler.delegate = self
    }
    
    func performCPR() {
        print("Doctor performs CPR")
    }
    
}

struct Surgeon: LifeCertificate {
    
    init(handler: EmergencyHandler){
        handler.delegate = self
    }
    
    func performCPR() {
        print("Surgeon performs CPR")
    }
    
}



