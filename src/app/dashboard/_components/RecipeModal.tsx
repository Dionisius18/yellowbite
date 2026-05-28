"use client";

import { useEffect } from "react";
import { calculateRecipeMacros, formatQty, getRecipeTags } from "@/lib/utils";
import type {
  Ingredient,
  Recipe,
  RecipeIngredient,
} from "@/lib/types";

interface Props {
  recipe: Recipe | null;
  recipeIngredients: RecipeIngredient[];
  ingredientMap: Map<string, Ingredient>;
  onClose: () => void;
}

export default function RecipeModal({
  recipe,
  recipeIngredients,
  ingredientMap,
  onClose,
}: Props) {
  // Tutup modal pakai Escape, lock scroll saat terbuka
  useEffect(() => {
    if (!recipe) return;
    function handleKey(e: KeyboardEvent) {
      if (e.key === "Escape") onClose();
    }
    document.addEventListener("keydown", handleKey);
    document.body.style.overflow = "hidden";
    return () => {
      document.removeEventListener("keydown", handleKey);
      document.body.style.overflow = "";
    };
  }, [recipe, onClose]);

  if (!recipe) return null;

  const macros = calculateRecipeMacros(recipe, recipeIngredients, ingredientMap);
  const tags = getRecipeTags(macros);
  const ings = recipeIngredients.filter((ri) => ri.recipe_id === recipe.id);
  const [c1, c2] = recipe.hero_gradient;

  return (
    <div
      onClick={(e) => e.target === e.currentTarget && onClose()}
      className="fixed inset-0 bg-ink/55 backdrop-blur-sm flex items-center justify-center p-5 z-50 animate-[fadeIn_0.2s_ease]"
    >
      <div className="bg-white rounded-2xl max-w-[600px] w-full max-h-[92vh] overflow-y-auto shadow-2xl">
        {/* Hero */}
        <div
          className="relative aspect-[16/8] flex items-center justify-center overflow-hidden"
          style={{ background: `linear-gradient(135deg, ${c1} 0%, ${c2} 100%)` }}
        >
          <span
            className="text-[96px] relative z-10"
            style={{ filter: "drop-shadow(2px 4px 6px rgba(0,0,0,0.18))" }}
          >
            {recipe.hero_emoji}
          </span>
          <div className="absolute inset-0 pointer-events-none [background:radial-gradient(circle_at_20%_20%,rgba(255,255,255,0.25),transparent_50%),radial-gradient(circle_at_80%_80%,rgba(0,0,0,0.08),transparent_50%)]" />
          <button
            onClick={onClose}
            className="absolute top-4 right-4 w-9 h-9 rounded-full bg-white/90 border border-amber-100 text-xl flex items-center justify-center hover:bg-primary transition z-20"
            aria-label="Tutup"
          >
            ×
          </button>
        </div>

        {/* Header */}
        <header className="px-8 pt-7 pb-3">
          <span className="inline-block px-3 py-1 bg-primary text-ink text-[11px] font-bold uppercase tracking-[0.1em] rounded-full mb-3">
            {recipe.meal_type}
          </span>
          <h3 className="text-3xl font-bold tracking-tight leading-tight">
            {recipe.recipe_name}
          </h3>
          {tags.length > 0 && (
            <div className="flex flex-wrap gap-1.5 mt-3.5">
              {tags.map((t) => {
                const styles: Record<string, string> = {
                  protein: "bg-orange-50 text-[#B83C00]",
                  "low-carb": "bg-green-50 text-[#2E5C1E]",
                  light: "bg-blue-50 text-[#1565C0]",
                  hearty: "bg-red-50 text-[#A33A1A]",
                };
                return (
                  <span
                    key={t.label}
                    className={`px-2.5 py-1 text-[10.5px] font-bold rounded-full ${
                      styles[t.style]
                    }`}
                  >
                    {t.label}
                  </span>
                );
              })}
            </div>
          )}
        </header>

        {/* Macros */}
        <div className="mx-8 my-3 bg-cream rounded-xl grid grid-cols-4 py-4">
          <MacroBlock value={macros.kcal} label="KCAL" highlight />
          <MacroBlock value={macros.protein} suffix="g" label="Protein" />
          <MacroBlock value={macros.carbs} suffix="g" label="Karbohidrat" />
          <MacroBlock value={macros.fat} suffix="g" label="Lemak" last />
        </div>

        {/* Body */}
        <div className="px-8 pb-8 space-y-6">
          <section>
            <h4 className="text-xs font-bold uppercase tracking-wider text-ink-muted mb-2.5">
              Bahan yang Terpakai
            </h4>
            <ul className="space-y-1.5">
              {ings.map((ri) => {
                const def = ingredientMap.get(ri.ingredient_name);
                const isBase = def?.is_base ?? false;
                const amount = isBase
                  ? "secukupnya"
                  : formatQty(ri.required_weight, def?.base_unit ?? "");
                return (
                  <li
                    key={ri.ingredient_name}
                    className="flex justify-between gap-3 px-3.5 py-2.5 bg-cream rounded text-sm"
                  >
                    <span className="font-semibold">
                      {def?.emoji ?? "•"} {ri.ingredient_name}
                    </span>
                    <span
                      className={`font-bold tabular-nums ${
                        isBase ? "text-ink-soft italic font-medium" : "text-accent"
                      }`}
                    >
                      {amount}
                    </span>
                  </li>
                );
              })}
            </ul>
          </section>

          <section>
            <h4 className="text-xs font-bold uppercase tracking-wider text-ink-muted mb-2.5">
              Cara Memasak
            </h4>
            <p className="text-sm leading-7 text-ink">{recipe.instructions}</p>
          </section>
        </div>
      </div>
    </div>
  );
}

function MacroBlock({
  value,
  suffix = "",
  label,
  highlight = false,
  last = false,
}: {
  value: number;
  suffix?: string;
  label: string;
  highlight?: boolean;
  last?: boolean;
}) {
  return (
    <div className={`text-center ${last ? "" : "border-r border-amber-100"}`}>
      <div
        className={`font-display font-extrabold text-2xl leading-none tabular-nums ${
          highlight ? "text-accent" : "text-ink"
        }`}
      >
        {value}
        {suffix && (
          <span className="text-sm font-semibold text-ink-muted ml-0.5">
            {suffix}
          </span>
        )}
      </div>
      <div className="text-[10px] font-bold uppercase tracking-wider text-ink-soft mt-1.5">
        {label}
      </div>
    </div>
  );
}
