/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of Brin'Git
 *
 * Brin'Git is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Brin'Git is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Brin'Git.  If not, see <http://www.gnu.org/licenses/>.
 */
class Wording {
  // Views Titles

  static const String stagingViewTitle = 'staging';
  static const String explorerViewTitle = 'explorer';
  static const String locationViewTitle = 'location';

  // Block Titles

  static const String commitBlockTitle = 'COMMIT';
  static const String locationBlockTitle = 'LOCATION';
  static const String commitSummaryBlockTitle = 'COMMIT SUMMARY';
  static const String previewBlockTitle = 'PREVIEW';
  static const String explorerBlockTitle = 'EXPLORER';
  static const String stagingBlockTitle = 'STAGING';
  static const String diffBlockTitle = 'DIFF';
  static const String consoleBlockTitle = 'CONSOLE';

  static const String gitActionAddAllTitle = 'Add All';
  static const String gitActionRestoreTitle = 'Restore';
  static const String gitActionCommitTitle = 'Commit';
  static const String gitActionDeleteTitle = 'Delete';
  static const String gitActionStashTitle = 'Stash';
  static const String gitActionRestoreStagedTitle = 'Restore Staged';

  // Common

  static const String cancelAction = 'Cancel';
  static const String initializationMessage = 'Initialization...';

  // Home Screen

  static const String homeScreenCreateGitProjectButtonTitle =
      'Create Git Project';

  // Create New Git Project Modal

  static const String modalCreateNewGitProjectTitle =
      homeScreenCreateGitProjectButtonTitle;
  static const String modalCreateNewGitProjectCreateButtonTitle = 'Create';
  static const String modalCreateNewGitProjectCancelButtonTitle = cancelAction;
  static const String modalCreateNewGitProjectTextfieldSelectFolderPathLabel =
      'Parent Folder';
  static const String modalCreateNewGitProjectProjectNameHintText = 'Name';
  static const String modalCreateNewGitProjectProjectNameLabel = 'project name';
  static const String modalCreateNewGitProjectPathSelectorHintText =
      'path directory';
  static const String modalCreateNewGitProjectPathSelectorTitle =
      'Set project path';

  static const String
      modalCreateNewGitProjectErrorMessageForInvalidProjectPathName =
      'is not a valid project name';
  static const String
      modalCreateNewGitProjectErrorMessageForExistingProjectPath =
      'already exists';
  static const String modalCreateNewGitProjectErrorMessageForEmptyProjectName =
      'the project name cannot be empty';
  static const String
      modalCreateNewGitProjectErrorMessageForInvalidProjectName =
      'is not a valid project name';
  static const String modalCreateNewGitProjectErrorMessageNotAGitRepository =
      'not a git directory';

  static const String pathSelectorActionSaveButton = 'Save';
  static const String versionMessageForGitChip = 'fetching git version...';

  // Staging

  static const String modifiedFiles = 'Modified';
  static const String stagedFiles = 'Staged (waiting to be committed)';
  static const String untrackedFiles = 'Untracked';

  // License Notice

  static const String licenseNoticeModalTitle = 'Brin\'Git License';
  static const String licenseNoticeModalMoreButtonTitle = 'More';
  static const String licenseNoticeModalContinueButtonTitle = 'Ok';
}
