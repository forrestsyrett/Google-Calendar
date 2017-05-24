//
//  ViewController.swift
//  GoogleCalendar
//
//  Created by TLPAAdmin on 5/23/17.
//  Copyright © 2017 Forrest Syrett. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST
import GoogleSignIn
import Alamofire
import SwiftyJSON
import JTAppleCalendar


class ViewController: UIViewController {
    
    var eventsArray: [String] = []
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    Alamofire.request("https://www.googleapis.com/calendar/v3/calendars/llpa.isc@gmail.com/events?key=AIzaSyCn0Iqz8JDaVf9ry6K7rUyzvhhWKcSh70E", method: .get).validate().responseJSON { response in
    switch response.result {
    case .success(let value):
    let json = JSON(value)
    
    print(json)
    let items = json["items"].arrayValue
        
    for item in items {
        let event = (item["summary"])
        self.eventsArray.append(event.string!)
        }
        
        print(self.eventsArray)
    
    case .failure(let error):
    print(error)
    }
}
    }
    
    func createEvent() {
        
        
    }
    
    
    
 }

extension ViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    /// Tells the delegate that the JTAppleCalendar is about to display
    /// a date-cell. This is the point of customization for your date cells
    /// - Parameters:
    ///     - calendar: The JTAppleCalendar view giving this information.
    ///     - date: The date attached to the cell.
    ///     - cellState: The month the date-cell belongs to.
    ///     - indexPath: use this value when dequeing cells
   

    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        
        let startDate = dateFormatter.date(from: "2017 01 01")!
        let endDate = dateFormatter.date(from: "2017 12 31")!

        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        return cell
    }
}

