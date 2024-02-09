//
//  Login.swift
//  Medications+
//
//  Created by Jai Pannu on 07/02/24.
//

import SwiftUI

struct Login: View {
    var body: some View {
        ZStack{
            Color(red: 0.949, green: 0.949, blue: 0.971)
                .ignoresSafeArea()
            VStack{
                Text("Feature not available")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.vertical)
                
                Text("App is running in Developer Mode")
                    .fontWeight(.thin)
                
                    
            }
        }
    }
}

#Preview {
    Login()
}
