//
//  ViewController.swift
//  ThePriceIsRight
//
//  Created by Yanunsey on 10/1/23.
//

import UIKit
import CoreML

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var yearStepper: UIStepper!
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var labelData: UILabel!
    @IBOutlet weak var squareMetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let labelSquare = squareMetLabel {
            labelSquare.text = "100 \u{33A1}"
        }
        
        updatePredictions()
        setupDescriptionView()
        setupSegmentedControl()
        setupStepper()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePredictions()
    }
    
    
    func  setupStepper(){
        guard let stepper = yearStepper else { return }
        stepper.value = 1975
        stepper.layer.borderWidth = 1
        stepper.layer.borderColor = UIColor.white.cgColor
        stepper.layer.cornerRadius = 6
        stepper.setIncrementImage(stepper.incrementImage(for: .normal), for: .normal)
        stepper.setDecrementImage(stepper.decrementImage(for: .normal), for: .normal)
        stepper.tintColor = UIColor.white
    }

    
    func setupSegmentedControl(){
        
        guard let segControl = segmentedControl else { return }
        segControl.layer.borderWidth = 1
        segControl.layer.borderColor = UIColor.white.cgColor
            
        guard let textColor = UIColor(named: "TextColor") else { return }

        if segControl.tag != 6{
            segControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
            segControl.setTitleTextAttributes([.foregroundColor: textColor, .font: UIFont.boldSystemFont(ofSize: 18)], for: .selected)
        } else {
            segControl.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 12)], for: .normal)
            segControl.setTitleTextAttributes([.foregroundColor: textColor], for: .selected)
        }
    }
    
    func setupDescriptionView() {
        viewDescription.layer.cornerRadius = 6
        viewDescription.layer.borderColor = UIColor.white.cgColor

    }
    
    func updatePredictions(){
        var stringValue = ""
        
        do {
            let model: HousePriceModel_mlmodel_ = try HousePriceModel_mlmodel_(configuration: .init())
            let prediction = try model.prediction(bathrooms: Double(house.bathrooms), cars: Double(house.garage), condition: Double(house.condition), rooms: Double(house.rooms), size: Double(house.size), yearBuilt: Double(house.year))
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 0
            stringValue = formatter.string(from: prediction.value as NSNumber) ?? "N/A"
            
        } catch {
            print(error.localizedDescription)
        }
        self.labelDescription.text = "\(house)"
        
    
        if let resultsLabel = self.resultsLabel {
            resultsLabel.text = stringValue
        }
        
    }

    @IBAction func dataChanged(_ sender: Any) {
        
        guard let sender = sender as? UIView else { return }
        
        switch sender.tag {
        case 1 :
            let sender = sender as! UISegmentedControl
            house.rooms = sender.selectedSegmentIndex + 1
            break
        case 2 :
            let sender = sender as! UISegmentedControl
            house.bathrooms = sender.selectedSegmentIndex + 1
            break
        case 3 :
            let sender = sender as! UISegmentedControl
            house.garage = sender.selectedSegmentIndex
            break
        case 4 :
            let sender = sender as! UIStepper
            house.year = Int(sender.value)
            self.labelData.text = "\(Int(sender.value))"
            break
        case 5:
            let sender = sender as! UISlider
            house.size = Int(sender.value)
            self.squareMetLabel.text = "\(Int(sender.value))\u{33A1}"
            break
        case 6 :
            let sender = sender as! UISegmentedControl
            house.condition = sender.selectedSegmentIndex
            break
        default:
            print("Aquí no entraremos nunca")
        }
        
        self.updatePredictions()
    }
    
}

