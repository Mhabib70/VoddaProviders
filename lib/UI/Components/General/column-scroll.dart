
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Logic/Controllers/app-controller.dart';
import '../../../Public/styles.dart';

class ColumnScroll extends StatefulWidget {
  List<Widget>? children;
  Widget? emptyList;
  double padding;
  Function? getLoadedWidgets;
  Function? onEndScroll;
  Function? checkEmptyList;
  String? loadingTag;
  ColumnScroll({Key? key,this.getLoadedWidgets,this.children,this.padding=paddingSize,this.onEndScroll,this.loadingTag,this.emptyList,this.checkEmptyList}) : super(key: key);

  @override
  State<ColumnScroll> createState() => _ColumnScrollState();
}

class _ColumnScrollState extends State<ColumnScroll> {
  final _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async{
      if(_scrollController.position.pixels > _scrollController.position.maxScrollExtent-100
          && widget.onEndScroll!=null && !AppController.isLoading.value==false){
        await widget.onEndScroll!();
      }
        

    });
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Obx(
       () {
         late bool isLoading;
         // if(widget.loadingTag==null)
         //  isLoading=AppController.isLoading.value;
         // else
           isLoading=AppController.isLoading.value;
        return !isLoading && widget.checkEmptyList!=null && widget.checkEmptyList!()?
        widget.emptyList??Container():Scrollbar(
            interactive: true,
            thickness: 10,
            thumbVisibility: size.width<500?false:true,
            trackVisibility: size.width<500?false:true,
            controller: _scrollController,

            child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
            scrollbars: false
        ),
        child: SingleChildScrollView(
        controller: _scrollController,
          child: Container(
                margin: EdgeInsets.only(
                    left: widget.padding, right: widget.padding),
                width: size.width,
                child:
                Column(
                  children: [
                    widget.getLoadedWidgets!=null?widget.getLoadedWidgets!():Column(
                      children: widget.children??[],
                    ),
                    isLoading?
                    Container(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppController.primaryColor,
                            strokeWidth: 4,
                          ),
                        ],
                      ),
                    ):Container(height: 100,)
                  ],
                )
              ),
        )));
      }
    )
    ;
  }
}
