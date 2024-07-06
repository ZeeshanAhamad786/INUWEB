import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/image_picker_controller.dart';
import '../../../controllers/utils/constant.dart';
import '../../../controllers/utils/my_color.dart';
import '../../../model/task_model.dart';
import '../../../model/task_teacher_selection_model.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_coordinate_name.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import '../../custom_widgets/custom_textfield.dart';
class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}
class _TaskScreenState extends State<TaskScreen> {
  ImagePickerController imagePickerController=Get.put(ImagePickerController());
  DateTime _selectedDate = DateTime.now();
  List<TaskModel> data = [
    TaskModel(
        imageUrl: "assets/png/profile1.png",
        userName: "Eshan",
        userEmail: "abc@xyz.com",
        userTitle: "New upcoming topic",
        userDeadline: "01 June 04:30 PM",
        userStatus: "Need to Work"),
    TaskModel(
        imageUrl: "assets/png/profile1.png",
        userName: "Rana",
        userEmail: "abc@xyz.com",
        userTitle: "New upcoming topic",
        userDeadline: "01 June 04:30 PM",
        userStatus: "Done"),
    TaskModel(
        imageUrl: "assets/png/profile1.png",
        userName: "Mohsin",
        userEmail: "abc@xyz.com",
        userTitle: "New upcoming topic",
        userDeadline: "01 June 04:30 PM",
        userStatus: "Need to Work"),
    TaskModel(
        imageUrl: "assets/png/profile1.png",
        userName: "hello",
        userEmail: "abc@xyz.com",
        userTitle: "New upcoming topic",
        userDeadline: "01 June 04:30 PM",
        userStatus: "Need to Work"),
    TaskModel(
        imageUrl: "assets/png/profile1.png",
        userName: "Eshan",
        userEmail: "abc@xyz.com",
        userTitle: "New upcoming topic",
        userDeadline: "01 June 04:30 PM",
        userStatus: "Need to Work"),
    TaskModel(
        imageUrl: "assets/png/profile1.png",
        userName: "Eshan",
        userEmail: "abc@xyz.com",
        userTitle: "New upcoming topic",
        userDeadline: "01 June 04:30 PM",
        userStatus: "Need to Work"),
  ];
  List<TaskTeacherSelectionModel> data1 = [
    TaskTeacherSelectionModel(
        imageUrl: 'assets/png/notificationProfile.png',
        title: 'Shan',
        subtitle: 'abc@gmail.com',
        selected: false.obs),
    TaskTeacherSelectionModel(
        imageUrl: 'assets/png/notificationProfile.png',
        title: 'umer',
        subtitle: 'abc@gmail.com',
        selected: false.obs),
    TaskTeacherSelectionModel(
        imageUrl: 'assets/png/notificationProfile.png',
        title: 'rana',
        subtitle: 'abc@gmail.com',
        selected: false.obs),
    TaskTeacherSelectionModel(
        imageUrl: 'assets/png/notificationProfile.png',
        title: 'ahmad',
        subtitle: 'abc@gmail.com',
        selected: false.obs),
    TaskTeacherSelectionModel(
        imageUrl: 'assets/png/notificationProfile.png',
        title: 'Shan',
        subtitle: 'abc@gmail.com',
        selected: false.obs)
  ];
  RxBool addNew = false.obs;
  RxBool editTask = false.obs;
  RxBool showDetail = false.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            CustomCoordinateName(
              coordinateName: 'Coordinate Name',
              onLogout: () {
                Get.offAllNamed('/LoginScreen');
              },
            ),


            editTask.value ||addNew.value
                ? Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: .5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                 border: Border.all(color: Colors.black.withOpacity(0.25),),
                     color:Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                           editTask.value? editTask.value = false:addNew.value=false;

                          },
                          child: Container(
                            height: 2.5.w,width: 2.5.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColor.backgroundColor),
                            child: Center(child: Icon(Icons.arrow_back,size: 16.px,)),
                          ),
                        ),
                      ),
                  getVertical(2.h),
                      Text(
                        "Task Title/Name",
                        style: Constant.textEmail,
                      ),
                      getVertical( 0.5.h),
                      CustomTextFormField(
                        hintText: "Enter Task title",
                        fillColor: MyColor.SearchColor,
                        hintStyle: Constant.textGreySign,
                        borderColor: MyColor.blueColor,
                        contentPadding: EdgeInsets.all(1.w),
                      ),
                      getVertical( 2.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text("Task Description (Optional)",style:Constant.textEmail),
                                SizedBox(height: .5.h),
                                CustomTextFormFieldLine(
                                  maxLines: 9,
                                  hintText: "Enter task description",
                                  hintStyle: Constant.textGreySign,
                                  fillColor: MyColor.SearchColor,
                                  borderColor: MyColor.blueColor,
                                ),
                                SizedBox(height: 1.h),
                                Text("File Upload (Optional)",style:Constant.textEmail),
                                SizedBox(height: 1.h),
                            GestureDetector(
                              onTap: () {
                                imagePickerController.getImage();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w), // Adjust these values as needed
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: MyColor.blueColor),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (imagePickerController.imagePath.isNotEmpty)
                                      kIsWeb
                                          ? Image.network(
                                            imagePickerController.imagePath.toString(),
                                            fit: BoxFit.cover,)
                                          :
                                      Image.file(
                                        File(imagePickerController.imagePath.toString()),
                                        fit: BoxFit.cover,

                                      )
                                    else...[
                                      Text("Click to upload file (optional)",style: Constant.textForgot,),
                                    SvgPicture.asset("assets/svg/shareWeb.svg"),
                                    ]
                                  ],
                                ),
                              ),
                            )
                              ],
                            ),
                          ),
                          getHorizontal(1.w),
                          Expanded(
                            child: Column(
                              children: [
                                Text("Teachers selection",style:Constant.textEmail),
                                getVertical(.5.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.w, horizontal: 2.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: MyColor.blueColor),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child:
                                            CustomSearchTextField(
                                              hintText: "Search Task",
                                              hintStyle: Constant.textEmail,
                                              onChanged: (value) {
                                                print("Search value: $value");
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                // Toggle all selected values
                                                bool allSelected = data1.every((element) => element.selected.value);
                                                for (var item in data1) {
                                                  item.selected.value = !allSelected;
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset("assets/svg/allselected.svg"),
                                                  Text("Select all",style: Constant.textSelect,),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                       height: 20.w,
                                        child: ListView.builder(
                                            itemCount: data1.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(vertical: 1.w),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14),
                                                    color: MyColor.SearchColor),
                                                child: ListTile(
                                                  leading: Image.asset(data1[index].imageUrl),
                                                  title: Text(data1[index].title,style: Constant.textMainTitle,),
                                                  subtitle: Text(data1[index].subtitle,style: Constant.textEmail,),
                                                  trailing: Obx(() => Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        border: Border.all(color: MyColor.blueColor),
                                                        color: data1[index].selected.value
                                                            ? MyColor.blueColor
                                                            : Colors.white),
                                                    child: Center(
                                                      child: Icon(Icons.check,size: 12,
                                                          color: data1[index].selected.value
                                                              ? Colors.white
                                                              : MyColor.blueColor),
                                                    ),
                                                  )),
                                                  onTap: () {
                                                    data1[index].selected.value =
                                                    !data1[index].selected.value;
                                                  },
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 1.w),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                 Text('Task Deadline',style:Constant.textEmail ,),
                                getVertical(.5.h),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: MyColor.blueColor),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: dp.DayPicker.single(
                                    selectedDate: _selectedDate,
                                    onChanged: (DateTime date) {
                                      setState(() {
                                        _selectedDate = date;
                                      });
                                    },
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2040),
                                  ),
                                ),
                                SizedBox(height: .5.h),
                                GestureDetector(onTap: () {
                                  editTask.value? editTask.value = false:addNew.value=false;
                                // Get.back();

                                },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w, vertical: .5.w
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.blueColor,
                                    ),
                                    child: Center(child:  Text("Submit",style: Constant.textSubmit,)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
                :showDetail.value == true ?
            SingleChildScrollView(
              child: Column(
                children: [
                  EditTaskComponent(

                    showDetail: showDetail, addNewOrEdit: editTask,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 3.w,left: 3.w,right: 3.w,bottom: 8.2.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black.withOpacity(0.25)),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage("assets/png/notificationProfile.png"),
                                radius: 100, // Adjust radius as needed
                              ),
                              SizedBox(height: 2.h),
                              Text("ZEESHAN", style: Constant.textNameBold),
                              Text("abc@gmail.com", style: Constant.textEmail),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 1.w,bottom: 1.5.w,right: 1.w,top: 1.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black.withOpacity(0.25)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Task Title/Name", style: Constant.textEmail),
                                  SizedBox(height: 1.h),
                                  Text("New upcoming topic", style: Constant.textTitle),
                                  SizedBox(height: 1.h),
                                  Text("Task Description", style: Constant.textEmail),
                                  SizedBox(height: 1.h),
                                  Text(
                                    """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eu ipsum at leo euismod suscipit eu nec justo. Nulla ultrices in nunc nec vulputate. Praesent condimentum neque id semper efficitur. Suspendisse at nulla eu velit fringilla consequat. Aenean ornare sapien vitae...""",
                                    style: Constant.textTitle,
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Deadline",style: Constant.textEmail,),
                                      Text("Status",style: Constant.textEmail,),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("01 June 04:30 PM",style: Constant.textMainTitle,),
                                      Text("Approved",style: Constant.textMainTitle,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              padding: EdgeInsets.only(top: .5.w,right: 1.w,left: 1.w,bottom: .5.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: MyColor.blueColor),
                              ),
                              child: Column(
                                children: [
                                  CustomSearchTextField(
                                    hintText: "Search Task",
                                    hintStyle: Constant.textEmail,
                                    onChanged: (value) {
                                      print("Search value: $value");
                                    },
                                  ),
                                  SizedBox(
                                    height: 9.w,
                                    child: ListView.builder(
                                      itemCount: data1.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(vertical: .5.w),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: MyColor.SearchColor,
                                          ),
                                          child: ListTile(
                                              leading: Image.asset(data1[index].imageUrl),
                                              title: Text(data1[index].title, style: Constant.textMainTitle),
                                              subtitle: Text(data1[index].subtitle, style: Constant.textEmail),
                                              trailing: Row(mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("Task.docx",style: Constant.textDocs,),
                                                  getHorizontal(.5.w),
                                                  SvgPicture.asset("assets/svg/docs.svg")
                                                ],
                                              )
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
                : Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:3.h ),

                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 0, // Spread radius
                        blurRadius: 8, // Blur radius
                        offset: Offset(1, 1), // Shadow position (x, y)
                      ),
                    ],
                  ),
                  child:Column(children: [
                    getVertical(2.h),
                    Row(
                      children: [
                        Expanded(flex:4,
                          child: TextFormField(decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Transform.scale(scale: 0.5,
                                  child: SvgPicture.asset("assets/svg/search.svg")),
                              hintText: "Search Task", hintStyle: Constant.textEmail,
                              isDense: true,
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),borderSide: BorderSide(color: MyColor.blueColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),borderSide: BorderSide(color:MyColor.blueColor ))),),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 1.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                             addNew.value=true;                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColor.blueColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 1.5.w),
                              ),
                              child: Text(
                                "Add New Task",
                                style: Constant.textAddNewTask,
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                    getVertical(1.5.w),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Text("Teacher",style:Constant.textMainTitle,),
                        Text("Topic",style:Constant.textMainTitle,),
                        Text("Deadline",style:Constant.textMainTitle,),
                        Text("Status",style:Constant.textMainTitle,),
                        getHorizontal(15.w)
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context,index){
                            return Container(
                                margin:EdgeInsets.symmetric(vertical: 1.h,) ,
                                padding: EdgeInsets.only(left: 0.5.w,right: 1.w,top: 0.5.w,bottom: 0.5.w),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    color: MyColor.backgroundColor),
                                child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(backgroundImage: AssetImage(data[index].imageUrl),),
                                    Expanded(flex: 2,
                                      child: Column(
                                        children: [
                                          Text(data[index].userName),
                                          Text(data[index].userEmail),
                                        ],
                                      ),
                                    ),
                                    Expanded(flex:2,
                                        child: Text(data[index].userTitle)),
                                    Expanded(flex:2,
                                        child: Text(data[index].userDeadline)),
                                    Expanded(flex:2,
                                        child: Text(data[index].userStatus)),
                                    CustomTaskButton(buttonColor:MyColor.blueColor ,
                                      buttonText: 'Approve', onPressed: () {  },),
                                    getHorizontal(.8.h),
                                    CustomSatisfactoryButton(buttonColor:MyColor.blueColor ,
                                      buttonText: 'Satisfactory', onPressed: () {  },),
                                    getHorizontal(.8.h),
                                    CustomTaskButton(buttonColor:MyColor.redColor ,
                                      buttonText: 'Reject', onPressed: () {  },),
                                    getHorizontal(.8.h),
                                    CustomTaskButton(buttonColor:MyColor.greyColor ,
                                      buttonText: 'Details', onPressed: () {
                                      showDetail.value=true;
                                      },),
                                  ],
                                )

                            );
                          }),
                    )

                  ],) ,
                )
            ),


            getVertical(2.w),getHorizontal(2.w)

          ],
        ),
      ),
    ));
  }
}
