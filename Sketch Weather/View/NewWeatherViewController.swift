//
//  NewWeatherViewController.swift
//  Sketch Weather
//
//  Created by Alphonso Sensley II on 5/28/21.
//  Copyright © 2021 Alphonso. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import AVKit
import MarqueeLabel
import SpriteKit


@available(iOS 14.0, *)
class NewWeatherViewController: UIViewController, UITableViewDataSource {
    var timeGreeting         = ""
    var windDirection        = ""
    var backgroundImage      = UIImageView()
    let stackView            = UIStackView()
    var cityLabel            = UILabel()
    var currentWeatherImage  = UIImageView()
    var temperatureLabel     = UILabel()
    var weatherSummaryLabel  = MarqueeLabel()
    let tableView            = UITableView()
    var menuButton           = UIBarButtonItem()
    let synthesizer          = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
    
       title = ""
        menuButton = UIBarButtonItem(image: UIImage(systemName: "menubar.arrow.down.rectangle"), style: .plain, target: self, action: #selector(menuButtonPressed))
       navigationItem.rightBarButtonItem = menuButton
       navigationItem.rightBarButtonItem?.tintColor = .black
       setupBackgroundImageView()
       setupCurrentWeatherImageView()
       setupWeatherLabels()
       tableView.backgroundColor = .clear
       configureStackView()
       
       Networking().getWeatherForecast()
        synthesizer.speak(speechUtterance())
    }
    
    @objc private func menuButtonPressed() {
        present(NewWeekWeatherViewController(), animated: true, completion: nil)
    }
    
    func configureStackView() {
        setupStackViewConstraints()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(currentWeatherImage)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(weatherSummaryLabel)
        stackView.addArrangedSubview(tableView)
    }
    
    func setupStackViewConstraints() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant:-100),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
      
    }
    
    func setupWeatherLabels() {
        view.addSubview(cityLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(weatherSummaryLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textAlignment = .center
        temperatureLabel.textAlignment = .center
        weatherSummaryLabel.textAlignment = .center
        temperatureLabel.text = "\(temp)"
        cityLabel.text = "\(cityString)"
        cityLabel.font = .systemFont(ofSize: 44, weight: .heavy)
        temperatureLabel.font = .systemFont(ofSize: 42, weight: .bold)
        weatherSummaryLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        weatherSummaryLabel.text = "\(hourlyData[0]["summary"]!)"
        temperatureLabel.text = "\(Int(temp))"
        weatherSummaryLabel.animationDelay = 1
        weatherSummaryLabel.scrollDuration = 5
        temperatureLabel.frame = .zero
        weatherSummaryLabel.frame = .zero
    }
    
    func setupCurrentWeatherImageView() {
        view.addSubview(currentWeatherImage)
        currentWeatherImage.image = UIImage(named: "Partly Cloudy")
        currentWeatherImage.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherImage.contentMode = .scaleAspectFit
        currentWeatherImage.frame = .zero
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImage)
        setBackgroundForTimeOfDay(imageView: backgroundImage)
       
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func speechUtterance() -> AVSpeechUtterance {
           var hot = ""
           var cold = ""
           let date = Date()
           let calendar = Calendar.current
           let hour = calendar.component(.hour, from: date)
           
           //This block determines the greeting based on time of day
           if (17...23).contains(hour) {
               timeGreeting = "Good Evening"
           }else if (0...11).contains(hour) {
               timeGreeting = "Good Morning"
               
           }else{
               timeGreeting = "Good Afternoon"
           }
           
        if (85...125).contains(temp) {
               hot = "It's Hot! Try to stay cool!"
               
           }else if (0...34).contains(temp) {
               cold = "Bring a Jacket! It's rather cold."
           }else{
               hot = ""
               cold = ""
           }
           
           //This block contructs the actual speech utterance
           let currentSpokenForecast = AVSpeechUtterance(string:"\(timeGreeting). Welcome Too  \(cityString).  \(hot)\(cold) The current temperature is \(temperatureLabel.text!) degrees. It is currently \(weatherSummaryLabel.text!) with wind speed at \(Int(windSpeed)) mph.\(hot)\(cold). This week it looks like \(weekSummary).")
       
        
        var voiceToUse: AVSpeechSynthesisVoice?
        for voice in AVSpeechSynthesisVoice.speechVoices() {
            if #available(iOS 9.0, *) {
                if voice.name == "Siri-1" {
                    voiceToUse = voice
                }
            }
        }
        
        currentSpokenForecast.voice = voiceToUse
//        let allVoices = AVSpeechSynthesisVoice.speechVoices()
//        currentSpokenForecast.voice = AVSpeechSynthesisVoice(language: "en-US")
//        currentSpokenForecast.voice = AVSpeechSynthesisVoice(identifier: allVoices[0].identifier)
        
           
          return currentSpokenForecast
       }
}

@available(iOS 14.0, *)
extension NewWeatherViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") else {
            //Problem Dequeing Cell, Blank Cell Will Be Returned.
            return UITableViewCell()
        }
        return cell
    }
}

