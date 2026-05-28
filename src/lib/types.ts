/**
 * Type definitions untuk skema database YellowBite.
 * Mencerminkan tabel di Supabase 1:1.
 */

export type MealType = "Sarapan" | "Siang" | "Malam";

export interface Macros {
  kcal: number;
  protein: number;
  carbs: number;
  fat: number;
}

export interface Ingredient {
  name: string;
  base_unit: string;
  available_units: Record<string, number>; // {Gram: 1, Kg: 1000}
  is_base: boolean;
  emoji: string;
  macros: Macros; // per 1 base_unit
}

export interface Recipe {
  id: number;
  recipe_name: string;
  meal_type: MealType;
  instructions: string;
  hero_emoji: string;
  hero_gradient: [string, string];
}

export interface RecipeIngredient {
  recipe_id: number;
  ingredient_name: string;
  required_weight: number;
}

export interface InventoryItem {
  id: string;
  user_id: string;
  ingredient_name: string;
  weight: number; // dalam base_unit bahan tsb
  created_at: string;
  updated_at: string;
}

/** Hasil dari algoritma meal planner */
export interface DayPlan {
  day: number;
  meals: {
    Sarapan: Recipe | null;
    Siang: Recipe | null;
    Malam: Recipe | null;
  };
}

export interface PlanResult {
  plan: DayPlan[];
  note: string | null;
  elapsedMs: number;
}

export interface RecipeTag {
  label: string;
  style: "protein" | "low-carb" | "light" | "hearty";
}
