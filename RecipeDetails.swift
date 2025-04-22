
import Foundation
struct RecipeInfo: Codable {
    let readyInMinutes: Int?
    let servings: Int?
    let analyzedInstructions: [Instruction]?
}

struct Instruction: Codable {
    let steps: [InstructionStep]
}

struct InstructionStep: Codable, Identifiable {
    let number: Int
    let step: String
    var id: Int { number } 
}
