//
//  FlightVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit
import Lottie

class FlightViewController: UIViewController {
    
    var viewModel: FlightViewModel = FlightViewModel()
    
    private let animationView = UIView()
    private let loadingAnimationView: LottieAnimationView = LottieAnimationView()
    
    @IBOutlet weak var chooseADestinationLabel: UILabel!
    @IBOutlet weak var flightOriginView: UIView!
    @IBOutlet weak var flightOriginTextField: UITextField!
    @IBOutlet weak var calendarOnGoingView: UIView!
    @IBOutlet weak var calendarOnGoingTextField: UITextField!
    @IBOutlet weak var calendarOutGoingView: UIView!
    @IBOutlet weak var calendarOutGoingTextField: UITextField!
    @IBOutlet weak var flightDestinationView: UIView!
    @IBOutlet weak var flightDestinationTextField: UITextField!
    @IBOutlet weak var passengersView: UIView!
    @IBOutlet weak var passengersTextField: UITextField!
    @IBOutlet weak var ticketSearchButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configElements()
        configCollectionView()
    }
    
    @IBAction func tappedSearchButton(_ sender: UIButton) {
        
        let viewController: TicketsViewController? = UIStoryboard(name: "TicketsViewController", bundle: nil).instantiateViewController(withIdentifier: "TicketsViewController") as? TicketsViewController
        viewController?.modalPresentationStyle = .automatic
        self.configLoadingAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.present(viewController ?? UIViewController(), animated: true)
            self.removeLoadingAnimation()
        }
        
    }
    
    private func configLoadingAnimation() {
        animationView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        animationView.frame = UIScreen.main.bounds
        animationView.center = view.center
        loadingAnimationView.animation = LottieAnimation.named("103343-airplane-loader-animation.json")
        loadingAnimationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        loadingAnimationView.center = view.center
        loadingAnimationView.backgroundColor = .clear
        loadingAnimationView.contentMode = .scaleAspectFit
        loadingAnimationView.loopMode = .playOnce
        loadingAnimationView.play()
        animationView.addSubview(loadingAnimationView)
        self.view.addSubview(animationView)
    }
    
    private func removeLoadingAnimation() {
        animationView.removeFromSuperview()
    }
    
    private func configElements() {
        
        flightOriginTextField.borderStyle = .none
        flightDestinationTextField.borderStyle = .none
        calendarOnGoingTextField.borderStyle = .none
        calendarOutGoingTextField.borderStyle = .none
        passengersTextField.borderStyle = .none
        
        chooseADestinationLabel.text = "Comece uma nova viagem!"
        
        flightOriginTextField.placeholder = "Escolha a origem"
        flightDestinationTextField.placeholder = "Escolha o destino"
        
        calendarOnGoingTextField.placeholder = "Ida"
        calendarOutGoingTextField.placeholder = "Retorno"
        
        passengersTextField.placeholder = "Quantos passageiros?"
        
        let font = UIFont.systemFont(ofSize: 15)
        let atributos: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        let textoComFonte = NSAttributedString(string: "Buscar passagens", attributes: atributos)
        ticketSearchButton.setAttributedTitle(textoComFonte, for: .normal)
        
        flightOriginView.layer.cornerRadius = 5
        flightOriginView.clipsToBounds = true
        flightDestinationView.layer.cornerRadius = 5
        flightDestinationView.clipsToBounds = true
        calendarOnGoingView.layer.cornerRadius = 5
        calendarOnGoingView.clipsToBounds = true
        calendarOutGoingView.layer.cornerRadius = 5
        calendarOutGoingView.clipsToBounds = true
        passengersView.layer.cornerRadius = 5
        passengersView.clipsToBounds = true
        ticketSearchButton.layer.cornerRadius = 5
        ticketSearchButton.clipsToBounds = true
        
    }
    
   private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FlightScreenCollectionViewCell.nib(), forCellWithReuseIdentifier: FlightScreenCollectionViewCell.identifier)
        viewModel.getConfigLayoutCollectionView(collectionView: collectionView)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension FlightViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getListObject()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlightScreenCollectionViewCell.identifier, for: indexPath) as? FlightScreenCollectionViewCell
        cell?.setupCell(cityObject: viewModel.getListObjectCellForItemAt(index: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.sizeForItem(IndexPath: indexPath, frame: collectionView.frame, height: collectionView.bounds.height, collectionView: collectionView)

    }
    
}

