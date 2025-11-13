# 💕 MatchUp - Application de Rencontres avec IA

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.35.4-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-Private-red)
![Version](https://img.shields.io/badge/Version-1.3.0+1-green)

**Trouvez votre match parfait avec l'intelligence artificielle**

[Démo Web](#-démo-web) • [Fonctionnalités](#-fonctionnalités) • [Installation](#-installation) • [Architecture](#-architecture) • [Contribuer](#-contribuer)

</div>

---

## 📖 À Propos

**MatchUp** est une application de rencontres moderne qui utilise l'intelligence artificielle pour créer des matches de qualité. L'application offre une expérience utilisateur fluide et intuitive avec un design soigné inspiré de Material Design 3.

### 🎯 Objectifs du Projet

- 💝 Faciliter les rencontres authentiques entre personnes compatibles
- 🤖 Utiliser l'IA pour améliorer la qualité du matching
- 🎨 Offrir une expérience utilisateur exceptionnelle
- 🔒 Garantir la confidentialité et la sécurité des données

### 👥 Public Cible

Adultes de 18 à 45 ans recherchant des relations sérieuses et durables.

---

## ✨ Fonctionnalités

### 🔐 Authentification
- ✅ Inscription avec email et mot de passe
- ✅ Connexion sécurisée
- ✅ Validation en temps réel des formulaires
- 🔜 Authentification Firebase (prochaine version)

### 🏠 Écran d'Accueil
- ✅ Deck de profils swipable (glisser pour liker/disliker)
- ✅ 3 filtres de découverte (Tout, Recommandés, Nouveaux)
- ✅ Actions rapides : Like, Super Like, Dislike
- ✅ Affichage complet des profils avec photos et informations

### 💬 Chat
- ✅ Liste de conversations avec aperçu des derniers messages
- ✅ Interface de conversation intuitive
- ✅ Envoi de messages en temps réel (mock)
- ✅ Indicateurs visuels de statut en ligne
- 🔜 Chat temps réel avec Firebase

### 🤝 Matchs
- ✅ Gestion des demandes de match (Accepter/Refuser)
- ✅ Liste des matchs confirmés
- ✅ Création automatique de conversation lors de l'acceptation
- ✅ Navigation fluide vers les profils et conversations

### 👤 Profil Utilisateur
- ✅ Affichage complet du profil avec photos
- ✅ Édition de toutes les informations personnelles
- ✅ Gestion des centres d'intérêt
- ✅ Définition des préférences de matching
- ✅ Galerie de photos (6 emplacements)
- 🔜 Upload de photos réel

### ⚙️ Paramètres Complets
- ✅ **Confidentialité** : Visibilité du profil, localisation, utilisateurs bloqués
- ✅ **Notifications** : Gestion fine de tous les types de notifications
- ✅ **Compte & Sécurité** : Changement de mot de passe, 2FA, gestion des appareils
- ✅ **Aide & Support** : FAQs, contact support, signalement de bugs
- ✅ **Mentions Légales** : CGU, Politique de confidentialité, Règles de la communauté

---

## 🚀 Démo Web

L'application est disponible en version web pour démonstration :

**[🌐 Accéder à la démo](https://5060-iarv63g03298gbbkxfyfo-ad490db5.sandbox.novita.ai)**

> ⚠️ **Note** : La démo utilise des données mock. L'intégration Firebase est prévue pour la prochaine version.

---

## 🛠️ Installation

### Prérequis

- **Flutter** : Version 3.35.4 ou supérieure
- **Dart** : Version 3.9.2 ou supérieure
- **Android Studio** ou **VS Code** avec extensions Flutter
- **Git** pour le versionnement

### Étapes d'Installation

1. **Cloner le repository**
```bash
git clone https://github.com/RBSoftwareAI/matchup2.git
cd matchup2
```

2. **Basculer sur la branche de développement**
```bash
git checkout base
```

3. **Installer les dépendances**
```bash
flutter pub get
```

4. **Vérifier l'installation**
```bash
flutter doctor
flutter analyze
```

5. **Lancer l'application**

**Mode Web (Développement)**
```bash
flutter run -d chrome
```

**Mode Web (Production)**
```bash
flutter build web --release
cd build/web
python3 -m http.server 8080
```

**Mode Android**
```bash
flutter run
```

---

## 🏗️ Architecture

Le projet suit l'architecture **Clean Architecture** pour garantir la maintenabilité et l'évolutivité.

```
lib/
├── main.dart                          # Point d'entrée avec MultiProvider
├── config/
│   ├── routes/app_router.dart        # Configuration GoRouter (17 routes)
│   └── theme/app_theme.dart          # Thème Material 3 personnalisé
├── core/
│   └── constants/                    # Couleurs, styles de texte
├── features/                         # Fonctionnalités par domaine
│   ├── auth/                         # Authentification
│   ├── home/                         # Découverte de profils
│   ├── matches/                      # Gestion des matchs
│   ├── chat/                         # Messagerie
│   ├── profile/                      # Profil utilisateur
│   └── settings/                     # Paramètres
└── shared/                           # Composants partagés
    └── widgets/
```

### 🧩 Structure d'une Feature

Chaque feature suit le pattern Clean Architecture :

```
feature/
├── data/
│   ├── models/                       # Modèles de données
│   └── mock_data.dart               # Données de test
├── domain/
│   ├── models/                      # Entités métier
│   └── repositories/                # Interfaces repositories
└── presentation/
    ├── providers/                   # Gestion d'état (Provider)
    ├── screens/                     # Écrans UI
    └── widgets/                     # Widgets réutilisables
```

---

## 🎨 Design System

### Palette de Couleurs

```dart
Primary:        #FF3B3B  // Rouge principal
PrimaryPressed: #E23333  // Rouge foncé (hover/pressed)
Background:     #FFF5F2  // Fond rose clair
CardBg:         #FFFFFF  // Blanc pour les cartes
TextPrimary:    #1F2937  // Gris foncé pour le texte
TextMuted:      #6B7280  // Gris moyen pour texte secondaire
```

### Composants UI

- **Border Radius** : 24px (coins arrondis doux)
- **Typography** : Semi-bold (600) pour les titres
- **Animations** : 150ms avec `Curves.easeInOut`
- **Spacing** : Système basé sur multiples de 8

---

## 📦 Dépendances Principales

| Package | Version | Usage |
|---------|---------|-------|
| `go_router` | ^14.6.2 | Navigation déclarative |
| `provider` | 6.1.5 | Gestion d'état |
| `flutter_card_swiper` | ^7.0.1 | Deck de profils swipable |
| `cached_network_image` | ^3.4.1 | Cache d'images optimisé |
| `intl` | ^0.19.0 | Internationalisation |

**Voir le fichier `pubspec.yaml` pour la liste complète.**

---

## 🔄 Workflow Git

### Branches

- **`main`** : Branche de production (code stable uniquement)
- **`base`** : Branche de développement actif
- **`feature/*`** : Branches pour nouvelles fonctionnalités

### Processus de Contribution

1. **Créer une branche feature**
```bash
git checkout base
git checkout -b feature/nom-de-la-feature
```

2. **Développer et tester**
```bash
# Analyse du code
flutter analyze

# Formater le code
dart format .

# Tester
flutter test
```

3. **Commit avec message conventionnel**
```bash
git add .
git commit -m "feat: description claire de la fonctionnalité"
```

4. **Pousser et créer une PR**
```bash
git push origin feature/nom-de-la-feature
# Créer une Pull Request vers la branche base
```

### Convention de Commits

- `feat:` Nouvelle fonctionnalité
- `fix:` Correction de bug
- `docs:` Documentation
- `style:` Formatage du code
- `refactor:` Refactorisation
- `test:` Ajout de tests
- `chore:` Tâches de maintenance

---

## 🧪 Tests

### Lancer les Tests

```bash
# Tests unitaires
flutter test

# Tests d'intégration
flutter test integration_test/

# Coverage
flutter test --coverage
```

### Structure des Tests

```
test/
├── unit/                   # Tests unitaires
├── widget/                 # Tests de widgets
└── integration/            # Tests d'intégration
```

---

## 🚧 Roadmap

### ✅ Phase 1 - MVP (Complété)
- [x] Architecture Clean
- [x] Authentification UI
- [x] Navigation principale
- [x] Découverte de profils
- [x] Système de matchs
- [x] Chat basique
- [x] Profil utilisateur
- [x] Paramètres complets

### 🔄 Phase 2 - Backend (En cours)
- [ ] Intégration Firebase Auth
- [ ] Firestore pour les profils
- [ ] Cloud Storage pour les photos
- [ ] Chat temps réel
- [ ] Notifications push

### 🔜 Phase 3 - IA & Matching
- [ ] Algorithme de matching IA
- [ ] Recommandations personnalisées
- [ ] Analyse de compatibilité
- [ ] Filtres avancés

### 🔮 Phase 4 - Fonctionnalités Avancées
- [ ] Appels vidéo
- [ ] Stories
- [ ] Événements et rencontres
- [ ] Système de badges et récompenses
- [ ] Mode sombre

---

## 📱 Screenshots

> 🚧 Screenshots à venir après finalisation du design

---

## 🤝 Contribuer

Les contributions sont les bienvenues ! Veuillez suivre ces étapes :

1. **Fork** le projet
2. Créer une **branche feature** (`git checkout -b feature/AmazingFeature`)
3. **Committer** vos changements (`git commit -m 'feat: Add some AmazingFeature'`)
4. **Push** vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une **Pull Request**

### Guidelines de Contribution

- Respecter l'architecture Clean existante
- Suivre le style de code Dart officiel
- Écrire des tests pour les nouvelles fonctionnalités
- Documenter les changements importants
- Utiliser les conventions de commit

---

## 📄 License

Ce projet est privé et propriétaire. Tous droits réservés.

---

## 👨‍💻 Équipe de Développement

**RBSoftware AI** - Développement et maintenance

---

## 📞 Contact & Support

- **Email** : support@matchup.app
- **GitHub** : [RBSoftwareAI/matchup2](https://github.com/RBSoftwareAI/matchup2)
- **Issues** : [Signaler un bug](https://github.com/RBSoftwareAI/matchup2/issues)

---

## 🙏 Remerciements

- **Flutter Team** pour le framework exceptionnel
- **Material Design** pour les guidelines de design
- **Open Source Community** pour les packages utilisés

---

<div align="center">

**Fait avec ❤️ par RBSoftware AI**

⭐ **Star ce projet si vous l'aimez !** ⭐

</div>
