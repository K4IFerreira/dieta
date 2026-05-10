import Link from "next/link";
import { prisma } from "@/lib/prisma";

export default async function FoodsPage() {
  const foods = await prisma.food.findMany({
    where: { userId: "demo-user" },
    orderBy: { createdAt: "desc" }
  });

  return (
    <main>
      <h1>Alimentos</h1>
      <p>
        <Link href="/">← Voltar</Link>
      </p>
      <p>
        <Link href="/foods/new">+ Cadastrar alimento</Link>
      </p>
      <ul>
        {foods.map((food) => (
          <li key={food.id}>
            {food.name} ({food.unit}) {food.category ? `- ${food.category}` : ""}
          </li>
        ))}
      </ul>
      {foods.length === 0 ? <p>Nenhum alimento cadastrado ainda.</p> : null}
    </main>
  );
}
