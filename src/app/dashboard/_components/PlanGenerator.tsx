"use client";

import { useMemo, useState } from "react";
import { generateMealPlan, analyzeNearMisses, type NearMissRecipe } from "@/lib/mealPlanner";
import { calculateRecipeMacros, formatQty, getRecipeTags } from "@/lib/utils";
import type {
  Ingredient,
  InventoryItem,
  PlanResult,
  Recipe,
  RecipeIngredient,
} from "@/lib/types";

interface Props {
  inventory: InventoryItem[];
  ingredients: Ingredient[];
  recipes: Recipe[];
  recipeIngredients: RecipeIngredient[];
  onRecipeClick: (recipe: Recipe) => void;
}

const DAY_WORDS = [
  "Pertama",
  "Kedua",
  "Ketiga",
  "Keempat",
  "Kelima",
  "Keenam",
  "Ketujuh",
];

export default function PlanGenerator({
  inventory,
  ingredients,
  recipes,
  recipeIngredients,
  onRecipeClick,
}: Props) {
  const [days, setDays] = useState(3);
  const [result, setResult] = useState<PlanResult | null>(null);

  const ingredientMap = useMemo(() => {
    const m = new Map<string, Ingredient>();
    ingredients.forEach((i) => m.set(i.name, i));
    return m;
  }, [ingredients]);

  function handleGenerate() {
    if (inventory.length === 0) {
      alert("Tambahkan bahan ke kulkas dulu sebelum generate plan.");
      return;
    }
    const r = generateMealPlan(
      inventory,
      recipes,
      recipeIngredients,
      ingredients,
      days
    );
    setResult(r);
    // Scroll ke output
    setTimeout(() => {
      document
        .getElementById("plan-output")
        ?.scrollIntoView({ behavior: "smooth", block: "start" });
    }, 100);
  }

  const successfulDays = result
    ? result.plan.filter((d) => Object.values(d.meals).every((m) => m !== null))
        .length
    : 0;
  const totalMeals = result
    ? result.plan.reduce(
        (sum, d) => sum + Object.values(d.meals).filter(Boolean).length,
        0
      )
    : 0;

  // Cari resep "hampir bisa" saat ada masalah generate
  const nearMisses: NearMissRecipe[] = useMemo(() => {
    if (!result?.note) return [];
    return analyzeNearMisses(
      inventory,
      recipes,
      recipeIngredients,
      ingredients,
      5
    );
  }, [result, inventory, recipes, recipeIngredients, ingredients]);

  return (
    <>
      {/* ============ GENERATE BAR ============ */}
      <section className="bg-gradient-to-br from-cream via-white to-primary/10 border-[1.5px] border-primary rounded-2xl p-7 flex flex-wrap items-center justify-between gap-5">
        <div>
          <h2 className="text-2xl font-bold">Siap untuk merencanakan?</h2>
          <p className="text-sm text-ink-muted mt-1">
            Pilih durasi rencana makan, lalu biarkan sistem menyusun menumu.
          </p>
        </div>
        <div className="flex items-end gap-3">
          <div>
            <label className="block text-xs font-bold uppercase tracking-wider text-ink-muted mb-1.5">
              Durasi
            </label>
            <select
              value={days}
              onChange={(e) => setDays(parseInt(e.target.value, 10))}
              className="px-4 py-3 border-2 border-amber-100 rounded-lg focus:border-primary focus:ring-2 focus:ring-primary/25 outline-none transition min-w-[130px]"
            >
              {[1, 2, 3, 4, 5, 6, 7].map((n) => (
                <option key={n} value={n}>
                  {n} Hari
                </option>
              ))}
            </select>
          </div>
          <button
            onClick={handleGenerate}
            className="bg-accent hover:bg-accent-dark text-white font-bold px-7 py-3 rounded-lg shadow-sm transition text-base"
          >
            ✨ Generate Plan
          </button>
        </div>
      </section>

      {/* ============ PLAN OUTPUT ============ */}
      {result && (
        <section id="plan-output" className="mt-12">
          <header className="text-center mb-9">
            <span className="inline-block text-[11px] font-bold uppercase tracking-[0.18em] text-accent px-3.5 py-1.5 bg-accent/8 rounded-full mb-3">
              Hasil Generasi
            </span>
            <h2 className="text-4xl sm:text-5xl font-bold tracking-tight leading-none">
              Rencana Makanmu
            </h2>
            <p className="text-ink-muted italic font-display mt-3">
              {successfulDays} dari {days} hari · {totalMeals} menu disusun ·
              diproses {result.elapsedMs}ms
            </p>
          </header>

          {/* Kalau TIDAK ada menu sama sekali → tampilkan saran saja, skip day cards */}
          {totalMeals === 0 ? (
            <NoMenuFallback nearMisses={nearMisses} note={result.note} />
          ) : (
            <>
              <div className="flex flex-col gap-14">
                {result.plan.map((dayPlan, idx) => (
                  <article key={dayPlan.day} style={{ animationDelay: `${idx * 100}ms` }}>
                    <header className="flex items-center gap-4 mb-4 pb-3 border-b border-amber-100">
                      <span className="font-display font-extrabold text-5xl text-primary leading-none tabular-nums">
                        {String(dayPlan.day).padStart(2, "0")}
                      </span>
                      <div>
                        <span className="block text-[11px] font-bold uppercase tracking-widest text-ink-soft">
                          Hari ke-{dayPlan.day}
                        </span>
                        <h3 className="text-2xl font-bold leading-none mt-0.5">
                          Hari {DAY_WORDS[dayPlan.day - 1] ?? dayPlan.day}
                        </h3>
                      </div>
                    </header>
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-5">
                      {(["Sarapan", "Siang", "Malam"] as const).map((mt) => (
                        <MealCard
                          key={mt}
                          timeLabel={mt}
                          recipe={dayPlan.meals[mt]}
                          recipeIngredients={recipeIngredients}
                          ingredientMap={ingredientMap}
                          onClick={onRecipeClick}
                        />
                      ))}
                    </div>
                  </article>
                ))}
              </div>

              {result.note && (
                <div className="mt-8 px-5 py-4 bg-accent/8 border-l-4 border-accent rounded text-accent font-semibold text-sm">
                  ⚠ {result.note}
                </div>
              )}

              {nearMisses.length > 0 && (
                <NearMissSection nearMisses={nearMisses} compact />
              )}
            </>
          )}
        </section>
      )}
    </>
  );
}

/* ============ NO-MENU FALLBACK ============
   Tampilan saat 0 menu berhasil di-generate.
   ============================================ */
function NoMenuFallback({
  nearMisses,
  note,
}: {
  nearMisses: NearMissRecipe[];
  note: string | null;
}) {
  return (
    <div className="max-w-3xl mx-auto">
      <div className="bg-white border border-amber-100 rounded-2xl p-8 text-center">
        <div className="text-6xl mb-4">🤔</div>
        <h3 className="text-2xl font-bold mb-2">Belum bisa buat menu apa pun</h3>
        <p className="text-ink-muted leading-relaxed">
          {note ??
            "Bahan di kulkasmu belum cukup. Cek saran di bawah untuk tahu bahan apa yang perlu ditambah."}
        </p>
      </div>
      {nearMisses.length > 0 && <NearMissSection nearMisses={nearMisses} />}
    </div>
  );
}

/* ============ NEAR-MISS SECTION ============
   Resep yang hampir bisa dibuat + daftar bahan yang kurang.
   ========================================== */
function NearMissSection({
  nearMisses,
  compact = false,
}: {
  nearMisses: NearMissRecipe[];
  compact?: boolean;
}) {
  // Kumpulkan bahan kurang yang paling sering muncul → "shopping list" cepat
  const counts = new Map<string, { emoji: string; count: number }>();
  nearMisses.forEach((nm) => {
    nm.missingIngredients.forEach((mi) => {
      const cur = counts.get(mi.name) ?? { emoji: mi.emoji, count: 0 };
      cur.count++;
      counts.set(mi.name, cur);
    });
  });
  const topMissing = Array.from(counts.entries())
    .sort((a, b) => b[1].count - a[1].count)
    .slice(0, 6);

  return (
    <section className={compact ? "mt-8" : "mt-6"}>
      <header className="mb-5">
        <span className="inline-block text-[11px] font-bold uppercase tracking-[0.18em] text-accent px-3.5 py-1.5 bg-accent/8 rounded-full mb-3">
          💡 Saran
        </span>
        <h3 className="text-2xl font-bold leading-tight">
          {compact ? "Resep selanjutnya hampir bisa" : "Resep yang hampir bisa dibuat"}
        </h3>
        <p className="text-sm text-ink-muted mt-1">
          Tinggal tambahkan bahan yang ditandai di bawah, lalu generate ulang.
        </p>
      </header>

      {topMissing.length > 0 && (
        <div className="mb-5 p-4 bg-primary/10 border border-primary/30 rounded-xl">
          <div className="text-[11px] font-bold uppercase tracking-wider text-ink-muted mb-2">
            Bahan paling banyak dicari
          </div>
          <div className="flex flex-wrap gap-2">
            {topMissing.map(([name, { emoji, count }]) => (
              <span
                key={name}
                className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-white border border-primary/40 rounded-full text-sm font-semibold"
              >
                <span>{emoji}</span>
                <span>{name}</span>
                <span className="text-[10px] font-bold text-accent">
                  ×{count}
                </span>
              </span>
            ))}
          </div>
        </div>
      )}

      <div className="space-y-3">
        {nearMisses.map((nm) => (
          <div
            key={nm.recipe.id}
            className="bg-white border border-amber-100 rounded-xl p-4 flex gap-4 items-start"
          >
            <div
              className="w-14 h-14 rounded-lg flex items-center justify-center shrink-0 text-3xl"
              style={{
                background: `linear-gradient(135deg, ${nm.recipe.hero_gradient[0]}, ${nm.recipe.hero_gradient[1]})`,
              }}
            >
              {nm.recipe.hero_emoji}
            </div>
            <div className="flex-1 min-w-0">
              <div className="flex items-baseline justify-between gap-3 flex-wrap">
                <div>
                  <span className="text-[10px] font-bold uppercase tracking-widest text-accent">
                    {nm.recipe.meal_type}
                  </span>
                  <h4 className="font-display font-bold text-lg leading-tight">
                    {nm.recipe.recipe_name}
                  </h4>
                </div>
                <span className="text-xs font-bold text-ink-muted bg-cream px-2.5 py-1 rounded-full">
                  Kurang {nm.missingCount} bahan
                </span>
              </div>
              <div className="flex flex-wrap gap-1.5 mt-2.5">
                {nm.missingIngredients.map((mi) => (
                  <span
                    key={mi.name}
                    className="inline-flex items-center gap-1 text-xs px-2.5 py-1 bg-accent/10 text-accent font-semibold rounded-full"
                    title={`Butuh ${formatQty(mi.required, mi.base_unit)}`}
                  >
                    <span>{mi.emoji}</span>
                    <span>{mi.name}</span>
                  </span>
                ))}
              </div>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}

/* ============ MEAL CARD ============ */
function MealCard({
  timeLabel,
  recipe,
  recipeIngredients,
  ingredientMap,
  onClick,
}: {
  timeLabel: "Sarapan" | "Siang" | "Malam";
  recipe: Recipe | null;
  recipeIngredients: RecipeIngredient[];
  ingredientMap: Map<string, Ingredient>;
  onClick: (r: Recipe) => void;
}) {
  if (!recipe) {
    return (
      <div className="bg-white border border-amber-50 rounded-2xl overflow-hidden opacity-60">
        <div className="aspect-[16/10] flex items-center justify-center [background:repeating-linear-gradient(45deg,#FFFDF2,#FFFDF2_10px,rgba(230,81,0,0.05)_10px,rgba(230,81,0,0.05)_20px)]">
          <span className="text-5xl text-ink-soft">⊘</span>
        </div>
        <div className="p-5">
          <span className="text-[10px] font-extrabold uppercase tracking-[0.18em] text-accent">
            {timeLabel}
          </span>
          <h4 className="font-display font-bold text-lg leading-tight mt-2">
            Tidak tersedia
          </h4>
          <p className="text-xs text-ink-soft italic mt-1">
            Bahan tidak mencukupi
          </p>
        </div>
      </div>
    );
  }

  const macros = calculateRecipeMacros(recipe, recipeIngredients, ingredientMap);
  const tags = getRecipeTags(macros);
  const [c1, c2] = recipe.hero_gradient;

  return (
    <button
      type="button"
      onClick={() => onClick(recipe)}
      className="group bg-white border border-amber-50 rounded-2xl overflow-hidden text-left w-full transition hover:-translate-y-1 hover:shadow-lg hover:border-primary"
    >
      {/* Hero */}
      <div
        className="aspect-[16/10] flex items-center justify-center relative overflow-hidden"
        style={{ background: `linear-gradient(135deg, ${c1} 0%, ${c2} 100%)` }}
      >
        <span
          className="text-6xl relative z-10 transition group-hover:scale-110 group-hover:rotate-0"
          style={{
            filter: "drop-shadow(2px 4px 6px rgba(0,0,0,0.15))",
            transform: "rotate(-4deg)",
          }}
        >
          {recipe.hero_emoji}
        </span>
        <div className="absolute inset-0 pointer-events-none [background:radial-gradient(circle_at_20%_20%,rgba(255,255,255,0.25),transparent_50%),radial-gradient(circle_at_80%_80%,rgba(0,0,0,0.08),transparent_50%)]" />
      </div>
      {/* Body */}
      <div className="p-5 space-y-3">
        <span className="text-[10px] font-extrabold uppercase tracking-[0.18em] text-accent">
          {timeLabel}
        </span>
        <h4 className="font-display font-bold text-lg leading-tight -mt-1">
          {recipe.recipe_name}
        </h4>
        <div className="grid grid-cols-4 gap-1 py-3 border-y border-amber-50">
          <Macro value={macros.kcal} label="KCAL" highlight />
          <Macro value={`${macros.protein}g`} label="PROT" />
          <Macro value={`${macros.carbs}g`} label="KARB" />
          <Macro value={`${macros.fat}g`} label="LMK" />
        </div>
        {tags.length > 0 && (
          <div className="flex flex-wrap gap-1.5">
            {tags.map((t) => (
              <Tag key={t.label} tag={t} />
            ))}
          </div>
        )}
        <div className="text-xs font-bold text-ink-soft transition group-hover:text-accent group-hover:translate-x-1">
          Lihat detail →
        </div>
      </div>
    </button>
  );
}

function Macro({
  value,
  label,
  highlight = false,
}: {
  value: number | string;
  label: string;
  highlight?: boolean;
}) {
  return (
    <div className="text-center">
      <div
        className={`font-display font-bold text-base leading-none tabular-nums ${
          highlight ? "text-accent" : "text-ink"
        }`}
      >
        {value}
      </div>
      <div className="text-[9px] font-bold tracking-widest text-ink-soft mt-1">
        {label}
      </div>
    </div>
  );
}

function Tag({ tag }: { tag: { label: string; style: string } }) {
  const styles: Record<string, string> = {
    protein: "bg-orange-50 text-[#B83C00]",
    "low-carb": "bg-green-50 text-[#2E5C1E]",
    light: "bg-blue-50 text-[#1565C0]",
    hearty: "bg-red-50 text-[#A33A1A]",
  };
  return (
    <span
      className={`px-2.5 py-1 text-[10.5px] font-bold rounded-full whitespace-nowrap ${
        styles[tag.style] ?? "bg-amber-50 text-amber-700"
      }`}
    >
      {tag.label}
    </span>
  );
}
