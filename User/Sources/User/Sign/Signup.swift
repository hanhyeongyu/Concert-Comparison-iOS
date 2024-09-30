//
//  SignUpView.swift
//
//
//  Created by 한현규 on 7/26/24.
//

import SwiftUI


struct Signup: View {
    
    @Environment(User.self)
    private var user
    
    @State 
    private var email: String = ""
    
    @State
    private var password: String = ""
    
    @State
    private var showAlert: Bool = false
    
    @Environment(\.presentationMode)
    private var presentationMode
    
    init(){
    }
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("회원가입")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            TextField("이메일", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("비밀번호", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            Spacer()
            
            Button(action: {
                Task{
                    await signupButtonDidTap()
                }
            }) {
                Text("회원가입")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("회원가입 실패"),
                  message: Text("회원가입에 실패하였습니다."),
                  dismissButton: .default(Text("확인")))
        }
    }
        
    
    private func signupButtonDidTap() async{
        do{
            try await user.signup(email: email, password: password)
            await MainActor.run {
                presentationMode.wrappedValue.dismiss()
            }            
        }catch{
            showAlert = true
        }
    }
}

#Preview {
    Signup()
        .environment(User())
}



