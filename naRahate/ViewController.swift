//
//  ViewController.swift
//  naRahate
//
//  Created by Азамат Кубаев on 14.02.2024.
//


import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    var imageName: String?
    var name: String?
    var latitude: CLLocationDegrees = 0.0 // Объявляем свойство для хранения широты
    var longitude: CLLocationDegrees = 0.0 // Объявляем свойство для хранения долготы
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        if let name = name {
            labelName.text = name
        }
        
        if let imageName = imageName {
            imageView.image = UIImage(named: imageName)
        }
        locationManager.requestWhenInUseAuthorization()
        drawRoute()
    }
    
    func drawRoute() {
        let userLatitude: CLLocationDegrees = 51.094826
        let userLongitude: CLLocationDegrees = 71.405771

        let sourcePlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude))
        let destinationPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = sourceMapItem
        directionsRequest.destination = destinationMapItem
        directionsRequest.transportType = .transit
        
        let directions = MKDirections(request: directionsRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error calculating directions: \(error.localizedDescription)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
}

