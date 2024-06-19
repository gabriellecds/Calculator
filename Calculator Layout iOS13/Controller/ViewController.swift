
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet var numbers: [UIButton]!
    @IBOutlet var properties: [UIButton]!
    @IBOutlet var calculators: [UIButton]!
    
    private var isFinishedTypingNumber: Bool = true
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display Label text to a Double.")
            }
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            if let result = calculator.calculate(symbol: calcMethod){
                displayValue = result
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "." {
                
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
                
                displayLabel.text = displayLabel.text! + numValue
            }
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        for button in numbers {
            button.styleNumbersButtons()
        }
        
        for button in properties {
            button.stylePropertiesButtons()
        }
 
        for button in calculators {
            button.styleCalculatorsButtons()
        }
    }
}

//MARK: - Buttons Appearance

extension UIButton {
    
    func styleNumbersButtons() {
        let sideLength = min(self.frame.size.width, self.frame.size.height)
        self.frame.size = CGSize(width: sideLength, height: sideLength)
        
        self.backgroundColor = UIColor.darkGray
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = sideLength / 2
        self.layer.masksToBounds = true
    }
  
    func stylePropertiesButtons() {
        let sideLength = min(self.frame.size.width, self.frame.size.height)
        self.frame.size = CGSize(width: sideLength, height: sideLength)
        
        self.backgroundColor = UIColor.lightGray
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.cornerRadius = sideLength / 2
        self.layer.masksToBounds = true
    }
    
    func styleCalculatorsButtons() {
        let sideLength = min(self.frame.size.width, self.frame.size.height)
        self.frame.size = CGSize(width: sideLength, height: sideLength)
        
        self.backgroundColor = UIColor.orange
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = sideLength / 2
        self.layer.masksToBounds = true
    }
}
