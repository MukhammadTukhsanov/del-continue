class OnboardingModel {
  String imageSource;
  String title;

  OnboardingModel({required this.imageSource, required this.title});
}

List<OnboardingModel> onboardingModelContents = [
  OnboardingModel(
      title: 'Sevimli ovqatga buyurtma bering',
      imageSource: 'assets/images/onboarding-1.png'),
  OnboardingModel(
      title: 'Tezkor yetkazib berish',
      imageSource: 'assets/images/onboarding-2.png'),
  OnboardingModel(
      title: 'Yoqimli ishtaxa', imageSource: 'assets/images/onboarding-3.png')
];
