//
//  ChooseMapViewController.swift
//  TracMe
//
//  Created by Archit Rathi on 3/15/16.
//  Copyright © 2016 Archit Rathi. All rights reserved.
//

import UIKit
import MapKit

class ChooseMapViewController: UIViewController, MKMapViewDelegate {

    var email: String!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    @IBAction func search(sender: AnyObject) {
        self.performSearch();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldReturn(sender: AnyObject) {
        sender.resignFirstResponder()
        mapView.removeAnnotations(mapView.annotations)
        self.performSearch()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func performSearch() {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText.text
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler{
            (response: MKLocalSearchResponse?, error: NSError?) in
            if let items = response?.mapItems
            {
                for item in items{
                    
                    
                    let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: item.placemark.location!.coordinate.latitude, longitude: item.placemark.location!.coordinate.longitude);
                    
                    var span = MKCoordinateSpanMake(0.5, 0.5)
                    var region = MKCoordinateRegion(center: location, span: span)
                    
                    self.mapView.setRegion(region, animated: true);
                    
                    let anotation = MKPointAnnotation()
                    anotation.coordinate = location
                    anotation.title = item.name!;
                    //print(anotation.coordinate);
                    self.mapView.addAnnotation(anotation)
                    
                    

                }
            }
        }
    }

}
