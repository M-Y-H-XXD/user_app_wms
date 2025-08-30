import 'package:flutter/material.dart';
import 'package:wms/apis/show_distribution_centers_of_product_sorted.dart';
import 'package:wms/generated/l10n.dart';
import 'package:wms/screens/products_of_distribution_center.dart';
import 'package:wms/static_classes/show_distribution_centers_of_product_sorted_data.dart';

class DistributionCentersSorted extends StatefulWidget {
  DistributionCentersSorted({
    super.key,
    required this.productID,
    required this.latitude,
    required this.longitude,
  });
  int productID;
  double longitude;
  double latitude;
  @override
  State<DistributionCentersSorted> createState() =>
      _DistributionCentersSortedState();
}

class _DistributionCentersSortedState extends State<DistributionCentersSorted> {
  double fontSize = 30;
  bool isload = true;
  Map distributionsMap = {};
  List distributionsList = [];
  void moveToDistributionCenterProducts({
    required BuildContext context,
    required int distributionCenterId,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ProductsOfDistributionCenter(
              distributionCenterId: distributionCenterId,
            ),
      ),
    );
  }

  Future<void> fetchData() async {
    ShowDistributionCentersOfProductSorted
    showDistributionCentersOfProductSorted =
        ShowDistributionCentersOfProductSorted();
    await showDistributionCentersOfProductSorted
        .showDistributionCentersOfProductSortedMethod(
          productID: widget.productID,
          longitude: widget.longitude,
          latitude: widget.latitude,
        );
    distributionsMap.addAll(
      ShowDistributionCentersOfProductSortedData
          .showDistributionCentersOfProductSortedMap,
    );
    distributionsList.addAll(distributionsMap["distribuction_centers"]);
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
        title: Text(S.of(context).distributions_centers_by_closest),
      ),
      body:
          (isload)
              ? const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              )
              : Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: distributionsList.length,
                  itemBuilder: (context, index) {
                    var item = distributionsList[index];
                    return InkWell(
                      onTap:
                          () => moveToDistributionCenterProducts(
                            context: context,
                            distributionCenterId: item['id'],
                          ),
                      child: Card(
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${S.of(context).name}:${item["name"]}',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${S.of(context).location}:${item['location']}',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${S.of(context).sales_type}:${item['type_name']}',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
