import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct ContentView: View{

    var body: some View {
        NavigationView {

             VStack {
                  
                        Text("Welcome")
                            .font(.largeTitle)
                            .padding()

             
                        ZStack(alignment: .leading) {
                            TextField("", text: $email)
                                .foregroundColor(.blue)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                            
                            if email.isEmpty {
                                Text("Email")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 20)
                            }
                        }
                        .padding(.bottom)

               
                        ZStack(alignment: .leading) {
                            SecureField("", text: $password)
                                .foregroundColor(.blue)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                            
                            if password.isEmpty {
                                Text("Password")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 20)
                            }
                        }
                        .padding(.bottom)


                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        }
                        
             
                        Button(action: {
                            login()
                        }) {
                            Text("Login")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }

             
                        Button(action: {
                            register()
                        }) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding()
                    }

        }
    }

    func logOut() {
        do {
            try Auth.auth().signOut()
            print("Successfully signed out")
            isLoggedIn = false
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}