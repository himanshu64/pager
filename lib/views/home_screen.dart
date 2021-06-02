import 'package:flutter/material.dart';
import 'package:pager/controller/product_notifier.dart';
import 'package:pager/model/product_model.dart';
import 'package:pager/views/widgets/productCard.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  ScrollController _scrollController =  ScrollController();
  int _page = 0;
 

  @override
  void initState() {
    super.initState();

    var productProvider = Provider.of<ProductNotifier>(context, listen: false);
    productProvider.resetStreams();
    productProvider.fetchProductList(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
            productProvider.setLoadingStatus(true);
        productProvider.fetchProductList(++_page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Product Listing"),
        
      ),
      body: Consumer<ProductNotifier>(
        builder: (context, productNotify, child) {
          if (productNotify.productList.length > 0) {
            return _listView(productNotify);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _listView(ProductNotifier dataProvider) {
    return Column(
      children: [
        Expanded(
                  child: ListView.separated(
            itemCount: dataProvider.productList.length,
            controller: _scrollController,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
          

              return _buildRow(dataProvider.productList[index], index, dataProvider.productList);
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
              );
            },
          ),
        ),
         dataProvider.isLoading  ?  Container(
           height: 30.0,
           width: 30.0,
           color: Colors.transparent,
           child: CircularProgressIndicator()): Container() 
      ],
    );
  }

  Widget _buildRow(ProductModel productModel, int index, List<ProductModel> productList) {
    Widget widget = productCard(
        thumbnail: productModel.thumbnail,
        salePrice: productModel.salePrice,
        displayName: productModel.displayName,
        mrp: productModel.mrp);

    Draggable draggable = LongPressDraggable<ProductModel>(
      data: productModel,
      axis: Axis.vertical,
      maxSimultaneousDrags: 1,
      child: widget,
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: widget,
      ),
      delay: Duration(milliseconds: 50),
      feedback: Material(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: widget,
        ),
        elevation: 0.0,
      ),
    );
    return DragTarget<ProductModel>(
    onWillAccept: (track) {
      return productList.indexOf(track!) != index;
    },
    onAccept: (track) {
      setState(() {
        int currentIndex = productList.indexOf(track);
        productList.remove(track);
        productList.insert(currentIndex > index ? index : index - 1, track);
      });
    },
    
    builder: (BuildContext context, candidateData, rejectedData) {
      return Column(
        children: <Widget>[
          AnimatedSize(
            duration: Duration(milliseconds: 100),
            vsync: this,
            child: candidateData.isEmpty
                ? Container()
                : Opacity(
                    opacity: 0.0,
                    child: widget,
                  ),
          ),
          Card(
            child: candidateData.isEmpty ? draggable : widget,
          )
        ],
      );
    },
  );
  }

  

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
