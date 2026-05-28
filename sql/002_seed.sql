-- ============================================================
-- YellowBite — Seed Data (master ingredients + recipes)
-- Jalankan SETELAH 001_schema.sql
-- ============================================================

-- ---------- 1. INGREDIENTS (53 bahan) ----------
insert into public.ingredients (name, base_unit, available_units, is_base, emoji, macros) values
  ('Ayam Fillet', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🍗', '{"kcal": 1.65, "protein": 0.31, "carbs": 0, "fat": 0.036}'::jsonb),
  ('Daging Sapi', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🥩', '{"kcal": 2.5, "protein": 0.26, "carbs": 0, "fat": 0.15}'::jsonb),
  ('Ikan', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🐟', '{"kcal": 1.4, "protein": 0.22, "carbs": 0, "fat": 0.05}'::jsonb),
  ('Udang', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🦐', '{"kcal": 1.0, "protein": 0.24, "carbs": 0, "fat": 0.012}'::jsonb),
  ('Telur', 'Pcs', '{"Pcs": 1, "Gram": 0.01667}'::jsonb, false, '🥚', '{"kcal": 72, "protein": 6, "carbs": 0.4, "fat": 5}'::jsonb),
  ('Tahu', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 50}'::jsonb, false, '⬜', '{"kcal": 0.76, "protein": 0.08, "carbs": 0.019, "fat": 0.045}'::jsonb),
  ('Tempe', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 100}'::jsonb, false, '🟫', '{"kcal": 1.93, "protein": 0.19, "carbs": 0.094, "fat": 0.11}'::jsonb),
  ('Beras', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🌾', '{"kcal": 3.6, "protein": 0.07, "carbs": 0.79, "fat": 0.007}'::jsonb),
  ('Mie Telur', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 70}'::jsonb, false, '🍜', '{"kcal": 3.7, "protein": 0.13, "carbs": 0.71, "fat": 0.044}'::jsonb),
  ('Mie Instan', 'Pcs', '{"Pcs": 1}'::jsonb, false, '🍝', '{"kcal": 380, "protein": 8, "carbs": 54, "fat": 14}'::jsonb),
  ('Roti Tawar', 'Pcs', '{"Pcs": 1}'::jsonb, false, '🍞', '{"kcal": 80, "protein": 2.6, "carbs": 14, "fat": 1}'::jsonb),
  ('Kentang', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 150}'::jsonb, false, '🥔', '{"kcal": 0.77, "protein": 0.02, "carbs": 0.17, "fat": 0.001}'::jsonb),
  ('Jagung', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 200}'::jsonb, false, '🌽', '{"kcal": 0.86, "protein": 0.032, "carbs": 0.19, "fat": 0.012}'::jsonb),
  ('Tepung Terigu', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🌾', '{"kcal": 3.64, "protein": 0.1, "carbs": 0.76, "fat": 0.01}'::jsonb),
  ('Wortel', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 100}'::jsonb, false, '🥕', '{"kcal": 0.41, "protein": 0.009, "carbs": 0.096, "fat": 0.002}'::jsonb),
  ('Kangkung', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🥬', '{"kcal": 0.19, "protein": 0.026, "carbs": 0.036, "fat": 0.002}'::jsonb),
  ('Bayam', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🥬', '{"kcal": 0.23, "protein": 0.029, "carbs": 0.036, "fat": 0.004}'::jsonb),
  ('Sawi', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🥬', '{"kcal": 0.19, "protein": 0.022, "carbs": 0.034, "fat": 0.002}'::jsonb),
  ('Brokoli', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🥦', '{"kcal": 0.34, "protein": 0.028, "carbs": 0.066, "fat": 0.004}'::jsonb),
  ('Kol', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🥬', '{"kcal": 0.25, "protein": 0.013, "carbs": 0.058, "fat": 0.001}'::jsonb),
  ('Kacang Panjang', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🫛', '{"kcal": 0.47, "protein": 0.027, "carbs": 0.08, "fat": 0.004}'::jsonb),
  ('Buncis', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🫛', '{"kcal": 0.31, "protein": 0.018, "carbs": 0.07, "fat": 0.001}'::jsonb),
  ('Tauge', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, false, '🌱', '{"kcal": 0.3, "protein": 0.03, "carbs": 0.06, "fat": 0.002}'::jsonb),
  ('Tomat', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 100}'::jsonb, false, '🍅', '{"kcal": 0.18, "protein": 0.009, "carbs": 0.039, "fat": 0.002}'::jsonb),
  ('Mentimun', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 200}'::jsonb, false, '🥒', '{"kcal": 0.16, "protein": 0.007, "carbs": 0.036, "fat": 0.001}'::jsonb),
  ('Labu Siam', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 250}'::jsonb, false, '🥒', '{"kcal": 0.19, "protein": 0.008, "carbs": 0.045, "fat": 0.001}'::jsonb),
  ('Terong', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 150}'::jsonb, false, '🍆', '{"kcal": 0.25, "protein": 0.01, "carbs": 0.059, "fat": 0.002}'::jsonb),
  ('Daun Bawang', 'Gram', '{"Gram": 1, "Pcs": 15}'::jsonb, false, '🌿', '{"kcal": 0.32, "protein": 0.018, "carbs": 0.073, "fat": 0.002}'::jsonb),
  ('Bawang Merah', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 8}'::jsonb, false, '🧅', '{"kcal": 0.42, "protein": 0.013, "carbs": 0.094, "fat": 0.001}'::jsonb),
  ('Bawang Putih', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 5}'::jsonb, false, '🧄', '{"kcal": 1.49, "protein": 0.064, "carbs": 0.331, "fat": 0.005}'::jsonb),
  ('Cabe Merah', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 5}'::jsonb, false, '🌶️', '{"kcal": 0.4, "protein": 0.018, "carbs": 0.087, "fat": 0.004}'::jsonb),
  ('Cabe Rawit', 'Gram', '{"Gram": 1, "Kg": 1000, "Pcs": 2}'::jsonb, false, '🌶️', '{"kcal": 0.4, "protein": 0.02, "carbs": 0.087, "fat": 0.004}'::jsonb),
  ('Jahe', 'Gram', '{"Gram": 1}'::jsonb, false, '🫚', '{"kcal": 0.8, "protein": 0.018, "carbs": 0.178, "fat": 0.008}'::jsonb),
  ('Kunyit', 'Gram', '{"Gram": 1}'::jsonb, false, '🟡', '{"kcal": 3.12, "protein": 0.097, "carbs": 0.679, "fat": 0.03}'::jsonb),
  ('Lengkuas', 'Gram', '{"Gram": 1}'::jsonb, false, '🟤', '{"kcal": 0.8, "protein": 0.018, "carbs": 0.178, "fat": 0.008}'::jsonb),
  ('Sereh', 'Pcs', '{"Pcs": 1}'::jsonb, false, '🌾', '{"kcal": 0, "protein": 0, "carbs": 0, "fat": 0}'::jsonb),
  ('Daun Salam', 'Pcs', '{"Pcs": 1}'::jsonb, false, '🍃', '{"kcal": 0, "protein": 0, "carbs": 0, "fat": 0}'::jsonb),
  ('Daun Jeruk', 'Pcs', '{"Pcs": 1}'::jsonb, false, '🍃', '{"kcal": 0, "protein": 0, "carbs": 0, "fat": 0}'::jsonb),
  ('Kemiri', 'Pcs', '{"Pcs": 1}'::jsonb, false, '🌰', '{"kcal": 22, "protein": 0.5, "carbs": 0.5, "fat": 2}'::jsonb),
  ('Susu', 'ml', '{"ml": 1, "Liter": 1000}'::jsonb, false, '🥛', '{"kcal": 0.42, "protein": 0.034, "carbs": 0.05, "fat": 0.01}'::jsonb),
  ('Keju', 'Gram', '{"Gram": 1}'::jsonb, false, '🧀', '{"kcal": 4.02, "protein": 0.225, "carbs": 0.013, "fat": 0.33}'::jsonb),
  ('Mentega', 'Gram', '{"Gram": 1}'::jsonb, false, '🧈', '{"kcal": 7.17, "protein": 0.009, "carbs": 0.001, "fat": 0.811}'::jsonb),
  ('Pisang', 'Pcs', '{"Pcs": 1, "Gram": 0.00833}'::jsonb, false, '🍌', '{"kcal": 105, "protein": 1.3, "carbs": 27, "fat": 0.4}'::jsonb),
  ('Garam', 'Gram', '{"Gram": 1}'::jsonb, true, '🧂', '{"kcal": 0, "protein": 0, "carbs": 0, "fat": 0}'::jsonb),
  ('Gula', 'Gram', '{"Gram": 1, "Kg": 1000}'::jsonb, true, '🍚', '{"kcal": 4.0, "protein": 0, "carbs": 1.0, "fat": 0}'::jsonb),
  ('Merica', 'Gram', '{"Gram": 1}'::jsonb, true, '⚫', '{"kcal": 2.55, "protein": 0.105, "carbs": 0.643, "fat": 0.033}'::jsonb),
  ('Minyak Goreng', 'ml', '{"ml": 1, "Liter": 1000}'::jsonb, true, '🛢️', '{"kcal": 8.84, "protein": 0, "carbs": 0, "fat": 1.0}'::jsonb),
  ('Kecap Manis', 'ml', '{"ml": 1, "Liter": 1000}'::jsonb, true, '🍶', '{"kcal": 1.5, "protein": 0.05, "carbs": 0.32, "fat": 0}'::jsonb),
  ('Kecap Asin', 'ml', '{"ml": 1, "Liter": 1000}'::jsonb, true, '🍶', '{"kcal": 0.6, "protein": 0.087, "carbs": 0.045, "fat": 0}'::jsonb),
  ('Saus Tiram', 'ml', '{"ml": 1}'::jsonb, true, '🦪', '{"kcal": 0.51, "protein": 0.014, "carbs": 0.11, "fat": 0}'::jsonb),
  ('Saus Sambal', 'ml', '{"ml": 1}'::jsonb, true, '🌶️', '{"kcal": 1.0, "protein": 0.025, "carbs": 0.25, "fat": 0}'::jsonb),
  ('Tepung Beras', 'Gram', '{"Gram": 1}'::jsonb, true, '🌾', '{"kcal": 3.66, "protein": 0.058, "carbs": 0.802, "fat": 0.014}'::jsonb),
  ('Air', 'ml', '{"ml": 1, "Liter": 1000}'::jsonb, true, '💧', '{"kcal": 0, "protein": 0, "carbs": 0, "fat": 0}'::jsonb);

-- ---------- 2. RECIPES (24 resep) ----------
insert into public.recipes (recipe_name, meal_type, hero_emoji, hero_gradient, instructions) values
  ('Nasi Goreng Sederhana', 'Sarapan', '🍳', '["#FFE082", "#FFB300"]'::jsonb, '1. Panaskan minyak, tumis bawang putih hingga harum. 2. Masukkan telur, orak-arik. 3. Tambahkan nasi, aduk rata. 4. Tuang kecap manis dan garam, aduk hingga merata. 5. Sajikan hangat.'),
  ('Telur Dadar Spesial', 'Sarapan', '🥚', '["#FFF59D", "#FBC02D"]'::jsonb, '1. Kocok telur dengan irisan daun bawang dan bawang merah. 2. Tambahkan garam dan merica secukupnya. 3. Panaskan minyak di wajan datar. 4. Tuang adonan telur, masak hingga matang kedua sisi. 5. Sajikan.'),
  ('Bubur Ayam Sederhana', 'Sarapan', '🍲', '["#FFECB3", "#FFA000"]'::jsonb, '1. Rebus beras dengan banyak air hingga menjadi bubur lembut. 2. Suwir ayam fillet yang sudah direbus. 3. Tumis bawang putih halus, campurkan ke bubur. 4. Tambahkan garam. 5. Sajikan dengan suwiran ayam di atasnya.'),
  ('Roti Bakar Keju', 'Sarapan', '🍞', '["#FFE0B2", "#FB8C00"]'::jsonb, '1. Olesi roti tawar dengan mentega di kedua sisi. 2. Panggang di wajan datar hingga kecoklatan. 3. Taburi parutan keju di atasnya. 4. Tutup sebentar agar keju meleleh. 5. Sajikan dengan susu hangat.'),
  ('Pancake Pisang', 'Sarapan', '🥞', '["#FFF8E1", "#FFB300"]'::jsonb, '1. Haluskan pisang dengan garpu. 2. Campur dengan tepung terigu, telur, susu, dan gula. 3. Aduk hingga adonan halus. 4. Panaskan wajan, tuang adonan satu sendok per pancake. 5. Balik saat permukaan berbuih. Sajikan hangat.'),
  ('Mie Goreng Pagi', 'Sarapan', '🍜', '["#FFE082", "#F57C00"]'::jsonb, '1. Rebus mie telur hingga matang, tiriskan. 2. Tumis bawang putih dan sawi cincang. 3. Masukkan mie, telur kocok, dan kecap manis. 4. Aduk rata hingga matang. 5. Sajikan dengan taburan bawang goreng.'),
  ('Nasi Telur Kecap', 'Sarapan', '🍚', '["#FFECB3", "#F9A825"]'::jsonb, '1. Goreng telur mata sapi atau ceplok. 2. Iris tipis bawang merah, tumis sebentar dengan kecap manis. 3. Siramkan ke atas nasi hangat. 4. Letakkan telur di atasnya. 5. Sajikan segera.'),
  ('Omelet Sayur', 'Sarapan', '🍳', '["#FFF59D", "#FFB300"]'::jsonb, '1. Cincang wortel dan daun bawang. 2. Kocok telur, campur dengan sayuran. 3. Tambahkan garam dan merica. 4. Panaskan minyak, masak omelet hingga kedua sisi matang. 5. Sajikan.'),
  ('Ayam Goreng + Nasi', 'Siang', '🍗', '["#FFB300", "#E65100"]'::jsonb, '1. Marinasi ayam dengan bawang putih halus, garam, dan merica selama 15 menit. 2. Goreng dalam minyak panas hingga keemasan. 3. Masak nasi terpisah. 4. Sajikan ayam goreng dengan nasi hangat dan mentimun iris.'),
  ('Soto Ayam Sederhana', 'Siang', '🍜', '["#FFD54F", "#E65100"]'::jsonb, '1. Rebus ayam dengan jahe, kunyit, dan daun salam. 2. Suwir ayam, sisihkan kaldu. 3. Tumis bawang putih dan merah hingga harum, masukkan ke kaldu. 4. Sajikan dengan nasi, suwiran ayam, dan taburan daun bawang.'),
  ('Capcay Kuah', 'Siang', '🥦', '["#C5E1A5", "#558B2F"]'::jsonb, '1. Potong sayuran (wortel, brokoli, sawi, kol). 2. Tumis bawang putih hingga harum. 3. Masukkan wortel dulu (paling keras), lalu sayuran lain. 4. Tambahkan air, saus tiram, dan garam. 5. Masak hingga matang tapi tetap renyah.'),
  ('Tumis Kangkung Bawang Putih', 'Siang', '🥬', '["#AED581", "#388E3C"]'::jsonb, '1. Cuci dan potong kangkung. 2. Iris bawang putih dan cabe rawit. 3. Tumis bumbu hingga harum. 4. Masukkan kangkung, aduk cepat. 5. Tambahkan saus tiram dan garam. Sajikan segera.'),
  ('Mie Ayam Rumahan', 'Siang', '🍜', '["#FFCC80", "#E65100"]'::jsonb, '1. Rebus mie telur, tiriskan. 2. Tumis ayam cincang dengan bawang putih dan kecap asin. 3. Rebus sawi sebentar. 4. Susun mie, ayam, dan sawi di mangkuk. 5. Siram dengan kuah kaldu hangat.'),
  ('Sup Ayam Wortel Kentang', 'Siang', '🥕', '["#FFB74D", "#E65100"]'::jsonb, '1. Rebus ayam fillet hingga empuk. 2. Potong wortel dan kentang dadu. 3. Masukkan ke kaldu, tambahkan bawang putih halus. 4. Bumbui dengan garam dan merica. 5. Sajikan dengan taburan daun bawang.'),
  ('Nasi Goreng Spesial', 'Siang', '🍛', '["#FFB300", "#BF360C"]'::jsonb, '1. Tumis bawang merah dan bawang putih hingga harum. 2. Masukkan ayam cincang, masak hingga matang. 3. Tambahkan telur orak-arik. 4. Masukkan nasi, kecap manis, dan garam. Aduk rata. 5. Sajikan dengan acar mentimun.'),
  ('Orak-Arik Telur Tomat', 'Siang', '🍅', '["#FF8A65", "#D84315"]'::jsonb, '1. Potong tomat dadu, iris bawang merah. 2. Tumis bawang merah hingga harum. 3. Masukkan tomat, masak hingga layu. 4. Tuang telur kocok, aduk hingga matang merata. 5. Bumbui garam. Sajikan dengan nasi.'),
  ('Ikan Goreng Sambal', 'Malam', '🐟', '["#FF7043", "#BF360C"]'::jsonb, '1. Lumuri ikan dengan garam dan kunyit. 2. Goreng hingga keemasan. 3. Untuk sambal: ulek cabe merah, bawang merah, tomat, garam. 4. Tumis sambal sebentar. 5. Sajikan ikan dengan sambal dan nasi hangat.'),
  ('Sayur Asem Segar', 'Malam', '🌽', '["#DCE775", "#7CB342"]'::jsonb, '1. Rebus air dengan bawang merah ulek dan daun salam. 2. Masukkan jagung dan labu siam (paling lama matang). 3. Tambahkan kacang panjang. 4. Bumbui dengan gula dan garam. 5. Sajikan hangat dengan nasi.'),
  ('Ayam Bakar Kecap', 'Malam', '🍗', '["#FF8F00", "#3E2723"]'::jsonb, '1. Marinasi ayam dengan bawang putih halus, kecap manis, dan garam selama 30 menit. 2. Bakar di atas teflon atau panggangan. 3. Olesi sisa bumbu marinasi berkala. 4. Bakar hingga matang merata. 5. Sajikan dengan nasi.'),
  ('Tumis Tempe Cabe Hijau', 'Malam', '🟫', '["#A1887F", "#4E342E"]'::jsonb, '1. Potong tempe dadu, goreng setengah matang. 2. Iris bawang merah dan cabe. 3. Tumis bumbu hingga harum. 4. Masukkan tempe, aduk rata. 5. Tambahkan kecap manis dan sedikit air. Masak hingga meresap.'),
  ('Sambal Goreng Tahu', 'Malam', '⬜', '["#FF8A65", "#BF360C"]'::jsonb, '1. Potong tahu dadu, goreng hingga kuning keemasan. 2. Ulek cabe merah, bawang merah, tomat. 3. Tumis sambal hingga harum. 4. Masukkan tahu, aduk rata. 5. Bumbui gula dan garam. Sajikan dengan nasi.'),
  ('Sup Bayam Jagung', 'Malam', '🥬', '["#A5D6A7", "#2E7D32"]'::jsonb, '1. Rebus air dengan bawang merah geprek. 2. Masukkan jagung pipil, masak 5 menit. 3. Tambahkan bayam, masak sebentar saja. 4. Bumbui dengan garam dan gula. 5. Sajikan segera selagi hangat.'),
  ('Nasi Tahu Tumis Kecap', 'Malam', '🍱', '["#FFCC80", "#5D4037"]'::jsonb, '1. Potong tahu dadu, goreng hingga keemasan. 2. Tumis bawang putih hingga harum. 3. Masukkan tahu, kecap manis, dan sedikit air. 4. Masak hingga meresap. 5. Sajikan dengan nasi hangat.'),
  ('Telur Balado', 'Malam', '🥚', '["#FF7043", "#BF360C"]'::jsonb, '1. Rebus telur, kupas, goreng sebentar. 2. Ulek cabe merah, bawang merah, tomat. 3. Tumis bumbu balado hingga harum dan minyak keluar. 4. Masukkan telur, aduk rata. 5. Bumbui garam dan gula. Sajikan dengan nasi.');

-- ---------- 3. RECIPE_INGREDIENTS ----------
-- Insert tiap komposisi dengan lookup recipe_id berdasarkan recipe_name

-- Nasi Goreng Sederhana
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Beras', 100 from public.recipes where recipe_name = 'Nasi Goreng Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Telur', 1 from public.recipes where recipe_name = 'Nasi Goreng Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 10 from public.recipes where recipe_name = 'Nasi Goreng Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kecap Manis', 15 from public.recipes where recipe_name = 'Nasi Goreng Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 10 from public.recipes where recipe_name = 'Nasi Goreng Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 2 from public.recipes where recipe_name = 'Nasi Goreng Sederhana';

-- Telur Dadar Spesial
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Telur', 2 from public.recipes where recipe_name = 'Telur Dadar Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Daun Bawang', 15 from public.recipes where recipe_name = 'Telur Dadar Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Merah', 8 from public.recipes where recipe_name = 'Telur Dadar Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 2 from public.recipes where recipe_name = 'Telur Dadar Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Merica', 1 from public.recipes where recipe_name = 'Telur Dadar Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 8 from public.recipes where recipe_name = 'Telur Dadar Spesial';

-- Bubur Ayam Sederhana
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Beras', 80 from public.recipes where recipe_name = 'Bubur Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Ayam Fillet', 100 from public.recipes where recipe_name = 'Bubur Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 8 from public.recipes where recipe_name = 'Bubur Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Daun Bawang', 10 from public.recipes where recipe_name = 'Bubur Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 3 from public.recipes where recipe_name = 'Bubur Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Air', 500 from public.recipes where recipe_name = 'Bubur Ayam Sederhana';

-- Roti Bakar Keju
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Roti Tawar', 2 from public.recipes where recipe_name = 'Roti Bakar Keju';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Keju', 30 from public.recipes where recipe_name = 'Roti Bakar Keju';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Mentega', 15 from public.recipes where recipe_name = 'Roti Bakar Keju';

-- Pancake Pisang
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Tepung Terigu', 100 from public.recipes where recipe_name = 'Pancake Pisang';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Pisang', 2 from public.recipes where recipe_name = 'Pancake Pisang';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Telur', 1 from public.recipes where recipe_name = 'Pancake Pisang';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Susu', 150 from public.recipes where recipe_name = 'Pancake Pisang';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Gula', 20 from public.recipes where recipe_name = 'Pancake Pisang';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Mentega', 10 from public.recipes where recipe_name = 'Pancake Pisang';

-- Mie Goreng Pagi
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Mie Telur', 100 from public.recipes where recipe_name = 'Mie Goreng Pagi';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Telur', 1 from public.recipes where recipe_name = 'Mie Goreng Pagi';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Sawi', 50 from public.recipes where recipe_name = 'Mie Goreng Pagi';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 8 from public.recipes where recipe_name = 'Mie Goreng Pagi';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kecap Manis', 15 from public.recipes where recipe_name = 'Mie Goreng Pagi';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 10 from public.recipes where recipe_name = 'Mie Goreng Pagi';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 2 from public.recipes where recipe_name = 'Mie Goreng Pagi';

-- Nasi Telur Kecap
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Beras', 100 from public.recipes where recipe_name = 'Nasi Telur Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Telur', 2 from public.recipes where recipe_name = 'Nasi Telur Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Merah', 16 from public.recipes where recipe_name = 'Nasi Telur Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kecap Manis', 20 from public.recipes where recipe_name = 'Nasi Telur Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 10 from public.recipes where recipe_name = 'Nasi Telur Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 1 from public.recipes where recipe_name = 'Nasi Telur Kecap';

-- Omelet Sayur
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Telur', 2 from public.recipes where recipe_name = 'Omelet Sayur';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Wortel', 30 from public.recipes where recipe_name = 'Omelet Sayur';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Daun Bawang', 10 from public.recipes where recipe_name = 'Omelet Sayur';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 2 from public.recipes where recipe_name = 'Omelet Sayur';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Merica', 1 from public.recipes where recipe_name = 'Omelet Sayur';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 8 from public.recipes where recipe_name = 'Omelet Sayur';

-- Ayam Goreng + Nasi
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Ayam Fillet', 200 from public.recipes where recipe_name = 'Ayam Goreng + Nasi';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Beras', 150 from public.recipes where recipe_name = 'Ayam Goreng + Nasi';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 10 from public.recipes where recipe_name = 'Ayam Goreng + Nasi';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Mentimun', 50 from public.recipes where recipe_name = 'Ayam Goreng + Nasi';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 5 from public.recipes where recipe_name = 'Ayam Goreng + Nasi';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Merica', 2 from public.recipes where recipe_name = 'Ayam Goreng + Nasi';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 100 from public.recipes where recipe_name = 'Ayam Goreng + Nasi';

-- Soto Ayam Sederhana
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Ayam Fillet', 200 from public.recipes where recipe_name = 'Soto Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Beras', 100 from public.recipes where recipe_name = 'Soto Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 10 from public.recipes where recipe_name = 'Soto Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Merah', 16 from public.recipes where recipe_name = 'Soto Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kunyit', 5 from public.recipes where recipe_name = 'Soto Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Jahe', 5 from public.recipes where recipe_name = 'Soto Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Daun Salam', 2 from public.recipes where recipe_name = 'Soto Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Daun Bawang', 15 from public.recipes where recipe_name = 'Soto Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 5 from public.recipes where recipe_name = 'Soto Ayam Sederhana';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Air', 800 from public.recipes where recipe_name = 'Soto Ayam Sederhana';

-- Capcay Kuah
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Wortel', 80 from public.recipes where recipe_name = 'Capcay Kuah';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Brokoli', 100 from public.recipes where recipe_name = 'Capcay Kuah';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Sawi', 80 from public.recipes where recipe_name = 'Capcay Kuah';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kol', 80 from public.recipes where recipe_name = 'Capcay Kuah';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 10 from public.recipes where recipe_name = 'Capcay Kuah';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Saus Tiram', 15 from public.recipes where recipe_name = 'Capcay Kuah';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 3 from public.recipes where recipe_name = 'Capcay Kuah';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 15 from public.recipes where recipe_name = 'Capcay Kuah';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Air', 200 from public.recipes where recipe_name = 'Capcay Kuah';

-- Tumis Kangkung Bawang Putih
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kangkung', 200 from public.recipes where recipe_name = 'Tumis Kangkung Bawang Putih';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 10 from public.recipes where recipe_name = 'Tumis Kangkung Bawang Putih';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Cabe Rawit', 5 from public.recipes where recipe_name = 'Tumis Kangkung Bawang Putih';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Saus Tiram', 10 from public.recipes where recipe_name = 'Tumis Kangkung Bawang Putih';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 2 from public.recipes where recipe_name = 'Tumis Kangkung Bawang Putih';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 15 from public.recipes where recipe_name = 'Tumis Kangkung Bawang Putih';

-- Mie Ayam Rumahan
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Mie Telur', 100 from public.recipes where recipe_name = 'Mie Ayam Rumahan';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Ayam Fillet', 100 from public.recipes where recipe_name = 'Mie Ayam Rumahan';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Sawi', 50 from public.recipes where recipe_name = 'Mie Ayam Rumahan';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 10 from public.recipes where recipe_name = 'Mie Ayam Rumahan';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Daun Bawang', 10 from public.recipes where recipe_name = 'Mie Ayam Rumahan';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kecap Asin', 15 from public.recipes where recipe_name = 'Mie Ayam Rumahan';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 3 from public.recipes where recipe_name = 'Mie Ayam Rumahan';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 10 from public.recipes where recipe_name = 'Mie Ayam Rumahan';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Air', 400 from public.recipes where recipe_name = 'Mie Ayam Rumahan';

-- Sup Ayam Wortel Kentang
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Ayam Fillet', 150 from public.recipes where recipe_name = 'Sup Ayam Wortel Kentang';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Wortel', 100 from public.recipes where recipe_name = 'Sup Ayam Wortel Kentang';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kentang', 150 from public.recipes where recipe_name = 'Sup Ayam Wortel Kentang';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 10 from public.recipes where recipe_name = 'Sup Ayam Wortel Kentang';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Daun Bawang', 10 from public.recipes where recipe_name = 'Sup Ayam Wortel Kentang';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 5 from public.recipes where recipe_name = 'Sup Ayam Wortel Kentang';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Merica', 2 from public.recipes where recipe_name = 'Sup Ayam Wortel Kentang';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Air', 600 from public.recipes where recipe_name = 'Sup Ayam Wortel Kentang';

-- Nasi Goreng Spesial
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Beras', 150 from public.recipes where recipe_name = 'Nasi Goreng Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Telur', 1 from public.recipes where recipe_name = 'Nasi Goreng Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Ayam Fillet', 100 from public.recipes where recipe_name = 'Nasi Goreng Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Merah', 16 from public.recipes where recipe_name = 'Nasi Goreng Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 10 from public.recipes where recipe_name = 'Nasi Goreng Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Mentimun', 50 from public.recipes where recipe_name = 'Nasi Goreng Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kecap Manis', 20 from public.recipes where recipe_name = 'Nasi Goreng Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 3 from public.recipes where recipe_name = 'Nasi Goreng Spesial';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 15 from public.recipes where recipe_name = 'Nasi Goreng Spesial';

-- Orak-Arik Telur Tomat
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Telur', 3 from public.recipes where recipe_name = 'Orak-Arik Telur Tomat';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Tomat', 150 from public.recipes where recipe_name = 'Orak-Arik Telur Tomat';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Merah', 16 from public.recipes where recipe_name = 'Orak-Arik Telur Tomat';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Beras', 100 from public.recipes where recipe_name = 'Orak-Arik Telur Tomat';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 3 from public.recipes where recipe_name = 'Orak-Arik Telur Tomat';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 10 from public.recipes where recipe_name = 'Orak-Arik Telur Tomat';

-- Ikan Goreng Sambal
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Ikan', 250 from public.recipes where recipe_name = 'Ikan Goreng Sambal';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Beras', 100 from public.recipes where recipe_name = 'Ikan Goreng Sambal';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Cabe Merah', 25 from public.recipes where recipe_name = 'Ikan Goreng Sambal';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Merah', 24 from public.recipes where recipe_name = 'Ikan Goreng Sambal';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Tomat', 50 from public.recipes where recipe_name = 'Ikan Goreng Sambal';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kunyit', 3 from public.recipes where recipe_name = 'Ikan Goreng Sambal';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 5 from public.recipes where recipe_name = 'Ikan Goreng Sambal';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 80 from public.recipes where recipe_name = 'Ikan Goreng Sambal';

-- Sayur Asem Segar
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kacang Panjang', 80 from public.recipes where recipe_name = 'Sayur Asem Segar';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Jagung', 150 from public.recipes where recipe_name = 'Sayur Asem Segar';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Labu Siam', 150 from public.recipes where recipe_name = 'Sayur Asem Segar';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Merah', 16 from public.recipes where recipe_name = 'Sayur Asem Segar';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Daun Salam', 2 from public.recipes where recipe_name = 'Sayur Asem Segar';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Gula', 5 from public.recipes where recipe_name = 'Sayur Asem Segar';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 5 from public.recipes where recipe_name = 'Sayur Asem Segar';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Air', 700 from public.recipes where recipe_name = 'Sayur Asem Segar';

-- Ayam Bakar Kecap
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Ayam Fillet', 250 from public.recipes where recipe_name = 'Ayam Bakar Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Beras', 100 from public.recipes where recipe_name = 'Ayam Bakar Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 15 from public.recipes where recipe_name = 'Ayam Bakar Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kecap Manis', 30 from public.recipes where recipe_name = 'Ayam Bakar Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 3 from public.recipes where recipe_name = 'Ayam Bakar Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Merica', 1 from public.recipes where recipe_name = 'Ayam Bakar Kecap';

-- Tumis Tempe Cabe Hijau
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Tempe', 200 from public.recipes where recipe_name = 'Tumis Tempe Cabe Hijau';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Cabe Merah', 20 from public.recipes where recipe_name = 'Tumis Tempe Cabe Hijau';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Merah', 16 from public.recipes where recipe_name = 'Tumis Tempe Cabe Hijau';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 8 from public.recipes where recipe_name = 'Tumis Tempe Cabe Hijau';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kecap Manis', 15 from public.recipes where recipe_name = 'Tumis Tempe Cabe Hijau';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 3 from public.recipes where recipe_name = 'Tumis Tempe Cabe Hijau';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 20 from public.recipes where recipe_name = 'Tumis Tempe Cabe Hijau';

-- Sambal Goreng Tahu
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Tahu', 200 from public.recipes where recipe_name = 'Sambal Goreng Tahu';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Cabe Merah', 25 from public.recipes where recipe_name = 'Sambal Goreng Tahu';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Merah', 16 from public.recipes where recipe_name = 'Sambal Goreng Tahu';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Tomat', 80 from public.recipes where recipe_name = 'Sambal Goreng Tahu';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Gula', 5 from public.recipes where recipe_name = 'Sambal Goreng Tahu';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 3 from public.recipes where recipe_name = 'Sambal Goreng Tahu';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 30 from public.recipes where recipe_name = 'Sambal Goreng Tahu';

-- Sup Bayam Jagung
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bayam', 150 from public.recipes where recipe_name = 'Sup Bayam Jagung';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Jagung', 100 from public.recipes where recipe_name = 'Sup Bayam Jagung';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Merah', 16 from public.recipes where recipe_name = 'Sup Bayam Jagung';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 5 from public.recipes where recipe_name = 'Sup Bayam Jagung';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 4 from public.recipes where recipe_name = 'Sup Bayam Jagung';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Gula', 3 from public.recipes where recipe_name = 'Sup Bayam Jagung';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Air', 600 from public.recipes where recipe_name = 'Sup Bayam Jagung';

-- Nasi Tahu Tumis Kecap
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Tahu', 200 from public.recipes where recipe_name = 'Nasi Tahu Tumis Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Beras', 100 from public.recipes where recipe_name = 'Nasi Tahu Tumis Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Putih', 10 from public.recipes where recipe_name = 'Nasi Tahu Tumis Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Daun Bawang', 10 from public.recipes where recipe_name = 'Nasi Tahu Tumis Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Kecap Manis', 25 from public.recipes where recipe_name = 'Nasi Tahu Tumis Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 2 from public.recipes where recipe_name = 'Nasi Tahu Tumis Kecap';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 20 from public.recipes where recipe_name = 'Nasi Tahu Tumis Kecap';

-- Telur Balado
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Telur', 4 from public.recipes where recipe_name = 'Telur Balado';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Cabe Merah', 25 from public.recipes where recipe_name = 'Telur Balado';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Bawang Merah', 24 from public.recipes where recipe_name = 'Telur Balado';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Tomat', 60 from public.recipes where recipe_name = 'Telur Balado';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Beras', 100 from public.recipes where recipe_name = 'Telur Balado';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Garam', 3 from public.recipes where recipe_name = 'Telur Balado';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Gula', 3 from public.recipes where recipe_name = 'Telur Balado';
insert into public.recipe_ingredients (recipe_id, ingredient_name, required_weight) select id, 'Minyak Goreng', 25 from public.recipes where recipe_name = 'Telur Balado';

-- ============================================================
-- ✅ Seed selesai
-- ============================================================