import 'package:flutter/material.dart';
import 'package:images_test/src/resources/colors.dart';


class Avatar extends StatelessWidget {
  const Avatar.tiny({
    Key? key,
    required this.streamagramUser,
  })  : _avatarSize = _tinyAvatarSize,
        _coloredCircle = _tinyColoredCircle,
        hasNewStory = false,
        fontSize = 12,
        isThumbnail = true,
        super(key: key);

  const Avatar.small({
    Key? key,
    required this.streamagramUser,
  })  : _avatarSize = _smallAvatarSize,
        _coloredCircle = _smallColoredCircle,
        hasNewStory = false,
        fontSize = 14,
        isThumbnail = true,
        super(key: key);

  const Avatar.medium({
    Key? key,
    this.hasNewStory = false,
    required this.streamagramUser,
  })  : _avatarSize = _mediumAvatarSize,
        _coloredCircle = _mediumColoredCircle,
        fontSize = 20,
        isThumbnail = true,
        super(key: key);

  const Avatar.big({
    Key? key,
    this.hasNewStory = false,
    required this.streamagramUser,
  })  : _avatarSize = _largeAvatarSize,
        _coloredCircle = _largeColoredCircle,
        fontSize = 26,
        isThumbnail = false,
        super(key: key);

  const Avatar.huge({
    Key? key,
    this.hasNewStory = false,
    required this.streamagramUser,
  })  : _avatarSize = _hugeAvatarSize,
        _coloredCircle = _hugeColoredCircle,
        fontSize = 30,
        isThumbnail = false,
        super(key: key);

  /// Indicates if the user has a new story. If yes, their avatar is surrounded
  /// with an indicator.
  final bool hasNewStory;

  /// The user data to show for the avatar.
  final String streamagramUser;

  /// Text size of the user's initials when there is no profile photo.
  final double fontSize;

  final double _avatarSize;
  final double _coloredCircle;

  // Small avatar configuration
  static const _tinyAvatarSize = 22.0;
  static const _tinyPaddedCircle = _tinyAvatarSize + 2;
  static const _tinyColoredCircle = _tinyPaddedCircle * 2 + 4;

  // Small avatar configuration
  static const _smallAvatarSize = 30.0;
  static const _smallPaddedCircle = _smallAvatarSize + 2;
  static const _smallColoredCircle = _smallPaddedCircle * 2 + 4;

  // Medium avatar configuration
  static const _mediumAvatarSize = 40.0;
  static const _mediumPaddedCircle = _mediumAvatarSize + 2;
  static const _mediumColoredCircle = _mediumPaddedCircle * 2 + 4;

  // Large avatar configuration
  static const _largeAvatarSize = 90.0;
  static const _largPaddedCircle = _largeAvatarSize + 2;
  static const _largeColoredCircle = _largPaddedCircle * 2 + 4;

  // Huge avatar configuration
  static const _hugeAvatarSize = 120.0;
  static const _hugePaddedCircle = _hugeAvatarSize + 2;
  static const _hugeColoredCircle = _hugePaddedCircle * 2 + 4;

  /// Whether this avatar uses a thumbnail as an image (low quality).
  final bool isThumbnail;

  @override
  Widget build(BuildContext context) {
    final picture = _CircularProfilePicture(
      size: _avatarSize,
      userData: streamagramUser,
      fontSize: fontSize,
      isThumbnail: isThumbnail,
    );

    if (!hasNewStory) {
      return picture;
    }
    return Container(
      width: _coloredCircle,
      height: _coloredCircle,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(child: picture),
    );
  }
}

class _CircularProfilePicture extends StatelessWidget {
  const _CircularProfilePicture({
    Key? key,
    required this.size,
    required this.userData,
    required this.fontSize,
    this.isThumbnail = false,
  }) : super(key: key);

  final String userData;

  final double size;
  final double fontSize;

  final bool isThumbnail;

  @override
  Widget build(BuildContext context) {

    return Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: UIColors.secondary,
              shape: BoxShape.circle,
            ),
          );
  }
}
