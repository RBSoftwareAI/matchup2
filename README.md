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

### ✅ Navigation Principale (v1.1 - Sur `base`)
- Bottom navigation à 4 onglets : Accueil, Matchs, Chat, Profil
- Navigation fluide avec GoRouter
- 8 routes configurées

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

### 🚧 En Développement
- Écran Matchs (placeholder)
- Écran Profil (placeholder)

## 🌿 Gestion des Branches

- **`main`** : Branche de production (code stable v1.0 - authentification uniquement)
- **`base`** : Branche de développement (v1.1 - navigation principale + accueil + chat)
- **`feature/*`** : Branches temporaires pour le développement de fonctionnalités

## 🏗️ Architecture

Le projet suit l'architecture **Clean Architecture** avec une séparation claire des responsabilités :

```
lib/
├── main.dart                          # Point d'entrée avec Provider
├── config/
│   ├── routes/app_router.dart        # 8 routes avec bottom nav
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
│   ├── matches/                      # Matchs
│   │   └── presentation/screens/     # MatchesScreen (placeholder)
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
│   └── profile/                      # Profil utilisateur
│       └── presentation/screens/     # ProfileScreen (placeholder)
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
- **Text Muted**: `#6B7280` (Gris moyen)

### Design System
- **Border Radius**: 24px
- **Title Font Weight**: Semi-gras (600)
- **Transitions**: 150ms slide animations

## 🛠️ Technologies

- **Framework**: Flutter 3.35.4
- **Dart**: 3.9.2
- **Navigation**: GoRouter 14.6.2
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
# Pour développement actif (v1.1 - recommandé)
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

### 5. Matches Screen (`/matches`)
Écran de matchs (placeholder)

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

### 8. Profile Screen (`/profile`)
Écran de profil (placeholder)

## 🔧 Configuration

### Routes
Les routes sont configurées dans `lib/config/routes/app_router.dart` :
- `/start` - Écran de démarrage (route initiale)
- `/signin` - Écran de connexion
- `/signup` - Écran d'inscription
- `/home` - Écran d'accueil avec deck swipable
- `/matches` - Écran de matchs
- `/chat` - Liste de conversations
- `/chat/:userId` - Conversation détaillée
- `/profile` - Profil utilisateur

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
   - **Matchs** : Écran en développement
   - **Chat** : Ouvrez une conversation et envoyez des messages
   - **Profil** : Écran en développement

## 🚧 Prochaines Étapes (Phase 3)

### Priorité Haute
- [ ] Intégration Firebase Authentication
- [ ] Firebase Firestore pour les profils
- [ ] Firebase Storage pour les photos
- [ ] Écran de création/édition de profil complet
- [ ] Upload de photos utilisateur

### Priorité Moyenne
- [ ] Écran Matchs avec logique de matching
- [ ] Algorithme IA de recommandation avancé
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

## 📄 License

Propriétaire - RBSoftwareAI

## 👥 Équipe

Développé avec ❤️ par l'équipe RBSoftwareAI

---

**Version actuelle** : v1.1 (branche `base`)  
**Dernière mise à jour** : Session 2 - Navigation principale et écran d'accueil
