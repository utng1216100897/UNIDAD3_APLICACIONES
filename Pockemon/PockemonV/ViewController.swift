//
//  ViewController.swift
//  PockemonV
//
//  Created by LABMAC13 on 01/03/19.
//  Copyright © 2019 LABMAC13. All rights reserved.
//

import UIKit
import GoogleMaps
class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    var mapView:GMSMapView!
    let locationManger = CLLocationManager()
    var listPokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadPokemons()
        
        let camera = GMSCameraPosition.camera(withLatitude: 43, longitude: -77, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        
        self.mapView.delegate = self
        
        // Get user permision and later get the location
        self.locationManger.requestAlwaysAuthorization()
        self.locationManger.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()  {
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManger.startUpdatingLocation()
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.listPokemon.append(Pokemon(latitude: coordinate.latitude, longitude: coordinate.longitude, image: "Charmander", name: "Charmander", des: "Charmander lives in Japan", power: 55))
        
        var index = 0
        for pokemon in listPokemon{
            
            if !pokemon.isCatch! {
                let markerPokemon = GMSMarker()
                markerPokemon.position = CLLocationCoordinate2D(latitude: pokemon.latitude!, longitude: pokemon.longitude!)
                markerPokemon.title = pokemon.name!
                markerPokemon.snippet = "\(pokemon.des!), power \(pokemon.power!)"
                markerPokemon.icon = UIImage(named: pokemon.image!)
                markerPokemon.map = self.mapView
                
                if (Double(myLocation.latitude).roundTo(places: 4) == Double(pokemon.latitude!).roundTo(places: 4) &&
                    Double(myLocation.longitude).roundTo(places: 4) == Double(pokemon.longitude!).roundTo(places: 4)){
                    listPokemon[index].isCatch = true
                    AlertDialog(PokemonPower: pokemon.power!)
                }
            }
            
            index = index + 1
        }
    }
    
    var myLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        myLocation = manager.location!.coordinate
        
        // my location
        let markerMe = GMSMarker()
        markerMe.position = CLLocationCoordinate2D(latitude: myLocation.latitude, longitude: myLocation.longitude)
        markerMe.title = "Me"
        markerMe.snippet = "Here is my location"
        markerMe.icon = UIImage(named: "Mario")
        markerMe.map = self.mapView
        
        var index = 0
        for pokemon in listPokemon{
            
            if !pokemon.isCatch! {
                let markerPokemon = GMSMarker()
                markerPokemon.position = CLLocationCoordinate2D(latitude: pokemon.latitude!, longitude: pokemon.longitude!)
                markerPokemon.title = pokemon.name!
                markerPokemon.snippet = "\(pokemon.des!), power \(pokemon.power!)"
                markerPokemon.icon = UIImage(named: pokemon.image!)
                markerPokemon.map = self.mapView
                
                if (Double(myLocation.latitude).roundTo(places: 4) == Double(pokemon.latitude!).roundTo(places: 4) &&
                    Double(myLocation.longitude).roundTo(places: 4) == Double(pokemon.longitude!).roundTo(places: 4)){
                    listPokemon[index].isCatch = true
                    AlertDialog(PokemonPower: pokemon.power!)
                }
            }
            
            index = index + 1
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: myLocation.latitude, longitude: myLocation.longitude, zoom: 15)
        self.mapView.camera = camera
    }
    
    var playerPower:Double = 0
    func LoadPokemons(){
        self.listPokemon.append(Pokemon(latitude: 37.778994893035, longitude: -122.401846647263, image: "Charmander", name: "Charmander", des: "Charmander lives in Japan", power: 55))
        self.listPokemon.append(Pokemon(latitude: 37.7949568502667, longitude: -122.410494089127, image: "Bulbasaur", name: "Bulbasaur", des: "Bulbasaur lives in USA", power: 90.5))
        self.listPokemon.append(Pokemon(latitude: 37.7816621152613, longitude: -122.41225361824, image: "Squirtle", name: "Squirtle", des: "Squirtle lives in Iraq", power: 33.5))
    }
    
    func AlertDialog(PokemonPower:Double){
        playerPower = playerPower + PokemonPower
        let alert = UIAlertController(title: "Catch new pokemon", message: "Your new power is \(playerPower)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {action in print("+ one")}))
        self.present(alert, animated: true, completion: nil)
    }
}

extension Double{
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

