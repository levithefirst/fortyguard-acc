// Server-side only. Never import this file from a client component.
import { neon } from "@neondatabase/serverless";

if (!process.env.DATABASE_URL) {
  throw new Error("DATABASE_URL is not set — check .env.local against .env.example");
}

export const sql = neon(process.env.DATABASE_URL);
