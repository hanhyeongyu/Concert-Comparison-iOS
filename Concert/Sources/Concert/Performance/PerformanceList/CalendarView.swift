//
//  CalendarView.swift
//  
//
//  Created by 한현규 on 8/22/24.
//


import Foundation
import UIKit
import SwiftUI

struct CalendarView: UIViewRepresentable {
    
    
    @Binding
    private var allowedDates: Set<Date>
    
    @Binding 
    private var selection: Selection
    
    init(
        allowedDates: Binding<Set<Date>>,
        dateSelected: Binding<Selection>
    ) {
        self._allowedDates = allowedDates
        self._selection = dateSelected
    }
    
    func makeUIView(context: Context) -> UICalendarView {
        let calendar = Calendar(identifier: .gregorian)
        let view = UICalendarView()
                
        view.delegate = context.coordinator                           
        
        view.calendar = calendar
        
        view.availableDateRange = DateInterval(start: allowedDates.min() ?? .now, end: allowedDates.max() ?? .now)
        view.wantsDateDecorations = false       //if decoration -> true
        
                
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dateSelection
        
        
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {        
        let reload = [selection.current, selection.before].compactMap { $0 }
        uiView.reloadDecorations(forDateComponents: reload, animated: true)
    }
    
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        
        var parent: CalendarView
        var dateSelected: DateComponents?

        init(parent: CalendarView) {
            self.parent = parent
        }

        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            if parent.selection.current == dateComponents {
                return .customView {
                    let label = UILabel()
                    label.text = "❤️"
                    label.adjustsFontSizeToFitWidth = true
                    label.textAlignment = .center
                    return label
                }
            }
            return .default()
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate,
                           didSelectDate dateComponents: DateComponents?) {
            parent.selection.update(dateComponents)
            //parent.dateSelected = dateComponents
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate,
                           canSelectDate dateComponents: DateComponents?) -> Bool {
            guard let dateComponents = dateComponents,
                  let date = Calendar.current.date(from: dateComponents) else { return false }
            return parent.allowedDates.contains(date)
        }
    }
    
    
    
    @Observable
    class Selection{
        var current: DateComponents?
        var before: DateComponents?
        func update(_ date: DateComponents?){
            self.before = current
            self.current = date
        }
    }

}



