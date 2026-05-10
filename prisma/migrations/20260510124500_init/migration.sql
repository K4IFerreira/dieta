-- CreateEnum
CREATE TYPE "MealType" AS ENUM ('BREAKFAST', 'LUNCH', 'DINNER', 'SNACK');
CREATE TYPE "WorkoutType" AS ENUM ('STRENGTH', 'RUN', 'CARDIO', 'MOBILITY', 'OTHER');
CREATE TYPE "FoodCategory" AS ENUM ('CARB', 'PROTEIN', 'FAT', 'FRUIT', 'VEGETABLE', 'DAIRY', 'OTHER');

-- CreateTable
CREATE TABLE "User" (
  "id" TEXT PRIMARY KEY,
  "name" TEXT,
  "email" TEXT NOT NULL UNIQUE,
  "passwordHash" TEXT NOT NULL,
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "Food" (
  "id" TEXT PRIMARY KEY,
  "userId" TEXT NOT NULL,
  "name" TEXT NOT NULL,
  "category" "FoodCategory",
  "unit" TEXT NOT NULL,
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "Food_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE "FoodPurchase" (
  "id" TEXT PRIMARY KEY,
  "userId" TEXT NOT NULL,
  "foodId" TEXT NOT NULL,
  "quantity" DECIMAL(10,2) NOT NULL,
  "unitPrice" DECIMAL(10,2) NOT NULL,
  "purchaseDate" TIMESTAMP(3) NOT NULL,
  "expirationDate" TIMESTAMP(3),
  "notes" TEXT,
  CONSTRAINT "FoodPurchase_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "FoodPurchase_foodId_fkey" FOREIGN KEY ("foodId") REFERENCES "Food"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE "Meal" (
  "id" TEXT PRIMARY KEY,
  "userId" TEXT NOT NULL,
  "mealType" "MealType" NOT NULL,
  "consumedAt" TIMESTAMP(3) NOT NULL,
  "notes" TEXT,
  CONSTRAINT "Meal_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE "MealItem" (
  "id" TEXT PRIMARY KEY,
  "mealId" TEXT NOT NULL,
  "foodId" TEXT NOT NULL,
  "quantity" DECIMAL(10,2) NOT NULL,
  "calories" INTEGER,
  "proteinG" DECIMAL(8,2),
  "carbsG" DECIMAL(8,2),
  "fatG" DECIMAL(8,2),
  CONSTRAINT "MealItem_mealId_fkey" FOREIGN KEY ("mealId") REFERENCES "Meal"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "MealItem_foodId_fkey" FOREIGN KEY ("foodId") REFERENCES "Food"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE "Workout" (
  "id" TEXT PRIMARY KEY,
  "userId" TEXT NOT NULL,
  "workoutType" "WorkoutType" NOT NULL,
  "startedAt" TIMESTAMP(3) NOT NULL,
  "durationMin" INTEGER,
  "notes" TEXT,
  CONSTRAINT "Workout_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE "WorkoutExercise" (
  "id" TEXT PRIMARY KEY,
  "workoutId" TEXT NOT NULL,
  "name" TEXT NOT NULL,
  "sets" INTEGER,
  "reps" INTEGER,
  "loadKg" DECIMAL(8,2),
  "durationMin" INTEGER,
  CONSTRAINT "WorkoutExercise_workoutId_fkey" FOREIGN KEY ("workoutId") REFERENCES "Workout"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE "BodyMeasurement" (
  "id" TEXT PRIMARY KEY,
  "userId" TEXT NOT NULL,
  "measuredAt" TIMESTAMP(3) NOT NULL,
  "weightKg" DECIMAL(5,2),
  "bodyFatPct" DECIMAL(5,2),
  "chestCm" DECIMAL(5,2),
  "waistCm" DECIMAL(5,2),
  "hipCm" DECIMAL(5,2),
  "armCm" DECIMAL(5,2),
  "thighCm" DECIMAL(5,2),
  "notes" TEXT,
  CONSTRAINT "BodyMeasurement_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "Food_userId_idx" ON "Food"("userId");
CREATE INDEX "FoodPurchase_userId_purchaseDate_idx" ON "FoodPurchase"("userId", "purchaseDate");
CREATE INDEX "FoodPurchase_foodId_idx" ON "FoodPurchase"("foodId");
CREATE INDEX "Meal_userId_consumedAt_idx" ON "Meal"("userId", "consumedAt");
CREATE INDEX "MealItem_mealId_idx" ON "MealItem"("mealId");
CREATE INDEX "MealItem_foodId_idx" ON "MealItem"("foodId");
CREATE INDEX "Workout_userId_startedAt_idx" ON "Workout"("userId", "startedAt");
CREATE INDEX "WorkoutExercise_workoutId_idx" ON "WorkoutExercise"("workoutId");
CREATE INDEX "BodyMeasurement_userId_measuredAt_idx" ON "BodyMeasurement"("userId", "measuredAt");
