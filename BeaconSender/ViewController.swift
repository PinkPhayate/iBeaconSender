import UIKit
import CoreLocation
import CoreBluetooth
import RxSwift
import RxCocoa

class ViewController: UIViewController, CBPeripheralManagerDelegate {

    var myPeripheralManager: CBPeripheralManager!
    let myProximityUUID = NSUUID.init(uuidString:"F583F8B6-8086-4644-A41D-CF1B015828EA")
    var major: Int = 4
    var minor: Int = 3
    let uuid: String = "F583F8B6-8086-4644-A41D-CF1B015828EA"
    @IBOutlet weak var majorTextField: UITextField!
    @IBOutlet weak var minorTextField: UITextField!
//    @IBOutlet weak var uuidLable: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.majorTextField.text = String(major)
        self.minorTextField.text = String(minor)
//        self.uuidLable.text = self.uuid
//        self.uuidLable.textAlignment = NSTextAlignment.center
        
        
        myPeripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            let beaconRegion = CLBeaconRegion.init(proximityUUID: myProximityUUID! as UUID, major: CLBeaconMajorValue(major), minor: CLBeaconMinorValue(minor), identifier: "com.mycompany.myregion")
            let beaconPeripheralData = NSDictionary(dictionary: beaconRegion.peripheralData(withMeasuredPower: nil))
 
            
            myPeripheralManager.startAdvertising(beaconPeripheralData as? [String : AnyObject])
        }
    }
}
