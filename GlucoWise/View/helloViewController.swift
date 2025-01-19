import SwiftUI

struct AlooParathaView: View {
    @State private var quantity: Double = 2.0
    @State private var measure: String = "Piece"
    @State private var giIndex: Int = 80

    var body: some View {
        VStack {
            HStack {
                Button(action: {}) {
                    Text("Back")
                }
                Spacer()
                Button(action: {}) {
                    Text("Done")
                }
            }
            Spacer()

            VStack {
                Image("aloo_paratha") // Replace with your image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)

                HStack {
                    Text("Quantity")
                    TextField("", value: $quantity, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .frame(width: 50)
                    Picker("Measure", selection: $measure) {
                        ForEach(["Piece", "Serving", "Portion"], id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }

                VStack {
                    Text("GI Index")
                    Text("\(giIndex)")
                        .font(.headline)
                }
                // Optional: Add a progress view for GI Index

                Text("It will take 40 minutes of running to burn 400 calories. Your meal has high carbs. Add more fibre or protein in your next meal to help stabilize blood sugar.")
                    .multilineTextAlignment(.center)

                VStack {
                    Text("Macronutrient Breakdown")
                    HStack {
                        Text("Carbs")
                        Spacer()
                        Text("73 g")
                    }
                    HStack {
                        Text("Protein")
                        Spacer()
                        Text("19 g")
                    }
                    HStack {
                        Text("Fats")
                        Spacer()
                        Text("21 g")
                    }
                    HStack {
                        Text("Fiber")
                        Spacer()
                        Text("9 g")
                    }
                }
            }
        }
        .padding()
    }
}
