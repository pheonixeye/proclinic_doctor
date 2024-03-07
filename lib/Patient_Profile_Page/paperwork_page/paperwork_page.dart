import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';

List<String> headlines = [
  'Sheets',
  'Labs',
  'Rads',
  'Prescriptions',
  'Comments',
];

List<Icon> iconlist = [
  const Icon(
    Icons.contact_page,
    size: 100,
  ),
  const Icon(
    Icons.format_list_numbered,
    size: 100,
  ),
  const Icon(
    Icons.radio,
    size: 100,
  ),
  const Icon(
    Icons.description,
    size: 100,
  ),
  const Icon(
    Icons.comment_bank,
    size: 100,
  ),
];

class PaperWorkPage extends StatefulWidget {
  const PaperWorkPage({Key? key}) : super(key: key);
  @override
  _PaperWorkPageState createState() => _PaperWorkPageState();
}

class _PaperWorkPageState extends State<PaperWorkPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'PaperWork :',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              leading: const SizedBox.shrink(),
            ),
            body: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: MediaQuery.sizeOf(context).height * 0.25,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: headlines.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: ThemeConstants.cd,
                        child: GridTile(
                          footer: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              headlines[index],
                              textAlign: TextAlign.center,
                              textScaler: const TextScaler.linear(2),
                            ),
                          ),
                          child: iconlist[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
