//
//  GiftData.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/12/26.
//

import SwiftUI
import Foundation
internal import Combine

@MainActor
class GiftData: ObservableObject {
    @AppStorage("GiftData") private var giftData: Data = Data()
    @Published var gift: ProductItem = ProductItem()
    
    init() {
        gift = (try? JSONDecoder().decode(ProductItem.self, from: giftData)) ?? ProductItem()
    }
    
    func closestToFive() -> Date {
        let date = Date()
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        
        components.hour = 5
        components.minute = 0
        components.second = 0
        
        guard let earlier = calendar.date(from: components) else { return Date() }
        guard let later = calendar.date(byAdding: .day, value: 1, to: earlier) else { return Date() }
        let dif1 = abs(earlier.timeIntervalSince(date))
        let dif2 = abs(later.timeIntervalSince(date))
        if dif1 < dif2 { return earlier }
        else { return later }
    }
    
    func earlyFive() -> Date {
        let date = Date()
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        
        components.hour = 5
        components.minute = 0
        components.second = 0
        
        guard let earlier = calendar.date(from: components) else { return Date() }
        return earlier
    }
    
    func earlyFive(_ date: Date) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        
        components.hour = 5
        components.minute = 0
        components.second = 0
        
        guard let earlier = calendar.date(from: components) else { return Date() }
        return earlier
    }
    
    func lateFive() -> Date {
        let date = Date()
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        
        components.hour = 5
        components.minute = 0
        components.second = 0
        
        guard let earlier = calendar.date(from: components) else { return Date() }
        guard let later = calendar.date(byAdding: .day, value: 1, to: earlier) else { return Date() }
        return later
    }
    
//    func getFirstCompliment() -> String {
//        guard gift.compliments.count > 0 else { return "No compliments yet!" }
//        guard let comp = gift.compliments.first else {return "Compliments Empty"}
//        guard let date = gift.startDate else {return "not started"}
//        gift.complimentsGiven = [date : comp]
//        gift.dateLast = date
//        gift.removeCompliments(compliment: comp)
//        save()
//        return comp
//    }
//    
//    func getTodayCompliment() -> String {
//        if gift.complimentsGiven == nil {
//            return getFirstCompliment()
//        } else {
//            guard !gift.compliments.isEmpty else {return "No compliments yet!"}
//            guard let comp = gift.compliments.first else { return "No compliments yet!" }
//            guard let dateLast = gift.dateLast else { return "No compliments yet!" }
//            guard gift.complimentsGiven != nil else { return "No compliments yet!" }
//            let timeint: Double = 23 * 60 * 60
//            let timeSince = dateLast.timeIntervalSince(Date())
//            if timeSince >= timeint {
//                let dt = closestToFive()
//                gift.complimentsGiven![dt] = comp
//                gift.dateLast = dt
//                gift.removeCompliments(compliment: comp)
//                save()
//                return comp
//            } else {
//                return gift.complimentsGiven![dateLast] ?? "No compliments yet!"
//            }
//        }
//    }
    
    func getTodayCompliment() -> String? {
        guard let sd = gift.startDate else { return nil }
        if let cg = gift.complimentsGiven {
            let rn  = earlyFive()
            let interval = Int(rn.timeIntervalSince(sd))
            if interval < 0 {
                return gift.compliments[0]
            } else {
                let newint = interval / (60 * 60 * 24)
                if newint < gift.compliments.count {
                    return gift.compliments[newint]
                } else {
                    return nil
                }
            }
        } else {
            return nil
        }
    }
    
    func getSentGifts() -> [Date : String] {
        guard let cg = gift.complimentsGiven else { return [:] }
        var ar: [Date : String] = [:]
        for i in 0 ..< cg.count {
            ar[cg[i]] = gift.compliments[i]
        }
        return ar
    }
    
    func endGift() async throws {
        do {
            try await FireBaseProductManager.shared.endGift(gift: gift)
        } catch {
            
        }
        
    }
    
//    func getGiftatDate(_ date: Date) -> String? {
//        let calendar = Calendar.current
//        guard date > gift.startDate! else { return nil }
//        let counting = (gift.compliments.count + gift.complimentsGiven!.count) - 1
//        let end = calendar.date(byAdding: .day, value: counting, to: gift.startDate!)
//        if (date >= gift.startDate!) && (date <= end!) {
//            let dt = earlyFive(date)
//            let dtc = earlyFive()
//            let timeSince = Int(dt.timeIntervalSince(dtc)/(60*60*24))
//            if (timeSince <= 0) {
//                return gift.complimentsGiven![dt]
//            } else {
//                return gift.compliments[timeSince]
//            }
//        } else {
//            return nil
//        }
//    }
    
    func signOut() {
        giftData = Data()
        gift = ProductItem()
    }
    
    func setGift(_ gift: ProductItem) {
        self.gift = gift
        save()
    }
    
    func getCompliments() -> [String] {
        return gift.compliments
    }
    
    func getSenderId() -> String {
        return gift.senderId
    }
    
    func getReceiverId() -> String? {
        return gift.receiverId
    }
    
    func getStartDate() -> Date? {
        return gift.startDate
    }
    
    func getGift() -> ProductItem {
        return gift
    }
    
    private func save() {
        giftData = (try? JSONEncoder().encode(gift)) ?? Data()
    }
}
