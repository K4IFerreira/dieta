import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { createFoodSchema } from "@/lib/food-schema";

export async function GET(request: NextRequest) {
  const userId = request.nextUrl.searchParams.get("userId");

  if (!userId) {
    return NextResponse.json({ error: "userId é obrigatório" }, { status: 400 });
  }

  const foods = await prisma.food.findMany({
    where: { userId },
    orderBy: { createdAt: "desc" }
  });

  return NextResponse.json(foods);
}

export async function POST(request: NextRequest) {
  const body = await request.json();
  const parsed = createFoodSchema.safeParse(body);

  if (!parsed.success) {
    return NextResponse.json(
      { error: "Dados inválidos", details: parsed.error.flatten() },
      { status: 400 }
    );
  }

  const { userId, ...foodData } = parsed.data;

  await prisma.user.upsert({
    where: { email: `${userId}@demo.local` },
    update: {},
    create: {
      id: userId,
      email: `${userId}@demo.local`,
      passwordHash: "demo-password-hash"
    }
  });

  const food = await prisma.food.create({
    data: {
      userId,
      ...foodData
    }
  });

  return NextResponse.json(food, { status: 201 });
}
