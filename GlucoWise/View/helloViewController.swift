import SwiftUI

struct FoodDetailsView: View {
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Button(action: {
                    // Back action
                }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                }
                Spacer()
                Text("Aloo Paratha")
                    .font(.headline)
                Spacer()
                Button(action: {
                    // Done action
                }) {
                    Text("Done")
                        .foregroundColor(.blue)
                }
            }
            .padding()

            // Image
            Image("aalo") // Replace with your actual image name
                .resizable()
                .scaledToFill()
                .frame(height: 170)
                .frame(width: 370)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal,16)

            // Quantity and Measure
            HStack {
                // Quantity Dropdown
                VStack(alignment: .leading) {
                    Text("Quantity")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Menu {
                        ForEach(1...10, id: \.self) { quantity in
                            Button(action: {
                                // Action when a quantity is selected
                                print("Selected Quantity: \(quantity)")
                            }) {
                                Text("\(quantity)")
                            }
                        }
                    } label: {
                        HStack {
                            Text("2.0") // Replace with a @State variable to track selected value
                                .frame(width: 80, alignment: .leading)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                }
                
                Spacer()
                
                // Measure Dropdown
                VStack(alignment: .leading) {
                    Text("Measure")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Menu {
                        let measures = ["Piece", "Gram", "Ounce", "Cup"]
                        ForEach(measures, id: \.self) { measure in
                            Button(action: {
                                // Action when a measure is selected
                                print("Selected Measure: \(measure)")
                            }) {
                                Text(measure)
                            }
                        }
                    } label: {
                        HStack {
                            Text("Piece") // Replace with a @State variable to track selected value
                                .frame(width: 80, alignment: .leading)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal)


            // GI Index
            VStack(alignment: .leading, spacing: 8) {
                Text("GI Index")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    
                HStack {
                    // GI Circle
                    Text("GI")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(hex: "#6CAB9C"))
                        .clipShape(Circle())
                    
                    // GI Value and Text
                    VStack(alignment: .leading) {
                        Text("80")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Glycemic Index")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer() // Ensures proper spacing between the GI text and description
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                
                // Description Text
                Text("It will take 40 minutes of running to burn 400 calories. Your meal has high carbs. Add more fibre or protein in your next meal to help stabilize blood sugar.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .lineLimit(3)
            }
            .padding(.horizontal)


            // Macronutrient Breakdown
            VStack(alignment: .leading, spacing: 8) {
                Text("Macronutrient Breakdown")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                VStack {
                    HStack {
                        Text("Carbs")
                        Spacer()
                        Text("73 g")
                    }
                    Divider()
                    HStack {
                        Text("Protein")
                        Spacer()
                        Text("19 g")
                    }
                    Divider()
                    HStack {
                        Text("Fats")
                        Spacer()
                        Text("21 g")
                    }
                    Divider()
                    HStack {
                        Text("Fiber")
                        Spacer()
                        Text("9 g")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationBarHidden(true)
        .background(Color(.systemGray5).edgesIgnoringSafeArea(.all))
    }
}

struct FoodDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailsView()
    }
}
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(
            .sRGB,
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0,
            opacity: 1.0
        )
    }
}
