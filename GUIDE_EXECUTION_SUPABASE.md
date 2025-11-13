# 🚀 GUIDE D'EXÉCUTION - Configuration Supabase (Correction Erreur)

## ❌ ERREUR DÉTECTÉE

Tu as rencontré l'erreur suivante lors de l'exécution du script SQL:
```
Error: Failed to run sql query: ERROR: 42601: syntax error at or near "Bonjour"
```

### 🔍 Cause de l'erreur
- Le mot "Bonjour" apparaît à la ligne 1, ce qui signifie que du texte non-SQL a été copié avant le script
- Solution: Utiliser le nouveau fichier SQL propre fourni ci-dessous

---

## ✅ SOLUTION COMPLÈTE - 3 ÉTAPES

### ÉTAPE 1: Créer les Tables (Script SQL Corrigé)

#### 1.1 Accéder au SQL Editor
1. Aller sur: https://supabase.com/dashboard/project/kiwdwzukmmswiemiozcl
2. Cliquer sur **"SQL Editor"** dans le menu latéral gauche
3. Cliquer sur **"New Query"** (bouton en haut à droite)

#### 1.2 Copier le script SQL propre
1. Ouvrir le fichier: `/home/user/flutter_app/SUPABASE_SETUP_COMPLETE.sql`
2. **Copier TOUT le contenu du fichier** (du début à la fin)
3. **Coller dans l'éditeur SQL Supabase** (remplacer tout le contenu existant)

#### 1.3 Exécuter le script
1. Cliquer sur **"Run"** (ou appuyer sur `Ctrl+Enter` / `Cmd+Enter`)
2. Attendre la fin de l'exécution (peut prendre 5-10 secondes)
3. Vérifier qu'il n'y a **aucune erreur** dans le panneau de résultats

#### 1.4 Vérification
- Tu devrais voir un message de succès
- Aller dans **"Table Editor"** → Vérifier que les 5 tables existent:
  - ✅ users
  - ✅ gallery
  - ✅ interest
  - ✅ matches
  - ✅ message

---

### ÉTAPE 2: Créer les Buckets Storage (Interface Web)

#### 2.1 Accéder à Storage
1. Cliquer sur **"Storage"** dans le menu latéral gauche
2. Cliquer sur **"Create a new bucket"** (ou **"New bucket"**)

#### 2.2 Créer le bucket "avatars"
1. **Name**: `avatars`
2. **Public bucket**: ✅ **COCHER** (très important!)
3. Cliquer sur **"Create bucket"**

#### 2.3 Créer le bucket "gallery"
1. Cliquer à nouveau sur **"New bucket"**
2. **Name**: `gallery`
3. **Public bucket**: ✅ **COCHER**
4. Cliquer sur **"Create bucket"**

#### 2.4 Créer le bucket "chat"
1. Cliquer à nouveau sur **"New bucket"**
2. **Name**: `chat`
3. **Public bucket**: ✅ **COCHER**
4. Cliquer sur **"Create bucket"**

#### 2.5 Vérification
- Retourner à la page **"Storage"**
- Tu devrais voir **3 buckets** dans la liste:
  - ✅ avatars (Public)
  - ✅ gallery (Public)
  - ✅ chat (Public)

---

### ÉTAPE 3: Configurer les Politiques Storage (Script SQL)

#### 3.1 Retourner au SQL Editor
1. Cliquer sur **"SQL Editor"** dans le menu
2. Cliquer sur **"New Query"**

#### 3.2 Copier le script des politiques Storage
1. Ouvrir le fichier: `/home/user/flutter_app/SUPABASE_STORAGE_POLICIES.sql`
2. **Copier TOUT le contenu du fichier**
3. **Coller dans l'éditeur SQL**

#### 3.3 Exécuter le script
1. Cliquer sur **"Run"** (ou `Ctrl+Enter` / `Cmd+Enter`)
2. Attendre la fin de l'exécution
3. Vérifier qu'il n'y a **aucune erreur**

#### 3.4 Vérification des politiques
1. Aller dans **"Storage"** → Cliquer sur **"avatars"**
2. Cliquer sur l'onglet **"Policies"** (ou l'icône 🔒)
3. Tu devrais voir **4 politiques** avec des icônes 🔒 vertes:
   - Public read access for avatars
   - Users can upload their own avatar
   - Users can update their own avatar
   - Users can delete their own avatar

4. Répéter pour **"gallery"** → Devrait avoir **4 politiques**
5. Répéter pour **"chat"** → Devrait avoir **3 politiques**

---

## 📋 CHECKLIST DE VALIDATION COMPLÈTE

### Base de données (Étape 1)
- [ ] Script SQL exécuté sans erreur
- [ ] 5 tables créées (users, gallery, interest, matches, message)
- [ ] Indexes créés (vérifier dans "Database" → "Indexes")
- [ ] Triggers créés pour updated_at
- [ ] RLS activé sur toutes les tables

### Storage Buckets (Étape 2)
- [ ] Bucket "avatars" créé (Public)
- [ ] Bucket "gallery" créé (Public)
- [ ] Bucket "chat" créé (Public)
- [ ] Les 3 buckets sont visibles dans Storage

### Storage Policies (Étape 3)
- [ ] 4 politiques créées pour "avatars" (SELECT, INSERT, UPDATE, DELETE)
- [ ] 4 politiques créées pour "gallery" (SELECT, INSERT, UPDATE, DELETE)
- [ ] 3 politiques créées pour "chat" (SELECT, INSERT, DELETE)
- [ ] Toutes les politiques ont une icône 🔒 verte (active)
- [ ] Total: **11 politiques Storage**

### Tests Rapides
- [ ] Aller dans "Table Editor" → "users" → Voir la structure
- [ ] Aller dans "Storage" → "avatars" → Onglet "Policies" → Voir les 4 politiques
- [ ] Pas d'erreurs dans les logs (Dashboard → Logs)

---

## 🎯 RÉSUMÉ DES FICHIERS À UTILISER

### Pour la base de données:
```
📄 /home/user/flutter_app/SUPABASE_SETUP_COMPLETE.sql
   ↳ Copier TOUT le contenu dans SQL Editor Supabase
   ↳ Cliquer sur "Run"
```

### Pour les politiques Storage:
```
📄 /home/user/flutter_app/SUPABASE_STORAGE_POLICIES.sql
   ↳ Copier TOUT le contenu dans SQL Editor Supabase
   ↳ Cliquer sur "Run"
```

### Pour le guide détaillé (référence):
```
📖 /home/user/flutter_app/SUPABASE_STORAGE_SETUP.md
   ↳ Guide étape par étape avec captures d'écran expliquées
   ↳ À consulter si besoin de plus de détails
```

---

## 🆘 SI TU RENCONTRES DES ERREURS

### Erreur: "relation already exists"
- **Cause**: Les tables existent déjà
- **Solution**: 
  1. Aller dans "Table Editor"
  2. Supprimer toutes les tables manuellement
  3. Réexécuter le script

### Erreur: "policy already exists"
- **Cause**: Les politiques existent déjà
- **Solution**: 
  1. Aller dans "Storage" → chaque bucket → "Policies"
  2. Supprimer toutes les politiques
  3. Réexécuter le script

### Erreur: "bucket not found"
- **Cause**: Les buckets n'existent pas encore
- **Solution**: Créer les 3 buckets d'abord (Étape 2), puis exécuter les politiques (Étape 3)

### Erreur: "syntax error"
- **Cause**: Copie incomplète ou texte supplémentaire
- **Solution**: 
  1. Faire "Select All" (Ctrl+A / Cmd+A) dans l'éditeur
  2. Supprimer tout
  3. Recopier le script complet depuis le fichier
  4. Réexécuter

---

## ✅ CONFIRMATION FINALE

Une fois TOUTES les étapes terminées, tu devrais avoir:

### Dans Table Editor:
- 5 tables avec des colonnes
- Chaque table a un onglet "RLS" montrant les politiques actives

### Dans Storage:
- 3 buckets publics
- 11 politiques au total (4+4+3)
- Toutes les politiques avec 🔒 vert

### Prêt pour la Session 6:
- ✅ Backend Supabase 100% configuré
- ✅ Services Flutter prêts à être utilisés
- ✅ Authentification fonctionnelle
- ✅ Upload de fichiers fonctionnel

---

## 🚀 PROCHAINE ÉTAPE

Une fois la configuration Supabase terminée:

1. **Fermer cette session**
2. **Ouvrir une nouvelle session (Session 6)**
3. **Fournir le prompt**: `/home/user/flutter_app/PROMPT_SESSION_6.txt`
4. **Commencer l'implémentation de l'UI d'authentification**

---

## 📞 BESOIN D'AIDE?

Si quelque chose ne fonctionne pas:
1. Vérifier les logs Supabase: Dashboard → Logs
2. Vérifier la console du navigateur (F12)
3. Tester une requête simple dans SQL Editor:
   ```sql
   SELECT * FROM public.users LIMIT 1;
   ```

---

**Bonne configuration ! 🎉**
