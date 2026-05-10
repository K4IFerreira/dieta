"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

const categories = ["CARB", "PROTEIN", "FAT", "FRUIT", "VEGETABLE", "DAIRY", "OTHER"] as const;

export function FoodForm() {
  const router = useRouter();
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function onSubmit(formData: FormData) {
    setLoading(true);
    setError(null);

    const payload = {
      userId: "demo-user",
      name: String(formData.get("name") ?? ""),
      unit: String(formData.get("unit") ?? ""),
      category: String(formData.get("category") ?? "") || undefined
    };

    const res = await fetch("/api/foods", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload)
    });

    if (!res.ok) {
      const data = await res.json();
      setError(data?.error ?? "Erro ao salvar alimento");
      setLoading(false);
      return;
    }

    router.push("/foods");
    router.refresh();
  }

  return (
    <form action={onSubmit} style={{ display: "grid", gap: 12, maxWidth: 420 }}>
      <label>
        Nome
        <input name="name" required minLength={2} />
      </label>
      <label>
        Unidade
        <input name="unit" required placeholder="g, ml, unidade" />
      </label>
      <label>
        Categoria
        <select name="category" defaultValue="">
          <option value="">Selecione</option>
          {categories.map((category) => (
            <option key={category} value={category}>
              {category}
            </option>
          ))}
        </select>
      </label>
      <button type="submit" disabled={loading}>{loading ? "Salvando..." : "Salvar"}</button>
      {error ? <p style={{ color: "crimson" }}>{error}</p> : null}
    </form>
  );
}
