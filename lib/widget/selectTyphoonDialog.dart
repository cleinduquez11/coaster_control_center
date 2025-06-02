import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/provider/GetTyphoonProvider.dart';
import 'package:coaster_control_center/visSandboxVisualize.dart';





Future<void> showTyphoonDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      final typController = TextEditingController(text: '');
      final typ = Provider.of<Gettyphoonprovider>(context);
      return AlertDialog(
        // backgroundColor: Colors.green[400],
        title: const Text(
          'Select Typhoon',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),

        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.30,
          height: MediaQuery.of(context).size.height * 0.20,
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Start Date';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      // helperText: '20151012.000000',
                      hintText: 'Ex. Haiyan',
                      labelText: 'Typhoon International Name'),
                  onChanged: (value) {
                    // cnfg.getCols(value);
                  },
                  controller: typController),
              const SizedBox(
                height: 20,
              ),
              typ.typExist
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Result Found',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => VisSandBoxVisualization(length: int.parse(typ.files['length']), url: typ.files['url'])));
                          },
                          child: ListTile(
                            tileColor: Colors.deepPurple,
                            title: Center(
                              child: Text(
                                typ.files['Typhoon'].toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              typ.typExist1
                  ? ListTile(
                      tileColor: Colors.redAccent,
                      title: const Center(
                        child: Text(
                          'No Result',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    )
                  : Container()
            ],
          )),
        ),

        actions: [
          Center(
            child: ElevatedButton(
              child: const Text('Search Typhoon'),
              onPressed: () async {
                await typ.isTypExist(
                    "https://mmsucoaster.xyz/server/Raw/typhoon/${typController.text.toString().toLowerCase()}/cnfg.json");

                if (typ.typExist) {
                  await typ.getRawTyphoon(
                      "https://mmsucoaster.xyz/server/Raw/typhoon/${typController.text.toString().toLowerCase()}/cnfg.json");
                }
                print(typController.text.toString().toLowerCase());

              },
            ),
          ),
        ],
      );
    },
  );
}
