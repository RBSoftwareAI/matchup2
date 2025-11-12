import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../providers/home_provider.dart';
import '../widgets/profile_deck.dart';
import '../widgets/swipe_buttons.dart';

/// Home screen with swipeable profile deck
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
      
      final provider = context.read<HomeProvider>();
      switch (_currentTabIndex) {
        case 0:
          provider.setFilter(ProfileFilter.all);
          break;
        case 1:
          provider.setFilter(ProfileFilter.recommended);
          break;
        case 2:
          provider.setFilter(ProfileFilter.newProfiles);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header with TabBar
            _buildHeader(),
            // Profile deck
            Expanded(
              child: _buildProfileDeck(),
            ),
            // Swipe buttons
            _buildSwipeButtons(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Build header with title and tab bar
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Accueil',
            style: AppTextStyles.h1,
          ),
          const SizedBox(height: 16),
          // Tab bar
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textPrimary,
              labelStyle: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: AppTextStyles.bodyMedium,
              indicator: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              padding: const EdgeInsets.all(4),
              tabs: const [
                Tab(text: 'Tout'),
                Tab(text: 'Recommandés'),
                Tab(text: 'New'),
              ],
            ),
          ),
          // Profile count
          Consumer<HomeProvider>(
            builder: (context, provider, child) {
              final count = provider.remainingProfilesCount;
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  '$count profils restants',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Build profile deck
  Widget _buildProfileDeck() {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }

        final profiles = provider.filteredProfiles;

        return ProfileDeck(
          key: ValueKey('${provider.currentFilter}_${profiles.length}'),
          profiles: profiles,
          onSwipeLeft: (profile) {
            provider.onSwipeLeft(profile);
          },
          onSwipeRight: (profile) {
            provider.onSwipeRight(profile);
          },
          onSwipeUp: (profile) {
            provider.onSwipeUp(profile);
          },
        );
      },
    );
  }

  /// Build swipe buttons
  Widget _buildSwipeButtons() {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        final profiles = provider.filteredProfiles;
        
        if (profiles.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SwipeButtons(
            onDislike: () {
              final currentProfile = profiles.first;
              provider.onSwipeLeft(currentProfile);
            },
            onLike: () {
              final currentProfile = profiles.first;
              provider.onSwipeRight(currentProfile);
            },
            onSuperLike: () {
              final currentProfile = profiles.first;
              provider.onSwipeUp(currentProfile);
            },
          ),
        );
      },
    );
  }
}
