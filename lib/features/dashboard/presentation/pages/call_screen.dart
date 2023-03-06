import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:ronvest/core/constants/app_asset.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {

  final AgoraClient _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AppAsset.agoraAppID,
        channelName: 'ronvest',
        tempToken: AppAsset.agoraToken,
      )
  );

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    await _client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child:  Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                AgoraVideoViewer(
                    client: _client,
                  layoutType: Layout.floating,
                  showNumberOfUsers: true,
                ),
                AgoraVideoButtons(
                    client: _client,
                  enabledButtons: const [
                    BuiltInButtons.toggleCamera,
                    BuiltInButtons.callEnd,
                    BuiltInButtons.toggleMic,
                    BuiltInButtons.screenSharing,
                    BuiltInButtons.switchCamera,
                  ],
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async => false,
    );
  }
}
