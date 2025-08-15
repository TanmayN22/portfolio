class MotivService {
  static final List<String> _motivationalQuotes = [
    "Dreams are not what you see in your sleep. Dreams are things which do not let you sleep.",
    "Your love makes me strong. Your hate makes me unstoppable.",
    "Talent without working hard is nothing.",
    "I've never tried to hide the fact that it is my intention to become the best.",
    "If you don't believe you are the best, then you will never achieve all that you are capable of.",
    "We don't want to tell our dreams. We want to show them.",
    "Discipline is the bridge between goals and accomplishment.",
    "The essence of strategy is choosing what not to do.",
    "Continuous learning is the key to growth and success.",
    "Endurance and discipline pave the road to mastery.",
    "Stay consistent. Stay motivated. Keep going.",
    "Every champion was once a beginner who refused to give up.",
    "The difference between ordinary and extraordinary is practice.",
    "Progress, not perfection, is the goal.",
    "Your only limit is your mind.",
    "You are in danger of living a life so comfortable that you'll never realize your true potential.",
    "Most people quit at 40%. You have 60% more left in you.",
    "Get comfortable being uncomfortable.",
    "Your mind has to be stronger than your feelings.",
    "Be uncommon among uncommon people.",
    "I already know what giving up feels like. I want to see what happens if I don't.",
    "The comfort zone is where dreams go to die.",
    "Suffering is the price of growth.",
    "You have to set yourself goals so you can push yourself harder. Desire is the key to success.",
    "Easy is not an option. No days off. Never quit. Be fearless.",
    "Talent you have naturally. Skill is only developed by hours and hours of work.",
  ];

  static String getRandomQuote() {
    _motivationalQuotes.shuffle();
    return _motivationalQuotes.first;
  }

  static List<String> getAllQuotes() {
    return List.from(_motivationalQuotes);
  }
}
