import { z } from "zod";

export const createFoodSchema = z.object({
  name: z.string().trim().min(2, "Nome precisa ter no mínimo 2 caracteres"),
  unit: z.string().trim().min(1, "Unidade é obrigatória"),
  category: z
    .enum(["CARB", "PROTEIN", "FAT", "FRUIT", "VEGETABLE", "DAIRY", "OTHER"])
    .optional(),
  userId: z.string().trim().min(1, "userId é obrigatório")
});

export type CreateFoodInput = z.infer<typeof createFoodSchema>;
