//
//  ViewController.swift
//  Xplore
//
//  Created by Dilshad P on 06/05/25.
//

import UIKit
import SDWebImage
import Combine
import SafariServices


class HomeViewController: UIViewController {
    
    lazy var placeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.image = UIImage(named: "xplore")
        image.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        image.addGestureRecognizer(gesture)
        return image
    }()
    
    let placeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28,weight: .bold)
        return label
    }()
    
    lazy var distanceFromPlaceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Distance"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16,weight: .regular)
        label.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapDistanceLabel))
        label.addGestureRecognizer(gesture)
        return label
    }()
    
    lazy var shuffleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Xplore", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapShuffle), for: .touchUpInside)
        return button
    }()
    
    let categoryView = CategoryView()
    var databaseService: DatabaseServicesProtocol?
    var places: [Place] = []
    var currentPlace : Place?
    var currentLocation:(Double, Double)?
    let locationService = LocationService()
    var toekns: Set<AnyCancellable> = []
    
    init(databaseService: DatabaseServicesProtocol) {
        self.databaseService = databaseService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        fetchplaces()
        getCurrentLocation()
    }


    private func configureUI() {
        
        view.addSubview(placeImageView)
        view.addSubview(placeNameLabel)
        view.addSubview(distanceFromPlaceLabel)
        view.addSubview(categoryView)
        view.addSubview(shuffleButton)
        
        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            placeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            placeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            placeImageView.heightAnchor.constraint(equalToConstant: 350),
            
            
            placeNameLabel.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: 12),
            placeNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeNameLabel.widthAnchor.constraint(equalToConstant: 200),
            placeNameLabel.heightAnchor.constraint(equalToConstant: 32),
            
            
            categoryView.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 12),
            categoryView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryView.heightAnchor.constraint(equalToConstant: 48),
            
            
            distanceFromPlaceLabel.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 12),
            distanceFromPlaceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            distanceFromPlaceLabel.widthAnchor.constraint(equalToConstant: 200),
            distanceFromPlaceLabel.heightAnchor.constraint(equalToConstant: 48),
            
            
            shuffleButton.topAnchor.constraint(equalTo: distanceFromPlaceLabel.bottomAnchor, constant: 24),
            shuffleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -24),
            shuffleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            shuffleButton.heightAnchor.constraint(equalToConstant: 48),
            ])
            
    }
    
    
    @objc func didTapShuffle() {
        
        if !places.isEmpty {
            self.currentPlace = places.randomElement()!
            guard let currentPlace = currentPlace else {return}
            updateCurrentPlaceFor(currentPlace: currentPlace)
        }
    }
    
    @objc func didTapImage() {
        print("image tapped")
    }
    
    @objc func didTapDistanceLabel() {
        openGoogleMaps()
    }
    
    private func fetchplaces() {
        
        databaseService?.fetchPlaces {[weak self] results in
            
            guard let strongSelf = self else { return }
            
            switch results {
            case .success(let places):
                strongSelf.places = places
                strongSelf.fetchDistance()
            case .failure(let failure):
                print("Failed")
                print(failure.localizedDescription)
            }
        }
    }
    
    private func updateCurrentPlaceFor(currentPlace:Place){
        
        placeNameLabel.text = currentPlace.name
        
        // image
        let urlString = currentPlace.inageURL
        let url = URL(string: urlString)
        placeImageView.sd_setImage(with: url)
        
        // category
        categoryView.setCategory(category: currentPlace.category)
        
        //distance
        if let distance = currentPlace.distance {
            
            distanceFromPlaceLabel.text = "\(distance) away"
        }else {
            distanceFromPlaceLabel.text = "Get Direction"
        }
            
    }
    
    private func getCurrentLocation() {
        locationService.requestLocationAccess()
        locationService.locationPublisher.receive(on: DispatchQueue.main).sink {  _ in
            
        }receiveValue: {[weak self] location in
            guard let strongSelf = self else { return }
            strongSelf.currentLocation = (location.latitude, location.longitude)
        }.store(in: &toekns)
    }
    
    private func fetchDistance() {
        guard let currentLocation = currentLocation, places.count > 0 else { return }
        
       for i in 0..<places.count {
           locationService.getDistance(longitude: "\(currentLocation.1)", lattitude: "\(currentLocation.0)", placeID: places[i].placeID, apiKey: "AlzaSyCCN12UJBsAXcsRXTzRJ6jniaE_LusKhoo") {[weak self] result in
               guard let strongSelf = self else { return }
               switch result {
               case .success(let success):
                   strongSelf.places[i].distance = success
               case .failure(let failure):
                   print(failure.localizedDescription)
               }
           }
        }
    }
    
    private func openGoogleMaps() {
        guard let currentPlace = currentPlace, let googleMapURL = URL(string: "comgooglemaps://"),let placeURL = createURL(currentPlace: currentPlace) else {return}
        
        
        if (UIApplication.shared.canOpenURL(googleMapURL)){
            UIApplication.shared.open(placeURL)
        }else{
            let safariVC = SFSafariViewController(url: placeURL)
            present(safariVC, animated: true)
        }
    }
    
    private func createURL(currentPlace:Place) ->URL? {
        let baseURL = "https://www.google.com/maps/search/?api=1&query=''&query_place_id=\(currentPlace.placeID)"
        
        guard let url = URL(string:baseURL) else{ return nil}
        
        return url
    }
}

#Preview {
    HomeViewController(databaseService: DatabaseServices())
}
