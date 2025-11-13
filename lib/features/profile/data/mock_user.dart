import '../domain/models/user_profile.dart';
import '../domain/models/user_preferences.dart';

/// Mock user profile (current user)
final UserProfile mockUserProfile = UserProfile(
  id: 'user_current',
  name: 'Thomas Dupont',
  age: 28,
  city: 'Paris',
  country: 'France',
  bio: 'Passionné de technologie et de voyages. J\'aime découvrir de nouvelles cultures et partager de bons moments. Cherche une relation sérieuse basée sur la complicité et les valeurs communes.',
  jobTitle: 'Développeur Full Stack',
  company: 'Tech Innovation',
  education: 'Master Informatique - Sorbonne Université',
  heightCm: 178,
  interests: [
    'Technologie',
    'Voyages',
    'Photographie',
    'Cuisine',
    'Sport',
    'Cinéma',
    'Musique',
    'Randonnée',
  ],
  photoUrls: [
    'https://i.pravatar.cc/400?img=12',
    'https://i.pravatar.cc/400?img=13',
    'https://i.pravatar.cc/400?img=14',
    'https://i.pravatar.cc/400?img=15',
    'https://i.pravatar.cc/400?img=16',
    'https://i.pravatar.cc/400?img=17',
  ],
  preferences: const UserPreferences(
    preferredGenders: ['Femme'],
    minAge: 22,
    maxAge: 35,
    maxDistanceKm: 20,
  ),
);
