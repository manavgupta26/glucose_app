//
//  recipie.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 1/19/25.
//

struct Recipe {
    let title: String
    let description: String
    let ingredients: [String]
    let steps: [String]
    let imageName: String
}

// Dataset
let recipeData: [Recipe] = [
    Recipe(
        title: "Avocado Toast",
        description: "A healthy and delicious breakfast option.",
        ingredients: [
            "2 slices of bread",
            "1 ripe avocado",
            "Salt and pepper to taste",
            "Chili flakes (optional)",
            "Lemon juice (optional)"
        ],
        steps: [
            "Toast the bread until golden brown.",
            "Mash the avocado in a bowl.",
            "Spread the mashed avocado on the toasted bread.",
            "Add salt, pepper, and chili flakes to taste.",
            "Drizzle with lemon juice if desired."
        ],
        imageName: "avocado_toast"
    ),
    Recipe(
        title: "Berry Smoothie",
        description: "A refreshing drink packed with antioxidants.",
        ingredients: [
            "1 cup frozen mixed berries",
            "1 banana",
            "1/2 cup almond milk",
            "1 tbsp honey (optional)"
        ],
        steps: [
            "Combine all ingredients in a blender.",
            "Blend until smooth.",
            "Pour into a glass and enjoy."
        ],
        imageName: "berry_smoothie"
    )
]
