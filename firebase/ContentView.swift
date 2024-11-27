import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct ContentView: View{

    var body: some View {
        NavigationView {

             VStack {
                if isLoggedIn {

                    VStack {
                        Text("Welcome to Anik Ekka!")
                            .font(.largeTitle)
                            .padding()
                        

                        TextField("Enter new item", text: $newItem)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
              
                        Button(action: {
                            addItemToFirestore()
                        }) {
                            Text("Add Item")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding()
                        
                      
                        List(items, id: \.self) { item in
                            Text(item)
                        }
                        

                        Button(action: {
                            logOut()
                        }) {
                            Text("Log Out")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                    .onAppear {
                        fetchItems()
                    }
                } else {
                  
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
    // Register
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isLoggedIn = true
            }
        }
    }

    // Login
     func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isLoggedIn = true
            }
        }
    }

}
    func addItemToFirestore() {
        if !newItem.isEmpty {
            db.collection("items").addDocument(data: [
                "item": newItem,
                "timestamp": Timestamp()
            ]) { error in
                if let error = error {
                    print("Error adding document: \(error.localizedDescription)")
                } else {
                    newItem = ""
                    fetchItems()
                }
            }
        }
    }

     func fetchItems() {
        db.collection("items").order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error.localizedDescription)")
                } else {
                    items = snapshot?.documents.compactMap { document in
                        return document.data()["item"] as? String
                    } ?? []
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}