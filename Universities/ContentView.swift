//
//  ContentView.swift
//  Universities
//
//  Created by Daniyal Ahmed on 09/10/2024.
//
import SwiftUI
struct ContentView: View {
    @State private var country: String = ""
    @State private var universities: [University] = []
    @State private var expandedUniversity: UUID?

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter country name", text: $country)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    UniversityService().fetchUniversities(country: country) { fetchedUniversities in
                        DispatchQueue.main.async {
                            self.universities = fetchedUniversities
                        }
                    }
                }) {
                    Text("Search")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                List(universities) { university in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(university.name)
                                .onTapGesture {
                                    withAnimation {
                                        self.expandedUniversity = self.expandedUniversity == university.id ? nil : university.id
                                    }
                                }
                            Spacer()
                            Text("+")
                                .font(.title)
                                .rotationEffect(self.expandedUniversity == university.id ? .degrees(45) : .degrees(0))
                        }
                        if expandedUniversity == university.id {
                            VStack(alignment: .leading) {
                                Text("Domains: \(university.domains.joined(separator: ", "))")
                                Text("Country Code: \(university.alpha_two_code)")
                                Text("Web Sites: \(university.web_pages.first ?? "")")
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        if let url = URL(string: university.web_pages.first ?? "") {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                                Text("State / Province: \(university.state_province ?? "N/A")")
                                Text("Country: \(university.country)")
                            }
                            .padding(.leading)
                        }
                    }
                }
            }
            .navigationTitle("University Finder")
        }
    }
}
