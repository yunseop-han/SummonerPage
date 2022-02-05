//
//  Date+RelativeDate.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/06.
//
import Foundation

extension Date {
    func getRelativeDate() -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: Date())

         if let year = interval.year, year > 0 {
             return "\(year)년 전"
         } else if let month = interval.month, month > 0 {
             return "\(month)달 전"
                 
         } else if let day = interval.day, day > 0 {
             return day == 1 ? "어제" : "\(day)일 전"
         } else if let hour = interval.hour, hour > 0 {
             return "\(hour)시간 전"
         } else if let min = interval.minute, min > 0 {
             return "\(min)분 전"
         } else {
             return "방금전"
         }
    }
}
