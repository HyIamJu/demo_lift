import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class HttpHistory {
  final String status;
  final String url;
  final String pinStatus;
  final String data;
  HttpHistory(
      {required this.status,
      required this.url,
      required this.data,
      required this.pinStatus});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    _urlController.text = "http://127.0.0.1:5000/control";

    super.initState();
  }

  final httpClient = Dio();

  List<HttpHistory> httpRequestList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("DEMO LIFT PROJECT"),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // ----------------------------------------------
              // URL UP FIELD
              // ----------------------------------------------
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(),
                      child: TextFormField(
                        controller: _urlController,
                        decoration: const InputDecoration(
                          labelText: 'URL UP',
                          labelStyle: TextStyle(
                            color: Colors.blueGrey,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      postDataService(_urlController.text, "1");
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        elevation: 0,
                        backgroundColor: Colors.green),
                    child: const Icon(
                      Icons.keyboard_double_arrow_up,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      postDataService(_urlController.text, "2");
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        elevation: 0,
                        backgroundColor: Colors.blue),
                    child: const Icon(
                      Icons.keyboard_double_arrow_down,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      postDataService(_urlController.text, "3");
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        elevation: 0,
                        backgroundColor: Colors.yellow),
                    child: const Icon(
                      Icons.pause,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      postDataService(_urlController.text, "4");
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        elevation: 0,
                        backgroundColor: Colors.red),
                    child: const Icon(
                      Icons.stop,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        httpRequestList.clear();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        elevation: 0,
                        backgroundColor: Colors.grey),
                    child: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const Text(
                'Press button to action services:',
              ),
              const SizedBox(height: 15),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: httpRequestList.length,
                  itemBuilder: (context, index) {
                    var data = httpRequestList.elementAt(index);
                    return HistoryHttpWidget(no: index + 1, history: data);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  postDataService(String url, String pinStatus) async {
    try {
      final response = await httpClient.post(
        url,
        data: {
          "pin": pinStatus,
        },
      );

      setState(() {
        toastification.show(
          // ignore: use_build_context_synchronously
          context: context,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          type: ToastificationType.success,
          title: const Text("Succes Post Request"),
          autoCloseDuration: const Duration(seconds: 3),
        );
        httpRequestList.add(HttpHistory(
          status: (response.statusCode ?? 0).toString(),
          url: (response.realUri).toString(),
          data: response.data.toString(),
          pinStatus: pinStatus,
        ));
      });
    } on DioException catch (e) {
      setState(() {
        httpRequestList.add(HttpHistory(
          status: e.type.name,
          url: e.requestOptions.path.toString(),
          data: (e.response ?? "-").toString(),
          pinStatus: pinStatus,
        ));

        toastification.show(
          // ignore: use_build_context_synchronously
          context: context,
          icon: const Icon(Icons.cancel_outlined, color: Colors.white),
          type: ToastificationType.error,
          title: Text(e.toString()),
          autoCloseDuration: const Duration(seconds: 3),
        );
      });
    }
  }
}

class HistoryHttpWidget extends StatelessWidget {
  final int no;
  final HttpHistory history;
  const HistoryHttpWidget({
    super.key,
    required this.history,
    required this.no,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Row(
        children: [
          Text("No.$no"),
          const SizedBox(width: 10),
          Text(history.status),
          const SizedBox(width: 10),
          const Divider(),
          Text("Pin ${history.pinStatus}"),
          const SizedBox(width: 10),
          Flexible(child: Text(history.url)),
          const SizedBox(width: 10),
          Expanded(child: Text(history.data)),
        ],
      ),
    );
  }
}
