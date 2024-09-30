//
//  SwiftUIView.swift
//  
//
//  Created by 한현규 on 8/14/24.
//

import SwiftUI

public struct PageView<Page : View>: View {
    var pages: [Page]
    @State private var currentPage = 0
    
    public init(pages: [Page]) {
        self.pages = pages
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.trailing)
        }
        
    }
}

