
# iOS_Lab_assignment_2

## Group Members
- Zunayed (Roll: 46)
- Turzo (Roll: 48)
- Efty (Roll: 52)
- Anik (Roll: 121)

## Description
In the previous iOS lab, we learned how to integrate Firestore with an Xcode app to enable seamless data management. We explored setting up Firebase in the app, adding data to Firestore, and fetching it dynamically. The fetched data was displayed within the app, demonstrating real-time database capabilities. This exercise highlighted Firestore's ease of use for building scalable, cloud-backed iOS applications.

## Contribution

- Zunayed (Roll: 46)

```swift
// Add item to Firestore
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

     
```

- Turzo (Roll:48)

```swift
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

   

// Fetch Item
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

// Logout
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
```

- Efty (Roll:52)

```swift
struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Welcome Text
                Text("Welcome")
                    .font(.largeTitle)
                    .padding()

                // Email Input Field
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

                // Password Input Field
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

                // Error Message
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                // Login Button
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

                // Sign-Up Button
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
}

    
```

- Anik (Roll:121)

```Swift
  NavigationView {
    VStack {
        if isLoggedIn {
            VStack {
                // Welcome Text
                Text("Welcome to Anik Ekka!")
                    .font(.largeTitle)
                    .padding()

                // Input Field for New Item
                TextField("Enter new item", text: $newItem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                // Add Item Button
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

                // List of Items
                List(items, id: \.self) { item in
                    Text(item)
                }

                // Log Out Button
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
        }
    }
}

```


## Features

- Sign Up
- Login
- Add data to firestore through UI
- Fetch data from firestore
- Logout
  
## Screenshots

<img src="https://github.com/user-attachments/assets/04e932e2-4baf-426c-a595-1a031d77b2f0" height="400">
<img src="https://github.com/user-attachments/assets/5b33b53f-0a48-4915-88b7-a9e5ccea4a58" height="400">
<img src="https://github.com/user-attachments/assets/65273a02-2731-4eb8-be19-a4afc9d1ef7a" height="400">
<img src="https://github.com/user-attachments/assets/b875a06c-a7ee-450a-8a0e-7602177d7e81" height="400">
<img src="https://github.com/user-attachments/assets/8743c205-bcfd-4221-9499-5a2d5463ddb0" height="400">
<img src="https://github.com/user-attachments/assets/aa40cadf-82c5-42d3-a106-bd9038f9571e" height="400">

