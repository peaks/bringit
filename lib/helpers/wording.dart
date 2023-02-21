class Wording {
  static const String stagingScreenTitle = 'staging';
  static const String explorerScreenTitle = 'explorer';
  static const String locationScreenTitle = 'location';

  static const String commitBlockTitle = 'COMMIT';
  static const String locationBlockTitle = 'LOCATION';
  static const String commitSummaryBlockTitle = 'COMMIT SUMMARY';
  static const String previewBlockTitle = 'PREVIEW';
  static const String explorerBlockTitle = 'EXPLORER';
  static const String stagingBlockTitle = 'STAGING';
  static const String diffBlockTitle = 'DIFF';
  static const String consoleBlockTitle = 'CONSOLE';

  static const List<String> stagingScreenTitles = <String>[
    stagingBlockTitle,
    commitBlockTitle,
    diffBlockTitle,
  ];

  static const List<String> explorerScreenTitles = <String>[
    previewBlockTitle,
    explorerBlockTitle,
  ];

  static const List<String> locationScreenTitles = <String>[
    commitBlockTitle,
    locationBlockTitle,
    commitSummaryBlockTitle,
  ];

  static const Map<String, List<String>> mapScreenTitles = <String, List<String>>{
    stagingScreenTitle: stagingScreenTitles,
    explorerScreenTitle: explorerScreenTitles,
    locationScreenTitle: locationScreenTitles,
  };
}
