//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var billTotal: Float?
    var tipPercentage: Float?
    var people: Float?

    @IBOutlet weak var ZeroButton: UIButton!
    @IBOutlet weak var TenButton: UIButton!
    @IBOutlet weak var TwentyButton: UIButton!

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var splitLabel: UILabel!

    @IBAction func tipButtonClicked(_ sender: UIButton) {
        switch (sender.currentTitle!) {
        case "0%":
            tipPercentage = 0
            buttonHandler(clicked: ZeroButton, TenButton, TwentyButton)
        case "10%":
            tipPercentage = 0.1
            buttonHandler(clicked: TenButton, ZeroButton, TwentyButton)
        case "20%":
            tipPercentage = 0.2
            buttonHandler(clicked: TwentyButton, ZeroButton, TenButton)
        default:
            tipPercentage = 0
        }
    }

    func buttonHandler(clicked: UIButton, _ unClicked1: UIButton, _ unClicked2: UIButton) {
        clicked.isSelected = true
        unClicked1.isSelected = false
        unClicked2.isSelected = false
    }


    @IBAction func stepperClicked(_ sender: UIStepper) {
        splitLabel.text = String(format: "%.0f", sender.value)
        people = Float(sender.value)
    }

    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        billTotal = Float(textField.text!)

        if (billTotal != nil) {
            self.performSegue(withIdentifier: "goToResult", sender: self)
        } else {
            self.showToast(message: "Please, put the value in the bill textfield")
        }


    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToResult") {
            var billCalculator: BillCalculator = BillCalculator(totalBill: billTotal!, tipPercentage: tipPercentage!, numberOfPeople: people!)
            let secondVC = segue.destination as! ResultViewController
            let billResult: Float = billCalculator.getDividedPrice()
            let billDescription = billCalculator.getDescription()
            secondVC.bill = String(format: "%.2f", billResult)
            secondVC.billDescription = billDescription
        }
    }

    func showToast(message: String) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - 75, y: self.view.frame.size.height - 100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { (isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }


}

