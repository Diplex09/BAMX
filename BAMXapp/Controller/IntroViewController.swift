//
//  IntroViewController.swift
//  BAMXapp
//
//  Created by user195828 on 9/6/21.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [IntroSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Empezar", for: .normal)
            }
            else{
                nextBtn.setTitle("Siguiente", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        slides = [IntroSlide(title: "DONA", description: "Apoya con un donativo economico o en especie", image: #imageLiteral(resourceName: "heart")),
                  IntroSlide(title: "REVISA", description: "Mantente informado de lo que se ha realizado con tu donativo", image: #imageLiteral(resourceName: "badge")),
                  IntroSlide(title: "GRACIAS", description: "La(s) familia(s) que has alimentado te lo agradecen y obtienes recompensas", image: #imageLiteral(resourceName: "trophy"))]
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        if currentPage == slides.count - 1 {
            //move to login
            let controller = storyboard?.instantiateViewController(identifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .coverVertical
            UserDefaults.standard.hasOnboarded = true
            present(controller, animated: true, completion: nil)
        }
        else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        if currentPage != 0 {
            currentPage -= 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension IntroViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x
                / width)
    }
}
