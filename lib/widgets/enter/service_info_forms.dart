import 'package:flutter/material.dart';

import '../../models/service.dart';

class orderInfoForms extends StatefulWidget {
  const orderInfoForms({
    Key? key,
  }) : super(key: key);

  @override
  State<orderInfoForms> createState() => _orderInfoFormsState();
}

class _orderInfoFormsState extends State<orderInfoForms> {
  List services = [
    'Adding',
  ];

  TextEditingController serviceNameCtr = TextEditingController();
  TextEditingController priceCtr = TextEditingController();

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
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      services[index].serviceName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${services[index].price}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
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
          onPressed: () {
            Service newService = Service(
              serviceName: serviceNameCtr.text,
              price: double.parse(priceCtr.text),
            );
            setState(() {
              services.insert(services.length - 2, newService);
              services.removeAt(services.length - 2);
            });
          },
          icon: Icon(
            Icons.done,
            color: Colors.green,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: serviceNameCtr,
                        decoration: const InputDecoration(
                          hintText: 'Service Name',
                        ),
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: VerticalDivider(
                    width: 10,
                    color: Colors.black,
                    thickness: 1.5,
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: priceCtr,
                    decoration: const InputDecoration(
                      hintText: 'Price',
                    ),
                  ),
                )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '\$',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
