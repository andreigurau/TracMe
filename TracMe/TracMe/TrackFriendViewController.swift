//
//  TrackFriendViewController.swift
//  TracMe
//
//  Created by Andrei Gurau on 4/5/16.
//  Copyright © 2016 Archit Rathi. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation

class TrackFriendViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    var e: String!;
    var myEmail: String!
    var trackingEmail: String!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var myLocations: [CLLocation] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        //goToLocation(centerLocation)
        //print(destination)
        
        var carlos = Firebase(url: "https://vivid-torch-4452.firebaseio.com/"+myEmail+"/tracker/email");
        
        carlos.observeEventType(.Value, withBlock: { snapshot in
            self.e = snapshot.value as! String;
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        
        
        
        //Setup our Map View
        mapView.delegate = self
        mapView.mapType = MKMapType.Satellite
        mapView.showsUserLocation = true
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        //destination.coordinate =
        //destination.title = item.name!;
        //print(anotation.coordinate);
        //self.mapView.addAnnotation(destination!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //print(locations[0])
    
        e = e!.stringByReplacingOccurrencesOfString(".", withString: "t", options: NSStringCompareOptions.LiteralSearch, range: nil);
        var ref = Firebase(url: "https://vivid-torch-4452.firebaseio.com/"+e+"/coordinate")
        
        myLocations.append(locations[0] as CLLocation)
        
        let spanX = 0.007
        let spanY = 0.007
        var newRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        mapView.setRegion(newRegion, animated: true)
        
        if (myLocations.count > 1){
            var sourceIndex = myLocations.count - 1
            var destinationIndex = myLocations.count - 2
            
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[destinationIndex].coordinate
            var a = [c1, c2]
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            mapView.addOverlay(polyline)
        }
    }
    
}