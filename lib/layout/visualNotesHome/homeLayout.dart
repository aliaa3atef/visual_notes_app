import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:visual_notes_app/models/visualNotesData/data.dart';
import 'package:visual_notes_app/shared/components/components.dart';
import 'package:visual_notes_app/shared/styles/colors.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  String status;
  List<String> selectStatus = ['opened' , 'closed'];
  List<Data> data = [
    Data(
        title: "title 1",
        image:
            'https://res-5.cloudinary.com/dwpujv6in/image/upload/c_lpad,dpr_2.0,f_auto,h_560,q_auto:eco,w_700/v1/media/catalog/product/h/o/ho1_dnchwl_st_frontlow-host-dining-chair-tait-stone-walnut_1.jpg',
        description: 'description 1',
        date: '6/1/2022',
        time: '10:02 PM',
        status: 'closed'),
    Data(
        title: "title 1",
        image:
        'https://res-5.cloudinary.com/dwpujv6in/image/upload/c_lpad,dpr_2.0,f_auto,h_560,q_auto:eco,w_700/v1/media/catalog/product/h/o/ho1_dnchwl_st_frontlow-host-dining-chair-tait-stone-walnut_1.jpg',
        description: 'description 1',
        date: '6/1/2022',
        time: '10:02 PM',
        status: 'closed'),
    Data(
        title: "title 1",
        image:
        'https://res-5.cloudinary.com/dwpujv6in/image/upload/c_lpad,dpr_2.0,f_auto,h_560,q_auto:eco,w_700/v1/media/catalog/product/h/o/ho1_dnchwl_st_frontlow-host-dining-chair-tait-stone-walnut_1.jpg',
        description: 'description 1',
        date: '6/1/2022',
        time: '10:02 PM',
        status: 'closed'),
    Data(
        title: "title 1",
        image:
        'https://res-5.cloudinary.com/dwpujv6in/image/upload/c_lpad,dpr_2.0,f_auto,h_560,q_auto:eco,w_700/v1/media/catalog/product/h/o/ho1_dnchwl_st_frontlow-host-dining-chair-tait-stone-walnut_1.jpg',
        description: 'description 1',
        date: '6/1/2022',
        time: '10:02 PM',
        status: 'closed'),
    Data(
        title: "title 1",
        image:
        'https://res-5.cloudinary.com/dwpujv6in/image/upload/c_lpad,dpr_2.0,f_auto,h_560,q_auto:eco,w_700/v1/media/catalog/product/h/o/ho1_dnchwl_st_frontlow-host-dining-chair-tait-stone-walnut_1.jpg',
        description: 'description 1',
        date: '6/1/2022',
        time: '10:02 PM',
        status: 'closed'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "Home",
        actions: [

          OutlinedButton(onPressed: (){buildAlertDialog(context: context);},
              child:  Text("Add New Visual Note" , style: TextStyle(color: HexColor('bdc920'),),),
          )

        ],
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildItem(context, index);
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 1,
        ),
        itemCount: data.length,
      ),
    );
  }

  Future<void> buildAlertDialog({
    @required BuildContext context,
  }) {
    final AlertDialog alert = AlertDialog(
      content: Container(
        height: 340,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Row(
              children:  [
                const Text('Upload Image : '),
                const Spacer(),
                Icon(Icons.camera_alt_rounded , color: HexColor('bdc920') ,),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(color: HexColor('bdc920'),),
            const SizedBox(
              height: 20,
            ),
            sharedTextFormField(
              controller: titleController,
              text: 'Enter Title',
              type: TextInputType.text,
            ),
            const SizedBox(
              height: 10,
            ),
            sharedTextFormField(
                controller: descriptionController,
                text: 'Enter Description',
                type: TextInputType.text),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: double.infinity,
              child: DropdownButton(
                value: status,
                hint: const Text("Select Status"),
                items: selectStatus.map((e) {
                  return DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  );
                }).toList(),

                onChanged: (val){
                  setState(() {
                    status = val;
                  });
                },
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            OutlinedButton(onPressed: (){}, child: const Text("Add")),
          ],
        ),
      ),
    );
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return alert;
        });
  }

  Widget buildItem(BuildContext context, index) {
    return GestureDetector(
      onLongPress: (){
        showMenu(
          position: const RelativeRect.fromLTRB(0, 0, 0, 0),
          items: <PopupMenuEntry>[
            PopupMenuItem(
              onTap: (){},
              value: index,
              child: Row(
                children: [
                  Icon(Icons.delete , color: HexColor('939c1f'),),
                  const Text("Delete"),
                ],
              ),
            )
          ],
          context: context,
        );
      },
      child: Card(
        elevation: 20,
        color: HexColor('939c1f'),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 120,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  data[index].title,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  width: 30,
                ),
                Image(
                  image: NetworkImage(data[index].image),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 30,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: 100,
                    child: Text(
                      data[index].description,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data[index].date,
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      data[index].time,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  data[index].status,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
