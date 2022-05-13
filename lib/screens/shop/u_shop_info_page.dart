import 'package:barber_app/models/u_shop_about.dart';
import 'package:barber_app/models/u_shop_comments.dart';
import 'package:barber_app/models/u_shop_services.dart';
import 'package:flutter/material.dart';



class uShopInfoPage extends StatelessWidget {
  const uShopInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.black,
                height: 1.0,
              ),
              preferredSize: const Size.fromHeight(4.0)),
          elevation: 0,
          leading: IconButton(icon:Icon(Icons.arrow_back_ios_new,color: Colors.black) ,onPressed:() =>null,),
          backgroundColor: Color(0xffe5e5e5),
          title: SizedBox(
            //height: 120,
            // width: 100,
              height: MediaQuery.of(context).size.width*0.25,
              child: Image.asset("assets/r.png")),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(

                iconSize: MediaQuery.of(context).size.width*0.09,
                color: Colors.black,
                onPressed: () => null,
                icon: Icon(Icons.account_circle),
              ),
            ),
          ],
        ),
        body: uShopInfo2(),
      ),
    );
  }
}


class uShopInfo2 extends StatefulWidget {
  @override
  _uShopInfo2State createState() => _uShopInfo2State();
}

class _uShopInfo2State extends State<uShopInfo2> {
  String dropdownValue = 'Ulu';
  List<ShopServices> serviceList=[
    ShopServices(45, "Hair Cutting"),
    ShopServices(55, "Perm dye"),
    ShopServices(65, "Groom Shave"),
    ShopServices(25, "Shave with machine"),
    ShopServices(35, "Shave with razor"),
    ShopServices(15, "Neck Shave")];


  List<ShopComments> comments=[
    ShopComments.withBasic("very good", "2022–04–02"),
    ShopComments.withBasic(" good", "2022–04–03"),

    ShopComments.withBasic("excellent barber.I strongly recommend it", "2022–04–30"),

  ];
  var mapHours={
    "Monday":"09:00 - 20:00",
    "Tuesday":"09:00 - 20:00",
    "Wednesday":"09:00 - 20:00",
    "Thursday":"09:00 - 20:00",
    "Friday":"09:00 - 20:00",
    "Saturday":"09:00 - 20:00",


  };




  @override
  Widget build(BuildContext context) {
    var shop=ShopAbout.withOnlyAddress(
        address: "Mimarsinan mah. gül sokak Kocasinan/Kayseri ",
        shopHours:mapHours ,
        name: "Findbest Kuaförü");
    return DefaultTabController(

      length: 3,
      child: Scaffold(

        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Color(0xffe5e5e5),

          //toolbarHeight: 220,
          toolbarHeight: MediaQuery.of(context).size.height*0.33,
          bottom: TabBar(
            tabs: [
              Tab( child:Text("Services",style: TextStyle(color: Colors.black),)),
              Tab(child:Text("Comments",style: TextStyle(color: Colors.black),)),
              Tab(child:Text("About",style: TextStyle(color: Colors.black),)),

            ],
          ),
          title: Column(
            children: [
              Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Image(
                      image: new NetworkImage("https://images.squarespace-cdn.com/content/v1/58ec34be03596e9140b6a633/1509598561215-N03XJ9BSZPMLHEQ9AWNN/IMG_1305.JPG?format=1000w"),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(

                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(5))

                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Findbest Kuaförü"),
                              IconButton(
                                icon: Icon(Icons.favorite),
                                onPressed: () => null,

                              ),
                            ],
                          ),
                        )
                    ),
                  ]
              ),

              Align(
                  alignment: Alignment.topLeft,
                  child: Text("Company name",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.03),))
            ],
          ),
        ),
        body: Container(
          color: Color(0xffe5e5e5),
          child: TabBarView(
            children: [
              Center( child: buildSubServices(serviceList),),
              Center( child: buildSubComments(comments)),
              Center( child: buildAbout(dropdownValue,mapHours,shop)),


            ],
          ),
        ),

        // floatingActionButton: FloatingActionButton(
        //
        //   onPressed : () {
        //     // Add your onPressed code here!
        //     _showMyDialog();
        //   },
        //   backgroundColor: Colors.green,
        //   child: const Icon(Icons.navigation),
        // ),



      ),
    );
  }
  ListView buildSubServices(List<ShopServices> lst) {


    return ListView.builder(
      itemCount: lst.length,
      itemBuilder: (context, index) {
        return Card(

          elevation: 0,
          child: ListTile(

            onTap: ()=>null,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(lst.elementAt(index).serviceName),
                Text("${lst.elementAt(index).price} TL"),
              ],
            ),

            trailing: IconButton(icon: Icon(Icons.add),onPressed: ()=>null),



          ),
        );
      },

    );
  }

  ListView buildSubComments(List<ShopComments> lst) {
    return ListView.builder(
      itemCount: lst.length,
      itemBuilder: (_,i){

        return Card(
          elevation: 5,


          child: ListTile(

            leading:
            Icon(Icons.account_circle_rounded),
            title: Text(lst.elementAt(i).detail),
            subtitle: Text(lst.elementAt(i).date),

          ),
        );
      },
      //shrinkWrap: true,

    );
  }
  Padding buildAbout(String dropdownValue,Map<String ,String> map,ShopAbout s) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 8, 20),
      child: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.015,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.map,size: MediaQuery.of(context).size.height*0.08,color: Color(0xff83d1c3),),
                SizedBox(width: MediaQuery.of(context).size.width*0.015,),
                Expanded(child: Text(s.address,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),)),

              ],
            ),

            ElevatedButton(onPressed: ()=>null, child: Text("Get Direction",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.03 )),style:
            ElevatedButton.styleFrom(
              primary: Color(0xff83d1c3),
              shape: StadiumBorder(),
            )


            ),


            Align(
                alignment: Alignment.topLeft,
                child: Text("Working Hours",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.035),)),
            Align(
              alignment: Alignment.topLeft,
              child: buildDataTable(s),
            ),

            Align(
                alignment: Alignment.topLeft,
                child: Text("Employees",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.035),)),
            Align(
              alignment: Alignment.topLeft,
              child: DropdownButton<String>(

                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward,color: Color(0xff83D1C3),),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Color(0xffe5e5e5),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Ulu', 'Alaattin', 'Akcan', 'kerem']
                    .map<DropdownMenuItem<String>>((String value) {

                  return DropdownMenuItem<String>(
                    value: value,

                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

          ],
        ),
      ),

    );
  }

  DataTable buildDataTable(ShopAbout s) {
    return DataTable(
      dataRowHeight: MediaQuery.of(context).size.width*0.06,
      dividerThickness: 0,
      columnSpacing: 0,

      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Days',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Hours',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),

      ],
      rows:  <DataRow>[

        DataRow(
          cells: <DataCell>[
            DataCell(Text('Monday'),),
            DataCell(Text(s.shopHours["Monday"].toString())),

          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Tuesday')),
            DataCell(Text(s.shopHours["Tuesday"].toString())),

          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Wednesday')),
            DataCell(Text(s.shopHours["Wednesday"].toString())),

          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Thursday')),
            DataCell(Text(s.shopHours["Thursday"].toString())),

          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Friday')),
            DataCell(Text(s.shopHours["Friday"].toString())),

          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Saturday')),
            DataCell(Text(s.shopHours["Saturday"].toString())),

          ],
        ),
      ],
    );
  }

}