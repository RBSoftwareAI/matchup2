# MatchUp - Application de Rencontres avec IA

Application mobile de rencontres utilisant l'intelligence artificielle pour matcher les utilisateurs selon leurs préférences.

## 🚀 Description

MatchUp est une application Flutter moderne qui analyse vos préférences et vous connecte aux profils compatibles grâce à un algorithme d'IA.

## 📱 Fonctionnalités Actuelles

### ✅ Authentification (v1.0)
- Écran de démarrage avec présentation de l'app
- Écran de connexion avec validation email/password
- Écran d'inscription avec validation complète
- Redirection automatique vers l'écran d'accueil après connexion

### ✅ Navigation Principale (v1.2 - Sur `base`)
- Bottom navigation à 4 onglets : Accueil, Matchs, Chat, Profil
- Navigation fluide avec GoRouter
- 13 routes configurées

### ✅ Écran d'Accueil (v1.1)
- **Deck swipable** avec 30 profils variés
- **3 systèmes de filtrage** :
  - "Tout" : Tous les profils disponibles
  - "Recommandés" : Profils compatibles selon vos intérêts
  - "New" : 20 profils les plus récents
- **Actions swipe** :
  - Swipe gauche : Refuser
  - Swipe droite : Like ❤️
  - Swipe haut : Super Like 🔥
- **Boutons d'action** en bas de l'écran
- **Compteur de profils** restants
- **Feedback visuel** pour chaque action

### ✅ Écran Matchs (v1.2) ⭐ NOUVEAU
- **TabBar locale** avec 2 onglets :
  - **"Demandes"** : Liste des demandes de match reçues (8 demandes mock)
  - **"Confirmés"** : Liste des matches confirmés
- **Carte de demande** avec :
  - Photo du profil
  - Nom, Âge, Métier
  - Distance (en km)
  - **Actions** :
    - Bouton "Refuser" (X rouge) - Retire la demande avec SnackBar
    - Bouton "Accepter" (cœur) - Crée une conversation automatiquement
- **États vides** avec illustrations et messages
- **Intégration Chat** : Accepter une demande crée automatiquement une conversation

### ✅ Chat (v1.1)
- **Liste de conversations** avec :
  - Avatars des utilisateurs
  - Aperçu du dernier message
  - Timestamps formatés
  - Badges de messages non lus
  - Barre de recherche
- **Écran de conversation** :
  - Historique des messages
  - Bulles de chat (gauche/droite)
  - Champ de saisie avec bouton envoyer
  - Envoi en temps réel (mock)

### ✅ Écran Profil (v1.2) ⭐ NOUVEAU
- **En-tête** :
  - Avatar circulaire (photo principale)
  - Icône de modification photo (SnackBar mock)
  - Nom, Âge, Ville, Pays
  - Bouton "Modifier le profil"
- **Carte "Informations"** :
  - Bio (multiligne)
  - Métier / Entreprise
  - Éducation
  - Taille (en cm)
- **Carte "Photos"** :
  - Grille 3 colonnes (6-8 photos mock)
  - Bouton "Ajouter des photos" (mock)
- **Carte "Centres d'intérêt"** :
  - Chips stylisés (8 intérêts max)
- **Carte "Préférences"** (lecture seule) :
  - Genres préférés
  - Tranche d'âge
  - Distance maximale
- **Section "Paramètres & plus"** :
  - Navigation vers 6 pages de paramètres
- **Bouton Déconnexion** avec dialog de confirmation

### ✅ Édition de Profil (v1.2) ⭐ NOUVEAU
- **Écran complet** (HORS bottom navigation)
- **AppBar** avec titre et bouton "Enregistrer"
- **Formulaire** :
  - Photo de profil avec bouton "Changer la photo"
  - Champs : Nom, Bio (max 500 caractères), Métier, Entreprise, Éducation
  - Ville, Pays, Taille (cm, input numérique)
- **Centres d'intérêt** :
  - Sélection/déselection par chips
  - 16 intérêts disponibles
- **Sauvegarde** : SnackBar "Profil mis à jour (mock)" + retour automatique

### ✅ Pages de Paramètres (v1.2) ⭐ NOUVEAU
5 pages de paramètres (placeholders prêts pour développement) :
- **Confidentialité** (`/privacy`)
- **Notifications** (`/notifications-settings`)
- **Compte & sécurité** (`/account`)
- **Aide** (`/help`)
- **Mentions légales** (`/legal`)

## 🌿 Gestion des Branches

- **`main`** : Branche de production (code stable v1.0 - authentification uniquement)
- **`base`** : Branche de développement (v1.2 - navigation + accueil + matchs + chat + profil complets)
- **`feature/*`** : Branches temporaires pour le développement de fonctionnalités

## 🏗️ Architecture

Le projet suit l'architecture **Clean Architecture** avec une séparation claire des responsabilités :

```
lib/
├── main.dart                          # Point d'entrée avec 3 Providers
├── config/
│   ├── routes/app_router.dart        # 13 routes avec bottom nav
│   └── theme/app_theme.dart          # Thème Material 3
├── core/constants/
│   ├── colors.dart                   # Palette complète
│   └── text_styles.dart              # 8+ styles de texte
├── features/
│   ├── auth/                         # Authentification
│   │   └── presentation/
│   │       ├── screens/              # Start, SignIn, SignUp
│   │       └── widgets/              # CustomButton, CustomTextField
│   ├── home/                         # Écran d'accueil
│   │   ├── data/
│   │   │   └── mock_profiles.dart    # 30 profils mock
│   │   ├── domain/models/
│   │   │   └── profile.dart          # Modèle Profile
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── home_provider.dart # State management
│   │       ├── screens/
│   │       │   └── home_screen.dart   # Deck swipable
│   │       └── widgets/
│   │           ├── profile_card.dart  # Carte de profil
│   │           ├── swipe_buttons.dart # Boutons d'action
│   │           └── profile_deck.dart  # Deck swipable
│   ├── matches/                      # Matchs ⭐ NOUVEAU
│   │   ├── data/
│   │   │   └── mock_matches.dart     # 8 demandes mock
│   │   ├── domain/models/
│   │   │   └── match_request.dart    # Modèle MatchRequest
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── matches_provider.dart # State management
│   │       ├── screens/
│   │       │   └── matches_screen.dart  # TabBar Demandes/Confirmés
│   │       └── widgets/
│   │           └── match_request_card.dart # Carte de demande
│   ├── chat/                         # Chat
│   │   ├── domain/models/
│   │   │   └── message.dart          # Modèles Message & Conversation
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── chat_list_screen.dart
│   │       │   └── chat_detail_screen.dart
│   │       └── widgets/
│   │           ├── chat_bubble.dart
│   │           └── conversation_card.dart
│   ├── profile/                      # Profil utilisateur ⭐ NOUVEAU
│   │   ├── data/
│   │   │   └── mock_user.dart        # Profil utilisateur mock
│   │   ├── domain/models/
│   │   │   ├── user_profile.dart     # Modèle UserProfile
│   │   │   └── user_preferences.dart # Modèle UserPreferences
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── profile_provider.dart # State management
│   │       ├── screens/
│   │       │   ├── profile_screen.dart   # Affichage complet
│   │       │   └── edit_profile_screen.dart # Édition
│   │       └── widgets/
│   │           ├── profile_header.dart    # En-tête
│   │           ├── profile_info_card.dart # Carte info
│   │           ├── photo_grid.dart        # Grille photos
│   │           └── interest_chip.dart     # Chip intérêt
│   └── settings/                     # Paramètres ⭐ NOUVEAU
│       └── presentation/screens/
│           ├── privacy_screen.dart
│           ├── notifications_settings_screen.dart
│           ├── account_screen.dart
│           ├── help_screen.dart
│           └── legal_screen.dart
└── shared/widgets/
    └── custom_bottom_nav.dart        # Bottom navigation
```

## 🎨 Charte Graphique

### Palette de Couleurs
- **Primary**: `#FF3B3B` (Rouge vif)
- **Primary Pressed**: `#E23333` (Rouge foncé)
- **Background**: `#FFF5F2` (Beige/rose pâle)
- **Card Background**: `#FFFFFF` (Blanc)
- **Text Primary**: `#1F2937` (Gris très foncé)
- **Text Secondary**: `#374151` (Gris foncé)
- **Text Muted**: `#6B7280` (Gris moyen)

### Design System
- **Border Radius**: 24px (général), 16px (cartes), 12px (petits éléments)
- **Title Font Weight**: Semi-gras (600)
- **Transitions**: 150ms slide animations

## 🛠️ Technologies

- **Framework**: Flutter 3.35.4
- **Dart**: 3.9.2
- **Navigation**: GoRouter 14.8.1
- **State Management**: Provider 6.1.5
- **UI Components**: 
  - flutter_card_swiper 7.0.1
  - cached_network_image 3.4.1
  - flutter_svg 2.0.10+1
- **Utilities**: intl 0.19.0
- **Architecture**: Clean Architecture

## 📦 Installation

1. **Cloner le repository**
```bash
git clone https://github.com/RBSoftwareAI/matchup2.git
cd matchup2
```

2. **Choisir la branche**
```bash
# Pour développement actif (v1.2 - recommandé)
git checkout base

# Pour version stable (v1.0 - authentification uniquement)
git checkout main
```

3. **Installer les dépendances**
```bash
flutter pub get
```

4. **Lancer l'application**
```bash
flutter run
```

## 🌐 Build Web

Pour créer un build web de production :

```bash
flutter build web --release
cd build/web
python3 -m http.server 5060
```

## 🧪 Tests

```bash
# Analyse statique du code
flutter analyze

# Lancer les tests unitaires
flutter test

# Formater le code
dart format .
```

## 📱 Écrans Disponibles

### 1. Start Screen (`/start`)
Écran d'accueil présentant l'application avec :
- Titre et description de l'app
- Bouton "Démarrer"
- Footer légal (CGU & Politique de confidentialité)

### 2. Sign In Screen (`/signin`)
Écran de connexion avec :
- Champ email (validation regex)
- Champ mot de passe (obscureText)
- Lien "Mot de passe oublié ?" (inactif)
- Lien vers création de compte
- Validation des champs en temps réel
- Redirection automatique vers `/home` après connexion

### 3. Sign Up Screen (`/signup`)
Écran d'inscription avec :
- Champ nom (min 2 caractères)
- Champ email (validation regex)
- Champ mot de passe (min 6 caractères)
- Champ confirmation mot de passe
- Validation que les mots de passe correspondent
- Lien vers connexion
- Redirection automatique vers `/home` après inscription

### 4. Home Screen (`/home`) ⭐
Écran principal avec deck swipable :
- 30 profils avec photos, infos et intérêts
- 3 onglets de filtrage (Tout, Recommandés, New)
- Swipe gestures (gauche/droite/haut)
- Boutons d'action en bas
- Compteur de profils restants
- État vide avec message

### 5. Matches Screen (`/matches`) ⭐ NOUVEAU
Écran de matchs avec TabBar :
- **Onglet "Demandes"** : 8 demandes de match avec actions Accepter/Refuser
- **Onglet "Confirmés"** : Liste des matches confirmés avec accès au chat
- États vides avec illustrations
- Intégration automatique avec le chat

### 6. Chat List Screen (`/chat`) ⭐
Liste des conversations avec :
- Avatars circulaires
- Aperçu du dernier message
- Timestamps formatés
- Badges de messages non lus
- Barre de recherche

### 7. Chat Detail Screen (`/chat/:userId`) ⭐
Conversation individuelle avec :
- Historique des messages
- Bulles de chat stylisées
- Champ de saisie
- Envoi en temps réel (mock)

### 8. Profile Screen (`/profile`) ⭐ NOUVEAU
Écran de profil complet avec :
- En-tête (avatar, nom, âge, localisation)
- Sections : Informations, Photos, Centres d'intérêt, Préférences
- Navigation vers paramètres
- Bouton déconnexion

### 9. Edit Profile Screen (`/edit-profile`) ⭐ NOUVEAU
Écran d'édition de profil :
- Formulaire complet
- Modification photo (mock)
- Gestion des centres d'intérêt
- Sauvegarde avec feedback

### 10-14. Settings Screens ⭐ NOUVEAU
- `/privacy` - Confidentialité
- `/notifications-settings` - Notifications
- `/account` - Compte & sécurité
- `/help` - Aide
- `/legal` - Mentions légales

## 🔧 Configuration

### Routes
Les routes sont configurées dans `lib/config/routes/app_router.dart` :
- `/start` - Écran de démarrage (route initiale)
- `/signin` - Écran de connexion
- `/signup` - Écran d'inscription
- `/home` - Écran d'accueil avec deck swipable
- `/matches` - Écran de matchs avec TabBar
- `/chat` - Liste de conversations
- `/chat/:userId` - Conversation détaillée
- `/profile` - Profil utilisateur
- `/edit-profile` - Édition de profil
- `/privacy` - Confidentialité
- `/notifications-settings` - Notifications
- `/account` - Compte & sécurité
- `/help` - Aide
- `/legal` - Mentions légales

### Thème
Le thème global est défini dans `lib/config/theme/app_theme.dart` avec :
- Material Design 3
- Couleurs personnalisées
- Styles de boutons et champs de texte
- Transitions cohérentes

## 📝 Convention de Code

- **Langue des commentaires**: Anglais
- **Langue de l'UI**: Français
- **Style**: Dart official style guide
- **Imports**: Relatifs pour les fichiers du même package
- **Const constructors**: Utilisés systématiquement

## 🎯 Comment Tester l'Application

1. Lancez l'application
2. Cliquez sur "Démarrer"
3. Entrez n'importe quel email/mot de passe valide (mode mock)
   - Exemple : `test@test.com` / `password`
4. Explorez les 4 onglets :
   - **Accueil** : Swipez les profils, testez les filtres
   - **Matchs** : Acceptez/Refusez des demandes, consultez les matches confirmés
   - **Chat** : Ouvrez une conversation et envoyez des messages
   - **Profil** : Consultez et modifiez votre profil, explorez les paramètres

## 🚧 Prochaines Étapes (Phase 3)

### Priorité Haute
- [ ] Intégration Firebase Authentication
- [ ] Firebase Firestore pour les profils
- [ ] Firebase Storage pour les photos
- [ ] Upload de photos utilisateur réel
- [ ] Paramètres de confidentialité fonctionnels
- [ ] Paramètres de notifications fonctionnels

### Priorité Moyenne
- [ ] Algorithme IA de recommandation avancé
- [ ] Matching en temps réel
- [ ] Chat en temps réel avec Firestore
- [ ] Notifications push
- [ ] Tests unitaires et d'intégration

### Priorité Basse
- [ ] Fonctionnalités premium
- [ ] Internationalisation (i18n)
- [ ] Accessibility improvements
- [ ] Performance optimization

## 📚 Documentation

Pour plus de détails sur l'architecture et le développement :
- **AI_QUICK_START.md** : Guide rapide pour les sessions IA
- **CONTEXT.md** : Documentation technique complète

## 📊 Statistiques du Projet

- **Lignes de code** : ~12,000+ lignes
- **Fichiers Dart** : 40+ fichiers
- **Modèles de données** : 6 modèles
- **Providers** : 3 providers (Home, Matches, Profile)
- **Routes** : 13 routes configurées
- **Widgets réutilisables** : 15+ widgets
- **Données mock** : 
  - 30 profils
  - 8 demandes de match
  - 1 profil utilisateur complet

## 📄 License

Propriétaire - RBSoftwareAI

## 👥 Équipe

Développé avec ❤️ par l'équipe RBSoftwareAI

---

**Version actuelle** : v1.2 (branche `base`)  
**Dernière mise à jour** : Session 3 - Écrans Matchs et Profil complets
