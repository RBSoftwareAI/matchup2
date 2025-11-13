# 🌿 Stratégie de Gestion des Branches - MatchUp

Documentation de la stratégie Git pour le projet MatchUp.

## 📋 Structure des Branches

### `main` - Production (Branche Principale)
**Rôle** : Code stable, testé et prêt pour la production

**Caractéristiques** :
- ✅ Code entièrement testé et validé
- ✅ Fonctionnalités complètes et stables
- ✅ Pas de work in progress
- ✅ Déployable en production à tout moment
- 🔒 Protégée contre les push directs

**Workflow** :
```bash
# Merge depuis base après validation
git checkout main
git merge base --no-ff
git push origin main

# Tag les versions
git tag -a v1.0.0 -m "Version 1.0.0 - Initial release"
git push origin v1.0.0
```

---

### `base` - Développement (Branche de Travail)
**Rôle** : Développement actif, intégration des nouvelles fonctionnalités

**Caractéristiques** :
- 🚧 Work in progress autorisé
- 🔄 Commits fréquents
- 🧪 Tests en cours
- ⚡ Intégration continue des features
- 📝 Documentation à jour

**Workflow** :
```bash
# Développement quotidien
git checkout base
git pull origin base

# Faire vos modifications...
git add .
git commit -m "feat: nouvelle fonctionnalité"
git push origin base
```

---

### `feature/*` - Fonctionnalités Spécifiques
**Rôle** : Développement isolé d'une fonctionnalité

**Convention de nommage** :
- `feature/auth-firebase` - Intégration Firebase Auth
- `feature/user-profile` - Système de profil utilisateur
- `feature/matching-algo` - Algorithme de matching
- `feature/chat-system` - Système de chat

**Workflow** :
```bash
# Créer une feature branch depuis base
git checkout base
git pull origin base
git checkout -b feature/nom-fonctionnalite

# Développer la feature...
git add .
git commit -m "feat: description"
git push origin feature/nom-fonctionnalite

# Créer une Pull Request vers base
# Après review et validation, merger dans base
git checkout base
git merge feature/nom-fonctionnalite --no-ff
git push origin base

# Supprimer la feature branch
git branch -d feature/nom-fonctionnalite
git push origin --delete feature/nom-fonctionnalite
```

---

### `hotfix/*` - Corrections Urgentes Production
**Rôle** : Corrections critiques sur la production

**Convention de nommage** :
- `hotfix/fix-login-crash` - Correction crash login
- `hotfix/security-patch` - Patch de sécurité

**Workflow** :
```bash
# Créer depuis main (pas base!)
git checkout main
git pull origin main
git checkout -b hotfix/fix-description

# Corriger le bug...
git add .
git commit -m "fix: correction urgente"

# Merger dans main
git checkout main
git merge hotfix/fix-description --no-ff
git push origin main

# Aussi merger dans base pour ne pas perdre le fix
git checkout base
git merge hotfix/fix-description --no-ff
git push origin base

# Tag la nouvelle version patch
git checkout main
git tag -a v1.0.1 -m "Hotfix v1.0.1"
git push origin v1.0.1

# Supprimer le hotfix branch
git branch -d hotfix/fix-description
git push origin --delete hotfix/fix-description
```

---

## 🔄 Workflow Complet

### 1. Développement d'une Nouvelle Fonctionnalité

```mermaid
base → feature/xxx → PR → base → (tests) → main
```

```bash
# 1. Créer feature branch
git checkout base
git checkout -b feature/user-profile

# 2. Développer
git commit -m "feat: add user profile screen"
git commit -m "feat: add profile edit form"
git commit -m "test: add profile tests"

# 3. Push et PR
git push origin feature/user-profile
# Créer Pull Request sur GitHub

# 4. Review et merge dans base
git checkout base
git merge feature/user-profile --no-ff
git push origin base

# 5. Tests sur base
flutter test
flutter analyze

# 6. Si stable, merger dans main
git checkout main
git merge base --no-ff
git tag -a v1.1.0 -m "Add user profile feature"
git push origin main --tags
```

### 2. Développement Quotidien Simple

```bash
# Travailler directement sur base
git checkout base
git pull origin base

# Modifier des fichiers
git add .
git commit -m "feat: amélioration UI"
git push origin base
```

### 3. Release en Production

```bash
# 1. S'assurer que base est testé
git checkout base
flutter test
flutter analyze

# 2. Merger dans main
git checkout main
git merge base --no-ff

# 3. Tag la version
git tag -a v1.2.0 -m "Release v1.2.0 - Chat feature"

# 4. Push
git push origin main --tags
```

---

## 📝 Conventions de Commit

### Format
```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types
- `feat`: Nouvelle fonctionnalité
- `fix`: Correction de bug
- `docs`: Documentation seulement
- `style`: Formatage, style (pas de changement de code)
- `refactor`: Refactorisation
- `test`: Ajout ou modification de tests
- `chore`: Maintenance, dépendances

### Exemples
```bash
feat(auth): add Firebase authentication
fix(login): resolve null pointer exception
docs(readme): update installation instructions
refactor(profile): simplify user data model
test(matching): add unit tests for algorithm
chore(deps): update flutter dependencies
```

---

## 🛡️ Protection des Branches

### Recommandations GitHub

**Pour `main`** :
- ✅ Require pull request reviews (1+ approvals)
- ✅ Require status checks to pass
- ✅ Require branches to be up to date
- ✅ Include administrators
- ❌ Allow force pushes (JAMAIS!)

**Pour `base`** :
- ⚠️ Plus flexible, mais recommandé :
- ✅ Require status checks (flutter analyze, tests)
- ⚠️ Review optionnelle selon la taille de l'équipe

---

## 📊 État Actuel du Projet

### Branches Existantes

| Branche | Commit | Description |
|---------|--------|-------------|
| `main` | `faa18e6` | Version stable 1.0.0 - Auth screens |
| `base` | `faa18e6` | Développement actif |

### Prochains Développements (sur `base`)

1. **Phase 2** : Firebase Authentication
   - Branch: `feature/firebase-auth`
   - Statut: À créer

2. **Phase 3** : User Profile
   - Branch: `feature/user-profile`
   - Statut: À créer

3. **Phase 4** : Matching Algorithm
   - Branch: `feature/matching-algo`
   - Statut: À créer

---

## 🎯 Best Practices

### DO ✅
- Toujours partir de `base` pour créer une feature
- Faire des commits atomiques et descriptifs
- Tester avant de merger dans `main`
- Utiliser `--no-ff` pour conserver l'historique
- Créer des PR pour les features importantes
- Tag les versions de production

### DON'T ❌
- Ne JAMAIS force push sur `main`
- Ne pas commiter directement sur `main`
- Ne pas merger dans `main` sans tests
- Ne pas créer de branches depuis d'autres features
- Ne pas laisser des branches feature mortes

---

## 🔍 Commandes Utiles

```bash
# Voir toutes les branches
git branch -a

# Voir l'historique graphique
git log --graph --oneline --all

# Voir les différences entre branches
git diff main..base

# Nettoyer les branches locales supprimées
git fetch -p && git branch -vv | grep 'gone]' | awk '{print $1}' | xargs git branch -d

# Voir qui a modifié quoi
git blame <file>

# Revenir en arrière sur base (ATTENTION!)
git checkout base
git reset --hard origin/base
```

---

**Document créé** : Session 1  
**Dernière mise à jour** : Session 1  
**Maintenu par** : RBSoftwareAI Team
