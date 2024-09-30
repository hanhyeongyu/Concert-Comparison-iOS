//
//  SignInView.swift
//
//
//  Created by 한현규 on 7/26/24.
//

import SwiftUI

public struct SignIn: View {
    
    @Environment(User.self)
    private var user: User
    
    @State
    private var email: String = ""
    
    @State
    private var password: String = ""
    
    @State
    private var isSecure: Bool = true    
    
    @State
    private var showAlert: Bool = false
    
    
    public init(){
    }
    
    public var body: some View {
        NavigationView{
            VStack {
                Text("로그인")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal, 16)
                
                
                HStack {
                    if isSecure {
                        SecureField("password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    } else {
                        TextField("password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        isSecure.toggle()
                    }) {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
                
                Button(action: {
                    Task{
                        await signinButtonDidTap()
                    }
                }){
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                
                
                Spacer()
                
                
                NavigationLink(
                    destination: Signup()
                ) {
                    Text("SignUp")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 16)
                }.padding(.bottom, 16.0)
            }
            
        }
        .navigationBarTitle("Login", displayMode: .inline)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("이메일, 비밀번호를 확인하세요"),
                  message: Text("해당 정보와 일치하는 회원이 존재하지 않습니다."),
                  dismissButton: .default(Text("확인")))
        }
    }
    
    private func signinButtonDidTap() async{
        do{
            try await user.signIn(email: email, password: password)
        }catch{
            await MainActor.run {
                showAlert = true
            }
        }
    }
}

#Preview {
    SignIn()
        .environment(User())
}



