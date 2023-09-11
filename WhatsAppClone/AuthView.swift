//
//  ContentView.swift
//  WhatsAppClone
//
//  Created by Reha Özkırşehirli on 6.09.2023.
//

import CoreData
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct AuthView: View {
    @Environment(\.managedObjectContext) private var viewContext

    let fireStore = Firestore.firestore()

    @State var userName: String = ""
    @State var mail: String = ""
    @State var password = ""
    @State var isPresented = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Spacer()
                TextField("E MAIL", text: $mail)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(TextInputAutocapitalization.never)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 16))
                SecureField("PASSWORD", text: $password)
                    .textContentType(.password)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 16))

                TextField("USER NAME", text: $userName)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 50, trailing: 16))
                Button("Sign In1") {
                    Auth.auth().signIn(withEmail: mail, password: password) { result,err in
                        if let err = err {
                            print(err.localizedDescription)
                        } else {
                            print("sign in done")
                            isPresented = true
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 5, trailing: 16))
                    .navigationDestination(isPresented: $isPresented) {
                        ChatList().environmentObject(UserStore())
                }
                NavigationLink {
                    ChatList()
                } label: {
                    Button("Sign Up") {
                        Auth.auth().createUser(withEmail: mail, password: password) { result, err in
                            if let err = err {
                                print(err.localizedDescription)
                            } else {
                                print("sign up done")
                                //                            var ref: DocumentReference?
                                let dict: [String: Any] = ["username": userName, "email": mail, "uuid": result!.user.uid]
                                fireStore.collection("Users").addDocument(data: dict, completion: { err in
                                    if let err = err {
                                        print(err.localizedDescription)
                                    } else {
                                    }
                                })
                            }
                        }
                    }
                }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
