import UIKit
import CoreLocation
import CoreBluetooth
import RxSwift
import RxCocoa
class ViewController: UIViewController, CBPeripheralManagerDelegate, UITextFieldDelegate {

    var myPeripheralManager: CBPeripheralManager!
    let myProximityUUID = NSUUID.init(uuidString:"F583F8B6-8086-4644-A41D-CF1B015828EA")
    var major = "3"
    var minor = "4"
    let uuid: String = "F583F8B6-8086-4644-A41D-CF1B015828EA"
    @IBOutlet weak var majorTextField: UITextField!
    @IBOutlet weak var minorTextField: UITextField!
    @IBOutlet weak var uuidLable: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.majorTextField.text = major
        self.minorTextField.text = minor
        self.majorTextField.delegate = self
        self.minorTextField.delegate = self
        self.uuidLable.text = self.uuid
        self.uuidLable.textAlignment = NSTextAlignment.center
        self.uuidLable.numberOfLines = 0
        
        
        myPeripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
        func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
            if error != nil {
                print("***Advertising ERROR")
                return
            }
            self.update()
        }
        
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            self.update()
        }
    }
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()

        if(textField == majorTextField) {
            if let _ = Int(textField.text!) {
                self.major = textField.text!
            }
            
        }else {
            if let _ = Int(textField.text!) {
                self.minor = textField.text!
            }
        }
            self.update()
        return true
    }
    func update() {
        let mj = Int(self.major)
        let mn = Int(self.minor)
        let beaconRegion = CLBeaconRegion.init(proximityUUID: myProximityUUID! as UUID, major: CLBeaconMajorValue(mj), minor: CLBeaconMinorValue(mn), identifier: "com.mycompany.myregion")
        let beaconPeripheralData = NSDictionary(dictionary: beaconRegion.peripheralData(withMeasuredPower: nil))
        myPeripheralManager.stopAdvertising()
        myPeripheralManager.startAdvertising(beaconPeripheralData as? [String : AnyObject])
    }
}
