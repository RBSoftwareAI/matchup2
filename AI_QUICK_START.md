# 🤖 AI Quick Start - MatchUp

Guide rapide pour reprendre le développement de MatchUp lors de la prochaine session IA.

## 📊 État Actuel du Projet

### ✅ Complété (Sur branche `base`)
- Architecture Clean mise en place
- Configuration GoRouter avec navigation fluide
- Thème personnalisé avec charte graphique MatchUp
- 3 écrans d'authentification fonctionnels (Start, SignIn, SignUp)
- **Navigation principale à 4 onglets (Accueil, Matchs, Chat, Profil)**
- **Écran Accueil avec deck swipable de profils**
- **Système de filtrage (Tout, Recommandés, New)**
- **Gestion d'état avec Provider**
- **Chat fonctionnel (liste + conversation)**
- **Écran Matchs complet avec TabBar (Demandes/Confirmés)**
- **Actions Accepter/Refuser sur demandes de match**
- **Écran Profil complet avec toutes les sections**
- **Édition de profil fonctionnelle**
- **Pages de paramètres (Confidentialité, Notifications, Compte, Aide, Légal)**
- Widgets réutilisables (CustomButton, CustomTextField, AuthFooter, ProfileCard, SwipeButtons, MatchRequestCard, InterestChip, etc.)
- Validations de formulaire en temps réel
- Design responsive et cohérent

### 🎯 Version Actuelle: 1.4.0+1
**Branche de production**: `main` (code stable d'origine)  
**Branche de développement**: `base` (nouvelles fonctionnalités implémentées)  
**Repository**: https://github.com/RBSoftwareAI/matchup2
**Backend**: Supabase (PostgreSQL + Auth + Storage + Real-time)

### 🌿 Workflow Git
- **`main`**: Branche de production (code stable uniquement)
- **`base`**: Branche de développement (travail en cours)
- **`feature/*`**: Branches pour nouvelles fonctionnalités

## 🏗️ Architecture Actuelle

```
lib/
├── main.dart                          # MaterialApp.router avec 3 Providers
├── config/
│   ├── routes/app_router.dart        # 13 routes complètes
│   └── theme/app_theme.dart          # Thème Material 3 personnalisé
├── core/
│   ├── config/
│   │   └── supabase_config.dart     # Configuration Supabase
│   ├── constants/
│   │   ├── colors.dart               # Palette complète (#FF3B3B primary)
│   │   └── text_styles.dart          # 8+ styles de texte
│   └── services/                     # Services backend Supabase
│       ├── auth_service.dart         # Authentification
│       ├── user_service.dart         # Gestion profils
│       ├── match_service.dart        # Matching
│       ├── message_service.dart      # Messagerie
│       └── storage_service.dart      # Upload photos
├── features/
│   ├── auth/
│   │   └── presentation/             # 3 écrans auth (Start, SignIn, SignUp)
│   ├── home/
│   │   ├── data/mock_profiles.dart   # 30 profils mock
│   │   ├── domain/models/profile.dart
│   │   └── presentation/
│   │       ├── providers/home_provider.dart
│   │       ├── screens/home_screen.dart
│   │       └── widgets/              # ProfileCard, SwipeButtons, ProfileDeck
│   ├── matches/
│   │   ├── data/mock_matches.dart    # 8 demandes mock
│   │   ├── domain/models/match_request.dart
│   │   └── presentation/
│   │       ├── providers/matches_provider.dart
│   │       ├── screens/matches_screen.dart  # TabBar Demandes/Confirmés
│   │       └── widgets/match_request_card.dart
│   ├── chat/
│   │   ├── domain/models/message.dart
│   │   └── presentation/
│   │       ├── screens/              # ChatListScreen, ChatDetailScreen
│   │       └── widgets/              # ChatBubble, ConversationCard
│   ├── profile/
│   │   ├── data/mock_user.dart       # Profil utilisateur mock
│   │   ├── domain/models/            # user_profile.dart, user_preferences.dart
│   │   └── presentation/
│   │       ├── providers/profile_provider.dart
│   │       ├── screens/              # ProfileScreen, EditProfileScreen
│   │       └── widgets/              # ProfileHeader, PhotoGrid, InterestChip...
│   └── settings/
│       └── presentation/
│           ├── providers/settings_provider.dart
│           ├── screens/              # 9 écrans (5 principaux + 4 documents légaux)
│           └── widgets/              # 4 widgets réutilisables
└── shared/widgets/
    └── custom_bottom_nav.dart        # Bottom navigation bar
```

## 🎨 Charte Graphique (À Respecter Strictement)

```dart
// Couleurs principales
Primary: #FF3B3B
PrimaryPressed: #E23333
Background: #FFF5F2
CardBackground: #FFFFFF
TextPrimary: #1F2937
TextMuted: #6B7280

// Design
BorderRadius: 24
TitleFontWeight: FontWeight.w600 (semi-gras)
Transitions: 150ms slide animations
```

## 🚀 Commandes Essentielles

### Démarrage Rapide
```bash
cd /home/user/flutter_app
flutter pub get
flutter run  # ou flutter build web --release pour le web
```

### Développement
```bash
# Analyse du code (à faire AVANT chaque commit)
flutter analyze

# Formater le code
dart format .

# Build web pour preview
flutter build web --release
cd build/web && python3 ../../web_server.py
```

### Git Workflow
```bash
# Clone et setup
git clone https://github.com/RBSoftwareAI/matchup2.git
cd matchup2
git checkout base  # Basculer sur la branche de développement

# Développement quotidien (sur base)
git checkout base
git pull origin base
# ... faire vos modifications ...
git add .
git commit -m "feat: description claire"
git push origin base

# Pour une nouvelle fonctionnalité
git checkout base
git checkout -b feature/nom-feature
# ... développer la feature ...
git add .
git commit -m "feat: description de la feature"
git push origin feature/nom-feature
# Puis créer une Pull Request vers base

# Déploiement en production
# Une fois le code testé sur base, merger vers main
git checkout main
git merge base
git push origin main
```

## 🔍 Points d'Attention

### ⚠️ Validations Actuelles
- **Email**: Regex strict `[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}`
- **Mot de passe**: Minimum 6 caractères
- **Nom**: Minimum 2 caractères
- **Confirmation password**: Doit correspondre exactement

### 🎯 Navigation
- Route initiale: `/start`
- Transitions: Slide 150ms avec `Curves.easeInOut`
- Back navigation: Icônes dans AppBar

### 📝 Conventions de Code
- **Commentaires**: Anglais
- **UI/Textes**: Français
- **Style**: Dart official guidelines
- **Widgets**: Const constructors quand possible

## 🔄 Prochaines Étapes Suggérées

### Phase 2 (Priorité Haute) - COMPLÉTÉ ✅
1. **Navigation principale** ✅
   - Bottom navigation à 4 onglets
   - Routes configurées avec GoRouter (13 routes)
   
2. **Écran Accueil** ✅
   - Deck swipable avec 30 profils mock
   - 3 filtres (Tout, Recommandés, New)
   - Actions swipe (like, dislike, super like)
   
3. **Chat** ✅
   - Liste de conversations
   - Écran de conversation
   - Envoi de messages mock

4. **Écran Matchs** ✅
   - TabBar avec "Demandes" et "Confirmés"
   - 8 demandes de match mock
   - Actions Accepter/Refuser fonctionnelles
   - Création automatique de conversation lors de l'acceptation

5. **Écran Profil** ✅
   - Affichage complet du profil utilisateur
   - Sections: Informations, Photos, Centres d'intérêt, Préférences
   - Navigation vers paramètres

6. **Édition de Profil** ✅
   - Formulaire complet d'édition
   - Modification de tous les champs
   - Gestion des centres d'intérêt

7. **Pages de Paramètres** ✅
   - Confidentialité, Notifications, Compte, Aide, Mentions légales

8. **State Management** ✅
   - 3 Providers (Home, Matches, Profile)
   - Gestion d'état complète

### Phase 3 (Priorité Haute - EN COURS ⚡)
9. **✅ Infrastructure Supabase Complète**
   - ✅ Script SQL avec 5 tables + RLS + Triggers
   - ✅ Configuration Flutter avec services
   - ✅ Services: Auth, User, Match, Message, Storage
   - ✅ Documentation complète (SUPABASE_SETUP.md)
   - 🔜 Intégration dans les écrans existants
   - 🔜 Migration des données mock vers Supabase

10. **Profil Utilisateur - Amélioration**
   - Upload de photos réel (actuellement mock)
   - Définition des préférences avancées
   - Paramètres de confidentialité fonctionnels

### Phase 4 (Priorité Moyenne)
11. **Matching Algorithm Réel**
   - Intégration API IA
   - Système de recommandation avancé
   - Gestion des matches

12. **Chat Temps Réel**
   - Firebase Realtime Database
   - Notifications push
   - Indicateurs de lecture

## 🐛 Problèmes Connus

Aucun problème connu actuellement. Le code compile sans erreur et toutes les fonctionnalités mock fonctionnent correctement.

## 📦 Dépendances Actuelles

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  
  # Backend
  supabase_flutter: ^2.3.4         # 🔥 NEW - Backend complet
  
  # Navigation & State
  go_router: ^14.6.2
  provider: 6.1.5
  
  # UI Components
  flutter_card_swiper: ^7.0.1
  cached_network_image: ^3.4.1
  flutter_svg: ^2.0.10+1
  
  # Utilities
  intl: ^0.19.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

## 🔧 Configuration Environnement

- **Flutter**: 3.35.4
- **Dart**: 3.9.2
- **Target SDK**: Android API 35, iOS 14+
- **Package**: com.matchup.app.matchup

## 💡 Tips pour la Prochaine Session

1. **Toujours commencer par**: `flutter pub get && flutter analyze`
2. **Supabase Setup**: 
   - Lire `docs/SUPABASE_SETUP.md` pour configuration complète
   - Créer `.env` avec credentials (voir `.env.example`)
   - Scripts SQL dans `supabase_schema.sql` (création) et `supabase_rollback.sql` (suppression)
3. **Respecter l'architecture Clean**: Nouvelle feature = nouveau dossier dans `features/`
4. **Services disponibles**: `AuthService`, `UserService`, `MatchService`, `MessageService`, `StorageService` dans `lib/core/services/`
5. **Widgets réutilisables**: Placer dans `features/X/presentation/widgets/` si spécifique, sinon `shared/widgets/`
6. **Tests**: Créer un test pour chaque nouvelle fonctionnalité critique
7. **Navigation**: Ajouter les nouvelles routes dans `app_router.dart`

## 📞 Contexte Projet

**Objectif**: Application de rencontres moderne utilisant l'IA pour améliorer le matching
**Public Cible**: Adultes 18-45 ans cherchant des relations sérieuses
**USP**: Algorithm d'IA avancé pour des matches de qualité

## 📚 Ressources Utiles

- [Go Router Documentation](https://pub.dev/packages/go_router)
- [Flutter Clean Architecture](https://github.com/ResoCoder/flutter-tdd-clean-architecture-course)
- [Material Design 3](https://m3.material.io/)
- [Firebase Flutter Setup](https://firebase.google.com/docs/flutter/setup)

## 🗄️ Supabase - Quick Reference

### Configuration Initiale
```bash
# 1. Créer .env avec credentials
cp .env.example .env

# 2. Dans Supabase Dashboard: SQL Editor
# Copier/coller supabase_schema.sql et exécuter

# 3. Storage: Créer bucket "matchUp" (public)
```

### Services Disponibles

```dart
// AuthService - Authentification
final authService = AuthService();
await authService.signUp(email: '...', password: '...');
await authService.signIn(email: '...', password: '...');
final user = authService.currentUser;

// UserService - Profils
final userService = UserService();
await userService.getUserProfile(userId);
await userService.updateUserProfile(userId, data);
final users = await userService.searchUsers(gender: 'female', city: 'Paris');

// MatchService - Matching
final matchService = MatchService();
await matchService.sendMatchRequest(targetUserId);
await matchService.acceptMatchRequest(matchId);
final matches = await matchService.getConfirmedMatches();

// MessageService - Chat
final messageService = MessageService();
await messageService.sendMessage(recipientId: '...', message: '...');
final messages = await messageService.getMessages(otherUserId);
final stream = messageService.subscribeToMessages(otherUserId); // Real-time

// StorageService - Upload
final storageService = StorageService();
final url = await storageService.uploadProfilePicture(userId: '...', file: file);
```

### Base de Données

**Tables** : users, gallery, interest, matches, message  
**RLS** : Activé sur toutes les tables  
**Triggers** : updated_at automatique  
**Indexes** : 20+ pour optimisation  
**Seed Data** : 15 utilisateurs + données relationnelles

📖 **Documentation complète** : `docs/SUPABASE_SETUP.md`

---

**Dernière mise à jour**: Session 5 - Infrastructure Supabase complète  
**Prochaine session**: Intégration Supabase dans les écrans existants (Auth, Profils, Matchs, Chat)
