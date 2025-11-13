# 🚀 Supabase Setup Guide - MatchUp

Guide complet pour configurer et utiliser Supabase avec l'application MatchUp.

## 📋 Table des Matières

1. [Vue d'ensemble](#vue-densemble)
2. [Architecture de la Base de Données](#architecture-de-la-base-de-données)
3. [Configuration Supabase](#configuration-supabase)
4. [Exécution du Schema SQL](#exécution-du-schema-sql)
5. [Configuration Storage](#configuration-storage)
6. [Configuration Flutter](#configuration-flutter)
7. [Utilisation des Services](#utilisation-des-services)
8. [Troubleshooting](#troubleshooting)

---

## Vue d'ensemble

MatchUp utilise Supabase comme backend pour :
- **Authentification** : Gestion des comptes utilisateurs
- **Base de données** : PostgreSQL avec Row Level Security
- **Storage** : Stockage des photos de profil et galeries
- **Real-time** : Messagerie instantanée

---

## Architecture de la Base de Données

### Schéma ASCII

```
┌─────────────────────────────────────────────────────┐
│                   auth.users                        │
│                  (Supabase Auth)                    │
└──────────────────┬──────────────────────────────────┘
                   │
                   │ (1:1)
                   ▼
┌──────────────────────────────────────────────────────┐
│                   users                              │
│  ─────────────────────────────────────────────       │
│  id (uuid, PK, FK -> auth.users)                    │
│  username, email, gender, age                        │
│  image, bio, city, country                           │
│  job_title, company, education, height_cm            │
│  is_active, is_verified, last_active                │
│  created_at, updated_at                              │
└──────────────┬───────────────┬──────────────┬────────┘
               │               │              │
        (1:N)  │        (1:N)  │       (1:N)  │
               ▼               ▼              ▼
┌──────────────────┐  ┌─────────────┐  ┌─────────────┐
│     gallery      │  │  interest   │  │   matches   │
│  ──────────────  │  │ ─────────── │  │ ─────────── │
│  id (PK)         │  │ id (PK)     │  │ id (PK)     │
│  users_id (FK)   │  │ users_id    │  │ sender_match│
│  image           │  │ name        │  │ receiver_   │
│  position        │  │             │  │   match     │
│  created_at      │  │ created_at  │  │ accepted    │
│  updated_at      │  │ updated_at  │  │ created_at  │
└──────────────────┘  └─────────────┘  │ updated_at  │
                                       └─────────────┘
                                              │
                                       (1:N)  │
                                              ▼
                                    ┌─────────────────┐
                                    │    message      │
                                    │ ─────────────── │
                                    │ id (PK)         │
                                    │ sender_id (FK)  │
                                    │ destination_    │
                                    │   users (FK)    │
                                    │ message         │
                                    │ seen            │
                                    │ created_at      │
                                    │ updated_at      │
                                    └─────────────────┘
```

### Tables Overview

| Table | Description | Lignes | Relations |
|-------|-------------|--------|-----------|
| `users` | Profils utilisateurs | 15+ seed | → auth.users |
| `gallery` | Photos galerie | 7+ seed | → users |
| `interest` | Centres d'intérêt | 45+ seed | → users |
| `matches` | Demandes de match | 8 seed | → users x2 |
| `message` | Messages chat | 11 seed | → users x2, matches |

### Indexes Optimisés

**20+ indexes** créés pour optimiser les requêtes courantes :
- Recherche par genre, âge, ville
- Récupération des matchs pending/confirmés
- Messages non lus par conversation
- Galerie et intérêts par utilisateur

---

## Configuration Supabase

### Étape 1 : Créer un Projet Supabase

1. Aller sur [https://app.supabase.com](https://app.supabase.com)
2. Cliquer sur "New Project"
3. Remplir les informations :
   - **Name** : matchup-production (ou matchup-dev pour test)
   - **Database Password** : Générer un mot de passe fort
   - **Region** : Choisir la plus proche (ex: West EU - Ireland)
4. Cliquer sur "Create new project"
5. Attendre 2-3 minutes pour la création

### Étape 2 : Récupérer les Credentials

1. Dans le dashboard Supabase, aller dans **Settings** → **API**
2. Noter les informations suivantes :

```
Project URL: https://xxxxxxxxxxxxx.supabase.co
anon/public key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

⚠️ **Important** : Ne JAMAIS committer ces clés dans Git !

---

## Exécution du Schema SQL

### Méthode 1 : SQL Editor (Recommandée)

1. Dans Supabase Dashboard, aller dans **SQL Editor**
2. Cliquer sur "New Query"
3. Copier tout le contenu de `supabase_schema.sql`
4. Cliquer sur "Run" (en bas à droite)
5. Vérifier le message de succès

**✅ Attendu** :
```
Success. No rows returned
```

### Méthode 2 : Supabase CLI

```bash
# Installer Supabase CLI
npm install -g supabase

# Se connecter
supabase login

# Lier le projet
supabase link --project-ref your-project-ref

# Exécuter le schema
supabase db push
```

### Vérification

Exécuter ces requêtes dans SQL Editor :

```sql
-- Compter les utilisateurs créés
select count(*) from users;
-- Résultat attendu : 15

-- Compter les matchs
select count(*) from matches;
-- Résultat attendu : 8

-- Vérifier RLS activé
select tablename, rowsecurity 
from pg_tables 
where schemaname = 'public';
-- Toutes les tables doivent avoir rowsecurity = true
```

### Rollback (Si Nécessaire)

Si vous devez recommencer :

```bash
# Dans SQL Editor, exécuter :
\i supabase_rollback.sql
```

---

## Configuration Storage

### Créer le Bucket "matchUp"

1. Dans Supabase Dashboard, aller dans **Storage**
2. Cliquer sur "New bucket"
3. Configuration :
   - **Name** : `matchUp`
   - **Public** : ✅ Yes (pour que les images soient accessibles publiquement)
   - **File size limit** : 5 MB (recommandé)
   - **Allowed MIME types** : image/jpeg, image/png, image/webp

### Créer la Structure de Dossiers

Dans le bucket `matchUp`, créer :
```
matchUp/
├── profiles/        # Photos de profil principales
├── gallery/         # Photos de galeries
└── temp/           # Uploads temporaires
```

### Configurer les Politiques Storage

Aller dans **Storage** → **Policies** → **New Policy**

#### Politique 1 : Lecture Publique

```sql
-- Allow public read access
create policy "Public read access"
on storage.objects for select
using (bucket_id = 'matchUp');
```

#### Politique 2 : Upload Authentifié

```sql
-- Allow authenticated users to upload
create policy "Authenticated users can upload"
on storage.objects for insert
to authenticated
with check (bucket_id = 'matchUp');
```

#### Politique 3 : Update Propriétaire

```sql
-- Allow users to update their own files
create policy "Users can update own files"
on storage.objects for update
to authenticated
using (bucket_id = 'matchUp' and auth.uid()::text = (storage.foldername(name))[1]);
```

#### Politique 4 : Delete Propriétaire

```sql
-- Allow users to delete their own files
create policy "Users can delete own files"
on storage.objects for delete
to authenticated
using (bucket_id = 'matchUp' and auth.uid()::text = (storage.foldername(name))[1]);
```

---

## Configuration Flutter

### Étape 1 : Ajouter la Dépendance

Dans `pubspec.yaml` :

```yaml
dependencies:
  supabase_flutter: ^2.3.4
```

Puis :
```bash
flutter pub get
```

### Étape 2 : Créer le Fichier .env

Créer `.env` à la racine du projet :

```env
SUPABASE_URL=https://xxxxxxxxxxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

⚠️ **Ajouter .env au .gitignore** :
```gitignore
.env
.env.*
```

### Étape 3 : Mettre à Jour supabase_config.dart

```dart
// lib/core/config/supabase_config.dart
class SupabaseConfig {
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://xxxxxxxxxxxxx.supabase.co', // Votre URL
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...', // Votre clé
  );
}
```

### Étape 4 : Initialiser dans main.dart

```dart
import 'package:flutter/material.dart';
import 'core/config/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialiser Supabase
  await SupabaseConfig.initialize();
  
  runApp(const MyApp());
}
```

---

## Utilisation des Services

### AuthService - Authentification

```dart
import 'package:matchup/core/services/auth_service.dart';

final authService = AuthService();

// Inscription
try {
  final response = await authService.signUp(
    email: 'user@example.com',
    password: 'securepass123',
    metadata: {'username': 'johndoe'},
  );
  
  if (response.user != null) {
    print('User created: ${response.user!.id}');
    // Créer le profil utilisateur
  }
} catch (e) {
  print('Error: $e');
}

// Connexion
try {
  final response = await authService.signIn(
    email: 'user@example.com',
    password: 'securepass123',
  );
  
  if (response.session != null) {
    print('Signed in successfully');
    // Rediriger vers home
  }
} catch (e) {
  print('Error: $e');
}
```

### UserService - Profils

```dart
import 'package:matchup/core/services/user_service.dart';

final userService = UserService();

// Créer profil après inscription
await userService.createUserProfile(
  userId: authResponse.user!.id,
  username: 'johndoe',
  email: 'john@example.com',
  gender: 'male',
  additionalData: {
    'age': 28,
    'city': 'Paris',
    'bio': 'Passionné de tech et de voyage',
  },
);

// Récupérer profil
final profile = await userService.getUserProfile(userId);
print('Bio: ${profile['bio']}');

// Mettre à jour profil
await userService.updateUserProfile(
  userId,
  {'bio': 'Nouvelle bio', 'city': 'Lyon'},
);

// Rechercher utilisateurs
final users = await userService.searchUsers(
  gender: 'female',
  minAge: 25,
  maxAge: 35,
  city: 'Paris',
  limit: 20,
);
```

### MatchService - Matching

```dart
import 'package:matchup/core/services/match_service.dart';

final matchService = MatchService();

// Envoyer like (match request)
await matchService.sendMatchRequest(targetUserId);

// Récupérer demandes reçues
final requests = await matchService.getReceivedMatchRequests();
for (var request in requests) {
  print('From: ${request['sender_profile']['username']}');
  
  // Accepter
  await matchService.acceptMatchRequest(request['id']);
  
  // Ou rejeter
  // await matchService.rejectMatchRequest(request['id']);
}

// Récupérer matchs confirmés
final matches = await matchService.getConfirmedMatches();
```

### MessageService - Messagerie

```dart
import 'package:matchup/core/services/message_service.dart';

final messageService = MessageService();

// Envoyer message
await messageService.sendMessage(
  recipientId: matchUserId,
  message: 'Salut ! Comment ça va ?',
);

// Récupérer messages conversation
final messages = await messageService.getMessages(otherUserId);
for (var msg in messages) {
  print('${msg['created_at']}: ${msg['message']}');
}

// Marquer comme lu
await messageService.markMessagesAsSeen(senderId);

// Écouter nouveaux messages (real-time)
final stream = messageService.subscribeToMessages(otherUserId);
stream.listen((message) {
  print('New message: ${message['message']}');
});
```

### StorageService - Upload Photos

```dart
import 'dart:io';
import 'package:matchup/core/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

final storageService = StorageService();

// Sélectionner image
final picker = ImagePicker();
final pickedFile = await picker.pickImage(source: ImageSource.gallery);

if (pickedFile != null) {
  final file = File(pickedFile.path);
  
  // Upload photo de profil
  final url = await storageService.uploadProfilePicture(
    userId: currentUserId,
    file: file,
  );
  
  // Mettre à jour profil avec URL
  await userService.updateUserProfile(
    currentUserId,
    {'image': url},
  );
}
```

---

## Troubleshooting

### Erreur : "No rows returned"

**Problème** : Pas d'erreur mais aucune donnée
**Solution** : 
- Vérifier que RLS est configuré correctement
- Vérifier que l'utilisateur est authentifié
- Vérifier les politiques RLS

### Erreur : "permission denied for table users"

**Problème** : RLS bloque l'accès
**Solution** :
```sql
-- Vérifier les politiques
select * from pg_policies where tablename = 'users';

-- Vérifier RLS activé
select tablename, rowsecurity from pg_tables where tablename = 'users';
```

### Erreur : "JWT expired"

**Problème** : Token d'authentification expiré
**Solution** :
```dart
// Refresh session
await SupabaseConfig.client.auth.refreshSession();

// Ou se reconnecter
await authService.signOut();
await authService.signIn(email, password);
```

### Erreur : "duplicate key value violates unique constraint"

**Problème** : Tentative d'insertion d'un doublon
**Solution** :
- Username déjà utilisé
- Email déjà utilisé
- Match déjà existant

Utiliser `matchService.matchExists()` avant d'envoyer un match

### Images ne s'affichent pas

**Problème** : URLs Storage incorrectes
**Solution** :
```dart
// Vérifier URL publique
final url = storageService.getPublicUrl('path/to/image.jpg');
print(url); // Doit commencer par https://

// Vérifier bucket public
// Dans Supabase: Storage → matchUp → Settings → Public bucket = ON
```

### Performance lente

**Solution** :
- Vérifier les indexes créés : `\d+ users`
- Limiter les résultats : `.limit(50)`
- Utiliser `.select('id, username')` au lieu de `.select()`

---

## 📚 Ressources

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Flutter Package](https://pub.dev/packages/supabase_flutter)
- [Row Level Security Guide](https://supabase.com/docs/guides/auth/row-level-security)
- [Storage Guide](https://supabase.com/docs/guides/storage)

---

## 🔄 Versions

- **Schema Version** : 1.0.0
- **Supabase Flutter** : ^2.3.4
- **Dernière mise à jour** : Session 5

---

**Documentation maintenue par** : RBSoftware AI
