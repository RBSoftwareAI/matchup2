# 📖 CONTEXT - Documentation Complète MatchUp

Documentation technique exhaustive pour les développeurs et les IA travaillant sur le projet MatchUp.

## 🎯 Vision du Projet

### Objectif Principal
Créer une application de rencontres moderne qui utilise l'intelligence artificielle pour améliorer significativement la qualité des matches entre utilisateurs.

### Proposition de Valeur Unique (USP)
- **IA Avancée**: Algorithme de matching basé sur des critères psychologiques et comportementaux
- **Qualité > Quantité**: Focus sur des matches pertinents plutôt que sur le volume
- **Expérience Utilisateur**: Interface moderne, fluide et intuitive
- **Sécurité**: Vérification des profils et modération IA

### Public Cible
- **Âge**: 18-45 ans
- **Objectif**: Relations sérieuses et durables
- **Profil**: Utilisateurs urbains, connectés, valorisant la qualité

## 🏗️ Architecture Technique

### Principes Architecturaux

Le projet suit les principes de la **Clean Architecture** (Robert C. Martin) avec une séparation stricte en couches :

```
┌─────────────────────────────────────────┐
│        Presentation Layer               │
│  (UI, Widgets, Screens, Controllers)    │
├─────────────────────────────────────────┤
│        Domain Layer                     │
│  (Entities, Use Cases, Repository       │
│   Interfaces, Business Logic)           │
├─────────────────────────────────────────┤
│        Data Layer                       │
│  (Repository Implementations, Data      │
│   Sources, Models, DTOs)                │
└─────────────────────────────────────────┘
```

### Structure Détaillée des Dossiers

```
lib/
├── main.dart                              # Entry point
│   └── runApp(MyApp())
│
├── config/                                # Configuration globale
│   ├── routes/
│   │   └── app_router.dart               # GoRouter configuration
│   │       ├── initialLocation: '/start'
│   │       ├── Routes: /start, /signin, /signup
│   │       └── Transitions: SlideTransition 150ms
│   │
│   └── theme/
│       └── app_theme.dart                # Theme configuration
│           ├── Material 3
│           ├── ColorScheme personnalisé
│           ├── InputDecorationTheme
│           ├── ElevatedButtonTheme
│           └── TextButtonTheme
│
├── core/                                  # Core business logic
│   ├── constants/
│   │   ├── colors.dart                   # App color palette
│   │   │   ├── Primary: #FF3B3B
│   │   │   ├── PrimaryPressed: #E23333
│   │   │   ├── Background: #FFF5F2
│   │   │   ├── CardBackground: #FFFFFF
│   │   │   ├── TextPrimary: #1F2937
│   │   │   └── TextMuted: #6B7280
│   │   │
│   │   └── text_styles.dart             # Typography system
│   │       ├── Headlines: h1, h2, h3
│   │       ├── Body: bodyLarge, bodyMedium, bodySmall
│   │       ├── Button, Link, Caption
│   │       └── All using AppColors
│   │
│   ├── errors/                           # (À créer)
│   │   └── failures.dart
│   │
│   ├── usecases/                         # (À créer)
│   │   └── usecase.dart
│   │
│   └── utils/                            # (À créer)
│       └── validators.dart
│
├── features/                              # Features by domain
│   │
│   ├── auth/                             # Authentication feature
│   │   ├── data/                         # (À créer)
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_data_source.dart
│   │   │   │   └── auth_local_data_source.dart
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   │
│   │   ├── domain/                       # (Partiellement créé)
│   │   │   ├── entities/
│   │   │   │   └── user.dart            # (À créer)
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart # (À créer)
│   │   │   └── usecases/
│   │   │       ├── sign_in.dart         # (À créer)
│   │   │       └── sign_up.dart         # (À créer)
│   │   │
│   │   └── presentation/                 # ✅ Complété
│   │       ├── screens/
│   │       │   ├── start_screen.dart
│   │       │   │   ├── SafeArea + Column layout
│   │       │   │   ├── Logo placeholder (Container + Icon)
│   │       │   │   ├── Title + Subtitle
│   │       │   │   ├── CustomButton "Démarrer"
│   │       │   │   └── LegalFooter
│   │       │   │
│   │       │   ├── sign_in_screen.dart
│   │       │   │   ├── AppBar with back button
│   │       │   │   ├── Title "Connexion"
│   │       │   │   ├── Email field (validation regex)
│   │       │   │   ├── Password field (obscureText)
│   │       │   │   ├── "Mot de passe oublié ?" link
│   │       │   │   ├── CustomButton "Se connecter" (mock)
│   │       │   │   └── AuthFooter vers /signup
│   │       │   │
│   │       │   └── sign_up_screen.dart
│   │       │       ├── AppBar with back button
│   │       │       ├── Title "Créer un compte"
│   │       │       ├── Name field (min 2 chars)
│   │       │       ├── Email field (validation regex)
│   │       │       ├── Password field (min 6 chars)
│   │       │       ├── Confirm password field
│   │       │       ├── CustomButton "S'inscrire" (mock)
│   │       │       └── AuthFooter vers /signin
│   │       │
│   │       └── widgets/
│   │           ├── custom_button.dart
│   │           │   ├── Stateful pour animation pressed
│   │           │   ├── Couleur: primary/primaryPressed
│   │           │   ├── BorderRadius: 24
│   │           │   ├── Height: 56
│   │           │   ├── Loading state (CircularProgressIndicator)
│   │           │   └── Enabled/disabled states
│   │           │
│   │           ├── custom_text_field.dart
│   │           │   ├── Stateful pour obscureText toggle
│   │           │   ├── Real-time validation
│   │           │   ├── Error message display
│   │           │   ├── Icon toggle pour password
│   │           │   ├── BorderRadius: 24
│   │           │   └── Prefixes/suffixes support
│   │           │
│   │           └── auth_footer.dart
│   │               ├── AuthFooter (generic)
│   │               │   ├── RichText avec liens
│   │               │   └── TapGestureRecognizer
│   │               └── LegalFooter (specific)
│   │                   ├── "Conditions" link
│   │                   └── "Politique de confidentialité" link
│   │
│   ├── profile/                          # (À créer)
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── matching/                         # (À créer)
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── chat/                             # (À créer)
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── shared/                                # Shared across features
    ├── widgets/                          # (Vide, prêt)
    │   └── (widgets globaux futurs)
    ├── models/                           # (À créer)
    └── services/                         # (À créer)
```

## 🎨 Design System Complet

### Palette de Couleurs

```dart
// Couleurs primaires
Primary: #FF3B3B           // Rouge vif - Actions principales
PrimaryPressed: #E23333    // Rouge foncé - État pressé
PrimaryLight: #FF6B6B      // Rouge clair - Survol/hover

// Backgrounds
Background: #FFF5F2        // Beige/rose pâle - Fond général
CardBackground: #FFFFFF    // Blanc - Cartes et surfaces

// Textes
TextPrimary: #1F2937       // Gris très foncé - Texte principal
TextSecondary: #374151     // Gris foncé - Texte secondaire
TextMuted: #6B7280         // Gris moyen - Texte désactivé/placeholder

// Utilitaires
Error: #DC2626             // Rouge erreur
Success: #10B981           // Vert succès
Warning: #F59E0B           // Orange avertissement
Info: #3B82F6              // Bleu information

// Bordures et séparateurs
Border: #E5E7EB            // Gris très clair
Divider: #E5E7EB           // Gris très clair
```

### Typographie

```dart
// Headlines
h1: 32px, w600, TextPrimary, height: 1.2
h2: 24px, w600, TextPrimary, height: 1.3
h3: 20px, w600, TextPrimary, height: 1.3

// Body
bodyLarge: 16px, w400, TextPrimary, height: 1.5
bodyMedium: 14px, w400, TextPrimary, height: 1.5
bodySmall: 12px, w400, TextMuted, height: 1.4

// Spéciaux
button: 16px, w600, white, letterSpacing: 0.5
link: 14px, w500, Primary, underline
caption: 12px, w400, TextMuted, height: 1.4
```

### Espacements

```dart
// Padding standards
xs: 4px
sm: 8px
md: 16px
lg: 24px
xl: 32px
xxl: 48px

// Border Radius
small: 12px
medium: 16px
large: 24px       // Standard pour l'app
xlarge: 32px
```

### Composants

#### Boutons
```dart
// Primary Button (CustomButton)
Height: 56px
BorderRadius: 24px
Background: Primary (#FF3B3B)
Background (pressed): PrimaryPressed (#E23333)
Text: 16px, w600, white, letterSpacing: 0.5
Padding: horizontal 32px, vertical 16px
Transition: 150ms

// Text Button
Foreground: Primary
Text: 14px, w500
No background, no border
```

#### Champs de Texte (CustomTextField)
```dart
Height: 56px (avec padding)
BorderRadius: 24px
Background: CardBackground (#FFFFFF)
Border: 1px Border (#E5E7EB)
Border (focused): 2px Primary (#FF3B3B)
Border (error): 1px/2px Error (#DC2626)
ContentPadding: horizontal 20px, vertical 16px
Label: 14px, TextMuted
Hint: 14px, TextMuted
Error: 12px, Error
```

## 🔒 Règles de Validation

### Email
```dart
Regex: r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
Obligatoire: Oui
Message d'erreur: "Email invalide"
```

### Mot de Passe
```dart
Longueur minimale: 6 caractères
Obligatoire: Oui
Message d'erreur: "Le mot de passe doit contenir au moins 6 caractères"

// Phase 2 (renforcer):
Longueur minimale: 8 caractères
Doit contenir: 1 majuscule, 1 minuscule, 1 chiffre, 1 caractère spécial
```

### Nom
```dart
Longueur minimale: 2 caractères
Obligatoire: Oui
Message d'erreur: "Le nom doit contenir au moins 2 caractères"
```

### Confirmation Mot de Passe
```dart
Doit correspondre: Au champ mot de passe
Obligatoire: Oui
Message d'erreur: "Les mots de passe ne correspondent pas"
```

## 🗺️ Navigation & Routing

### Routes Actuelles

```dart
Route: /start
Name: start
Screen: StartScreen
Initial: true
Params: none
```

```dart
Route: /signin
Name: signin
Screen: SignInScreen
Initial: false
Params: none
```

```dart
Route: /signup
Name: signup
Screen: SignUpScreen
Initial: false
Params: none
```

### Transitions

```dart
Type: SlideTransition
Direction: Droite vers gauche (Offset(1.0, 0.0) -> Offset.zero)
Curve: Curves.easeInOut
Duration: 150ms
```

### Navigation Patterns

```dart
// Navigation vers une nouvelle route
context.go('/signin')

// Navigation avec remplacement (pas de back)
context.replace('/home')

// Navigation avec paramètres (futur)
context.go('/profile/${userId}')

// Navigation arrière
context.pop()
// Ou
Navigator.of(context).pop()
```

## 📦 Dépendances

### Actuelles

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  go_router: ^14.8.1      # Navigation déclarative

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0   # Linting rules
```

### Planifiées Phase 2

```yaml
dependencies:
  # State Management
  provider: ^6.1.5        # ou riverpod: ^2.5.1
  
  # Firebase
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  cloud_firestore: ^5.4.3
  firebase_storage: ^12.3.2
  
  # Networking
  http: ^1.2.2
  dio: ^5.7.0             # Alternative HTTP client
  
  # Local Storage
  shared_preferences: ^2.5.3
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # UI
  cached_network_image: ^3.4.1
  image_picker: ^1.1.2
  
  # Utilities
  intl: ^0.19.0           # Internationalization
  equatable: ^2.0.7       # Value equality
```

## 🧪 Standards de Qualité

### Code Style

```dart
// ✅ BON
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

// ❌ MAUVAIS
class MyWidget extends StatelessWidget {
  MyWidget();
  
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
```

### Commentaires

```dart
// ✅ BON - Commentaires en anglais pour le code
/// User authentication screen
/// 
/// Handles user sign in with email and password.
/// Validates input and displays appropriate error messages.
class SignInScreen extends StatefulWidget { }

// ❌ MAUVAIS - Commentaires en français dans le code
/// Écran de connexion utilisateur
class SignInScreen extends StatefulWidget { }
```

### Nommage

```dart
// Classes: PascalCase
class UserProfile { }

// Variables/Functions: camelCase
final userName = 'John';
void getUserData() { }

// Constants: camelCase with const
const maxRetries = 3;

// Files: snake_case
user_profile_screen.dart
auth_repository.dart

// Private: prefix with _
class _MyPrivateWidget { }
final _privateVariable = '';
```

## 🎯 Décisions Architecturales

### Pourquoi GoRouter ?
- Navigation déclarative type-safe
- Deep linking natif
- Gestion automatique du back stack
- Transitions personnalisables
- Meilleur que Navigator 1.0

### Pourquoi Clean Architecture ?
- Séparation des responsabilités claire
- Testabilité maximale
- Indépendance du framework
- Facilite la maintenance et l'évolution
- Standard dans l'industrie

### Pourquoi Material 3 ?
- Design moderne et cohérent
- Composants riches out-of-the-box
- Personnalisation facile via ThemeData
- Animations fluides intégrées
- Support multi-plateforme

### État Mock Actuel
**Raison**: Permet de valider l'UI/UX et la navigation avant l'intégration backend.

**Prochaine étape**: Remplacer par des appels Firebase Auth réels en Phase 2.

## 🚀 Roadmap Détaillée

### Phase 1: Base ✅ (Complétée)
- [x] Architecture Clean
- [x] Configuration theme et routes
- [x] Écrans d'authentification (mock)
- [x] Widgets réutilisables
- [x] Validations formulaires
- [x] Navigation fluide

### Phase 2: Navigation & Home ✅ (Complétée)
- [x] Bottom navigation à 4 onglets
- [x] Routes principales configurées (13 routes)
- [x] State management (Provider - 3 providers)
- [x] Écran Accueil avec deck swipable
- [x] 30 profils mock avec données variées
- [x] Système de filtrage (Tout, Recommandés, New)
- [x] Actions swipe (like, dislike, super like)
- [x] Chat fonctionnel (liste + détail)
- [x] **Écran Matchs complet avec TabBar**
- [x] **8 demandes de match mock**
- [x] **Actions Accepter/Refuser fonctionnelles**
- [x] **Écran Profil complet (Infos, Photos, Intérêts, Préférences)**
- [x] **Édition de profil fonctionnelle**
- [x] **Pages de paramètres (5 écrans)**
- [x] Widgets ProfileCard, SwipeButtons, ProfileDeck, MatchRequestCard, InterestChip
- [x] Modèles Profile, Message, MatchRequest, UserProfile, UserPreferences

### Phase 3: Firebase Integration (Priorité 1 - À FAIRE)
- [ ] Firebase setup
- [ ] Firebase Auth integration
- [ ] AuthRepository implementation
- [ ] Sign in/Sign up use cases réels
- [ ] Error handling
- [ ] Loading states
- [ ] Firestore pour profils
- [ ] Upload photos Firebase Storage

### Phase 4: User Profile (Priorité 2)
- [ ] Profile model étendu
- [ ] Profile creation screen
- [ ] Photo upload interface
- [ ] Profile edit screen
- [ ] Preferences definition
- [ ] Bio and interests management
- [ ] Settings screen

### Phase 5: Matching Avancé (Priorité 3)
- [ ] Intégration algorithme IA
- [ ] Système de recommandation avancé
- [ ] Match logic réelle
- [ ] Match notifications
- [ ] Match list screen complet
- [ ] Profile détail dans matches

### Phase 6: Chat Temps Réel (Priorité 4)
- [ ] Real-time messaging (Firestore)
- [ ] Message notifications
- [ ] Read receipts
- [ ] Image sharing
- [ ] Typing indicators
- [ ] Online status

### Phase 6: Premium Features (Priorité 5)
- [ ] Subscription system
- [ ] Premium badges
- [ ] Advanced filters
- [ ] Unlimited likes
- [ ] See who liked you

### Phase 7: Polish & Launch
- [ ] Animations refinement
- [ ] Performance optimization
- [ ] Tests (unit, widget, integration)
- [ ] Accessibility
- [ ] Internationalization (i18n)
- [ ] App Store / Play Store assets

## 📝 Conventions & Best Practices

### Git Workflow
```bash
# Branches
main           # Production code
develop        # Development integration
feature/*      # New features
bugfix/*       # Bug fixes
hotfix/*       # Emergency fixes

# Commits (Conventional Commits)
feat: Nouvelle fonctionnalité
fix: Correction de bug
docs: Documentation
style: Formatage, style
refactor: Refactorisation
test: Ajout de tests
chore: Maintenance
```

### Pull Requests
- Titre clair et descriptif
- Description détaillée des changements
- Screenshots si changements UI
- Tests ajoutés/passés
- Code reviewé par au moins 1 personne

### Tests
```dart
// Unit tests: test/unit/
// Widget tests: test/widgets/
// Integration tests: integration_test/

// Nommer: <fichier>_test.dart
// Ex: auth_repository_test.dart
```

## 🔐 Sécurité

### Données Sensibles
- **Jamais** de clés API dans le code
- Utiliser environment variables
- Firebase config via google-services.json (ignoré git)
- Secrets dans CI/CD

### Validation
- Toujours valider côté client ET serveur
- Sanitize les inputs
- Regex stricts pour email/password
- Rate limiting sur les endpoints

## 📊 Métriques & Monitoring

### KPIs à Suivre (Futur)
- Taux de conversion inscription
- Taux de complétion profil
- Nombre de matches par utilisateur
- Taux d'engagement messages
- Retention Day 1, Day 7, Day 30
- Crash rate
- Performance scores

## 🎓 Ressources d'Apprentissage

### Documentation Officielle
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/language)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Firebase for Flutter](https://firebase.google.com/docs/flutter/setup)

### Tutoriels Recommandés
- [Flutter Clean Architecture - Reso Coder](https://resocoder.com/flutter-clean-architecture-tdd/)
- [GoRouter Tutorial](https://codewithandrea.com/articles/flutter-navigation-gorouter-go-vs-push/)
- [Provider State Management](https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple)

### Design References
- [Material Design 3](https://m3.material.io/)
- [Flutter Widget Catalog](https://docs.flutter.dev/ui/widgets)
- [Tinder UI/UX Analysis](https://uxdesign.cc/)

---

**Document créé**: Session 1  
**Dernière mise à jour**: Session 3 (Écrans Matchs et Profil complets)  
**Maintenu par**: RBSoftwareAI Team
