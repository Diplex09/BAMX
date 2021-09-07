//
//  IntroViewController.swift
//  BAMXapp
//
//  Created by user195828 on 9/6/21.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet var holderView: UIView!
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    private func configure() {
        // set up scroll view
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        let titles = ["DONA", "REVISA", "GRACIAS"]
        let descriptions = ["Apoya con un donativo economico o en especie", "Mantente informado de lo que se ha realizado con tu donativo", "La(s) familia(s) que has alimentado te lo agradecen y obtienes recompensas"]
        
        for x in 0..<3 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            // Title, image, button
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width - 20, height: 120))
            let desc = UILabel(frame: CGRect(x: 10, y: 160, width: pageView.frame.size.width - 20, height: 50)) //checar
            let imageView = UIImageView(frame: CGRect(x: 10, y: 140, width: pageView.frame.size.width - 20, height: pageView.frame.size.height - 205))
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height - 60, width: pageView.frame.size.width - 20, height: 50))
            
            imageView.contentMode = .scaleAspectFit // .scaleAspectFit
            /*let screenSize: CGRect = UIScreen.main.bounds
            imageView.frame = CGRect(x: 0, y: 0, width: screenSize.width * 0.2, height: screenSize.height * 0.2)
            //imageView.contentMode = .center*/
            imageView.image = UIImage(named: "intro_\(x)")
            pageView.addSubview(imageView)
            
            label.textAlignment = .center
            label.font = UIFont(name: "Lato-Bold", size: 40)
            label.textColor = .init(UIColor(hue: 0.9722, saturation: 0.86, brightness: 1, alpha: 1.0) /* #ff2247 */)
            pageView.addSubview(label)
            label.text = titles[x]
            
            desc.textAlignment = .center
            desc.font = UIFont(name: "Lato-Regular", size: 16)
            pageView.addSubview(desc)
            desc.text = descriptions[x]
            
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .init(UIColor(hue: 0.9722, saturation: 0.86, brightness: 1, alpha: 1.0) /* #ff2247 */)
            button.setTitle("Siguiente", for: .normal)
            if x == 2 {
                button.setTitle("Empezar", for: .normal)
            }
            
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.tag = x + 1
            pageView.addSubview(button)
        }
        
        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    @objc func didTapButton(_ button: UIButton) {
        guard button.tag < 3 else {
            //dismiss
            Core.shared.setIsNotNewUser()
            dismiss(animated: true, completion: nil)
            return
        }
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }
}


extension UIImage {

    func resize(maxWidthHeight : Double)-> UIImage? {

        let actualHeight = Double(size.height)
        let actualWidth = Double(size.width)
        var maxWidth = 0.0
        var maxHeight = 0.0

        if actualWidth > actualHeight {
            maxWidth = maxWidthHeight
            let per = (100.0 * maxWidthHeight / actualWidth)
            maxHeight = (actualHeight * per) / 100.0
        }else{
            maxHeight = maxWidthHeight
            let per = (100.0 * maxWidthHeight / actualHeight)
            maxWidth = (actualWidth * per) / 100.0
        }

        let hasAlpha = true
        let scale: CGFloat = 0.0

        UIGraphicsBeginImageContextWithOptions(CGSize(width: maxWidth, height: maxHeight), !hasAlpha, scale)
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: maxWidth, height: maxHeight)))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
}
