"use client";

import { useState, useMemo } from "react";
import { createClient } from "@/lib/supabase/client";
import { formatQty } from "@/lib/utils";
import type { Ingredient, InventoryItem } from "@/lib/types";

interface Props {
  userId: string;
  ingredients: Ingredient[];
  inventory: InventoryItem[];
  onInventoryChange: (next: InventoryItem[]) => void;
}

export default function InventoryPanel({
  userId,
  ingredients,
  inventory,
  onInventoryChange,
}: Props) {
  const supabase = createClient();
  const ingredientMap = useMemo(() => {
    const m = new Map<string, Ingredient>();
    ingredients.forEach((i) => m.set(i.name, i));
    return m;
  }, [ingredients]);

  // Form state
  const [search, setSearch] = useState("");
  const [selected, setSelected] = useState<Ingredient | null>(null);
  const [weight, setWeight] = useState("");
  const [unit, setUnit] = useState("");
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [busy, setBusy] = useState(false);
  const [msg, setMsg] = useState<{ text: string; type: "success" | "error" } | null>(null);

  const suggestions = useMemo(() => {
    const term = search.trim().toLowerCase();
    if (!term) return ingredients.slice(0, 12);
    return ingredients
      .filter((i) => i.name.toLowerCase().includes(term))
      .slice(0, 12);
  }, [search, ingredients]);

  function pickIngredient(ing: Ingredient) {
    setSelected(ing);
    setSearch(ing.name);
    setShowSuggestions(false);
    const firstUnit = Object.keys(ing.available_units)[0];
    setUnit(firstUnit);
  }

  function showMessage(text: string, type: "success" | "error") {
    setMsg({ text, type });
    if (type === "success") {
      setTimeout(() => setMsg(null), 2500);
    }
  }

  async function handleAdd() {
    setMsg(null);
    if (!selected) {
      showMessage("Pilih bahan dari daftar saran dulu.", "error");
      return;
    }
    const w = parseFloat(weight);
    if (!w || w <= 0) {
      showMessage("Kuantitas harus lebih dari 0.", "error");
      return;
    }
    if (!unit || !selected.available_units[unit]) {
      showMessage("Pilih satuan yang valid.", "error");
      return;
    }

    setBusy(true);
    // Konversi ke base_unit
    const factor = selected.available_units[unit];
    const convertedWeight = w * factor;

    // Cek apakah bahan sudah ada di inventory
    const existing = inventory.find((i) => i.ingredient_name === selected.name);

    if (existing) {
      // Update: tambahkan ke berat existing
      const { data, error } = await supabase
        .from("inventory")
        .update({ weight: existing.weight + convertedWeight })
        .eq("id", existing.id)
        .select()
        .single();

      setBusy(false);
      if (error) {
        showMessage(`Gagal update: ${error.message}`, "error");
        return;
      }
      onInventoryChange(inventory.map((i) => (i.id === existing.id ? data : i)));
    } else {
      // Insert baru
      const { data, error } = await supabase
        .from("inventory")
        .insert({
          user_id: userId,
          ingredient_name: selected.name,
          weight: convertedWeight,
        })
        .select()
        .single();

      setBusy(false);
      if (error) {
        showMessage(`Gagal tambah: ${error.message}`, "error");
        return;
      }
      onInventoryChange([...inventory, data]);
    }

    // Reset form
    showMessage(`✓ ${selected.name} ditambahkan.`, "success");
    setSearch("");
    setSelected(null);
    setWeight("");
    setUnit("");
  }

  async function handleDelete(id: string) {
    const { error } = await supabase.from("inventory").delete().eq("id", id);
    if (error) {
      showMessage(`Gagal hapus: ${error.message}`, "error");
      return;
    }
    onInventoryChange(inventory.filter((i) => i.id !== id));
  }

  async function handleClearAll() {
    if (inventory.length === 0) return;
    if (!confirm("Yakin ingin mengosongkan seluruh isi kulkas?")) return;
    const { error } = await supabase
      .from("inventory")
      .delete()
      .eq("user_id", userId);
    if (error) {
      showMessage(`Gagal kosongkan: ${error.message}`, "error");
      return;
    }
    onInventoryChange([]);
  }

  async function handleEditWeight(item: InventoryItem, newWeight: number) {
    if (newWeight <= 0) return;
    const { data, error } = await supabase
      .from("inventory")
      .update({ weight: newWeight })
      .eq("id", item.id)
      .select()
      .single();
    if (error) {
      showMessage(`Gagal update: ${error.message}`, "error");
      return;
    }
    onInventoryChange(inventory.map((i) => (i.id === item.id ? data : i)));
  }

  return (
    <div className="grid lg:grid-cols-[1fr_1.5fr] gap-7">
      {/* ============ INPUT FORM ============ */}
      <section className="bg-white border border-amber-100 rounded-2xl shadow-sm">
        <header className="px-7 pt-6 pb-4 border-b border-amber-50">
          <h2 className="text-xl font-bold">Tambah Bahan</h2>
          <p className="text-sm text-ink-muted mt-1">
            Masukkan bahan yang ada di kulkasmu.
          </p>
        </header>

        <div className="p-7 space-y-4">
          {/* Nama bahan + autocomplete */}
          <div>
            <label className="block text-xs font-bold uppercase tracking-wider text-ink-muted mb-1.5">
              Nama Bahan
            </label>
            <div className="relative">
              <input
                type="text"
                value={search}
                onChange={(e) => {
                  setSearch(e.target.value);
                  setSelected(null);
                  setUnit("");
                  setShowSuggestions(true);
                }}
                onFocus={() => setShowSuggestions(true)}
                onBlur={() => setTimeout(() => setShowSuggestions(false), 150)}
                placeholder="Ketik atau pilih, misal: Ayam Fillet"
                className="w-full px-4 py-2.5 border-2 border-amber-100 rounded-lg focus:border-primary focus:ring-2 focus:ring-primary/25 outline-none transition"
              />
              {showSuggestions && suggestions.length > 0 && (
                <ul className="absolute top-full left-0 right-0 mt-1 bg-white border border-amber-100 rounded-lg shadow-md max-h-72 overflow-y-auto z-20 p-1.5">
                  {suggestions.map((ing) => (
                    <li
                      key={ing.name}
                      onMouseDown={() => pickIngredient(ing)}
                      className="px-3 py-2 rounded cursor-pointer flex items-center gap-2.5 text-sm hover:bg-primary/15"
                    >
                      <span className="text-lg">{ing.emoji}</span>
                      <span>{ing.name}</span>
                      {ing.is_base && (
                        <span className="ml-auto text-[10px] font-bold uppercase tracking-wide px-2 py-0.5 bg-accent/10 text-accent rounded-full">
                          Bumbu Dasar
                        </span>
                      )}
                    </li>
                  ))}
                </ul>
              )}
            </div>
          </div>

          {/* Kuantitas + satuan */}
          <div className="grid grid-cols-[1fr_110px] gap-3">
            <div>
              <label className="block text-xs font-bold uppercase tracking-wider text-ink-muted mb-1.5">
                Kuantitas
              </label>
              <input
                type="number"
                step="0.01"
                min="0"
                value={weight}
                onChange={(e) => setWeight(e.target.value)}
                placeholder="500"
                onKeyDown={(e) => e.key === "Enter" && handleAdd()}
                className="w-full px-4 py-2.5 border-2 border-amber-100 rounded-lg focus:border-primary focus:ring-2 focus:ring-primary/25 outline-none transition"
              />
            </div>
            <div>
              <label className="block text-xs font-bold uppercase tracking-wider text-ink-muted mb-1.5">
                Satuan
              </label>
              <select
                value={unit}
                onChange={(e) => setUnit(e.target.value)}
                disabled={!selected}
                className="w-full px-3 py-2.5 border-2 border-amber-100 rounded-lg focus:border-primary focus:ring-2 focus:ring-primary/25 outline-none transition disabled:bg-cream disabled:text-ink-soft"
              >
                {!selected ? (
                  <option value="">—</option>
                ) : (
                  Object.keys(selected.available_units).map((u) => (
                    <option key={u} value={u}>
                      {u}
                    </option>
                  ))
                )}
              </select>
            </div>
          </div>

          <button
            onClick={handleAdd}
            disabled={busy}
            className="w-full bg-primary hover:bg-primary-dark text-ink font-bold py-3 rounded-lg shadow-sm transition disabled:opacity-50"
          >
            {busy ? "Menyimpan…" : "+ Tambah ke Kulkas"}
          </button>

          {msg && (
            <div
              className={`text-sm font-semibold ${
                msg.type === "error" ? "text-accent" : "text-green-700"
              }`}
            >
              {msg.text}
            </div>
          )}
        </div>
      </section>

      {/* ============ INVENTORY LIST ============ */}
      <section className="bg-white border border-amber-100 rounded-2xl shadow-sm">
        <header className="px-7 pt-6 pb-4 border-b border-amber-50 flex justify-between items-end">
          <div>
            <h2 className="text-xl font-bold">Isi Kulkasmu</h2>
            <p className="text-sm text-ink-muted mt-1">
              {inventory.length} bahan tersimpan
            </p>
          </div>
          {inventory.length > 0 && (
            <button
              onClick={handleClearAll}
              className="text-xs px-3 py-1.5 border border-amber-100 rounded-lg text-ink-muted hover:text-accent hover:border-accent transition"
            >
              Kosongkan
            </button>
          )}
        </header>

        <div className="p-4 space-y-2 max-h-[500px] overflow-y-auto">
          {inventory.length === 0 ? (
            <div className="text-center py-16 text-ink-soft">
              <div className="text-5xl mb-3">🧊</div>
              <p className="text-sm">
                Kulkasmu masih kosong.
                <br />
                Tambahkan bahan di sebelah kiri untuk mulai.
              </p>
            </div>
          ) : (
            inventory.map((item) => {
              const def = ingredientMap.get(item.ingredient_name);
              return (
                <InventoryItemRow
                  key={item.id}
                  item={item}
                  def={def}
                  onDelete={() => handleDelete(item.id)}
                  onEdit={(newWeight) => handleEditWeight(item, newWeight)}
                />
              );
            })
          )}
        </div>
      </section>
    </div>
  );
}

/* ---------- Sub-component: row dengan inline edit ---------- */
function InventoryItemRow({
  item,
  def,
  onDelete,
  onEdit,
}: {
  item: InventoryItem;
  def: Ingredient | undefined;
  onDelete: () => void;
  onEdit: (newWeight: number) => void;
}) {
  const [editing, setEditing] = useState(false);
  const [editValue, setEditValue] = useState(String(Math.round(item.weight * 100) / 100));

  const baseUnit = def?.base_unit ?? "";

  function saveEdit() {
    const w = parseFloat(editValue);
    if (w > 0) onEdit(w);
    setEditing(false);
  }

  return (
    <div className="flex items-center gap-3 p-3 bg-cream border border-amber-50 rounded-lg hover:border-primary transition">
      <div className="w-10 h-10 flex items-center justify-center bg-white rounded text-2xl shrink-0">
        {def?.emoji || "🍽️"}
      </div>
      <div className="flex-1 min-w-0">
        <div className="font-bold text-sm">
          {item.ingredient_name}
          {def?.is_base && (
            <span className="text-[10px] text-accent font-semibold ml-2">· Bumbu Dasar</span>
          )}
        </div>
        {editing ? (
          <div className="flex items-center gap-1 mt-0.5">
            <input
              type="number"
              step="0.01"
              min="0"
              value={editValue}
              onChange={(e) => setEditValue(e.target.value)}
              onKeyDown={(e) => e.key === "Enter" && saveEdit()}
              autoFocus
              className="w-20 px-2 py-0.5 text-sm border border-amber-200 rounded"
            />
            <span className="text-xs text-ink-muted">{baseUnit}</span>
          </div>
        ) : (
          <div className="text-sm text-ink-muted tabular-nums">
            {formatQty(item.weight, baseUnit)}
          </div>
        )}
      </div>
      <div className="flex gap-1">
        {editing ? (
          <button
            onClick={saveEdit}
            className="w-8 h-8 flex items-center justify-center rounded text-green-700 hover:bg-green-50"
            title="Simpan"
          >
            ✓
          </button>
        ) : (
          <button
            onClick={() => setEditing(true)}
            className="w-8 h-8 flex items-center justify-center rounded text-ink-soft hover:text-accent hover:bg-accent/5"
            title="Edit"
          >
            ✎
          </button>
        )}
        <button
          onClick={onDelete}
          className="w-8 h-8 flex items-center justify-center rounded text-ink-soft hover:text-accent hover:bg-accent/5"
          title="Hapus"
        >
          🗑
        </button>
      </div>
    </div>
  );
}
