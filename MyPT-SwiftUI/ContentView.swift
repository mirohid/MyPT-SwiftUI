import SwiftUI

struct ContentView: View {
    struct Exercise: Identifiable {
        let id = UUID()
        let imageName: String
        let title: String
        let description: String
    }
    
    @State private var expandedIndex: UUID? = nil
    @State private var selectedExercise: Exercise? = nil
    @State private var showSheet = false
    
    let exercises = [
        Exercise(imageName: "image", title: "Lat Pull Down", description: "A great exercise for upper back."),
        Exercise(imageName: "image", title: "Seated Row", description: "Helps build strong back muscles."),
        Exercise(imageName: "image", title: "Biceps Curl", description: "Targets the biceps effectively."),
        Exercise(imageName: "image", title: "Close Grip Lat Pull Down", description: "Focuses on lower lats."),
        
        Exercise(imageName: "image", title: "Lat Pull Down", description: "A great exercise for upper back."),
        Exercise(imageName: "image", title: "Seated Row", description: "Helps build strong back muscles."),
        Exercise(imageName: "image", title: "Biceps Curl", description: "Targets the biceps effectively."),
        Exercise(imageName: "image", title: "Close Grip Lat Pull Down", description: "Focuses on lower lats.")
    ]
    
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            
            VStack {
                // Rectangle Header
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 240)
                        .ignoresSafeArea()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Image(systemName: "chevron.backward")
                            .font(.title2)
                            .foregroundStyle(.black)
                            .bold()
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Back and Biceps!")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            HStack {
                                Text("Each Exercise:")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                
                                Text("3 sets")
                                Text("30 reps")
                            }
                            HStack {
                                Text("Rest Time:")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                
                                Text("3 mins/set")
                                Text("30 reps")
                            }
                        }
                    }
                    .padding(.leading, 20)
                 //   .padding(.top, 20)
                }
                
                // List Section with Expandable Rows
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(exercises) { exercise in
                            VStack {
                                HStack {
                                    // Left Image
                                    Image(exercise.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    // Center Text
                                    VStack(alignment: .leading) {
                                        Text(exercise.title)
                                            .font(.title3)
                                            .fontWeight(.medium)
                                        
                                        // Show Description only if expanded
                                        if expandedIndex == exercise.id {
                                            Text(exercise.description)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                                .padding(.top, 5)
                                                .transition(.opacity) // Smooth appearance
                                              
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    // Right Button
                                    Button(action: {
                                        withAnimation {
                                            expandedIndex = expandedIndex == exercise.id ? nil : exercise.id
                                        }
                                    }) {
                                        Image("Frame") // Assuming this is your down arrow image
                                            .rotationEffect(expandedIndex == exercise.id ? .degrees(180) : .degrees(0)) // Rotate when expanded
                                            .animation(.easeInOut, value: expandedIndex)
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                .onTapGesture {
                                    selectedExercise = exercise
                                    showSheet.toggle()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
            }
            
            
            
        }
        .sheet(isPresented: $showSheet) {
            if let exercise = selectedExercise {
                ExerciseDetailView(exercise: exercise)
            }
           
        }
        
        
        Button {
            //
        } label: {
            Text("Get Started")
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .frame(width: 350)
                .background(Color(red: 175/255, green: 237/255, blue: 87/255))
            .cornerRadius(25)        }
    }
}

// Sheet View
struct ExerciseDetailView: View {
    let exercise: ContentView.Exercise
    
    var body: some View {
        VStack(spacing: 20) {
            Image(exercise.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(exercise.title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(exercise.description)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
