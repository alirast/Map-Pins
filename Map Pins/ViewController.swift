//
//  ViewController.swift
//  Map Pins
//
//  Created by n on 03.10.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
//MARK: - properties
    @IBOutlet var mapView: MKMapView!
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", info: "Home to the 2012 Summer Olympics", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), wikiData: "London")
        let oslo = Capital(title: "Oslo", info: "Founded over a thousand years ago.", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), wikiData: "Oslo")
        let paris = Capital(title: "Paris", info: "Often called the City of Light.", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), wikiData: "Paris")
        let rome = Capital(title: "Rome", info: "Has a whole country inside it.", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), wikiData: "Rome")
        let washington = Capital(title: "Washington DC", info: "Named after George himself.", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), wikiData: "Washington,_D.C.")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeMapType))
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
//MARK: - mapView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.pinTintColor = .red
        return annotationView
    }
    
//MARK: - calloutAccessoryControlTapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Wikipedia", style: .default) { _ in
            let dvc = DetailViewController() 
            dvc.selectedCapital = capital
            self.navigationController?.pushViewController(dvc, animated: true)
        })
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
//MARK: - mapType
    @objc func changeMapType() {
        let ac = UIAlertController(title: "How do you want to view the map?", message: "Choose the map type", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Satellite", style: .default) { [self] _ in mapView.mapType = .satellite })
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default) { [self] _ in
            mapView.mapType = .hybrid })
        ac.addAction(UIAlertAction(title: "Flyover", style: .default) { [self] _ in
            mapView.mapType = .hybridFlyover })
        ac.addAction(UIAlertAction(title: "Standard", style: .default) { [self] _ in
            mapView.mapType = .standard })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}

