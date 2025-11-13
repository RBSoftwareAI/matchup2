# 🗄️ GUIDE COMPLET - Configuration Storage Supabase

## 📋 Vue d'ensemble

Ce guide vous explique comment configurer les 3 buckets storage et leurs politiques de sécurité pour l'application MatchUp.

---

## ÉTAPE 1: Créer les Buckets Storage

### 1.1 Accéder à Storage
1. Aller sur: https://supabase.com/dashboard/project/kiwdwzukmmswiemiozcl
2. Cliquer sur **"Storage"** dans le menu latéral gauche
3. Vous devriez voir la page "Storage"

### 1.2 Créer le bucket "avatars"
1. Cliquer sur **"Create a new bucket"** (ou **"New bucket"**)
2. Remplir les informations:
   - **Name**: `avatars`
   - **Public bucket**: ✅ **COCHÉ** (important!)
   - **File size limit**: 5 MB (optionnel)
   - **Allowed MIME types**: `image/jpeg, image/png, image/webp` (optionnel)
3. Cliquer sur **"Create bucket"**

### 1.3 Créer le bucket "gallery"
1. Cliquer à nouveau sur **"New bucket"**
2. Remplir les informations:
   - **Name**: `gallery`
   - **Public bucket**: ✅ **COCHÉ**
   - **File size limit**: 10 MB
   - **Allowed MIME types**: `image/jpeg, image/png, image/webp`
3. Cliquer sur **"Create bucket"**

### 1.4 Créer le bucket "chat"
1. Cliquer à nouveau sur **"New bucket"**
2. Remplir les informations:
   - **Name**: `chat`
   - **Public bucket**: ✅ **COCHÉ**
   - **File size limit**: 10 MB
   - **Allowed MIME types**: `image/jpeg, image/png, image/webp, image/gif`
3. Cliquer sur **"Create bucket"**

✅ **Vérification**: Vous devriez maintenant voir 3 buckets dans la liste : `avatars`, `gallery`, `chat`

---

## ÉTAPE 2: Configurer les Politiques Storage

### ⚠️ IMPORTANT: Structure des politiques

Les politiques storage utilisent une structure de dossiers:
```
avatars/
  └── {user_id}/
      └── avatar.jpg

gallery/
  └── {user_id}/
      ├── photo1.jpg
      ├── photo2.jpg
      └── photo3.jpg

chat/
  └── {match_id}/
      ├── image1.jpg
      └── image2.jpg
```

---

## 🖼️ BUCKET: avatars

### Configuration des politiques pour "avatars"

1. Cliquer sur le bucket **"avatars"** dans la liste
2. Cliquer sur l'onglet **"Policies"** (ou l'icône 🔒)
3. Cliquer sur **"New Policy"**

---

#### Politique 1: Lecture publique (SELECT)

**Cliquer sur "New Policy" → "For full customization"** (ou "Custom")

**Policy name**: `Public read access for avatars`

**Allowed operation**: SELECT (✅ coché)

**Target roles**: `authenticated` ET `anon` (cocher les deux)

**Policy definition (USING expression)**:
```sql
bucket_id = 'avatars'
```

**Policy definition (WITH CHECK expression)**: Laisser vide

**Cliquer sur "Review" puis "Save policy"**

---

#### Politique 2: Upload par utilisateur authentifié (INSERT)

**Cliquer sur "New Policy" → "For full customization"**

**Policy name**: `Users can upload their own avatar`

**Allowed operation**: INSERT (✅ coché)

**Target roles**: `authenticated` (uniquement)

**Policy definition (WITH CHECK expression)**:
```sql
bucket_id = 'avatars' 
AND (storage.foldername(name))[1] = auth.uid()::text
```

**Explication**: Cette politique permet uniquement aux utilisateurs d'uploader dans leur propre dossier (`avatars/{leur_user_id}/`)

**Cliquer sur "Review" puis "Save policy"**

---

#### Politique 3: Mise à jour de son propre avatar (UPDATE)

**Cliquer sur "New Policy" → "For full customization"**

**Policy name**: `Users can update their own avatar`

**Allowed operation**: UPDATE (✅ coché)

**Target roles**: `authenticated`

**Policy definition (USING expression)**:
```sql
bucket_id = 'avatars' 
AND (storage.foldername(name))[1] = auth.uid()::text
```

**Policy definition (WITH CHECK expression)**:
```sql
bucket_id = 'avatars' 
AND (storage.foldername(name))[1] = auth.uid()::text
```

**Cliquer sur "Review" puis "Save policy"**

---

#### Politique 4: Suppression de son propre avatar (DELETE)

**Cliquer sur "New Policy" → "For full customization"**

**Policy name**: `Users can delete their own avatar`

**Allowed operation**: DELETE (✅ coché)

**Target roles**: `authenticated`

**Policy definition (USING expression)**:
```sql
bucket_id = 'avatars' 
AND (storage.foldername(name))[1] = auth.uid()::text
```

**Cliquer sur "Review" puis "Save policy"**

---

## 📸 BUCKET: gallery

### Configuration des politiques pour "gallery"

1. Retourner à la liste des buckets (cliquer sur "Storage" dans le menu)
2. Cliquer sur le bucket **"gallery"**
3. Cliquer sur l'onglet **"Policies"**

---

#### Politique 1: Lecture publique (SELECT)

**Policy name**: `Public read access for gallery`

**Allowed operation**: SELECT

**Target roles**: `authenticated` ET `anon`

**Policy definition (USING)**:
```sql
bucket_id = 'gallery'
```

---

#### Politique 2: Upload photos galerie (INSERT)

**Policy name**: `Users can upload to their own gallery`

**Allowed operation**: INSERT

**Target roles**: `authenticated`

**Policy definition (WITH CHECK)**:
```sql
bucket_id = 'gallery' 
AND (storage.foldername(name))[1] = auth.uid()::text
```

---

#### Politique 3: Mise à jour photos galerie (UPDATE)

**Policy name**: `Users can update their own gallery photos`

**Allowed operation**: UPDATE

**Target roles**: `authenticated`

**Policy definition (USING)**:
```sql
bucket_id = 'gallery' 
AND (storage.foldername(name))[1] = auth.uid()::text
```

**Policy definition (WITH CHECK)**:
```sql
bucket_id = 'gallery' 
AND (storage.foldername(name))[1] = auth.uid()::text
```

---

#### Politique 4: Suppression photos galerie (DELETE)

**Policy name**: `Users can delete their own gallery photos`

**Allowed operation**: DELETE

**Target roles**: `authenticated`

**Policy definition (USING)**:
```sql
bucket_id = 'gallery' 
AND (storage.foldername(name))[1] = auth.uid()::text
```

---

## 💬 BUCKET: chat

### Configuration des politiques pour "chat"

1. Retourner à la liste des buckets
2. Cliquer sur le bucket **"chat"**
3. Cliquer sur l'onglet **"Policies"**

---

#### Politique 1: Lecture par membres du match (SELECT)

**Policy name**: `Users can read chat images from their matches`

**Allowed operation**: SELECT

**Target roles**: `authenticated`

**Policy definition (USING)**:
```sql
bucket_id = 'chat'
AND EXISTS (
  SELECT 1 FROM public.matches
  WHERE matches.id::text = (storage.foldername(name))[1]
  AND (matches.user1_id = auth.uid() OR matches.user2_id = auth.uid())
)
```

**Explication**: Cette politique permet uniquement de voir les images des matchs dont l'utilisateur fait partie.

---

#### Politique 2: Upload images dans ses matchs (INSERT)

**Policy name**: `Users can upload images to their matches`

**Allowed operation**: INSERT

**Target roles**: `authenticated`

**Policy definition (WITH CHECK)**:
```sql
bucket_id = 'chat'
AND EXISTS (
  SELECT 1 FROM public.matches
  WHERE matches.id::text = (storage.foldername(name))[1]
  AND (matches.user1_id = auth.uid() OR matches.user2_id = auth.uid())
)
```

---

#### Politique 3: Suppression de ses propres images (DELETE)

**Policy name**: `Users can delete their own chat images`

**Allowed operation**: DELETE

**Target roles**: `authenticated`

**Policy definition (USING)**:
```sql
bucket_id = 'chat'
AND EXISTS (
  SELECT 1 FROM public.matches
  WHERE matches.id::text = (storage.foldername(name))[1]
  AND (matches.user1_id = auth.uid() OR matches.user2_id = auth.uid())
)
```

---

## ✅ VÉRIFICATION FINALE

### Checklist de validation

Pour chaque bucket (`avatars`, `gallery`, `chat`), vérifier:

- [ ] Le bucket existe et est **Public**
- [ ] Il y a 4 politiques (SELECT, INSERT, UPDATE, DELETE) pour `avatars` et `gallery`
- [ ] Il y a 3 politiques (SELECT, INSERT, DELETE) pour `chat`
- [ ] Chaque politique a une icône 🔒 verte (active)
- [ ] Les noms de politiques sont descriptifs

### Test rapide

1. Aller dans "Storage" → "avatars"
2. Essayer de créer un dossier manuellement (devrait être autorisé)
3. Les politiques devraient empêcher les uploads non autorisés

---

## 📊 RÉSUMÉ DES POLITIQUES

### AVATARS (4 politiques)
| Opération | Qui peut ?                          | Condition                                  |
|-----------|-------------------------------------|-------------------------------------------|
| SELECT    | Tout le monde (auth + anon)        | bucket_id = 'avatars'                     |
| INSERT    | Utilisateurs authentifiés           | Dans leur propre dossier user_id          |
| UPDATE    | Utilisateurs authentifiés           | Uniquement leurs propres fichiers         |
| DELETE    | Utilisateurs authentifiés           | Uniquement leurs propres fichiers         |

### GALLERY (4 politiques)
| Opération | Qui peut ?                          | Condition                                  |
|-----------|-------------------------------------|-------------------------------------------|
| SELECT    | Tout le monde (auth + anon)        | bucket_id = 'gallery'                     |
| INSERT    | Utilisateurs authentifiés           | Dans leur propre dossier user_id          |
| UPDATE    | Utilisateurs authentifiés           | Uniquement leurs propres fichiers         |
| DELETE    | Utilisateurs authentifiés           | Uniquement leurs propres fichiers         |

### CHAT (3 politiques)
| Opération | Qui peut ?                          | Condition                                  |
|-----------|-------------------------------------|-------------------------------------------|
| SELECT    | Membres du match                    | Vérification dans table matches           |
| INSERT    | Membres du match                    | Vérification dans table matches           |
| DELETE    | Membres du match                    | Vérification dans table matches           |

---

## 🆘 DÉPANNAGE

### Erreur: "new row violates row-level security policy"
- Vérifier que les politiques sont bien activées (icône 🔒 verte)
- Vérifier que l'utilisateur est authentifié
- Vérifier que le chemin du fichier respecte la structure `bucket/{user_id}/filename`

### Les politiques n'apparaissent pas
- Actualiser la page
- Vérifier que vous êtes bien sur l'onglet "Policies" du bon bucket

### Erreur: "storage.foldername is not a function"
- Cette fonction existe dans Supabase Storage v3+
- Vérifier que votre projet Supabase est à jour

---

## 🎯 PROCHAINES ÉTAPES

Une fois les buckets et politiques configurés:

1. ✅ Revenir à Flutter
2. ✅ Les services `storage_service.dart` et `user_service.dart` sont prêts à utiliser
3. ✅ Tester l'upload d'avatar depuis l'app
4. ✅ Tester l'ajout de photos à la galerie

---

## 📞 SUPPORT

Si vous rencontrez des problèmes:
- Vérifier les logs Supabase (Dashboard → Logs)
- Tester les politiques dans le SQL Editor
- Consulter la documentation Supabase Storage

**Documentation officielle**: https://supabase.com/docs/guides/storage/security/access-control

---

✅ **Configuration Storage terminée !**
