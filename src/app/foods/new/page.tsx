import Link from "next/link";
import { FoodForm } from "@/components/food-form";

export default function NewFoodPage() {
  return (
    <main>
      <h1>Novo alimento</h1>
      <p><Link href="/foods">← Voltar para alimentos</Link></p>
      <FoodForm />
    </main>
  );
}
