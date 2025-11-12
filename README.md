# MatchUp - Application de Rencontres avec IA

Application mobile de rencontres utilisant l'intelligence artificielle pour matcher les utilisateurs selon leurs préférences.

## 🚀 Description

MatchUp est une application Flutter moderne qui analyse vos préférences et vous connecte aux profils compatibles grâce à un algorithme d'IA.

## 📱 Fonctionnalités Actuelles

### Authentification (v1.0 - Stable sur `main`)
- ✅ Écran de démarrage avec présentation de l'app
- ✅ Écran de connexion avec validation email/password
- ✅ Écran d'inscription avec validation complète
- ✅ Navigation fluide avec GoRouter
- ✅ Design cohérent suivant la charte graphique MatchUp

## 🌿 Gestion des Branches

- **`main`** : Branche de production (code stable et testé uniquement)
- **`base`** : Branche de développement (développement actif, nouvelles features)
- **`feature/*`** : Branches temporaires pour le développement de fonctionnalités

## 🏗️ Architecture

Le projet suit l'architecture **Clean Architecture** avec une séparation claire des responsabilités :

```
lib/
├── main.dart                          # Point d'entrée de l'application
├── config/                            # Configuration globale
│   ├── routes/
│   │   └── app_router.dart           # Configuration GoRouter
│   └── theme/
│       └── app_theme.dart            # Thème de l'application
├── core/                              # Éléments partagés core
│   └── constants/
│       ├── colors.dart               # Palette de couleurs
│       └── text_styles.dart          # Styles de texte
├── features/                          # Fonctionnalités par domaine
│   └── auth/                         # Domaine authentification
│       ├── presentation/
│       │   ├── screens/             # Écrans UI
│       │   │   ├── start_screen.dart
│       │   │   ├── sign_in_screen.dart
│       │   │   └── sign_up_screen.dart
│       │   └── widgets/             # Widgets réutilisables
│       │       ├── custom_button.dart
│       │       ├── custom_text_field.dart
│       │       └── auth_footer.dart
│       └── domain/                  # Logique métier (à venir)
└── shared/                           # Widgets partagés globaux
    └── widgets/
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
- **Navigation**: GoRouter 14.8.1
- **Architecture**: Clean Architecture
- **State Management**: StatefulWidget (sera étendu avec Provider/Riverpod)

## 📦 Installation

1. **Cloner le repository**
```bash
git clone https://github.com/RBSoftwareAI/matchup2.git
cd matchup2
```

2. **Choisir la branche**
```bash
# Pour développement actif
git checkout base

# Pour version stable (production)
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

### 3. Sign Up Screen (`/signup`)
Écran d'inscription avec :
- Champ nom (min 2 caractères)
- Champ email (validation regex)
- Champ mot de passe (min 6 caractères)
- Champ confirmation mot de passe
- Validation que les mots de passe correspondent
- Lien vers connexion

## 🔧 Configuration

### Routes
Les routes sont configurées dans `lib/config/routes/app_router.dart` :
- `/start` - Écran de démarrage (route initiale)
- `/signin` - Écran de connexion
- `/signup` - Écran d'inscription

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

## 🚧 Prochaines Étapes

- [ ] Intégration Firebase Authentication
- [ ] Écrans de profil utilisateur
- [ ] Système de matching avec IA
- [ ] Chat en temps réel
- [ ] Gestion des préférences utilisateur
- [ ] Tests unitaires et d'intégration

## 📄 License

Propriétaire - RBSoftwareAI

## 👥 Équipe

Développé avec ❤️ par l'équipe RBSoftwareAI
