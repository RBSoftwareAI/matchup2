# 🤖 AI Quick Start - MatchUp

Guide rapide pour reprendre le développement de MatchUp lors de la prochaine session IA.

## 📊 État Actuel du Projet

### ✅ Complété (Version Stable sur `main`)
- Architecture Clean mise en place
- Configuration GoRouter avec navigation fluide
- Thème personnalisé avec charte graphique MatchUp
- 3 écrans d'authentification fonctionnels (Start, SignIn, SignUp)
- Widgets réutilisables (CustomButton, CustomTextField, AuthFooter)
- Validations de formulaire en temps réel
- Design responsive et cohérent

### 🎯 Version Actuelle: 1.0.0+1
**Branche de production**: `main` (code stable et testé)  
**Branche de développement**: `base` (développement actif)  
**Repository**: https://github.com/RBSoftwareAI/matchup2

### 🌿 Workflow Git
- **`main`**: Branche de production (code stable uniquement)
- **`base`**: Branche de développement (travail en cours)
- **`feature/*`**: Branches pour nouvelles fonctionnalités

## 🏗️ Architecture Actuelle

```
lib/
├── main.dart                          # MaterialApp.router avec GoRouter
├── config/
│   ├── routes/app_router.dart        # 3 routes: /start, /signin, /signup
│   └── theme/app_theme.dart          # Thème Material 3 personnalisé
├── core/constants/
│   ├── colors.dart                   # Palette complète (#FF3B3B primary)
│   └── text_styles.dart              # 8+ styles de texte
├── features/auth/
│   ├── presentation/
│   │   ├── screens/                  # 3 écrans (Start, SignIn, SignUp)
│   │   └── widgets/                  # 3 widgets (Button, TextField, Footer)
│   └── domain/                       # Vide (prêt pour logique métier)
└── shared/widgets/                   # Vide (prêt pour widgets globaux)
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

### Phase 2 (Priorité Haute)
1. **Firebase Integration**
   - Ajouter Firebase Auth
   - Créer services d'authentification
   - Implémenter login/signup réels
   
2. **State Management**
   - Intégrer Provider ou Riverpod
   - Créer AuthProvider
   - Gérer l'état utilisateur global

3. **Profil Utilisateur**
   - Écran de création de profil
   - Upload de photos
   - Définition des préférences

### Phase 3 (Priorité Moyenne)
4. **Matching Algorithm**
   - Intégration API IA
   - Écran de découverte
   - Système de swipe/like

5. **Chat & Messages**
   - Liste des matches
   - Chat en temps réel (Firebase Realtime DB)
   - Notifications push

## 🐛 Problèmes Connus

Aucun problème connu actuellement. Le code compile sans erreur et toutes les fonctionnalités mock fonctionnent correctement.

## 📦 Dépendances Actuelles

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  go_router: ^14.8.1

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
2. **Respecter l'architecture Clean**: Nouvelle feature = nouveau dossier dans `features/`
3. **Widgets réutilisables**: Placer dans `features/X/presentation/widgets/` si spécifique, sinon `shared/widgets/`
4. **Tests**: Créer un test pour chaque nouvelle fonctionnalité critique
5. **Navigation**: Ajouter les nouvelles routes dans `app_router.dart`

## 📞 Contexte Projet

**Objectif**: Application de rencontres moderne utilisant l'IA pour améliorer le matching
**Public Cible**: Adultes 18-45 ans cherchant des relations sérieuses
**USP**: Algorithm d'IA avancé pour des matches de qualité

## 📚 Ressources Utiles

- [Go Router Documentation](https://pub.dev/packages/go_router)
- [Flutter Clean Architecture](https://github.com/ResoCoder/flutter-tdd-clean-architecture-course)
- [Material Design 3](https://m3.material.io/)
- [Firebase Flutter Setup](https://firebase.google.com/docs/flutter/setup)

---

**Dernière mise à jour**: Session 1 - Création de la base du projet  
**Prochaine session**: Intégration Firebase Authentication
