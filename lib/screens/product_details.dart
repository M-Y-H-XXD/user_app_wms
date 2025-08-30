import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wms/apis/reserve_products.dart';
import 'package:wms/constants_components/status_of_transfer.dart';
import 'package:wms/constants_components/type_of_transfer.dart';
import 'package:wms/generated/l10n.dart';
import 'package:wms/modles/constant_colors.dart';
import 'package:wms/mywigets/name_field.dart';
import 'package:wms/static_classes/reserve_products_data.dart';
import 'package:wms/static_classes/user_informations.dart';

final regex = RegExp(r'^[1-9][0-9]*$');

GlobalKey<FormState> formState = GlobalKey();

class ProductDetails extends StatefulWidget {
  ProductDetails({
    super.key,
    required this.item,
    required this.destributionCenterID,
  });
  var item;
  int destributionCenterID;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double fontSize = 20;
  late TypeOfTransfer typeOfTransfer;
  late StatusOfTransfer statusOfTransfer;
  Map reserveData = {};
  int reservedQuantity = 0;
  int? productId;
  Future<Response?> reserve({
    required TypeOfTransfer transferType,
    required StatusOfTransfer transferStatus,
    required int distributionCenterId,
    required Map<String, String> order,
    required String location,
    required double latitude,
    required double longitude,
  }) async {
    ReserveProducts reserveProducts = ReserveProducts();
    final Response? response = await reserveProducts.reserveProductsMethod(
      distributionCenterId: distributionCenterId,
      order: order,
      location: location,
      latitude: latitude,
      longitude: longitude,
      typeOfTransfer: transferType,
      statusOfTransfer: transferStatus,
    );
    reserveData.addAll(ReserveProductsData.reserveProductsMap);
    return response;
  }

  @override
  void initState() {
    productId = widget.item['id'];
    typeOfTransfer = TypeOfTransfer.Un_transfered;
    statusOfTransfer = StatusOfTransfer.wait;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String selectedOption0 = S.of(context).un_transferred;
    String selectedOptionStatus = S.of(context).wait;
    final List<String> options = [
      S.of(context).transferred,
      S.of(context).un_transferred,
    ];
    final List<String> optionsStatus = [
      S.of(context).accept,
      S.of(context).wait,
    ];
    Size size = MediaQuery.of(context).size;
    fontSize = size.width / 20;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(S.of(context).details)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80 * size.height / 100,
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(60),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${S.of(context).name}: ${widget.item['name']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).desciption}: ${widget.item['description']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).quantity}: ${widget.item['quantity']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).unit}: ${widget.item['unit']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).import_cycle}: ${widget.item['import_cycle']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).lowest_temperature}: ${widget.item['lowest_temperature']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).highest_temperature}: ${widget.item['highest_temperature']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).lowest_humidity}: ${widget.item['lowest_humidity']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).highest_humidity}: ${widget.item['highest_humidity']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).lowest_light}: ${widget.item['lowest_light']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).highest_light}: ${widget.item['highest_light']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).lowest_pressure}: ${widget.item['lowest_pressure']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).highest_pressure}: ${widget.item['highest_pressure']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).lowest_ventilation}: ${widget.item['lowest_ventilation']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).highest_ventilation}: ${widget.item['highest_ventilation']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).actual_load}: ${widget.item['actual_load']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).transferred_load}: ${widget.item['transfered_load']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).can_transfer}: ${widget.item['can_transfer']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).min_Capacity_to_transfer}: ${widget.item['min_Capacity_to_transfer']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${S.of(context).piece_price}: ${widget.item['actual_piece_price']}\$',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: double.infinity),
                  MaterialButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          String selectedOption = selectedOption0;
                          bool isExpanded = false;
                          String selectedOptionOfStatus = selectedOptionStatus;
                          bool isExpandedStatus = false;

                          return StatefulBuilder(
                            builder: (context, setModalState) {
                              return Form(
                                key: formState,
                                child: Container(
                                  height: size.height / 2,
                                  width: double.infinity,
                                  color:
                                      ConstantColors
                                          .backgroundOfStatefulBuilder,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Spacer(),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(30),
                                                      ),
                                                ),

                                            labelText: S.of(context).quantity,
                                            labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                          ),
                                          cursorColor: Colors.black,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'field is required';
                                            }
                                            if (!regex.hasMatch(value)) {
                                              return 'quantity  is invalid';
                                            }

                                            int? quantity =
                                                widget.item['actual_load'];

                                            // int enteredQuantity = int.parse(value);
                                            if (quantity != null &&
                                                int.parse(value) > quantity) {
                                              return S
                                                  .of(context)
                                                  .quantity_not_available;
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            reservedQuantity = int.parse(
                                              value!,
                                            );
                                          },
                                        ),
                                        const Spacer(),
                                        NameField(
                                          label: S.of(context).location,
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            setModalState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(selectedOption),
                                                Icon(
                                                  isExpanded
                                                      ? Icons.arrow_drop_up
                                                      : Icons.arrow_drop_down,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (isExpanded)
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 4,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color:
                                                  ConstantColors
                                                      .backgroundOfStatefulBuilder,
                                            ),
                                            child: Column(
                                              children:
                                                  options.map((option) {
                                                    return ListTile(
                                                      title: Text(option),
                                                      onTap: () {
                                                        setModalState(() {
                                                          selectedOption =
                                                              option;
                                                          isExpanded = false;
                                                        });

                                                        setState(() {
                                                          selectedOption0 =
                                                              option;
                                                          if (option ==
                                                              S
                                                                  .of(context)
                                                                  .transferred) {
                                                            typeOfTransfer =
                                                                TypeOfTransfer
                                                                    .transfered;
                                                          } else if (option ==
                                                              S
                                                                  .of(context)
                                                                  .un_transferred) {
                                                            typeOfTransfer =
                                                                TypeOfTransfer
                                                                    .Un_transfered;
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }).toList(),
                                            ),
                                          ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            setModalState(() {
                                              isExpandedStatus =
                                                  !isExpandedStatus;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(selectedOptionOfStatus),
                                                Icon(
                                                  isExpandedStatus
                                                      ? Icons.arrow_drop_up
                                                      : Icons.arrow_drop_down,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (isExpandedStatus)
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 4,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color:
                                                  ConstantColors
                                                      .backgroundOfStatefulBuilder,
                                            ),
                                            child: Column(
                                              children:
                                                  optionsStatus.map((option) {
                                                    return ListTile(
                                                      title: Text(option),
                                                      onTap: () {
                                                        setModalState(() {
                                                          selectedOptionOfStatus =
                                                              option;
                                                          isExpandedStatus =
                                                              false;
                                                        });

                                                        setState(() {
                                                          selectedOptionStatus =
                                                              option;
                                                          if (option ==
                                                              S
                                                                  .of(context)
                                                                  .accept) {
                                                            statusOfTransfer =
                                                                StatusOfTransfer
                                                                    .accepted;
                                                          } else if (option ==
                                                              S
                                                                  .of(context)
                                                                  .wait) {
                                                            statusOfTransfer =
                                                                StatusOfTransfer
                                                                    .wait;
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }).toList(),
                                            ),
                                          ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () async {
                                            if (formState.currentState!
                                                .validate()) {
                                              formState.currentState!.save();
                                              final Response?
                                              response = await reserve(
                                                transferType: typeOfTransfer,
                                                transferStatus:
                                                    statusOfTransfer,
                                                distributionCenterId:
                                                    widget.destributionCenterID,
                                                order: {
                                                  '$productId':
                                                      '$reservedQuantity',
                                                },
                                                location:
                                                    '${UserInformations.location}',
                                                latitude: 2,
                                                longitude: 2,
                                              );
                                              if (response != null &&
                                                  (response.statusCode == 201 ||
                                                      response.statusCode ==
                                                          202)) {
                                                String? msg =
                                                    reserveData['msg'];
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text('$msg'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                              } else if (response != null &&
                                                  (response.statusCode != 201 &&
                                                      response.statusCode !=
                                                          202)) {
                                                String? message =
                                                    reserveData['msg'];
                                                String? errorMsg =
                                                    reserveData['error'];
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '${message ?? " "} \n ${errorMsg ?? " "} ',
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(S.of(context).ok),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },

                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(10),
                    minWidth: size.width - 100,
                    child: Text(
                      S.of(context).reserve,
                      style: TextStyle(fontSize: fontSize * 1.25),
                    ),
                  ),
                ],
              ),
            ),

            // Builder(
            //   builder: (context) {
            //     return MaterialButton(
            //       onPressed: () {
            //         showBottomSheet(
            //           context: context,
            //           builder:
            //               (context) => Container(
            //                 height: size.height / 2,
            //                 width: double.infinity,
            //                 color: Colors.blueGrey,
            //               ),
            //         );
            //       },
            //       color: Colors.blue,
            //       child: Text(S.of(context).add_to_cart),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
