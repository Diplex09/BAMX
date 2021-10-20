//
//  MessageDonation.swift
//  BAMXapp
//
//  Created by Mar Mendoza on 20/10/21.
//

import UIKit

class ProgressDonationViewController : UIViewController{
    @IBOutlet var moneyDonated: UILabel!
    @IBOutlet var message: UILabel!
    @IBOutlet var displayImage: UIImageView!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        setMessage()
        
    }
    
    func setMessage(){
        let Donated: Int = 400
        
        displayImage.image = UIImage(named: "school_bus")
        moneyDonated.text = "\(Donated) pesos"
        message.text = "Alimentado así a 40 personas, donde si juntamos estos, podemos llenar un camión escolar."
    }
}
