//
//  MenuView.swift
//  Sketch Weather
//
//  Created by user on 1/8/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import Foundation
import UIKit

class MenuView: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    let SectionHeaderHeight: CGFloat = 25
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return bayArea.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int, indexPath: IndexPath) -> String? {
        return bayArea[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
        view.backgroundColor = .black
        let label = UILabel(frame: CGRect(x: 26, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .left
        label.textColor = UIColor.lightText
        label.text = bayArea[section]
        
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.text = cities[indexPath.section][indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    @IBAction func closeMenuButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        func tap() {
            self.dismiss(animated: true)
        }
        tap()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    
    
}




