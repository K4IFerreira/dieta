import Link from "next/link";

export default function Home() {
  return (
    <main>
      <h1>Dieta & Treinos</h1>
      <p>MVP inicial em Next.js + Prisma.</p>
      <ul>
        <li>
          <Link href="/foods">Cadastro de alimentos</Link>
        </li>
      </ul>
    </main>
  );
}
