//
//  FlightVC.swift
//  TripOrganizer
//
//  Created by Eduardo Escaleira on 09/03/23.
//

import UIKit

class FlightVC: UIViewController {
    
    var cityName: [String] = ["Florianópolis", "Rio de Janeiro", "Fernando de Noronha", "Belo Horizonte", "Porto Alegre"]
    var cityDescription: [String] = ["Conhecida por suas praias paradisíacas, Floripa também é famosa por sua culinária e por apresentar uma cultura vibrante.", "Famosa por suas praias, Cristo Redentor e pelo Pão de Açúcar. Também conhecida pelas grandes favelas e o Carnaval.", "Arquipélago reconhecido pelas suas praias pouco urbanizadas e por atividades como mergulho e snorkeling.", "Rodeada de montanhas, a cidade é conhecida pelo enorme Estádio Mineirão e a lagoa da Pampulha.", "Capital do estado de Rio Grande do Sul, no sul do Brasil. Na praça principal, a Praça Marechal Deodoro, encontra-se a Catedral."]
    var cityImage: [String] = ["floripa", "rioDeJaneiro", "noronha", "bh", "pa"]
    
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
        
        let vc: SecondFlightScreenVC? = UIStoryboard(name: "SecondFlightScreenVC", bundle: nil).instantiateViewController(withIdentifier: "SecondFlightScreenVC") as? SecondFlightScreenVC
        vc?.modalPresentationStyle = .automatic
        present(vc ?? UIViewController(), animated: true)
        
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
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FlightScreenCollectionViewCell.nib(), forCellWithReuseIdentifier: FlightScreenCollectionViewCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            
        }

    }
    
}

extension FlightVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlightScreenCollectionViewCell.identifier, for: indexPath) as? FlightScreenCollectionViewCell
        cell?.setupCell(cityName: cityName[indexPath.row], cityImage: cityImage[indexPath.row], cityDescription: cityDescription[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.8, height: collectionView.frame.size.height)
    }
    
    
}

