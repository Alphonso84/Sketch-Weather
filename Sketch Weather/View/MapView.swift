////
////  MapView.swift
////  Sketch Weather
////
////  Created by user on 5/15/18.
////  Copyright © 2018 Alphonso. All rights reserved.
////
//
//import Foundation
//import WebKit
//import UIKit
//
//
//import CoreLocation
//
//
//class MapView: UIViewController {
//
//
//   
//
//    let locations = CLLocationCoordinate2DMake(latitude[0] , longitude[0])
//
//
//   // let roadConditions = AWFTileSource(layerType: .roadConditions)
//
//    override func viewWillAppear(_ animated: Bool) {
//        let isRadarActive = weatherMap.containsSource(forLayerType: .radar)
//        let source = weatherMap.source(forLayerType: .radar)
//        let geoColor = weatherMap.source(forLayerType: .satelliteVisibleTransparent)
//        weatherMap.refreshAllSources()
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        weatherMap.disableAutoRefresh()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        weatherMap.enableAutoRefresh()
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        weatherMap.delegate = self
//
//        weatherMap.weatherMapView.frame = CGRect(x: 15, y: 165, width: 350, height: 500)
//            //view.bounds
//        weatherMap.addSources(forLayerTypes: [.cloudCover])
//
//        view.addSubview(weatherMap.weatherMapView)
//
////        let place = AWFPlace(city: "pittsburg", state: "ca", country: "us")
////        AWFObservations.sharedService().get(forPlace: place, options: nil) { (result) in
////            guard let results = result?.results else {print("Observation data failed to load - \(String(describing: result?.error))"); return }
////
////            if let obs = results.first as? AWFObservation {
////                print(results)
////            }
////        }
//
//        }
//
//
//}
