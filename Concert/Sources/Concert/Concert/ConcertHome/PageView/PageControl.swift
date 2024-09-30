//
//  PageControl.swift
//  
//
//  Created by 한현규 on 8/14/24.
//

import SwiftUI
import UIKit


struct PageControl: UIViewRepresentable {
            
    var numberOfPages : Int
    @Binding var currentPage : Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
        
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.addTarget(
            self,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged
        )
        return control
    }
    
    func updateUIView(_ pageControl: UIPageControl, context: Context) {
        pageControl.currentPage = currentPage
    }
    
    class Coordinator : NSObject{
        var control : PageControl
        
        init(_ control: PageControl) {
            self.control = control
        }
        
        @objc
        func updateCurrentPage(sender : UIPageControl){
            control.currentPage = sender.currentPage
        }
    }
    
}
