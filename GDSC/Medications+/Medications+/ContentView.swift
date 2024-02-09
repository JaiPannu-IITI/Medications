//
//  ContentView.swift
//  Medications+
//
//  Created by Jai Pannu on 05/02/24.
//

import SwiftUI
import SwiftData
import UIKit
import UserNotifications


class GlobalValues : ObservableObject {
    
    @Published  var summary = true
    @Published  var medicine = false
    @Published  var browse = false
    @Published  var AverageIntakeMonth = 0
    @Published  var DailyIntake = 0
    @Published  var AverageMissedMonth = 0
    @Published  var Missed = 0
    @Published  var isHighlightsViewActive = false
    @Published  var isArchivesViewActive = false
    @Published  var isLoginViewActive = false
    @Published  var isDateViewActive = false
    @Published  var AddMedicationActive = false
    @Published  var NameEnter = false
    @Published  var medinamegot = false
    
    
    
    
}


struct Medicine: Codable, Equatable, Hashable {
    
  
    let name: String
    let type: String
    let strength: String
    let frequency: String
    let time: Date
    var isArchived: Bool = false
    
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }
}



struct ContentView: View {
    
    
    @ObservedObject var globalvalues = GlobalValues()
    
    @State private var medications: [Medicine] = []
    @State private var medicationStrengths: [String] = []
//    @State private var archivedMedicines: [Medicine] = []
   
    @State private var medicationName: String = ""
    
    @State private var medicationType: String = ""
    
    @State private var medicationfreq : Frequen = .One
    
    @State private var time : Date = Date()
    
    @State private var medicationStrengthString : String = ""

        
   @State private var condition: Bool = false
    
    let integerStrings = ["10", "20", "30", "40", "50"]
       
    
    private var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: time)
    }
    


    
    var body: some View {
   
        
        
        
        if globalvalues.medicine
        {
                //if
                
            ZStack{
                
                VStack(spacing:0){
                    //                Color(red: 0.968, green: 0.973, blue: 0.977)
                    //                    .ignoresSafeArea()
                    //                    .frame(height: 100)
                    
//                    LinearGradient(gradient: Gradient(colors: [/*@START_MENU_TOKEN@*/Color(red: 0.196, green: 0.676, blue: 0.899)/*@END_MENU_TOKEN@*/, Color(red: 0.949, green: 0.949, blue: 0.971)]), startPoint: .top, endPoint: .bottom)
//                        .ignoresSafeArea()
//                    
                    //                            .frame(width: 200, height: 100)
                    
                    Color(red: 0.949, green: 0.949, blue: 0.971)
                        .ignoresSafeArea()
                    Color(red: 0.949, green: 0.949, blue: 0.971)
                        .ignoresSafeArea()
                    
                    /*@START_MENU_TOKEN@*/Color(red: 0.952, green: 0.957, blue: 0.953)/*@END_MENU_TOKEN@*/
                        .shadow(radius: 0.8)
                        .ignoresSafeArea()
                        .frame(height: 54)
                    
                }
                
                
              
                
                VStack{
                    
                    
                    Spacer(minLength: 39)
                    
                    HStack{
                        Spacer(minLength: 18)
                        
                        Text("Medications")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 154)
                        
                        Text("Edit")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                        
                        
                        
                        Spacer(minLength: 19)
                        
                        
                    }
                    
                    //                    Spacer(minLength: 636)
                    
                    ScrollView(){
                        
                        
//                        Button(action: {
//                            addMedication()
//                            saveMedications()
//saveMissed()
//                            loadMedications()
//loadMissed()
//                            print("done")
//                            print(medicationName)
//                        }, label: {
//                            
//                            Text("Refresh")
//                        })
                        
                 
                
                        
                        
                        
                        
                        
                        Button(action:{
                            globalvalues.AddMedicationActive = true
                        }
                    ,
                               label: {
                            
                            
                            VStack{
                                
                            
                                
                                HStack(spacing:3){
                                    
                               
                                    
                                    Text("Add Medication")
                                        .fontWeight(.regular)
                                        .foregroundColor(.blue)
                                        .font(.body)
                                        .padding(.leading)
//                                        .onAppear {
//                                            loadMedications()
//loadMissed()
//                                        }
                                    
                                    Spacer()
                                  
                                    
                                    
                                }
                                
                                
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(13)
                            .padding(.horizontal)
                            
                            
                        }

                        ).sheet(isPresented: $globalvalues.AddMedicationActive,  content: {AddMedicationView(medications: $medications, medicationName: $medicationName, medicationType: $medicationType, medicationfreq: $medicationfreq, time: $time, medicationStrengthString: $medicationStrengthString, condition: $condition, isPresented: $globalvalues.AddMedicationActive  )}
                            
                        )
                        
                        
                        List {ForEach(medications, id: \.self) { medications in
                            if !medications.isArchived {
                                Button(
                                    action:{
                                        print("pressed")
                                    },
                                    
                                    label:{
                                        HStack(spacing: 15){
                                            
                                            if medications.type == "Capsule" {
                                                
                                                
                                                Image("capsule")
                                                    .resizable()
                                                    .frame(width: 95 ,height: 100)
                                                    .cornerRadius(10)
                                                
                                                
                                            }
                                            else if medications.type == "Tablet" {
                                                
                                                
                                                Image("tablet")
                                                    .resizable()
                                                    .frame(width: 95 ,height: 100)
                                                    .cornerRadius(10)
                                                
                                                
                                            }
                                            else if medications.type == "Liquid" {
                                                
                                                
                                                Image("liquid")
                                                    .resizable()
                                                    .frame(width: 95 ,height: 100)
                                                    .cornerRadius(10)
                                                
                                                
                                            }
                                            else if medications.type == "Topical" {
                                                
                                                
                                                Image("topical")
                                                    .resizable()
                                                    .frame(width: 95 ,height: 100)
                                                    .cornerRadius(10)
                                                
                                                
                                            }
                                            else {
                                                
                                                
                                                Image("none")
                                                    .resizable()
                                                    .frame(width: 95 ,height: 100)
                                                    .cornerRadius(10)
                                                
                                                
                                            }
                                            
                                            
                                            VStack{
                                                HStack{
                                                    Text(medications.name)
                                                        .font(.title3)
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.black)
                                                    Spacer()
                                                }
                                                
                                                HStack{
                                                    Text(medications.type)
                                                        .font(.subheadline)
                                                        .foregroundColor(.black)
                                                    Spacer()
                                                }
                                                HStack{
                                                    Text("\(medications.strength) mg")
                                                        .font(.subheadline)
                                                        .foregroundColor(.black)
                                                    Spacer()
                                                }
                                                HStack(spacing: 0){
                                                    
                                                    Image(systemName: "calendar")
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color(red: 0.773, green: 0.773, blue: 0.781))
                                                    
                                                    if medications.frequency == "One"
                                                    {
                                                        Text("Every day")
                                                            .font(.body)
                                                            .fontWeight(.regular)
                                                            .foregroundColor(Color.black)
                                                            .padding(.leading)
                                                        
                                                        
                                                    }
                                                    else {
                                                        Text("Every \(medications.frequency) days")
                                                            .font(.body)
                                                            .fontWeight(.regular)
                                                            .foregroundColor(Color.black)
                                                            .padding(.leading)
                                                        
                                                        
                                                    }
                                                    
                                                    Spacer()
                                                }
                                                
                                            }
                                            Spacer()
                                            VStack(spacing: 35){
//                                                
//                                                Image(systemName: "chevron.right")
//                                                
//                                                    .fontWeight(.semibold)
//                                                    .foregroundColor(Color(red: 0.773, green: 0.773, blue: 0.781))
                                                
                                                
//                                                Button(
//                                                    action:{
//                                                        medications.isArchived = true
//                                                    },
//                                                    label:{
//                                                        Image(systemName: "archivebox.fill")
//                                                        
//                                                            .fontWeight(.semibold)
//                                                            .foregroundColor(Color(red: 0.773, green: 0.773, blue: 0.781))
//                                                    }
//                                                )
                                            }
                                        }.frame(height: 100)
                                        //
                                    }
                                )
                            }
                                        }
                        .swipeActions(edge: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/, allowsFullSwipe: /*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/) {

                            Button(/*role: .destructive*/) {
                                
                                globalvalues.Missed += 1
                              
                                    } label: {
                                        Label("Missed", systemImage: "calendar.badge.exclamationmark")
                                    }
                        }
                            
                        }.frame(minHeight: 600)
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }.frame(height: 690)
                    
                    HStack{
                        
                        Spacer()
                        
                        VStack{
                            Spacer()
                            Button(
                                
                                action: {
                                    globalvalues.summary=true
                                    globalvalues.medicine=false
                                    globalvalues.browse=false
                                },
                                
                                label: {
                                    
                                    Image(systemName: "pills.fill")
                                        .font(.title2)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.611, green: 0.571, blue: 0.563)/*@END_MENU_TOKEN@*/)
                                }
                            )
                            
                            Spacer(minLength:5)
                            
                            Text("Summary")
                                .font(.system(size: 10))
                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.611, green: 0.571, blue: 0.563)/*@END_MENU_TOKEN@*/)
                            
                        }
                        
                        Spacer()
                        
                        VStack{
                            Spacer()
                            Button(
                                
                                action: {
                                    globalvalues.summary=false
                                    globalvalues.medicine=true
                                    globalvalues.browse=false
                                },
                                
                                label: {
                                    
                                    Image(systemName: "cross.fill")
                                        .font(.title2)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.478, blue: 0.999)/*@END_MENU_TOKEN@*/)
                                }
                            )
                            
                            
                            Spacer(minLength:5)
                            
                            Text("Medications")
                                .font(.system(size: 10))
                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.478, blue: 0.999)/*@END_MENU_TOKEN@*/)
                            
                        }
                        
                        Spacer()
                        
                        VStack{
                            Spacer()
                            Button(
                                
                                action: {
                                    globalvalues.browse=true
                                    globalvalues.medicine=false
                                    globalvalues.summary=false
                                },
                                
                                label: {
                                    
                                    Image(systemName: "square.grid.2x2.fill")
                                        .font(.title2)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.611, green: 0.571, blue: 0.563)/*@END_MENU_TOKEN@*/)
                                }
                            )
                            Spacer(minLength:5)
                            
                            
                            
                            Text("Browse")
                                .font(.system(size: 10))
                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.611, green: 0.571, blue: 0.563)/*@END_MENU_TOKEN@*/)
                            
                        }
                        
                        Spacer()
                        
                        
                        
                    }
                    
                    
                    
                    Spacer(minLength:3)
                    
                }
                
            }
            .onAppear {
                loadMedications()
      
                

            }
            .onChange(of: condition) {
                
                print(condition)
                if condition {
                    print("done")
                    addMedication()
                    saveMedications()

                    self.condition = false
                }
            }
            
                //if
            }
        else if globalvalues.browse
            {
                //elseif
                
            ZStack{
                
                VStack(spacing:0){
                    //                Color(red: 0.968, green: 0.973, blue: 0.977)
                    //                    .ignoresSafeArea()
                    //                    .frame(height: 100)
                    
//                    LinearGradient(gradient: Gradient(colors: [/*@START_MENU_TOKEN@*/Color(red: 0.196, green: 0.676, blue: 0.899)/*@END_MENU_TOKEN@*/, Color(red: 0.949, green: 0.949, blue: 0.971)]), startPoint: .top, endPoint: .bottom)
//                        .ignoresSafeArea()
                    
                    //                            .frame(width: 200, height: 100)
                    
                    Color(red: 0.949, green: 0.949, blue: 0.971)
                        .ignoresSafeArea()
                    Color(red: 0.949, green: 0.949, blue: 0.971)
                        .ignoresSafeArea()
                    
                    /*@START_MENU_TOKEN@*/Color(red: 0.952, green: 0.957, blue: 0.953)/*@END_MENU_TOKEN@*/
                        .shadow(radius: 0.8)
                        .ignoresSafeArea()
                        .frame(height: 54)
                    
                }
                
                
              
                
                VStack{
                    
                    
                    Spacer(minLength: 39)
                    
                    HStack{
                        Spacer(minLength: 19)
                        
                        Text("Browse")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 231)
                        
                        Button(
                            
                            
                            action:{
                                globalvalues.isLoginViewActive = true
                            },
                            label:{
                                    ZStack{
                                        
                                        Image(systemName: "circle.fill")
                                        
                                            .font(.title)
                                            .foregroundColor(.white)
                                        
                                        
                                        Image(systemName: "person.crop.circle.fill")
                                            .font(.title)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.607, green: 0.632, blue: 0.679)/*@END_MENU_TOKEN@*/)
                                        
                                    }
                                    
                                    
                                }
                            
                        ).sheet(isPresented: $globalvalues.isLoginViewActive,  content: {Login()})
                        //                        .shadow(radius: 1)
                        
                        Spacer(minLength: 19)
                        
                        
                    }
                    
                    //                    Spacer(minLength: 636)
                    
                    ScrollView(){
                        
                        
                        
                        Button(action:{
                            globalvalues.isArchivesViewActive = true
                        }
                    ,
                               label: {
                            
                            
                            VStack{
                                
                                HStack(spacing:3){
                                    
                                    Image(systemName: "archivebox.fill")
                                        .renderingMode(.original)
                                        .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.green)
                                    
                                    Text("Archived Medicines")
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .padding(.leading)
                                    
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .fontWeight(.semibold)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.773, green: 0.773, blue: 0.781)/*@END_MENU_TOKEN@*/)
                                    
                                    
                                    
                                }
                                
                                
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(13)
                            .padding(.horizontal)
                            
                            
                        }

                        )
//                        .sheet(isPresented: $globalvalues.isArchivesViewActive,  content: {ArchivesView(archivedMedicines: $archivedMedicines)}
//                        )
                        
                        
                        
                        
                        
                        
                        
                    }.frame(height: 690)
                    
                    HStack{
                        
                        Spacer()
                        
                        VStack{
                            Spacer()
                            Button(
                                
                                action: {
                                    globalvalues.summary=true
                                    globalvalues.medicine=false
                                    globalvalues.browse=false
                                },
                                
                                label: {
                                    
                                    Image(systemName: "pills.fill")
                                        .font(.title2)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.611, green: 0.571, blue: 0.563)/*@END_MENU_TOKEN@*/)
                                }
                            )
                            
                            Spacer(minLength:5)
                            
                            Text("Summary")
                                .font(.system(size: 10))
                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.611, green: 0.571, blue: 0.563)/*@END_MENU_TOKEN@*/)
                            
                        }
                        
                        Spacer()
                        
                        VStack{
                            Spacer()
                            Button(
                                
                                action: {
                                    globalvalues.summary=false
                                    globalvalues.medicine=true
                                    globalvalues.browse=false
                                },
                                
                                label: {
                                    
                                    Image(systemName: "cross.fill")
                                        .font(.title2)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.611, green: 0.571, blue: 0.563)/*@END_MENU_TOKEN@*/)
                                }
                            )
                            
                            
                            Spacer(minLength:5)
                            
                            Text("Medications")
                                .font(.system(size: 10))
                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.611, green: 0.571, blue: 0.563)/*@END_MENU_TOKEN@*/)
                            
                        }
                        
                        Spacer()
                        
                        VStack{
                            Spacer()
                            Button(
                                
                                action: {
                                    globalvalues.browse=true
                                    globalvalues.medicine=false
                                    globalvalues.summary=false
                                },
                                
                                label: {
                                    
                                    Image(systemName: "square.grid.2x2.fill")
                                        .font(.title2)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.478, blue: 0.999)/*@END_MENU_TOKEN@*/)
                                }
                            )
                            Spacer(minLength:5)
                            
                            
                            
                            Text("Browse")
                                .font(.system(size: 10))
                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.478, blue: 0.999)/*@END_MENU_TOKEN@*/)
                            
                        }
                        
                        Spacer()
                        
                        
                        
                    }
                    
                    
                    
                    Spacer(minLength:3)
                    
                }
                
            }
            .onAppear {
                loadMedications()

            }
                //elseif
            }
            
            else{
                
                //else
                
                ZStack{
                    
                    VStack(spacing:0){
                        //                Color(red: 0.968, green: 0.973, blue: 0.977)
                        //                    .ignoresSafeArea()
                        //                    .frame(height: 100)
                        
                        LinearGradient(gradient: Gradient(colors: [/*@START_MENU_TOKEN@*/Color(red: 0.196, green: 0.676, blue: 0.899)/*@END_MENU_TOKEN@*/, Color(red: 0.949, green: 0.949, blue: 0.971)]), startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                    
                        //                            .frame(width: 200, height: 100)
                        
                        Color(red: 0.949, green: 0.949, blue: 0.971)
                            .ignoresSafeArea()
                        Color(red: 0.949, green: 0.949, blue: 0.971)
                            .ignoresSafeArea()
                        
                        /*@START_MENU_TOKEN@*/Color(red: 0.952, green: 0.957, blue: 0.953)/*@END_MENU_TOKEN@*/
                            .shadow(radius: 0.8)
                            .ignoresSafeArea()
                            .frame(height: 54)
                        
                    }
                    
                    
                  
                    
                    VStack{
                        
                        
                        Spacer(minLength: 39)
                        
                        HStack{
                            Spacer(minLength: 17)
                            
                            Text("Summary")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Spacer(minLength: 195)
                            
                            Button(
                                
                                
                                action:{
                                    globalvalues.isLoginViewActive = true
                                },
                                label:{
                                        ZStack{
                                            
                                            Image(systemName: "circle.fill")
                                            
                                                .font(.title)
                                                .foregroundColor(.white)
                                            
                                            
                                            Image(systemName: "person.crop.circle.fill")
                                                .font(.title)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.607, green: 0.632, blue: 0.679)/*@END_MENU_TOKEN@*/)
                                            
                                        }
                                        
                                        
                                    }
                                
                            ).sheet(isPresented: $globalvalues.isLoginViewActive,  content: {Login()})
                            //                        .shadow(radius: 1)
                            
                            Spacer(minLength: 19)
                            
                            
                        }
                        
                        //                    Spacer(minLength: 636)
                        
                        ScrollView(){
                            HStack{
                                Spacer(minLength: 19)
                                Text("Highlights")
                                    .font(.system(size: 24))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                
                                Spacer(minLength: 295)
                            }
                            
                            
                            VStack{
                                
                                HStack(spacing:3){
                                    
                                    Image(systemName: "pill.fill")
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.196, green: 0.676, blue: 0.899)/*@END_MENU_TOKEN@*/)
                                        .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                                    
                                    Text("Strength")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 0.196, green: 0.676, blue: 0.899))
                                        .font(.body)
                                    Spacer()
                                                                            
                                        Image(systemName: "chevron.right")
                                        
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 0.773, green: 0.773, blue: 0.781))
                                        
                                    
                                    
                                }
                                
                                
                                
                                HStack{
                                    //to reduce padding due to VStack
                                }
                                
                                HStack{
                                    
                                    if (globalvalues.DailyIntake >= 4000) {
                                        
                                        HStack{
                                            
                                            Image(systemName: "staroflife.fill")
                                                .foregroundColor(Color.red)
                                                .padding(.trailing)
                                                
                                            
                                            
                                            Text("You should try consulting a doctor as soon as possible")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                                .font(.body)
                                            
                                            Spacer()
                                            
                                        }
                                        
                                        
                                    }
                                    else if (globalvalues.DailyIntake >= 3000) {
                                        
                                        HStack{
                                            
                                            Image(systemName: "exclamationmark.triangle.fill")
                                                .foregroundColor(Color.red)
                                                .padding(.trailing)
                                                .font(.title2)
                                            
                                            
                                            Text("Daily Consumption must not exceed 4000 mg")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                                .font(.body)
                                            
                                            Spacer()
                                            
                                        }
                                     
                                       
                                        
                                    }
                                    else if (globalvalues.DailyIntake >= 2000) {
                                        
                                        HStack{
                                            
                                            Image(systemName: "exclamationmark.triangle")
                                                .foregroundColor(Color.red)
                                                .padding(.trailing)
                                                .font(.title2)
                                            
                                            
                                            Text("Your medicine intake is more than recommended")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                                .font(.body)
                                            
                                            Spacer()
                                            
                                        }
                                        
                            
                            
                                        
                                    }
                                   
                                
                                    
                                }
                                .padding(.vertical)
                                
                               
                                HStack{
                                    VStack{
                                        
                                        HStack(spacing:3){
                                            
                                            
                                            
                                            Image(systemName: "moonphase.full.moon.inverse")
                                                .font(.caption)
                                                .foregroundColor(Color(red: 0.196, green: 0.676, blue: 0.899))
                                            
                                            Text("Today")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color(red: 0.196, green: 0.676, blue: 0.899))
                                            
                                            Spacer()
                                            
                                        }
                                        .padding(.trailing)
                                        HStack{
                                            
                                            Text("\(globalvalues.DailyIntake)")
                                                .font(.largeTitle)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(red: 0.196, green: 0.676, blue: 0.899))
                                            Text("mg")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color(red: 0.196, green: 0.676, blue: 0.899))
                                                .padding(.top)
                                            Spacer()
                                        }
                                        .padding(.trailing)
                                    }
                                    
                                    VStack{
                                        HStack(spacing:3){
                                            
                                            Image(systemName: "moonphase.full.moon.inverse")
                                                .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.773, green: 0.773, blue: 0.781)/*@END_MENU_TOKEN@*/)
                                            
                                            Text("Average")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.773, green: 0.773, blue: 0.781)/*@END_MENU_TOKEN@*/)
                                            Spacer()
                                            
                                            
                                        }
                                        .padding(.leading)
                                        
                                        
                                        HStack{
                                            Text("\(globalvalues.AverageIntakeMonth)")
                                                .font(.largeTitle)
                                                .fontWeight(.bold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.773, green: 0.773, blue: 0.781)/*@END_MENU_TOKEN@*/)
                                            Text("mg")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.773, green: 0.773, blue: 0.781)/*@END_MENU_TOKEN@*/)
                                                .padding(.top)
                                            Spacer()
                                        }.padding(.leading)
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(13)
                            .padding(.horizontal)
                            
                            VStack{
                                
                                HStack(spacing:3){
                                    
                                    Image(systemName: "pill.fill")
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.196, green: 0.676, blue: 0.899)/*@END_MENU_TOKEN@*/)
                                        .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                                    
                                    Text("Missed")
                                        .fontWeight(.semibold)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.196, green: 0.676, blue: 0.899)/*@END_MENU_TOKEN@*/)
                                        .font(.body)
                                    Spacer()
                                                                            
                                        Image(systemName: "chevron.right")
                                        
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 0.773, green: 0.773, blue: 0.781))
                                        
                                    
                                    
                                }
                                
                                
                                
                                HStack{
                                    //to reduce padding due to VStack
                                }
                                
                                HStack{
                                    
                                   
                                }
                                .padding(.vertical)
                                
                               
                                HStack{
                                    VStack{
                                        
                                        HStack(spacing:3){
                                            
                                            
                                            
                                            Image(systemName: "moonphase.full.moon.inverse")
                                                .font(.caption)
                                                .foregroundColor(Color(red: 0.196, green: 0.676, blue: 0.899))
                                            
                                            Text("Today")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color(red: 0.196, green: 0.676, blue: 0.899))
                                            
                                            Spacer()
                                            
                                        }
                                        .padding(.trailing)
                                        HStack{
                                            
                                            Text("\(globalvalues.Missed)")
                                                .font(.largeTitle)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(red: 0.196, green: 0.676, blue: 0.899))
                                            Text("pills")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color(red: 0.196, green: 0.676, blue: 0.899))
                                                .padding(.top)
                                            Spacer()
                                        }
                                        .padding(.trailing)
                                    }
                                    
                                    VStack{
                                        HStack(spacing:3){
                                            
                                            Image(systemName: "moonphase.full.moon.inverse")
                                                .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.773, green: 0.773, blue: 0.781)/*@END_MENU_TOKEN@*/)
                                            
                                            Text("Average")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.773, green: 0.773, blue: 0.781)/*@END_MENU_TOKEN@*/)
                                            Spacer()
                                            
                                            
                                        }
                                        .padding(.leading)
                                        
                                        
                                        HStack{
                                            Text("\(globalvalues.AverageMissedMonth)")
                                                .font(.largeTitle)
                                                .fontWeight(.bold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.773, green: 0.773, blue: 0.781)/*@END_MENU_TOKEN@*/)
                                            Text("pills")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.773, green: 0.773, blue: 0.781)/*@END_MENU_TOKEN@*/)
                                                .padding(.top)
                                            Spacer()
                                        }.padding(.leading)
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(13)
                            .padding(.horizontal)
                            
                            
                            
                                
                                
                            Button(action:{
                                globalvalues.isHighlightsViewActive = true
                            }
                        , 
                                   label: {
                                
                                
                                VStack{
                                    
                                    HStack(spacing:3){
                                        
                                        Image(systemName: "sparkles")
                                            .renderingMode(.original)
                                            .font(.title3)
                                        
                                        Text("Show All Highlights")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 0.773, green: 0.773, blue: 0.781))
                                        
                                        
                                        
                                    }
                                    
                                    
                                }
                                .padding()
                                .background(.white)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            ).sheet(isPresented: $globalvalues.isHighlightsViewActive,  content: {HighlightsView()}
                            )
                            
                   
                        }.frame(height: 690)
                        
                        HStack{
                            
                            Spacer()
                            
                            VStack{
                                Spacer()
                                Button(
                                    
                                    action: {
                                        globalvalues.summary=true
                                        globalvalues.medicine=false
                                        globalvalues.browse=false
                                    },
                                    
                                    label: {
                                        
                                        Image(systemName: "pills.fill")
                                            .font(.title2)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.478, blue: 0.999)/*@END_MENU_TOKEN@*/)
                                    }
                                )
                                
                                Spacer(minLength:5)
                                
                                Text("Summary")
                                    .font(.system(size: 10))
                                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.478, blue: 0.999)/*@END_MENU_TOKEN@*/)
                                
                            }
                            
                            Spacer()
                            
                            VStack{
                                Spacer()
                                Button(
                                    
                                    action: {
                                        globalvalues.summary=false
                                        globalvalues.medicine=true
                                        globalvalues.browse=false
                                    },
                                    
                                    label: {
                                        
                                        Image(systemName: "cross.fill")
                                            .font(.title2)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.611, green: 0.571, blue: 0.563)/*@END_MENU_TOKEN@*/)
                                    }
                                )
                                
                                
                                Spacer(minLength:5)
                                
                                Text("Medications")
                                    .font(.system(size: 10))
                                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.611, green: 0.571, blue: 0.563)/*@END_MENU_TOKEN@*/)
                                
                            }
                            
                            Spacer()
                            
                            VStack{
                                Spacer()
                                Button(
                                    
                                    action: {
                                        globalvalues.browse=true
                                        globalvalues.medicine=false
                                        globalvalues.summary=false
                                    },
                                    
                                    label: {
                                        
                                        Image(systemName: "square.grid.2x2.fill")
                                            .font(.title2)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.611, green: 0.571, blue: 0.563)/*@END_MENU_TOKEN@*/)
                                    }
                                )
                                Spacer(minLength:5)
                                
                                
                                
                                Text("Browse")
                                    .font(.system(size: 10))
                                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.611, green: 0.571, blue: 0.563)/*@END_MENU_TOKEN@*/)
                                
                            }
                            
                            Spacer()
                            
                            
                            
                        }
                        
                        
                        
                        Spacer(minLength:3)
                        
                    }
                    
                }
                .onAppear {
                    self.requestNotificationAuthorization()
                    loadMedications()
          
                    transfer()
                    globalvalues.DailyIntake = calculateSum(of: medicationStrengths)
                }
                //else
            }
            
        }
        
    
    
//functions
    
    func transfer() {
        medicationStrengths = medications.map { $0.strength }
        print(medications.map { $0.strength })
    }

    
    @AppStorage("medications") private var storedMedications: Data = Data()

    

    func addMedication() {
        let newMedicine = Medicine(name: medicationName, type: medicationType, strength: medicationStrengthString ,frequency: medicationfreq.rawValue, time: time)
            medications.append(newMedicine)
        
        print("notisaved")
        print(time)
        
        sendremindNotification(title: " \(medicationName) ( \(medicationStrengthString) mg ) " , body: "Hey There, Don't miss your meds !!" , at: self.time)
        
            // Clear the text field after adding medication
            medicationName = ""
            medicationType = ""
            medicationfreq = .One
            time = Date()
            medicationStrengthString = ""
        }

    func saveMedications(){
        do {
            let encodedMedications = try JSONEncoder().encode(medications)
            storedMedications = encodedMedications
            print("medisaved")
            
        } catch {
            // Handle encoding error
            print("Error encoding medications: \(error.localizedDescription)")
        }
    }
    func loadMedications() {
        if !storedMedications.isEmpty {
            do {
                medications = try JSONDecoder().decode([Medicine].self, from: storedMedications)
            } catch {
                // Handle decoding error
                print("Error decoding medications: \(error.localizedDescription)")
            }
        }
    }    

    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting authorization for notifications: \(error.localizedDescription)")
            } else {
                if granted {
                    print("Notification authorization granted.")
                } else {
                    print("Notification authorization denied.")
                }
            }
        }
    }
    
    func sendremindNotification(title: String, body: String, at time: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: time)
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

                let request = UNNotificationRequest(identifier: "notificationDemo", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error sending notification: \(error.localizedDescription)")
            } else {
                print("Notification sent successfully!")
            }
        }
    }

    func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "notificationDemo", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error sending notification: \(error.localizedDescription)")
            } else {
                print("Notification sent successfully!")
                
            }
        }
    }

    
    func calculateSum(of strings: [String]) -> Int {
            var sum = 0
            for string in strings {
                if let intValue = Int(string) {
                    sum += intValue
                }
            }
            return sum
        }
    
    
    //functions
    
    
        }
    
    
struct HighlightsView : View{
    
    
    @ObservedObject var globalvalues = GlobalValues()
    
    
    var body: some View {
        
        ZStack{
            Color(red: 0.949, green: 0.949, blue: 0.971)
                .ignoresSafeArea()
            
            ScrollView{
                VStack{
                    HStack{
                        Spacer()
                        
                        Text("All Highlights")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                            .padding()
                        
                        Spacer()
                        
                        //                    ZStack{
                        //                        Image(systemName: "circle.fill")
                        //
                        //                            .font(.title)
                        //                            .foregroundColor(.white)
                        //
                        //
                        //                        Image(systemName: "person.crop.circle.fill")
                        //                            .font(.title)
                        //                            .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.607, green: 0.632, blue: 0.679)/*@END_MENU_TOKEN@*/)
                        //
                        //                    }
                        
                    }.padding()
                    Spacer(minLength: 320)
                    Text("That's all we can get at the moment")
                        .font(.title)
                        .fontWeight(.regular)
                    
                }
                
                
            }
        }
        
    }
}
    
    
struct AddMedicationView: View {
    
    @ObservedObject var globalvalues = GlobalValues()
   
    @Binding var medications: [Medicine]
   
    @Binding var medicationName: String
    
    @Binding var medicationType: String
    
    @Binding var medicationfreq : Frequen
    
    @Binding var time : Date
    
    @Binding var medicationStrengthString : String
    
    @Binding var condition : Bool
    
    @Binding var isPresented: Bool

    
    var body: some View {
        NavigationView{
            
            ZStack{
                
                
                
                
                
                
                
                Color(red: 1.0, green: 1.0, blue: 1.0)
                    .ignoresSafeArea()
                
                
                VStack{
                    Spacer(minLength: 200)
                    
                    Image("pills")
                        .resizable()
                        .frame(width: 75 ,height: 75)
                    
                    Spacer(minLength: 20)
                    
                    Text(
                        "Medication Name"
                    )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                    
                    
                    
                    Spacer(minLength: 20)
                    
                    TextField("Add medication name", text: $medicationName)
                                            .padding()
                                            .background(Color(.systemGray6))
                                            .cornerRadius(10)
                                            .padding(.horizontal)
                    
                    
                    
                    Spacer(minLength: 500)
                    
                    
                    if medicationName.isEmpty {
                        
                        NavigationLink(
                            
                            
                            destination: MedicationTypeView(medications: $medications, medicationName: $medicationName, medicationType: $medicationType, medicationfreq: $medicationfreq, time: $time, medicationStrengthString: $medicationStrengthString, condition: $condition, isPresented: $isPresented  ),
                            
                            label:{
                                
                                Button(
                                    
                                    action: {
                                        //none
                                    },
                                    label: {
                                        
                                        VStack{
                                            
                                            
                                            Text("Next")
                                                .frame(height: 50)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.733, green: 0.733, blue: 0.738)/*@END_MENU_TOKEN@*/)
                                                .fontWeight(.semibold)
                                            
                                            
                                            
                                            
                                            
                                        }
                                        .frame(width: 340)
                                        .background(Color(red: 0.937, green: 0.937, blue: 0.942))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                ).disabled(true)
                                
                                
                                
                            }
                            
                            
                        ).disabled(true)
                        
                    }
                    else  {
                        
                        NavigationLink(
                            
                            
                            destination: MedicationTypeView( medications: $medications, medicationName: $medicationName, medicationType: $medicationType, medicationfreq: $medicationfreq, time: $time, medicationStrengthString: $medicationStrengthString, condition: $condition, isPresented: $isPresented  ),
                        
                            label:{
                                
                                Button(
                                    
                                    action: {
                                    
                                        
                                    },
                                    label: {
                                        
                                        VStack{
                                            
                                            
                                            Text("Next")
                                                .frame(height: 50)
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                            
                                            
                                            
                                            
                                            
                                        }
                                        .frame(width: 340)
                                        .background(Color(red: -0.003, green: 0.478, blue: 0.999))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                ).disabled(true)
                                
                                
                                
                            }
                            
                            
                        )
                        .disabled(false)
                        
                    }
                    
                    Spacer(minLength: 200)
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
        }
            
            
        
        
        
        
        
    }
    
    
    

    
}
    

struct MedicationTypeView: View {
    
    @ObservedObject var globalvalues = GlobalValues()
   
    @Binding var medications: [Medicine]
   
    @Binding var medicationName: String
    
    @Binding var medicationType: String
    
    @Binding var medicationfreq : Frequen
    
    @Binding var time : Date
    
    @Binding var medicationStrengthString : String
    
    @Binding var condition : Bool
    
    @Binding var isPresented: Bool
    
    @State  var selectionCapsule: Bool = false
    @State  var selectionTablet: Bool = false
    @State  var selectionLiquid: Bool = false
    @State  var selectionTopical: Bool = false
    @State  var selectionCream: Bool = false
    @State  var selectionDevice: Bool = false
    @State  var selectionDrops: Bool = false
    @State  var selectionFoam: Bool = false
    @State  var selectionGel: Bool = false
    @State  var selectionInhaler: Bool = false
    @State  var selectionInjection: Bool = false
    @State  var selectionLotion: Bool = false
    @State  var selectionOintment: Bool = false
    @State  var selectionPatch: Bool = false
    @State  var selectionPowder: Bool = false
    @State  var selectionSpray: Bool = false
    @State  var selectionSuppository: Bool = false
    
    var body: some View {
        
        
        NavigationView{
            
            ZStack{
                
                
                
                
                
                
                
                Color(red: 1.0, green: 1.0, blue: 1.0)
                    .ignoresSafeArea()
                
          
                VStack{
                        
                        Spacer(minLength: 50)
                        
                    ScrollView(){
                        
                        Image("pills2")
                            .resizable()
                            .frame(width: 75 ,height: 75)
                        
                        Spacer(minLength: 15)
                        
                        Text(
                            "Choose the"
                        )
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        
                        Text(
                            "Medication Type"
                        )
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        
                        
//                        ScrollView{
                            
                            HStack{
                                
                                Text(
                                    "Common Forms"
                                )
                                .font(.title2)
                                .fontWeight(.bold)
                                
                                Spacer()
                            }.padding([.top, .leading])
                            
                            
                            Spacer(minLength: 20)
                            
                            Button(action:{
                                medicationType = "Capsule"
                                selectionCapsule = true
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                
                       
                                    
                                    HStack(){
                                        
                                        Text("Capsule")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionCapsule || medicationType == "Capsule" {
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                    
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            
                            Button(action:{
                                medicationType = "Tablet"
                                selectionCapsule = false
                                 selectionTablet = true
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                
                   
                                    
                                    HStack(){
                                        
                                        Text("Tablet")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionTablet || medicationType == "Tablet" {
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            Button(action:{
                                medicationType = "Liquid"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = true
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                
                                
                                    HStack(){
                                        
                                        Text("Liquid")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionLiquid || medicationType == "Liquid"{
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            Button(action:{
                                medicationType = "Topical"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = true
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                              
                                    
                                    HStack(){
                                        
                                        Text("Topical")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionTopical || medicationType == "Topical"{
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                    
                                
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            HStack{
                                
                                Text(
                                    "More Forms"
                                )
                                .font(.title2)
                                .fontWeight(.bold)
                                
                                Spacer()
                            }.padding([.top, .leading])
                            
                            
                            Spacer(minLength: 20)
                            
                            Button(action:{
                                medicationType = "Cream"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = true
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                
                          
                                    
                                    HStack(){
                                        
                                        Text("Cream")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionCream || medicationType == "Cream"{
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                    
                                    
                                
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            
                            Button(action:{
                                medicationType = "Device"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = true
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                
                      
                                    
                                    HStack(){
                                        
                                        Text("Device")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionDevice || medicationType == "Device" {
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                    
                                    
                                
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            
                            Button(action:{
                                medicationType = "Drops"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = true
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                
                          
                                    
                                    HStack(){
                                        
                                        Text("Drops")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionDrops || medicationType == "Drops"{
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                    
                                    
                                
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            
                            
                            Button(action:{
                                medicationType = "Foam"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = true
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                
                                    
                                    HStack(){
                                        
                                        Text("Foam")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionFoam || medicationType == "Foam"{
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                    
                                    
                                
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            Button(action:{
                                medicationType = "Gel"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = true
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                                                    HStack(){
                                        
                                        Text("Gel")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionGel || medicationType == "Gel"{
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                    
                                    
                                
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            Button(action:{
                                medicationType = "Inhaler"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = true
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                
                                
                                HStack(){
                                    
                                    Text("Inhaler")
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .padding(.leading)
                                    
                                    Spacer()
                                    if selectionInhaler || medicationType == "Inhaler"{
                                        Image(systemName: "checkmark")
                                            .fontWeight(.semibold)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                    }
                                    
                                }
                                
                                
                                
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                            }
                                
                            

                            )
                            
                            Button(action:{
                                medicationType = "Injection"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = true
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                
                                
                                
                                HStack(){
                                    
                                    Text("Injection")
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .padding(.leading)
                                    
                                    Spacer()
                                    if selectionInjection || medicationType == "Injection"{
                                        Image(systemName: "checkmark")
                                            .fontWeight(.semibold)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                    }
                                    
                                }
                                
                                
                                
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                            }
                                
                            

                            )
                            Button(action:{
                                medicationType = "Lotion"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = true
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                
                                VStack{
                                    
                                    HStack(){
                                        
                                        Text("Lotion")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionLotion || medicationType == "Lotion"{
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                    
                                    
                                }
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            Button(action:{
                                medicationType = "Ointment"
                                selectionCapsule = true
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = true
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                
                           
                                    
                                    HStack(){
                                        
                                        Text("Ointment")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionOintment || medicationType == "Ointment"{
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                    
                                    
                                
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            Button(action:{
                                medicationType = "Patch"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = true
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                         
                                    HStack(){
                                        
                                        Text("Patch")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionPatch || medicationType == "Patch"{
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                    
                                    
                                
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            
                            Button(action:{
                                medicationType = "Powder"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = true
                                 selectionSpray = false
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                        
                                    HStack(){
                                        
                                        Text("Powder")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionPowder || medicationType == "Powder"{
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    
                                    
                                    
                                }
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            Button(action:{
                                medicationType = "Spray"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = true
                                 selectionSuppository = false
                                
                            }
                        ,
                                   label: {
                                
                                
                              
                                    
                                    HStack(){
                                        
                                        Text("Spray")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionSpray || medicationType == "Spray"{
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    }
                                    
                                    
                                
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            Button(action:{
                                medicationType = "Suppository"
                                selectionCapsule = false
                                 selectionTablet = false
                                 selectionLiquid = false
                                 selectionTopical = false
                                 selectionCream = false
                                 selectionDevice = false
                                 selectionDrops = false
                                 selectionFoam = false
                                 selectionGel = false
                                 selectionInhaler = false
                                 selectionInjection = false
                                 selectionLotion = false
                                 selectionOintment = false
                                 selectionPatch = false
                                 selectionPowder = false
                                 selectionSpray = false
                                 selectionSuppository = true
                                
                            }
                        ,
                                   label: {
                                
                                
                            
                                    
                                    HStack(){
                                        
                                        Text("Suppository")
                                            .fontWeight(.regular)
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        if selectionSuppository || medicationType == "Suppository"{
                                            Image(systemName: "checkmark")
                                                .fontWeight(.semibold)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: -0.003, green: 0.462, blue: 0.97)/*@END_MENU_TOKEN@*/)
                                        }
                                        
                                    
                                    
                                    
                                }
                                .padding()
                                .background(/*@START_MENU_TOKEN@*/Color(red: 0.949, green: 0.949, blue: 0.971)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(13)
                                .padding(.horizontal)
                                
                                
                            }

                            )
                            
                           
                           
                            
                            
                        }.frame(height: 690)
                        
                    
                    
                    Spacer(minLength: 20)
                    
                    
                    if medicationType.isEmpty {
                        
                        NavigationLink(
                            
                            
                            destination: MedicationTypeView(medications: $medications, medicationName: $medicationName, medicationType: $medicationType, medicationfreq: $medicationfreq, time: $time, medicationStrengthString: $medicationStrengthString, condition: $condition, isPresented: $isPresented  ),
                            
                            label:{
                                
                                Button(
                                    
                                    action: {
                                        //none
                                    },
                                    label: {
                                        
                                        VStack{
                                            
                                            
                                            Text("Next")
                                                .frame(height: 50)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.733, green: 0.733, blue: 0.738)/*@END_MENU_TOKEN@*/)
                                                .fontWeight(.semibold)
                                            
                                            
                                            
                                            
                                            
                                        }
                                        .frame(width: 340)
                                        .background(Color(red: 0.937, green: 0.937, blue: 0.942))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                ).disabled(true)
                                
                                
                                
                            }
                            
                            
                        ).disabled(true)
                        
                    }
                    else  {
                        
                        NavigationLink(
                            
                            
                            destination: MedicationStrengthView(medications: $medications, medicationName: $medicationName, medicationType: $medicationType, medicationfreq: $medicationfreq, time: $time, medicationStrengthString: $medicationStrengthString, condition: $condition, isPresented: $isPresented  ),
                            
                            label:{
                                
                                Button(
                                    
                                    action: {
                                        
                                        
                                    },
                                    label: {
                                        
                                        VStack{
                                            
                                            
                                            Text("Next")
                                                .frame(height: 50)
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                            
                                            
                                            
                                            
                                            
                                        }
                                        .frame(width: 340)
                                        .background(Color(red: -0.003, green: 0.478, blue: 0.999))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                ).disabled(true)
                                
                                
                                
                            }
                            
                            
                        ).disabled(false)
                        
                    }
                    
                    Spacer(minLength: 74)
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
        }.navigationBarBackButtonHidden()
        
        
    }
}


struct MedicationStrengthView: View {
    
    @ObservedObject var globalvalues = GlobalValues()
   
    @Binding var medications: [Medicine]
   
    @Binding var medicationName: String
    
    @Binding var medicationType: String
    
    @Binding var medicationfreq : Frequen
    
    @Binding var time : Date
    
    @Binding var medicationStrengthString : String
    
    @Binding var condition : Bool
    
    @Binding var isPresented: Bool
    
    
    var medicationStrength: Int {
        return Int(medicationStrengthString) ?? 0
        
    }
    
    
    
    
    
   
    
    var body: some View {
        
        
        NavigationView{
            
            ZStack{
                
                
                
                
                Color(red: 1.0, green: 1.0, blue: 1.0)
                    .ignoresSafeArea()
                
                
                VStack{
                    Spacer(minLength: 200)
                    
                    Image("pills3")
                        .resizable()
                        .frame(width: 75 ,height: 75)
                    
                    Spacer(minLength: 20)
                    
                    Text(
                        "Add the Medication"
                    )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                    Text(
                        "Strength"
                    )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                    
                    
                    
                    Spacer(minLength: 20)
                    
                    ZStack{
                        
                        TextField("Add Strength"
                                  , text: $medicationStrengthString)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .keyboardType(.numberPad)
                        HStack{
                            Spacer(minLength: 370)
                            if medicationStrength == 0
                            {
                                Text("mg")
                                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.741, green: 0.741, blue: 0.758)/*@END_MENU_TOKEN@*/)
                                
                            }
                            else{
                                Text("mg")
                                    .foregroundColor(Color(red: -0.002, green: 0.518, blue: 0.927))
                                
                            }
                            
                            Spacer()
                            
                        }
                        
                    }
                    
                    Spacer(minLength: 500)
                    
                    
                    if medicationStrength == 0 {
                        
                        NavigationLink(
                            
                            
                            destination: CalenderView(medications: $medications, medicationName: $medicationName, medicationType: $medicationType, medicationfreq: $medicationfreq, time: $time, medicationStrengthString: $medicationStrengthString, condition: $condition, isPresented: $isPresented  ),
                            
                            label:{
                                
                                Button(
                                    
                                    action: {
                                        //none
                                    },
                                    label: {
                                        
                                        VStack{
                                            
                                            
                                            Text("Next")
                                                .frame(height: 50)
                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.733, green: 0.733, blue: 0.738)/*@END_MENU_TOKEN@*/)
                                                .fontWeight(.semibold)
                                            
                                            
                                            
                                            
                                            
                                        }
                                        .frame(width: 340)
                                        .background(Color(red: 0.937, green: 0.937, blue: 0.942))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                ).disabled(true)
                                
                                
                                
                            }
                            
                            
                        ).disabled(true)
                        
                    }
                    else  {
                        
                        NavigationLink(
                            
                            
                            destination:CalenderView(medications: $medications, medicationName: $medicationName, medicationType: $medicationType, medicationfreq: $medicationfreq, time: $time, medicationStrengthString: $medicationStrengthString, condition: $condition, isPresented: $isPresented  ),
                            
                            label:{
                                
                                Button(
                                    
                                    action: {
                                        
                                        
                                    },
                                    label: {
                                        
                                        VStack{
                                            
                                            
                                            Text("Next")
                                                .frame(height: 50)
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                            
                                            
                                            
                                            
                                            
                                        }
                                        .frame(width: 340)
                                        .background(Color(red: -0.003, green: 0.478, blue: 0.999))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                ).disabled(true)
                                
                                
                                
                            }
                            
                            
                        ).disabled(false)
                        
                    }
                    
                    Spacer(minLength: 200)
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
            
        }.navigationBarBackButtonHidden()
        
        }
        
        
        
    }



enum Frequen: String, CaseIterable, Identifiable{
    case One , Two , Three , Four , Five , Six , Seven
    var id: Self { self }
}

struct CalenderView: View {
    
    @ObservedObject var globalvalues = GlobalValues()
//
    @Binding var medications: [Medicine]
   
    @Binding var medicationName: String
    
    @Binding var medicationType: String
    
    @Binding var medicationfreq : Frequen
    
    @Binding var time : Date
    
    @Binding var medicationStrengthString : String
    
    @Binding var condition : Bool
    
    @Binding var isPresented: Bool
    
    private var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: time)
    }


    
    var body: some View {
        
        
        NavigationView{
            
            ZStack{
                
                
                                
                Color(red: 1.0, green: 1.0, blue: 1.0)
                    .ignoresSafeArea()
                
                
                VStack{
                    Spacer(minLength: 200)
                    
                    Image("pills4")
                        .resizable()
                        .frame(width: 75 ,height: 75)
                    
                    Spacer(minLength: 20)
                    
                    Text(
                        "When will you"
                    )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                    Text(
                        "take this?"
                    )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                    
                    ZStack{
                    
                    Button(
                        
                        action: {
                            //none
                        },
                        label: {
                            
                            HStack{
                                Spacer()
                                Text(
                                    "Frequency of Days"
                                )
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(Color.black)
                                
                                Spacer(minLength: 190)
                               
                                
                            }
                            
                            .frame(width: 390,height: 50)
                            .background(Color(red: 0.937, green: 0.937, blue: 0.942))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            
                            
                        }
                            
                            
                        
                    ).disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)

                        HStack{
                            Spacer(minLength: 320)
                            Picker("Frequency", selection: $medicationfreq) {
                                ForEach(Frequen.allCases, id: \.self) { freq in
                                    Text(freq.rawValue).tag(freq)
                                }
                            }
                            .frame(width: 120)
                            Spacer()
                        }
                        .padding(.trailing)
                    
                    }
                    
                    
                    
                    Spacer(minLength: 20)
                    
                    VStack{
                        HStack{
                            Spacer()
                            
                            Text("When you schedule a time, Health will send you a")
                                .font(.callout)
                                .foregroundColor(Color(red: 0.588, green: 0.588, blue: 0.605))
                            
                            Spacer(minLength: 60)
                            
                            
                        }.padding(.leading)
                        
                        
                            HStack{
                                
                                Spacer()
                                
                                Text("notification to take your medications")
                                    .font(.callout)
                                    .foregroundColor(Color(red: 0.588, green: 0.588, blue: 0.605))
                                
                                
                                Spacer(minLength: 120)
                            }
                            .padding(.leading)
                        
                    }
                    
                    
                    
                    HStack{
                        Spacer()
                        
                        Text(
                            "Time"
                        )
                        .font(.title3)
                        .fontWeight(.bold)
                        
                        Spacer(minLength: 350)
                    }.padding([.top, .leading])
                    
    DatePicker("Pick a time", selection: $time, displayedComponents: .hourAndMinute)
        .datePickerStyle(WheelDatePickerStyle())
        .labelsHidden()
        .padding()
                                
                            
//    Text("\(formattedTime)")
//                        .padding()
                    
                    
                    
                    
                    Spacer(minLength: 90)
                    
                    
                   
                        NavigationLink(
                            
                            
                            destination: Review(medications: $medications, medicationName: $medicationName, medicationType: $medicationType, medicationfreq: $medicationfreq, time: $time, medicationStrengthString: $medicationStrengthString, condition: $condition, isPresented: $isPresented),
                            
                            label:{
                                
                                Button(
                                    
                                    action: {
                                        
                                        
                                    },
                                    label: {
                                        
                                        VStack{
                                            
                                            
                                            Text("Next")
                                                .frame(height: 50)
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                            
                                            
                                            
                                            
                                            
                                        }
                                        .frame(width: 340)
                                        .background(Color(red: -0.003, green: 0.478, blue: 0.999))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                ).disabled(true)
                                
                                
                                
                            }
                            
                            
                        ).disabled(false)
                        
//                    Button(
//                        action:{
//                            print(formattedTime)
//                            print(time)
//                        },
//                        label:{
//                            Text("print time")
//                        }
//                    )
                    
                    
                    Spacer(minLength: 200)
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
        }.navigationBarBackButtonHidden()
       
        
    }
}


struct Review: View {
    
    @ObservedObject var globalvalues = GlobalValues()
    
    @Binding var medications: [Medicine]
   
    @Binding var medicationName: String
    
    @Binding var medicationType: String
    
    @Binding var medicationfreq : Frequen
    
    @Binding var time : Date
    
    @Binding var medicationStrengthString : String
    
    @Binding var condition : Bool
    
    @Binding var isPresented: Bool
    
//    let dateFormatter: DateFormatter = {
//            let formatter = DateFormatter()
//            formatter.dateStyle = .medium
//            formatter.timeStyle = .short
//            return formatter
//        }()
    
    let timeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm:ss a"
            return formatter
        }()
    
    var body: some View {
        
            
        NavigationView{
            
            ZStack{
                
                
                                
                Color(red: 1.0, green: 1.0, blue: 1.0)
                    .ignoresSafeArea()
                
                
                VStack{
                    Spacer(minLength: 300)
                    
                    
                    if medicationName == "Capsule" {
                        
                        
                        Image("capsule")
                            .resizable()
                            .frame(width: 95 ,height: 100)
                            .cornerRadius(10)
                            
                            
                    }
            else if medicationName == "Tablet" {
                
                
                Image("tablet")
                    .resizable()
                    .frame(width: 95 ,height: 100)
                    .cornerRadius(10)
                    
                    
            }
            else if medicationName == "Liquid" {
                
                
                Image("liquid")
                    .resizable()
                    .frame(width: 95 ,height: 100)
                    .cornerRadius(10)
                    
                    
            }
            else if medicationName == "Topical" {
                
                
                Image("topical")
                    .resizable()
                    .frame(width: 95 ,height: 100)
                    .cornerRadius(10)
                    
                    
            }
            else {
                
                
                Image("tablet")
                    .resizable()
                    .frame(width: 95 ,height: 100)
                    .cornerRadius(10)
                    
                    
            }
                    
                    
                    Spacer(minLength: 20)
                    
                    Text(
                        medicationName
                    )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                    Text(
                        medicationType
                    )
                    .font(.title3)
                    .fontWeight(.regular)
                    
                    HStack{
               
                        
                        Text(
                            "Schedule"
                        )
                        .font(.title3)
                        .fontWeight(.bold)
                        
                        Spacer()
                    }.padding([.top, .leading])
                    
                    
               
                      
                            
                            HStack{
                                if medicationfreq.rawValue == "One"
                                {
                                    Text("Every day")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.black)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                else {
                                    Text("Every \(medicationfreq.rawValue) days")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.black)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                
                            }
                            .frame(width: 390,height: 50)
                            .background(Color(red: 0.937, green: 0.937, blue: 0.942))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            
                    HStack{
                       
                        Text("\(timeFormatter.string(from: time))")
                        
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                        .padding(.leading)
                        
                        Spacer()
                       
                        
                    }
                    .frame(width: 390,height: 50)
                    .background(Color(red: 0.937, green: 0.937, blue: 0.942))
                    .cornerRadius(10)
                    .padding(.horizontal)
                            
                        
                            
                            
                        
                    Spacer(minLength: 300)
                    
                    Button(
                        
                        action: {
                            
                            isPresented = false
                            self.condition = true
                            
                            
                            
                            
                            print("processing")
                            print(condition)
                            
                            
                        }, label: {
                            VStack{
                                
                                
                                Text("Done")
                                    .frame(height: 50)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                
                                
                                
                                
                                
                            }
                            .frame(width: 340)
                            .background(Color(red: -0.003, green: 0.478, blue: 0.999))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                        
                        
                        
                        
                        
                    )
                    
                    
                    
                    
                    
                    
                    Spacer(minLength: 250)
                    

                        
                    
                    }
                    
                    
                    
                
                    
                    
                    
                    
                }
                
                
                
                
                
                
          
            
        }.navigationBarBackButtonHidden()
        
        
    
                           }
    
    

    
    
}


struct MediView: View {
    
    @ObservedObject var globalvalues = GlobalValues()
    
    @Binding var medications: [Medicine]
   
    @Binding var medicationName: String
    
    @Binding var medicationType: String
    
    @Binding var medicationfreq : Frequen
    
    @Binding var time : Date
    
    @Binding var medicationStrengthString : String
    
    @Binding var condition : Bool
    
    @Binding var isPresented: Bool
    
//    let dateFormatter: DateFormatter = {
//            let formatter = DateFormatter()
//            formatter.dateStyle = .medium
//            formatter.timeStyle = .short
//            return formatter
//        }()
    
    let timeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm:ss a"
            return formatter
        }()
    
    var body: some View {
        
            
        NavigationView{
            
            ZStack{
                
                
                                
                Color(red: 1.0, green: 1.0, blue: 1.0)
                    .ignoresSafeArea()
                
                
                VStack{
                    Spacer(minLength: 300)
                    
                    
                    if medicationName == "Capsule" {
                        
                        
                        Image("capsule")
                            .resizable()
                            .frame(width: 95 ,height: 100)
                            .cornerRadius(10)
                            
                            
                    }
            else if medicationName == "Tablet" {
                
                
                Image("tablet")
                    .resizable()
                    .frame(width: 95 ,height: 100)
                    .cornerRadius(10)
                    
                    
            }
            else if medicationName == "Liquid" {
                
                
                Image("liquid")
                    .resizable()
                    .frame(width: 95 ,height: 100)
                    .cornerRadius(10)
                    
                    
            }
            else if medicationName == "Topical" {
                
                
                Image("topical")
                    .resizable()
                    .frame(width: 95 ,height: 100)
                    .cornerRadius(10)
                    
                    
            }
            else {
                
                
                Image("none")
                    .resizable()
                    .frame(width: 95 ,height: 100)
                    .cornerRadius(10)
                    
                    
            }
                    
                    
                    Spacer(minLength: 20)
                    
                    Text(
                        medicationName
                    )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                    Text(
                        medicationType
                    )
                    .font(.title3)
                    .fontWeight(.regular)
                    
                    HStack{
               
                        
                        Text(
                            "Schedule"
                        )
                        .font(.title3)
                        .fontWeight(.bold)
                        
                        Spacer()
                    }.padding([.top, .leading])
                    
                    
               
                      
                            
                            HStack{
                                if medicationfreq.rawValue == "One"
                                {
                                    Text("Every day")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.black)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                else {
                                    Text("Every \(medicationfreq.rawValue) days")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.black)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                
                            }
                            .frame(width: 390,height: 50)
                            .background(Color(red: 0.937, green: 0.937, blue: 0.942))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            
                    HStack{
                       
                        Text("\(timeFormatter.string(from: time))")
                        
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                        .padding(.leading)
                        
                        Spacer()
                       
                        
                    }
                    .frame(width: 390,height: 50)
                    .background(Color(red: 0.937, green: 0.937, blue: 0.942))
                    .cornerRadius(10)
                    .padding(.horizontal)
                            
                        
                            
                            
                        
                    Spacer(minLength: 300)
                    
                    Button(
                        
                        action: {
                            
                            isPresented = false
                            
                            
                            
                        }, label: {
                            VStack{
                                
                                
                                Text("Archive")
                                    .frame(height: 50)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                
                                
                                
                                
                                
                            }
                            .frame(width: 340)
                            .background(.green)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                        
                        
                        
                        
                        
                    )
                    
                    
                    
                    
                    
                    
                    Spacer(minLength: 250)
                    

                        
                    
                    }
                    
                    
                    
                
                    
                    
                    
                    
                }
                
                
                
                
                
                
          
            
        }.navigationBarBackButtonHidden()
        
        
    
                           }
    
    

    
    
}


struct ArchivesView: View{
    
//    @Binding var archivedMedicines: [Medicine]
    
    
    var body: some View {
        NavigationView{
            
         
            
//            List {ForEach(archivedMedicines, id: \.self) { medication in
//                Button(
//                    action:{
//                        print("pressed")
//                    },
//                    
//                    label:{
//                        HStack(spacing: 15){
//                            
//                            if medication.type == "Capsule" {
//                                
//                                
//                                Image("capsule")
//                                    .resizable()
//                                    .frame(width: 95 ,height: 100)
//                                    .cornerRadius(10)
//                                
//                                
//                            }
//                            else if medication.type == "Tablet" {
//                                
//                                
//                                Image("tablet")
//                                    .resizable()
//                                    .frame(width: 95 ,height: 100)
//                                    .cornerRadius(10)
//                                
//                                
//                            }
//                            else if medication.type == "Liquid" {
//                                
//                                
//                                Image("liquid")
//                                    .resizable()
//                                    .frame(width: 95 ,height: 100)
//                                    .cornerRadius(10)
//                                
//                                
//                            }
//                            else if medication.type == "Topical" {
//                                
//                                
//                                Image("topical")
//                                    .resizable()
//                                    .frame(width: 95 ,height: 100)
//                                    .cornerRadius(10)
//                                
//                                
//                            }
//                            else {
//                                
//                                
//                                Image("none")
//                                    .resizable()
//                                    .frame(width: 95 ,height: 100)
//                                    .cornerRadius(10)
//                                
//                                
//                            }
//                            
//                            
//                            VStack{
//                                HStack{
//                                    Text(medication.name)
//                                        .font(.title3)
//                                        .fontWeight(.bold)
//                                        .foregroundColor(.black)
//                                    Spacer()
//                                }
//                                
//                                HStack{
//                                    Text(medication.type)
//                                        .font(.subheadline)
//                                        .foregroundColor(.black)
//                                    Spacer()
//                                }
//                                HStack{
//                                    Text("\(medication.strength) mg")
//                                        .font(.subheadline)
//                                        .foregroundColor(.black)
//                                    Spacer()
//                                }
//                                HStack(spacing: 0){
//                                    
//                                    Image(systemName: "calendar")
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(Color(red: 0.773, green: 0.773, blue: 0.781))
//                                    
//                                    if medication.frequency == "One"
//                                    {
//                                        Text("Every day")
//                                            .font(.body)
//                                            .fontWeight(.regular)
//                                            .foregroundColor(Color.black)
//                                            .padding(.leading)
//                                        
//                                        
//                                    }
//                                    else {
//                                        Text("Every \(medication.frequency) days")
//                                            .font(.body)
//                                            .fontWeight(.regular)
//                                            .foregroundColor(Color.black)
//                                            .padding(.leading)
//                                        
//                                        
//                                    }
//                                    
//                                    Spacer()
//                                }
//                                
//                            }
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                            
//                                .fontWeight(.semibold)
//                                .foregroundColor(Color(red: 0.773, green: 0.773, blue: 0.781))
//                        }.frame(height: 100)
//                        //
//                    }
//                )
//                
//            }
//            .swipeActions(edge: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/, allowsFullSwipe: /*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/) {
//                //
//                Button(role: .destructive) {
//                    // Archive action
//                    // Handle archiving the medication here
//                } label: {
//                    Label("Delete", systemImage: "archivebox.fill")
//                        .foregroundColor(.green)
//                }
//            }
//            }.frame(minHeight: 600)
            
            
            
        }
        
        
        
        
    }
    
}
    

     
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
