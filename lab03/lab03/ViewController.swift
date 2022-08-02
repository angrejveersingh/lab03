//
//  ViewController.swift
//  lab03
//
//  Created by Angrej veer Singh on 2022-07-21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var introMessage: UILabel!
    @IBOutlet weak var localTime: UILabel!
    
    @IBOutlet weak var weatherDescription: UILabel!
    private let locationManager = CLLocationManager()
//    private let locationManagerDelegate = MyLocationManagerDelegate()
    
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windImage: UIImageView!
    
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var cloudImage: UIImageView!
    @IBOutlet weak var humidityImage: UIImageView!
    @IBOutlet weak var weatherLocationImage: UIImageView!
//    var searchField: String?
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
        locationManager.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        searchField = textField.text
        loadWeather(search: textField.text)
        textField.endEditing(true)
        return true
    }

    @IBAction func onLocationTapped(_ sender: UIButton) {
        print("Location tapped")
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    @IBAction func onSearchTapped(_ sender: UIButton) {
        loadWeather(search: searchTextField.text)
    }
    
    private func loadWeather(search : String?){
        guard let search = search else {
            return
        }
        
        guard let url = getURL(query: search) else {
            print("Could not get the URL")
            return
        }
        
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            print("Network call resumed")
            
            guard error == nil else {
                print("Error occurred")
                return
            }
            
            guard let data = data else {
                print("Didnot get the data")
                return
            }
            
            if let weatherResponse = self.parseJson(data: data) {
                print(weatherResponse.location.country)
                print(weatherResponse.location.name)
                print(weatherResponse.current.condition.code)
                
                DispatchQueue.main.async {
                    print("Area code= \(weatherResponse.current.condition.code)")
                    self.introMessage.text = ""
                    self.locationLabel.text = weatherResponse.location.name
                    self.localTime.text = "\(weatherResponse.location.localtime)"
                    self.temperatureLabel.text = "\(weatherResponse.current.temp_c)C"
                    self.windSpeed.text = "\(weatherResponse.current.wind_kph) kph"
                    self.humidityLabel.text = "\(weatherResponse.current.humidity)"
                    self.cloudLabel.text = "\(weatherResponse.current.cloud)"
                    
                    let config2 = UIImage.SymbolConfiguration(paletteColors: [.systemBlue])
                    self.windImage.preferredSymbolConfiguration = config2
                    self.windImage.image = UIImage(systemName: "wind")
                    
                    
                    self.humidityImage.preferredSymbolConfiguration = config2
                    self.humidityImage.image = UIImage(systemName: "humidity")
                    
                    self.cloudImage.preferredSymbolConfiguration = config2
                    self.cloudImage.image = UIImage(systemName: "cloud")
                    
                    switch weatherResponse.current.condition.code {
                        case 1000:
                             let config = UIImage.SymbolConfiguration(paletteColors: [.systemYellow])
                             self.weatherLocationImage.preferredSymbolConfiguration = config
                             self.weatherLocationImage.image = UIImage(systemName: "sun.max.fill")
                             self.weatherDescription.text =  "\(weatherResponse.current.condition.text)"
                             
                             break
                        
                    case 1003:
                        let config = UIImage.SymbolConfiguration(paletteColors: [.systemBackground,.systemYellow])
                        self.weatherLocationImage.preferredSymbolConfiguration = config
                        self.weatherLocationImage.image = UIImage(systemName: "cloud.sun.fill")
                        self.weatherDescription.text =  "\(weatherResponse.current.condition.text)"
                        
                        break
                        
                    case 1006:
                        let config = UIImage.SymbolConfiguration(paletteColors: [.systemBackground])
                        self.weatherLocationImage.preferredSymbolConfiguration = config
                        self.weatherLocationImage.image = UIImage(systemName: "cloud.fill")
                        self.weatherDescription.text =  "\(weatherResponse.current.condition.text)"
                        break
                        
                    case 1135:
                        let config = UIImage.SymbolConfiguration(paletteColors: [.systemBackground])
                        self.weatherLocationImage.preferredSymbolConfiguration = config
                        self.weatherLocationImage.image = UIImage(systemName: "cloud.fog.fill")
                        self.weatherDescription.text =  "\(weatherResponse.current.condition.text)"
                        break
                        
                    case 1183:
                        let config = UIImage.SymbolConfiguration(paletteColors: [.systemBackground])
                        self.weatherLocationImage.preferredSymbolConfiguration = config
                        self.weatherLocationImage.image = UIImage(systemName: "cloud.rain.fill")
                        self.weatherDescription.text =  "\(weatherResponse.current.condition.text)"
                        break
                        
                    case 1153:
                        let config = UIImage.SymbolConfiguration(paletteColors: [.systemBackground])
                        self.weatherLocationImage.preferredSymbolConfiguration = config
                        self.weatherLocationImage.image = UIImage(systemName: "cloud.drizzle.fill")
                        self.weatherDescription.text =  "\(weatherResponse.current.condition.text)"
                        break
                        
                    case 1195:
                        let config = UIImage.SymbolConfiguration(paletteColors: [.systemBackground])
                        self.weatherLocationImage.preferredSymbolConfiguration = config
                        self.weatherLocationImage.image = UIImage(systemName: "cloud.heavyrain.fill")
                        self.weatherDescription.text =  "\(weatherResponse.current.condition.text)"
                        break
                        
                    case 1240:
                        let config = UIImage.SymbolConfiguration(paletteColors: [.systemBackground])
                        self.weatherLocationImage.preferredSymbolConfiguration = config
                        self.weatherLocationImage.image = UIImage(systemName: "cloud.rain.fill")
                        self.weatherDescription.text =  "\(weatherResponse.current.condition.text)"
                        break
                        
                    case 1276:
                        let config = UIImage.SymbolConfiguration(paletteColors: [.systemBackground])
                        self.weatherLocationImage.preferredSymbolConfiguration = config
                        self.weatherLocationImage.image = UIImage(systemName: "cloud.bolt.rain.fill")
                        self.weatherDescription.text =  "\(weatherResponse.current.condition.text)"
                        break
                        
                    case 1258:
                        let config = UIImage.SymbolConfiguration(paletteColors: [.systemBackground])
                        self.weatherLocationImage.preferredSymbolConfiguration = config
                        self.weatherLocationImage.image = UIImage(systemName: "cloud.snow.fill")
                        self.weatherDescription.text =  "\(weatherResponse.current.condition.text)"
                        break
                    
                    default:
                        print("Weather not defined")
                        
                    }

                }
                
                
            }
           
        }
        dataTask.resume()
    }
    
    private func getURL(query : String) -> URL? {
        let baseURL = "https://api.weatherapi.com/v1/"
        let currentEndpoint = "current.json"
        let apiKey = "af864be34c8e458bbcd190930222207"
        
        
        guard let url = "\(baseURL)\(currentEndpoint)?key=\(apiKey)&q=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        return URL(string: url)
//        let url = "http://api.weatherapi.com/v1/current.json?key=af864be34c8e458bbcd190930222207&q=London&aqi=no"
    }
    
    private func parseJson(data:Data) -> WeatherResponse?{
        let decoder = JSONDecoder()
        var weather: WeatherResponse?
        
        do{
            weather =  try decoder.decode(WeatherResponse.self, from: data)
        }catch{
            print("Error decoding")
            
            DispatchQueue.main.async {
                let config = UIImage.SymbolConfiguration(paletteColors: [.systemRed])
                self.weatherLocationImage.preferredSymbolConfiguration = config
                self.weatherLocationImage.image = UIImage(systemName: "exclamationmark.octagon")
                self.temperatureLabel.text = ""
                self.locationLabel.text = ""
                self.weatherDescription.text = "Please enter valid name!!"
                self.windSpeed.text = ""
                self.humidityLabel.text = ""
                self.cloudLabel.text = ""
                self.localTime.text = ""
                self.introMessage.text = ""
                
            }
            
        }
        
        return weather
    }
    
    
    
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got location")
        
        if let location = locations.last{
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("\(latitude),\(longitude)")
            let currentCordinates = "\(latitude) \(longitude)"
            loadWeather(search: currentCordinates)
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

struct WeatherResponse: Decodable{
    let location: Location
    let current: Weather
}

struct Location: Decodable{
    let name: String
    let country: String
    let localtime : String
}

struct Weather: Decodable{
    let temp_c: Float
    let condition: WeatherCondition
    let wind_kph : Float
    let humidity: Float
    let cloud : Float
}

struct WeatherCondition: Decodable{
    let text: String
    let code: Int
  
}

class MyLocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    
}

