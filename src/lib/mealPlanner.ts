import type {
  DayPlan,
  Ingredient,
  InventoryItem,
  PlanResult,
  Recipe,
  RecipeIngredient,
} from "./types";

/**
 * Algoritma rule-based meal planner.
 * Sesuai PRD: 3 aturan validasi (ketersediaan, kecukupan kuantitas, bypass bumbu dasar).
 */
export function generateMealPlan(
  inventory: InventoryItem[],
  recipes: Recipe[],
  recipeIngredients: RecipeIngredient[],
  ingredients: Ingredient[],
  targetDays: number
): PlanResult {
  const t0 =
    typeof performance !== "undefined" ? performance.now() : Date.now();

  // Build lookup maps untuk performa
  const ingredientMap = new Map<string, Ingredient>();
  ingredients.forEach((i) => ingredientMap.set(i.name, i));

  const recipeIngMap = new Map<number, RecipeIngredient[]>();
  recipeIngredients.forEach((ri) => {
    const list = recipeIngMap.get(ri.recipe_id) ?? [];
    list.push(ri);
    recipeIngMap.set(ri.recipe_id, list);
  });

  // Kulkas sementara (key by ingredient_name → weight in base_unit)
  const tempInventory: Record<string, number> = {};
  inventory.forEach((item) => {
    tempInventory[item.ingredient_name] = item.weight;
  });

  const result: DayPlan[] = [];
  const mealOrder: Array<"Sarapan" | "Siang" | "Malam"> = [
    "Sarapan",
    "Siang",
    "Malam",
  ];

  for (let day = 1; day <= targetDays; day++) {
    const usedToday = new Set<number>(); // recipe IDs sudah dipakai di hari ini
    const meals: DayPlan["meals"] = {
      Sarapan: null,
      Siang: null,
      Malam: null,
    };

    for (const mealType of mealOrder) {
      const valid = findValidRecipes(
        tempInventory,
        recipes,
        recipeIngMap,
        ingredientMap,
        mealType,
        usedToday
      );

      if (valid.length === 0) {
        // Bahan habis di hari/jam makan ini
        meals[mealType] = null;
        result.push({ day, meals });
        const elapsed =
          (typeof performance !== "undefined" ? performance.now() : Date.now()) -
          t0;
        // Hitung berapa menu yang berhasil dibuat sebelumnya
        const totalGenerated = result.reduce(
          (sum, d) => sum + Object.values(d.meals).filter(Boolean).length,
          0
        );
        const note =
          totalGenerated === 0
            ? `Bahan di kulkasmu belum cukup untuk membuat resep apa pun. Cek saran di bawah untuk tahu bahan apa yang perlu ditambah.`
            : `Bahan habis di Hari ke-${day} (${mealType}). Tambahkan bahan untuk memperpanjang rencana.`;
        return {
          plan: result,
          note,
          elapsedMs: Math.round(elapsed),
        };
      }

      const picked = pickBestRecipe(valid, recipeIngMap, ingredientMap);
      meals[mealType] = picked;
      usedToday.add(picked.id);
      deductIngredients(tempInventory, picked, recipeIngMap, ingredientMap);
    }

    result.push({ day, meals });
  }

  const elapsed =
    (typeof performance !== "undefined" ? performance.now() : Date.now()) - t0;
  return { plan: result, note: null, elapsedMs: Math.round(elapsed) };
}

/** Cari resep yang lulus 3 aturan validasi PRD */
function findValidRecipes(
  tempInventory: Record<string, number>,
  recipes: Recipe[],
  recipeIngMap: Map<number, RecipeIngredient[]>,
  ingredientMap: Map<string, Ingredient>,
  mealType: "Sarapan" | "Siang" | "Malam",
  usedToday: Set<number>
): Recipe[] {
  return recipes.filter((r) => {
    if (r.meal_type !== mealType) return false;
    if (usedToday.has(r.id)) return false;

    const ings = recipeIngMap.get(r.id) ?? [];
    for (const ri of ings) {
      const def = ingredientMap.get(ri.ingredient_name);
      // Bumbu dasar → bypass cek kuantitas (Aturan #3 PRD)
      if (def?.is_base) continue;
      // Bahan utama: harus ada di kulkas (Aturan #1)
      if (!(ri.ingredient_name in tempInventory)) return false;
      // Kuantitas harus cukup (Aturan #2)
      if (tempInventory[ri.ingredient_name] < ri.required_weight) return false;
    }
    return true;
  });
}

/** Pilih resep terbaik: skor tertinggi (jumlah bahan non-base) + random tiebreaker */
function pickBestRecipe(
  valid: Recipe[],
  recipeIngMap: Map<number, RecipeIngredient[]>,
  ingredientMap: Map<string, Ingredient>
): Recipe {
  const scored = valid.map((r) => {
    const ings = recipeIngMap.get(r.id) ?? [];
    const score = ings.filter((ri) => {
      const def = ingredientMap.get(ri.ingredient_name);
      return def && !def.is_base;
    }).length;
    return { recipe: r, score };
  });

  scored.sort((a, b) => b.score - a.score);
  const topScore = scored[0].score;
  const topRecipes = scored.filter((s) => s.score === topScore);
  // Random tiebreaker di antara skor tertinggi
  return topRecipes[Math.floor(Math.random() * topRecipes.length)].recipe;
}

/** Kurangi bahan non-base dari kulkas sementara */
function deductIngredients(
  tempInventory: Record<string, number>,
  recipe: Recipe,
  recipeIngMap: Map<number, RecipeIngredient[]>,
  ingredientMap: Map<string, Ingredient>
) {
  const ings = recipeIngMap.get(recipe.id) ?? [];
  for (const ri of ings) {
    const def = ingredientMap.get(ri.ingredient_name);
    if (def?.is_base) continue;
    if (!(ri.ingredient_name in tempInventory)) continue;
    tempInventory[ri.ingredient_name] -= ri.required_weight;
    if (tempInventory[ri.ingredient_name] < 0) {
      tempInventory[ri.ingredient_name] = 0;
    }
  }
}

/* ==========================================================================
   NEAR-MISS ANALYSIS
   Cari resep yang "hampir bisa dibuat" — bahan kurang sedikit.
   Berguna ketika plan gagal: user tahu bahan apa yang perlu ditambah.
   ========================================================================== */

export interface NearMissIngredient {
  name: string;
  required: number;
  have: number;
  emoji: string;
  base_unit: string;
}

export interface NearMissRecipe {
  recipe: Recipe;
  missingIngredients: NearMissIngredient[];
  missingCount: number;
}

export function analyzeNearMisses(
  inventory: InventoryItem[],
  recipes: Recipe[],
  recipeIngredients: RecipeIngredient[],
  ingredients: Ingredient[],
  limit = 5
): NearMissRecipe[] {
  const ingredientMap = new Map<string, Ingredient>();
  ingredients.forEach((i) => ingredientMap.set(i.name, i));

  const recipeIngMap = new Map<number, RecipeIngredient[]>();
  recipeIngredients.forEach((ri) => {
    const list = recipeIngMap.get(ri.recipe_id) ?? [];
    list.push(ri);
    recipeIngMap.set(ri.recipe_id, list);
  });

  const inv: Record<string, number> = {};
  inventory.forEach((item) => {
    inv[item.ingredient_name] = item.weight;
  });

  const nearMisses: NearMissRecipe[] = recipes
    .map((r) => {
      const ings = recipeIngMap.get(r.id) ?? [];
      const missing: NearMissIngredient[] = [];

      for (const ri of ings) {
        const def = ingredientMap.get(ri.ingredient_name);
        if (def?.is_base) continue; // bumbu dasar bypass
        const have = inv[ri.ingredient_name] ?? 0;
        if (have < ri.required_weight) {
          missing.push({
            name: ri.ingredient_name,
            required: ri.required_weight,
            have,
            emoji: def?.emoji ?? "•",
            base_unit: def?.base_unit ?? "",
          });
        }
      }

      return { recipe: r, missingIngredients: missing, missingCount: missing.length };
    })
    .filter((nm) => nm.missingCount > 0) // Skip yang sudah valid
    .sort((a, b) => a.missingCount - b.missingCount)
    .slice(0, limit);

  return nearMisses;
}
