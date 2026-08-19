
enum NewsCategory {
  all,
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology,
}

extension NewsCategoryX on NewsCategory {
 
  String? get apiValue {
    switch (this) {
      case NewsCategory.all:
        return null;
      default:
        return name;
    }
  }

  String get label {
    switch (this) {
      case NewsCategory.all:
        return 'All';
      case NewsCategory.business:
        return 'Business';
      case NewsCategory.entertainment:
        return 'Entertainment';
      case NewsCategory.general:
        return 'General';
      case NewsCategory.health:
        return 'Health';
      case NewsCategory.science:
        return 'Science';
      case NewsCategory.sports:
        return 'Sports';
      case NewsCategory.technology:
        return 'Technology';
    }
  }
}
