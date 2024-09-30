//
//  SwiftUIView.swift
//  
//
//  Created by 한현규 on 8/16/24.
//

import SwiftUI
import AppUtil

struct PaymentView: View {
    
    
    @Environment(Payment.self)    
    private var payment: Payment
    
    @Environment(\.dismiss) var dismiss
    
    @Binding
    private var path: NavigationPath
    
    
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
        
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            VStack(alignment: .leading){
                Text("결제")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(payment.orderName)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 16.0)
                
                Text(Formatter.currencyFormatter.string(from: payment.amount as NSNumber)!)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top, 4.0)
            }
                        
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.primary)
                    .frame(height: 200)
                    .cornerRadius(8.0)            
                                    
                
                Image(systemName: "creditcard")
                    .resizable()
                    .frame(width: 60, height: 40)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            
            
            Button(action: {
                Task{
                    do{
                        try await payment.payment()
                        await MainActor.run {
                            dismiss()
                        }                        
                    }catch{

                    }
                }
            }) {
                Text("결제")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
    
    
    private func queryItems(url : URL) -> [URLQueryItem]{
        let components = URLComponents(string: url.absoluteString)
        let items = components?.queryItems ?? []
        return items
    }
    

    private func paymentKey(url: URL) -> String{
        let key = "paymentKey"
        return queryItems(url: url).first { $0.name == key
        }!.value!
    }
}

#Preview {
    let mock = Payment(orderName: "Spring Concert", amount: 12000)
    return PaymentView(path: .constant(.init()))
        .environment(mock)
}
