import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math';

void main() {
  runApp(const ZingCallApp());
}

class ZingCallApp extends StatelessWidget {
  const ZingCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zing Call',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // App khulte hi apne aap ek 6-digit ka random ID ban jayega
  final callIdController = TextEditingController(
    text: (Random().nextInt(900000) + 100000).toString(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zing Call", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.video_camera_front, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 30),
              const Text(
                "Share this ID to invite friends",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: callIdController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: "Meeting ID",
                  prefixIcon: const Icon(Icons.meeting_room),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallPage(callID: callIdController.text),
                    ),
                  );
                },
                icon: const Icon(Icons.call),
                label: const Text("Start / Join Call", style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  final String callID;
  const CallPage({super.key, required this.callID});

  @override
  Widget build(BuildContext context) {
    final String userID = Random().nextInt(100000).toString();
    final String userName = "User_$userID";

    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        // 🔥 YAHAN PAR APNA ASALI APP ID AUR APP SIGN DAALNA HAI 🔥
        appID: 1413274594// Isko hatakar apna ZegoCloud ka AppID likho (Bina kisi "" ke)
        appSign: "b29585a1e133bc2edd9a0c1cb7b65e961ebfc00b4710e9dfeb79de6eae559a20", // Isko hatakar apna AppSign likho ("" ke andar)
        userID: userID,
        userName: userName,
        callID: callID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      ),
    );
  }
}
