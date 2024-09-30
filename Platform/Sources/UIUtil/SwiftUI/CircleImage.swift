//
//  CircleImage.swift
//
//
//  Created by 한현규 on 7/29/24.
//

import SwiftUI
import Kingfisher

public struct CircleImage: View {
    
    private var image : KFImage
    
    public init(url : URL){
        self.image = KFImage(url)
    }
    
    public var body: some View {
        
        ZStack {
            image
                .resizable()
                .clipShape(Circle())
                .shadow(radius: 7)
            
            Circle()
                .stroke(Color.white, lineWidth: 1.0)
        }
        
    }
}


#Preview {
    let url = URL(string: "https://upload.wikimedia.org/wikipedia/ko/thumb/2/24/Lenna.png/440px-Lenna.png")!
    return CircleImage(url: url)
}
