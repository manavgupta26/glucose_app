import UIKit

class creatingAccountViewController: UIViewController {
    
    
    @IBOutlet var namefield: UITextField!
    @IBOutlet var emailfield: UITextField!
    @IBOutlet var pwfield: UITextField!
    @IBOutlet var confirmpwfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withIdentifier: "showModal", sender: self)
    }
    

    
    

    
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "completeProfile", sender: self)
    }
    
    
    @IBAction func alreadyHaveTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "loginScreen", sender: self)
    }
    
    
}
