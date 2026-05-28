import type {
  Ingredient,
  Macros,
  Recipe,
  RecipeIngredient,
  RecipeTag,
} from "./types";

/**
 * Tampilkan kuantitas dalam satuan terbaik:
 * 1500 Gram → "1.5 Kg", 1000 ml → "1 Liter"
 */
export function formatQty(weight: number, baseUnit: string): string {
  let value = weight;
  let unit = baseUnit;
  if (baseUnit === "Gram" && weight >= 1000) {
    value = weight / 1000;
    unit = "Kg";
  } else if (baseUnit === "ml" && weight >= 1000) {
    value = weight / 1000;
    unit = "Liter";
  }
  const rounded = Math.round(value * 100) / 100;
  const text = Number.isInteger(rounded) ? String(rounded) : rounded.toString();
  return `${text} ${unit}`;
}

/**
 * Hitung total makro untuk satu resep (sum semua bahan × required_weight).
 */
export function calculateRecipeMacros(
  recipe: Recipe,
  recipeIngredients: RecipeIngredient[],
  ingredientMap: Map<string, Ingredient>
): Macros {
  const total = { kcal: 0, protein: 0, carbs: 0, fat: 0 };
  const ings = recipeIngredients.filter((ri) => ri.recipe_id === recipe.id);

  for (const ri of ings) {
    const def = ingredientMap.get(ri.ingredient_name);
    if (!def?.macros) continue;
    total.kcal += def.macros.kcal * ri.required_weight;
    total.protein += def.macros.protein * ri.required_weight;
    total.carbs += def.macros.carbs * ri.required_weight;
    total.fat += def.macros.fat * ri.required_weight;
  }

  return {
    kcal: Math.round(total.kcal),
    protein: Math.round(total.protein),
    carbs: Math.round(total.carbs),
    fat: Math.round(total.fat),
  };
}

/**
 * Tentukan tag kategori dari profil makro.
 */
export function getRecipeTags(macros: Macros): RecipeTag[] {
  const tags: RecipeTag[] = [];
  if (macros.protein >= 30) tags.push({ label: "Tinggi Protein", style: "protein" });
  if (macros.carbs < 30 && macros.kcal > 100)
    tags.push({ label: "Rendah Karbo", style: "low-carb" });
  if (macros.kcal > 0 && macros.kcal < 400)
    tags.push({ label: "Ringan", style: "light" });
  if (macros.kcal >= 600) tags.push({ label: "Mengenyangkan", style: "hearty" });
  return tags;
}
