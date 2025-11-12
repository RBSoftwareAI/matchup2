import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../providers/profile_provider.dart';
import '../widgets/interest_chip.dart';

/// Edit profile screen for updating user information
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _jobTitleController;
  late TextEditingController _companyController;
  late TextEditingController _educationController;
  late TextEditingController _cityController;
  late TextEditingController _countryController;
  late TextEditingController _heightController;
  
  List<String> _selectedInterests = [];
  final List<String> _availableInterests = [
    'Technologie',
    'Voyages',
    'Photographie',
    'Cuisine',
    'Sport',
    'Cinéma',
    'Musique',
    'Randonnée',
    'Lecture',
    'Art',
    'Design',
    'Mode',
    'Fitness',
    'Gaming',
    'Danse',
    'Yoga',
  ];

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>().profile;
    
    _nameController = TextEditingController(text: profile.name);
    _bioController = TextEditingController(text: profile.bio);
    _jobTitleController = TextEditingController(text: profile.jobTitle ?? '');
    _companyController = TextEditingController(text: profile.company ?? '');
    _educationController = TextEditingController(text: profile.education ?? '');
    _cityController = TextEditingController(text: profile.city);
    _countryController = TextEditingController(text: profile.country);
    _heightController = TextEditingController(
      text: profile.heightCm?.toString() ?? '',
    );
    _selectedInterests = List.from(profile.interests);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _jobTitleController.dispose();
    _companyController.dispose();
    _educationController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final provider = context.read<ProfileProvider>();
    final currentProfile = provider.profile;
    
    // Update profile with new values
    final updatedProfile = currentProfile.copyWith(
      name: _nameController.text,
      bio: _bioController.text,
      jobTitle: _jobTitleController.text.isEmpty ? null : _jobTitleController.text,
      company: _companyController.text.isEmpty ? null : _companyController.text,
      education: _educationController.text.isEmpty ? null : _educationController.text,
      city: _cityController.text,
      country: _countryController.text,
      heightCm: _heightController.text.isEmpty 
          ? null 
          : int.tryParse(_heightController.text),
      interests: _selectedInterests,
    );
    
    provider.updateProfile(updatedProfile);
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profil mis à jour (mock)'),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
    
    // Navigate back
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>().profile;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        title: const Text('Éditer le profil'),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              'Enregistrer',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo section
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: CachedNetworkImageProvider(
                      profile.mainPhotoUrl,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Changement de photo à venir'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.cardBackground,
                            width: 3,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Changement de photo à venir'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Changer la photo'),
              ),
            ),
            const SizedBox(height: 24),
            
            // Form fields
            _buildTextField(
              controller: _nameController,
              label: 'Nom',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _bioController,
              label: 'Bio',
              icon: Icons.article_outlined,
              maxLines: 4,
              maxLength: 500,
            ),
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _jobTitleController,
              label: 'Métier',
              icon: Icons.work_outline,
            ),
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _companyController,
              label: 'Entreprise',
              icon: Icons.business_outlined,
            ),
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _educationController,
              label: 'Éducation',
              icon: Icons.school_outlined,
            ),
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _cityController,
              label: 'Ville',
              icon: Icons.location_city,
            ),
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _countryController,
              label: 'Pays',
              icon: Icons.flag_outlined,
            ),
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _heightController,
              label: 'Taille (cm)',
              icon: Icons.height,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 24),
            
            // Interests section
            Text(
              'Centres d\'intérêt',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableInterests.map((interest) {
                final isSelected = _selectedInterests.contains(interest);
                return InterestChip(
                  label: interest,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedInterests.remove(interest);
                      } else {
                        _selectedInterests.add(interest);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    int? maxLength,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: AppColors.cardBackground,
      ),
    );
  }
}
