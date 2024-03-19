import 'package:berita/models/berita.dart';
import 'package:berita/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _apiServices = ApiServices();

  List<Berita> _berita = [];

  @override
  void initState() {
    super.initState();
    _loadHeadLines();
    initializeDateFormatting('id_ID', null);
  }

  Future<void> _loadHeadLines() async {
    final List<Map<String, dynamic>> allHeadLinesData =
        await _apiServices.getHeadLines();
    setState(() {
      _berita = allHeadLinesData.map((e) => Berita.fromJson(e)).toList();
    });
  }

  void _launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BERITA FARIS"),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: _berita.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          final Berita berita = _berita[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                berita.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              subtitle: Text(DateFormat('dd MMMM yyyy', 'id')
                  .format(DateTime.parse(berita.publishedAt))),
              onTap: () async {
                _launchURL(berita.url);
              },
            ),
          );
        },
      ),
    );
  }
}
