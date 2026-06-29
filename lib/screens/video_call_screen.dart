import 'package:flutter/material.dart';
import 'package:mentorly/utils/constants.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoCallScreen extends StatelessWidget {
  final String classID;
  final String className;

  const VideoCallScreen({super.key, required this.classID, required this.className});

  @override
  Widget build(BuildContext context) {
    final userID = DateTime.now().millisecondsSinceEpoch.toString();
    final userName = 'Dear Dev';
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: ZegoConfig.appID,
        appSign: ZegoConfig.appSign,
        conferenceID: classID,
        userID: userID,
        userName: userName,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
