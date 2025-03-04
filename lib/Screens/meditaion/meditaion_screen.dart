import 'package:bciapplication/Screens/meditaion/chart.dart';

import 'package:bciapplication/Screens/session/session_screen.dart';

import 'package:bciapplication/provider/connection_provider.dart';
import 'package:bciapplication/provider/song_provider.dart';

import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/widget/custom_button.dart';
import 'package:bciapplication/widget/onboarding_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeditaionScreen extends StatefulWidget {
  @override
  State<MeditaionScreen> createState() => _MeditaionScreenState();
}

class _MeditaionScreenState extends State<MeditaionScreen> {
  @override
  final _formKey = GlobalKey<FormState>();
  TextEditingController nubcontroller = TextEditingController();
  TextEditingController musiccontroller = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  @override
  void initState() {
    super.initState();
    print("✅ initState is running");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("✅ Calling fetchRecomendedsongs()");
      Provider.of<SongProvider>(context, listen: false).fetchRecomendedsongs();
    });
  }

  Widget build(BuildContext context) {
    final provider = Provider.of<ConnectionProvider>(context);
    final songprovider = Provider.of<SongProvider>(context);

    @override
    void dispose() {
      musiccontroller.dispose();
      nubcontroller.dispose();
      super.dispose();
    }

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
        padding: const EdgeInsets.only(left: 16, right: 16),
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
              SizedBox(height: 50),

              // Search Music
              Text(
                'Select Music',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              TextField(
                controller: musiccontroller,
                decoration: InputDecoration(
                  hintText: "search music",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
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
                        songprovider.fetchSearchsongs(musiccontroller.text);
                      }),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: brandPrimaryColor,
                    ),
                    onPressed: () {
                      musiccontroller.clear();
                      songprovider.clearSearchResults();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: TextStyle(color: textPrimaryColor),
              ),

              SizedBox(
                  height: 160, // ✅ Ensure height is set
                  child: songprovider.searchsongslist.isEmpty
                      ? Consumer<SongProvider>(
                          builder: (context, songprovider, child) {
                          if (songprovider.isloading) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: brandPrimaryColor,
                            ));
                          } else if (songprovider.error != null) {
                            return Center(
                                child: Text(
                              'Error: ${songprovider.error}',
                            ));
                          } else if (songprovider.recommendedsong.isEmpty) {
                            return Center(child: Text('No songs found'));
                          }

                          return SizedBox(
                              height:
                                  160, // ✅ Ensure ListView has a fixed height
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      songprovider.recommendedsong.length,
                                  itemBuilder: (context, index) {
                                    final songs =
                                        songprovider.recommendedsong[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: CircleAvatar(
                                              radius: 42,
                                              backgroundImage:
                                                  NetworkImage(songs.imageUrl),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(songs.title,
                                              style: TextStyle(
                                                  color: textPrimaryColor)),
                                          Text(songs.album,
                                              style: TextStyle(
                                                  color: textSecondaryColor,
                                                  fontSize: 11)),
                                        ],
                                      ),
                                    );
                                  }));
                        })
                      : SizedBox(
                          height: 160, // ✅ Ensure ListView has a fixed height
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: songprovider.searchsongslist.length,
                              itemBuilder: (context, index) {
                                final searchsongs =
                                    songprovider.searchsongslist[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CircleAvatar(
                                        radius: 42,
                                        backgroundImage:
                                            NetworkImage(searchsongs.imageUrl),
                                      ),
                                      SizedBox(height: 10),
                                      Text(searchsongs.title,
                                          style: TextStyle(
                                              color: textPrimaryColor)),
                                      Text(searchsongs.album,
                                          style: TextStyle(
                                              color: textSecondaryColor,
                                              fontSize: 11)),
                                    ],
                                  ),
                                );
                              }),
                        )),

              //      Recommended Music

              SizedBox(height: 20),

              // Meditation Threshold
              Text(
                'Meditation Threshold',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),

              // Replace this with a custom threshold indicator widget
              SizedBox(
                height: 130, // Set a fixed height for the visualizer
                child:
                    FrequencyVisualizer(), // Use the FrequencyVisualizer widget
              ),

              Center(
                child: Text(
                  'Session Time (min)',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
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
                                      controller: nubcontroller)));
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
