import 'package:flutter/material.dart';
import 'package:wms/apis/show_products_of_distribution_center.dart';
import 'package:wms/generated/l10n.dart';
import 'package:wms/screens/product_details.dart';
import 'package:wms/static_classes/show_products_of_distribution_center_data.dart';

class ProductsOfDistributionCenter extends StatefulWidget {
  ProductsOfDistributionCenter({super.key, required this.distributionCenterId});
  int distributionCenterId;
  @override
  State<ProductsOfDistributionCenter> createState() =>
      _ProductsOfDistributionCenterState();
}

class _ProductsOfDistributionCenterState
    extends State<ProductsOfDistributionCenter> {
  double fontSize = 30;
  bool isload = true;
  Map productsMap = {};
  List productsList = [];
  void moveToProductDetails({
    required BuildContext context,
    required var item,
    required int distributionCenterId,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ProductDetails(
              item: item,
              destributionCenterID: distributionCenterId,
            ),
      ),
    );
  }

  Future<void> fetchData() async {
    ShowProductsOfDistributionCenter showProductsOfDistributionCenter =
        ShowProductsOfDistributionCenter();
    await showProductsOfDistributionCenter
        .showProductsOfDistributionCenterMethod(
          distributionCenterId: widget.distributionCenterId,
        );
    productsMap.addAll(
      ShowProductsOfDistributionCenterData.showProductsOfDistributionCenterMap,
    );
    productsList.addAll(productsMap['products']);
  }

  void check() async {
    await fetchData();
    isload = false;
    setState(() {});
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    fontSize = size.width / 20;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).products_of_distribution_center),
      ),
      body:
          (isload)
              ? const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              )
              : Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.95,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  itemCount: productsList.length,
                  itemBuilder: (context, index) {
                    var item = productsList[index];
                    return InkWell(
                      onTap:
                          () => moveToProductDetails(
                            context: context,
                            item: item,
                            distributionCenterId: widget.distributionCenterId,
                          ),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                              title: Text(
                                '${item['name']}',
                                style: TextStyle(
                                  fontSize: 80 * fontSize / 100,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${item['description']}',
                                style: TextStyle(fontSize: 75 * fontSize / 100),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                '${S.of(context).quantity}:${item['quantity']}',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                '${item['actual_piece_price']}\$',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
