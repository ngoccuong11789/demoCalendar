//
//  ViewController.swift
//  DemoCalendar
//
//  Created by spcv on 6/15/17.
//  Copyright © 2017 spcv. All rights reserved.
//

import UIKit
import JTAppleCalendar
class ViewController: UIViewController {

    @IBOutlet weak var calendarView2: JTAppleCalendarView!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthlyLbl: UILabel!
    let formatter = DateFormatter()
    let calendar = Calendar.current
    var currentDate: Date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        calendarView.visibleDates { (visibleDate) in
            self.setupViewOfCalendar(visibleDates: visibleDate)
        }
        calendarView.scrollDirection = .vertical
        calendarView.scrollToDate(Date())
    }
    @IBAction func nextAction(_ sender: Any) {

        let nextWeekDate = calendar.date(byAdding: .day, value: 7, to: currentDate)
        calendarView.scrollToDate(nextWeekDate!)
        
    }
    @IBAction func previousBtn(_ sender: Any) {
        let previousWeekDate = calendar.date(byAdding: .day, value: -7, to: currentDate)
        calendarView.scrollToDate(previousWeekDate!)
    }


    func setupViewOfCalendar(visibleDates : DateSegmentInfo) {
        guard let date = visibleDates.monthDates.first?.date else {
            return
        }
        formatter.dateFormat = "MMMM"
        monthlyLbl.text = formatter.string(from: date)
    }
    
}

extension ViewController : JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 06 15")
        let endDate = formatter.date(from: "2017 12 31")
        //let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!, numberOfRows: 1, calendar: self.calendar, generateInDates: .forAllMonths , generateOutDates: .tillEndOfGrid, firstDayOfWeek: .sunday)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        if calendar == calendarView {
            guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CalendarCell else {
                return UICollectionViewCell() as! JTAppleCell
            }
            
            cell.dateLbl.text = cellState.text
            //cell.dateLbl_2.text = cellState.text
            return cell
        }
        if calendar == calendarView2 {
            guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "customCell2", for: indexPath) as? CalendarCell2 else {
                return UICollectionViewCell() as! JTAppleCell
            }
            
            cell.dateLbl_2.text = cellState.text
            return cell
        }else {
            return UICollectionViewCell() as! JTAppleCell
        }
        
    }
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewOfCalendar(visibleDates: visibleDates)
        guard let date = visibleDates.monthDates.first?.date else {
            return
        }
        currentDate = date
    }
    
}
