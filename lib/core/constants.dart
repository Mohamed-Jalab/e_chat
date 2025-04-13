import 'images.dart';

abstract class Constants {
  static const String isDarkMode = 'dark_mode';
  static const String isOnboardVisited = 'onboarding';
  static const String isRemembered = 'remembered';
  static const List<PageViewModel> pageViewData = [
    PageViewModel(
      image: AppImages.intro1,
      title: 'Group Chatting',
      subtitle: 'Connect with multiple members in group chats.',
    ),
    PageViewModel(
      image: AppImages.intro2,
      title: 'Video and Voice Calls',
      subtitle: 'Instantly connect via video and voice calls.',
    ),
    PageViewModel(
      image: AppImages.intro3,
      title: 'Message Encryption',
      subtitle: 'Ensure privacy with encrypted messages.',
    ),
    PageViewModel(
      image: AppImages.intro4,
      title: 'Cross-Platform Compatibility',
      subtitle: 'Access chats on any device seamlessly.',
    ),
  ];
}

class PageViewModel {
  final String image;
  final String title;
  final String subtitle;

  const PageViewModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
