//
//  ViewController.swift
//  BitcoinTicker
//


import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.currencyPicker.delegate = self
        self.currencyPicker.dataSource = self
        
     
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    //Number of columns of data
    func numberOfComponents(in pickView: UIPickerView) -> Int {
        return 2
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }

    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        finalURL = currencyArray[row]
        makeGetCall()
    }
    
    
    
//    
//    //MARK: - Networking URLSesion
//    /***************************************************************/
//    
//    func getWeatherData(url: String, parameters: [String : String]) {
//
//
//    }
//
    
    func makeGetCall() {
        // Set up the URL request
        guard let url = URL(string: baseURL + finalURL) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON1")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
                print("The todo is: " + todo.description)
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                guard let HOLA = todo["bid"] else {
                    print("Could not get todo title from JSON")
                    return
                }
                print(HOLA)
                let bitCoin = String(describing: HOLA)
                DispatchQueue.main.async {
                    self.bitcoinPriceLabel.text = bitCoin
                }
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    
    
  
//    
//    //MARK: - JSON Parsing without SwiftyJSON
//    /***************************************************************/
//    
//    func updateWeatherData(json : JSON) {
//
//
//        updateUIWithWeatherData()
//    }
//
//
//    //MARK: - Update UI
//    /***************************************************************/
//
//    func updateUIWithWeatherData() {
//
//    }



}

