"use client";

import { useMemo, useState } from "react";
import type { User } from "@supabase/supabase-js";
import InventoryPanel from "./InventoryPanel";
import PlanGenerator from "./PlanGenerator";
import RecipeModal from "./RecipeModal";
import LogoutButton from "@/components/LogoutButton";
import type {
  Ingredient,
  InventoryItem,
  Recipe,
  RecipeIngredient,
} from "@/lib/types";

interface Props {
  user: User;
  ingredients: Ingredient[];
  recipes: Recipe[];
  recipeIngredients: RecipeIngredient[];
  initialInventory: InventoryItem[];
}

export default function DashboardApp({
  user,
  ingredients,
  recipes,
  recipeIngredients,
  initialInventory,
}: Props) {
  const [inventory, setInventory] = useState(initialInventory);
  const [selectedRecipe, setSelectedRecipe] = useState<Recipe | null>(null);

  // Build ingredient lookup map (digunakan di modal)
  const ingredientMap = useMemo(() => {
    const m = new Map<string, Ingredient>();
    ingredients.forEach((i) => m.set(i.name, i));
    return m;
  }, [ingredients]);

  return (
    <main className="min-h-screen">
      {/* ============ HEADER ============ */}
      <header className="border-b border-amber-100 bg-gradient-to-b from-primary/10 to-transparent">
        <div className="max-w-6xl mx-auto px-6 py-6 flex items-center justify-between gap-4">
          <div className="flex items-center gap-3">
            <span className="text-3xl">🟡</span>
            <div>
              <h1 className="text-2xl font-bold tracking-tight leading-none">
                YellowBite
              </h1>
              <p className="text-xs text-ink-muted italic font-display mt-0.5">
                Dari kulkas ke meja makan, tanpa sisa.
              </p>
            </div>
          </div>
          <div className="flex items-center gap-4">
            <span className="text-sm text-ink-muted hidden sm:inline">
              {user.email}
            </span>
            <LogoutButton />
          </div>
        </div>
      </header>

      {/* ============ MAIN CONTENT ============ */}
      <div className="max-w-6xl mx-auto px-6 py-10 space-y-8">
        <InventoryPanel
          userId={user.id}
          ingredients={ingredients}
          inventory={inventory}
          onInventoryChange={setInventory}
        />

        <PlanGenerator
          inventory={inventory}
          ingredients={ingredients}
          recipes={recipes}
          recipeIngredients={recipeIngredients}
          onRecipeClick={setSelectedRecipe}
        />
      </div>

      {/* ============ FOOTER ============ */}
      <footer className="border-t border-amber-100 mt-12 py-8 px-6 text-center text-xs text-ink-soft">
        YellowBite · Rule-based engine, no AI · Data tersimpan aman di Supabase
      </footer>

      {/* ============ MODAL ============ */}
      <RecipeModal
        recipe={selectedRecipe}
        recipeIngredients={recipeIngredients}
        ingredientMap={ingredientMap}
        onClose={() => setSelectedRecipe(null)}
      />
    </main>
  );
}
