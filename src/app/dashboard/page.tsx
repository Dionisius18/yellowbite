import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import DashboardApp from "./_components/DashboardApp";
import type {
  Ingredient,
  InventoryItem,
  Recipe,
  RecipeIngredient,
} from "@/lib/types";

export default async function DashboardPage() {
  const supabase = await createClient();

  // User pasti ada karena middleware sudah validasi, tapi cek lagi untuk type-safety
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  // Fetch semua data paralel
  const [
    ingredientsRes,
    recipesRes,
    recipeIngsRes,
    inventoryRes,
  ] = await Promise.all([
    supabase.from("ingredients").select("*").order("name"),
    supabase.from("recipes").select("*").order("recipe_name"),
    supabase.from("recipe_ingredients").select("*"),
    supabase
      .from("inventory")
      .select("*")
      .eq("user_id", user.id)
      .order("created_at"),
  ]);

  // Cek error
  const error =
    ingredientsRes.error ||
    recipesRes.error ||
    recipeIngsRes.error ||
    inventoryRes.error;

  if (error) {
    return (
      <main className="min-h-screen flex items-center justify-center px-4">
        <div className="max-w-md bg-white border border-red-200 rounded-2xl p-7 shadow-sm">
          <h2 className="text-xl font-bold text-red-700 mb-2">
            ⚠️ Gagal memuat data
          </h2>
          <p className="text-sm text-ink-muted mb-3">
            Cek apakah SQL schema dan seed sudah dijalankan dengan benar di
            Supabase.
          </p>
          <pre className="text-xs bg-red-50 p-3 rounded text-red-700 overflow-auto">
            {error.message}
          </pre>
        </div>
      </main>
    );
  }

  return (
    <DashboardApp
      user={user}
      ingredients={(ingredientsRes.data ?? []) as Ingredient[]}
      recipes={(recipesRes.data ?? []) as Recipe[]}
      recipeIngredients={(recipeIngsRes.data ?? []) as RecipeIngredient[]}
      initialInventory={(inventoryRes.data ?? []) as InventoryItem[]}
    />
  );
}
