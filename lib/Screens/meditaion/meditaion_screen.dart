// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bciapplication/services/api/API_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bciapplication/Screens/meditaion/chart.dart';
import 'package:bciapplication/Screens/session/session_screen.dart';
import 'package:bciapplication/provider/connection_provider.dart';
import 'package:bciapplication/provider/session_provider.dart';

import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/widget/custom_button.dart';
import 'package:bciapplication/widget/onboarding_button.dart';

class MeditaionScreen extends StatefulWidget {
  const MeditaionScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<MeditaionScreen> createState() => _MeditaionScreenState();
}

class _MeditaionScreenState extends State<MeditaionScreen> {
  @override
  final _formKey = GlobalKey<FormState>();
  TextEditingController nubcontroller = TextEditingController();
  TextEditingController musiccontroller = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  double selectedThreshold = 0; // Default value from slider
  APIService apiService = APIService();

  @override
  void initState() {
    super.initState();
    print("✅ initState is running");
    Provider.of<SessionProvider>(context, listen: false).fetchSessions();
    // Provider.of<SessionProvider>(context, listen: false).loadSessionId();
  }

  String? selectedSessionId;
  String? selectedSessionName;

  void handleThresholdChange(double value) {
    setState(() {
      selectedThreshold = value; // Store the final slider value
    });
    print("Selected Threshold: $selectedThreshold");
  }

  Widget build(BuildContext context) {
    final provider = Provider.of<ConnectionProvider>(context);

    // void playSession(String sessionId, String sessionName) async {
    //   apiService.setCurrentPlayingSession(
    //       sessionId, sessionName); // Store the current session ID
    //   print("Playing session id: $sessionId");
    //   print("Playing session name: $sessionName");

    //   // If you are using an audio player package, start playing the session here.
    //   // Example: audioPlayer.play(session.filePath);
    // }

    final sessionProvider = Provider.of<SessionProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'headset Status : ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              provider.connectionStatus,
              style: TextStyle(
                  color: provider.buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              provider.statusIcon,
              color: provider.iconColor,
              size: 18,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton2(
                    text: 'CONNECTED',
                    backgroundColor: provider.connectionStatus == 'connected'
                        ? provider.buttonColor
                        : backgroundWhiteColor, // Highlight only when active
                    textColor: provider.buttonColor == Colors.green
                        ? textPrimaryColor
                        : textcolor,
                    onPressed: () {
                      provider.setConnectionStatus(
                          'connected'); // Directly set to 'connected'
                    },
                  ),
                  CustomButton2(
                    text: 'PAUSE',
                    backgroundColor: provider.connectionStatus == 'pause'
                        ? provider.buttonColor
                        : backgroundWhiteColor, // Highlight only when active
                    textColor: provider.buttonColor == Colors.blue
                        ? textPrimaryColor
                        : textcolor,
                    onPressed: () {
                      provider.setConnectionStatus(
                          'pause'); // Directly set to 'pause'
                    },
                  ),
                  CustomButton2(
                    text: 'STOP',
                    backgroundColor: provider.connectionStatus == 'stop'
                        ? provider.buttonColor
                        : backgroundWhiteColor, // Highlight only when active
                    textColor: provider.buttonColor == Colors.red
                        ? textPrimaryColor
                        : textcolor,
                    onPressed: () {
                      provider.setConnectionStatus(
                          'stop'); // Directly set to 'stop'
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Search Music
              Text(
                'Select Music',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              TextField(
                controller: musiccontroller,
                decoration: InputDecoration(
                  hintText: "search music",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: brandPrimaryColor, width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide:
                        const BorderSide(color: brandPrimaryColor, width: 3),
                  ),
                  prefixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: brandPrimaryColor,
                      ),
                      onPressed: () {
                        sessionProvider.searchSessions(musiccontroller.text);
                      }),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: brandPrimaryColor,
                    ),
                    onPressed: () {
                      musiccontroller.clear();

                      sessionProvider.fetchSessions();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: TextStyle(color: textPrimaryColor),
              ),

              SizedBox(
                height: 15,
              ),
              Text(
                'Recomended for chip',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),

              SizedBox(
                  height: 140,
                  child: sessionProvider.sessions.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sessionProvider.sessions.length,
                          itemBuilder: (context, index) {
                            final session = sessionProvider.sessions[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: InkWell(
                                      onTap: () {
                                        selectedSessionId = session.sessionId;
                                        selectedSessionName =
                                            session.sessionName;
                                      },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundImage:
                                                NetworkImage(session.imageUrl),
                                          ),
                                          SizedBox(height: 10),
                                          Text(session.sessionName,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: textSecondaryColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 10),
                                ],
                              ),
                            );
                          },
                        )
                      // Handle empty case

                      : SizedBox(
                          height: 140, // ✅ Ensure ListView has a fixed height
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: sessionProvider.sessions.length,
                              itemBuilder: (context, index) {
                                final searchsongs =
                                    sessionProvider.sessions[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          selectedSessionId =
                                              searchsongs.sessionId;
                                          selectedSessionName =
                                              searchsongs.sessionName;
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 42,
                                              backgroundImage: NetworkImage(
                                                  searchsongs.imageUrl),
                                            ),
                                            SizedBox(height: 10),
                                            Text(searchsongs.sessionName,
                                                style: TextStyle(
                                                    color: textPrimaryColor)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )),

              //      Recommended Music

              SizedBox(height: 15),

              // Meditation Threshold
              Text(
                'Meditation Threshold',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),

              // Replace this with a custom threshold indicator widget
              SizedBox(
                height: 120, // Set a fixed height for the visualizer

                child: FrequencyVisualizer(onThresholdChanged: (value) {
                  handleThresholdChange(value);
                }), // Use the FrequencyVisualizer widget
              ),

              Center(
                child: Text(
                  'Session Time (min)',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: buildTextField(
                  keyboardType: TextInputType.number,
                  controller: nubcontroller,
                  hintText: 'Enter time',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Start Session Button
              Center(
                child: SizedBox(
                  height: 47,
                  width: 250,
                  child: OnboardingButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SessionScreen(
                                thresholdvalue: selectedThreshold,
                                sessionId: selectedSessionId!,
                                sessionName: selectedSessionName!,
                                controller: nubcontroller,
                              ),
                            ),
                          );
                        }
                      },
                      buttonText: 'Start Session'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      {required String hintText,
      IconData? icon,
      required TextEditingController controller,
      TextInputType? keyboardType}) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Please enter a value";
        }
        return null;
      },
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: textPrimaryColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: textPrimaryColor),
        suffixIcon: Icon(icon, color: brandPrimaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: brandPrimaryColor, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: brandPrimaryColor, width: 3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: Colors.red, width: 3),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      ),
    );
  }
}
