import 'package:barber_app/constants.dart';
import 'package:barber_app/providers/service_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/service.dart';

class ServiceInfoForms extends StatefulWidget {
  const ServiceInfoForms({
    Key? key,
  }) : super(key: key);

  @override
  State<ServiceInfoForms> createState() => _ServiceInfoFormsState();
}

class _ServiceInfoFormsState extends State<ServiceInfoForms> {
  List<dynamic> services = [
    'Adding',
  ];

  TextEditingController serviceNameCtr = TextEditingController();
  TextEditingController priceCtr = TextEditingController();

  String hourOfProcessDropDownValue = 'Select Hour';

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        setOldServices(context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        if (services[index] == 'Editing') {
          return editingServiceMethod();
        } else if (services[index] == 'Adding') {
          return addingServiceMethod();
        }
        return Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  services.removeAt(index);
                  updateServiceListProvider(context);
                });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  right: 8,
                ),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        services[index].serviceName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 16,
                      color: Colors.black54,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          services[index].hourOfProcess,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.access_time,
                          color: Colors.yellow,
                        ),
                        const Spacer(),
                        Text(
                          '${services[index].price}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '\$',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget addingServiceMethod() {
    return GestureDetector(
      onTap: () {
        if (services.length == 1) {
          setState(() {
            serviceNameCtr.text = '';
            priceCtr.text = '';
            services.insert(0, 'Editing');
          });
        } else {
          if (services[services.length - 2] != 'Editing') {
            serviceNameCtr.text = '';
            priceCtr.text = '';
            setState(() {
              services.insert(services.length - 1, 'Editing');
            });
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: const Center(
          child: Text(
            'Add A Service',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Row editingServiceMethod() {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            if (hourOfProcessDropDownValue == 'Select Hour') {
              await _showMyDialog('Error', 'Please Select a time');
            } else if (serviceNameCtr.text.isEmpty) {
              await _showMyDialog('Error', 'Please fill the Service Name');
            } else if (priceCtr.text.isEmpty) {
              await _showMyDialog('Error', 'Please fill the Price');
            } else if (double.tryParse(priceCtr.text) == null) {
              await _showMyDialog('Error', 'Please enter valid price');
            } else {
              Service newService = Service(
                serviceName: serviceNameCtr.text,
                price: double.parse(
                  priceCtr.text,
                ),
                hourOfProcess: hourOfProcessDropDownValue,
              );
              hourOfProcessDropDownValue = 'Select Hour';
              setState(() {
                services.insert(services.length - 2, newService);
                services.removeAt(services.length - 2);
              });
              updateServiceListProvider(context);
            }
          },
          icon: const Icon(
            Icons.done,
            color: Colors.green,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: serviceNameCtr,
                      decoration: const InputDecoration(
                        hintText: 'Service Name',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: priceCtr,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Price',
                              suffixIcon: Icon(
                                Icons.attach_money,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: hourOfProcessDropDownValue,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                              ),
                              elevation: 16,
                              underline: Container(),
                              borderRadius: BorderRadius.circular(16),
                              onChanged: (String? newValue) {
                                setState(() {
                                  hourOfProcessDropDownValue = newValue!;
                                  print(newValue);
                                });
                              },
                              items: [
                                'Select Hour',
                                '15 Min',
                                '30 Min',
                                '45 Min',
                                '1 Hour',
                                '1.5 Hour',
                                '2 Hour',
                              ].map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: value == 'Select Hour'
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(String title, String detail) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!a
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(detail),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: kTurquoise,
              ),
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void setOldServices(BuildContext context) {
    services.clear();
    for (Service oldService
        in Provider.of<ServiceInfo>(context, listen: false).allService) {
      services.add(oldService);
    }
    services.add('Adding');
  }

  void updateServiceListProvider(BuildContext context) {
    List<dynamic> tempServiceList = [];
    for (dynamic service in services) {
      if (service != 'Editing' && service != 'Adding') {
        tempServiceList.add(service);
      }
    }
    Provider.of<ServiceInfo>(context, listen: false)
        .updateServiceList(tempServiceList);
  }
}
