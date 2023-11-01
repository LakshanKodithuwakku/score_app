import 'dart:ui';

import 'package:flutter/material.dart';

class CVIGuidanceScreen extends StatefulWidget {
  const CVIGuidanceScreen({Key? key}) : super(key: key);

  @override
  _CVIGuidanceScreenState createState() => _CVIGuidanceScreenState();
}

class _CVIGuidanceScreenState extends State<CVIGuidanceScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('CVI Parent Guidance'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _opacity,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  'assets/LRH_background.png',
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _opacity,
              child: Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(20.0),
                color: Colors.transparent, // Set the background color to transparent
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Welcome to',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue, // Custom color
                        ),
                      ),
                      Text(
                        'CVI Parent Guidance',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.green, // Custom color
                        ),
                      ),
                      SizedBox(height: 16.0),
                      GuidanceCard(
                        title: 'Understanding CVI and its impact',
                        content:
                        'Cerebral Visual Impairment (CVI) is a neurological condition that affects a child\'s vision. It is essential to understand how CVI impacts your child and their visual perception.',
                      ),
                      GuidanceCard(
                        title: 'Tips for daily life with CVI',
                        content:
                        'Discover practical tips to create a supportive environment for your child with CVI. This includes optimizing lighting, using high-contrast materials, and understanding their visual needs.',
                      ),
                      GuidanceCard(
                        title: 'Connecting with specialists',
                        content:
                        'Seeking the expertise of specialists is crucial. Connect with pediatric ophthalmologists, neurologists, and therapists who can provide a comprehensive evaluation and guidance tailored to your child\'s needs.',
                      ),
                      GuidanceCard(
                        title: 'Resources for parents and caregivers',
                        content:
                        'As a parent or caregiver, you are not alone in this journey. Access a range of resources, including support groups, online communities, and educational materials to empower yourself.',
                      ),
                      SizedBox(height: 16.0),
                      SectionTitle(
                        title: 'Contact Lady Ridgeway Hospital for Children (LRH)',
                        textColor: Colors.blue,
                      ),
                      ContactInfo(
                        text: '🏥  Address: 5th Lane, Colombo 8, Sri Lanka',
                        isHighlighted: true,
                        textColor: Colors.black,
                      ),
                      ContactInfo(
                        text: '📞  Phone: +94 11 269 1111',
                        isHighlighted: true,
                        textColor: Colors.black,
                      ),
                      ContactInfo(
                        text: '✉  Email: info@lrh.health.gov.lk',
                        isHighlighted: true,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GuidanceCard extends StatelessWidget {
  final String title;
  final String content;

  GuidanceCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth;
        if (constraints.maxWidth < 1000) {
          cardWidth = constraints.maxWidth - 32.0; // Adjust the padding
        } else {
          cardWidth = 1000.0; // Fixed width for tablets
        }

        return Container(
          width: cardWidth,
          margin: EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              Divider(height: 1, color: Colors.blue),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  content,
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class SectionTitle extends StatelessWidget {
  final String title;
  final Color textColor;

  SectionTitle({required this.title, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  final String text;
  final bool isHighlighted;
  final Color textColor;

  ContactInfo({required this.text, this.isHighlighted = false, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.info,
          color: isHighlighted ? Colors.blue : Colors.black, // Highlight color
        ),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ],
    );
  }
}
