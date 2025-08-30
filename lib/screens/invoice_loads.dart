import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wms/apis/delete_load.dart';
import 'package:wms/apis/edit_load.dart';
import 'package:wms/apis/show_invoice_loads.dart';
import 'package:wms/generated/l10n.dart';
import 'package:wms/modles/constant_colors.dart';
import 'package:wms/static_classes/delete_load_data.dart';
import 'package:wms/static_classes/edit_load_data.dart';
import 'package:wms/static_classes/show_invoice_loads_data.dart';

final regex = RegExp(r'^[1-9][0-9]*$');
GlobalKey<FormState> formState = GlobalKey();

class InvoiceLoads extends StatefulWidget {
  const InvoiceLoads({super.key, required this.invoiceId});
  final int invoiceId;
  @override
  State<InvoiceLoads> createState() => _InvoiceLoadsState();
}

class _InvoiceLoadsState extends State<InvoiceLoads> {
  double fontSize = 20;
  int reservedQuantity = 0;
  bool isload = true;
  Map invoiceLoadsMap = {};
  List invoiceLoadList = [];
  Map editMap = {};
  Map deleteMap = {};
  Future<void> fetchData() async {
    ShowInvoiceLoads showInvoiceLoads = ShowInvoiceLoads();
    await showInvoiceLoads.showInvoiceLoadsMethod(invoiceId: widget.invoiceId);
    invoiceLoadList = [];
    invoiceLoadsMap = {};
    invoiceLoadsMap.addAll(ShowInvoiceLoadsData.showInvoiceLoadsMap);
    invoiceLoadList.addAll(invoiceLoadsMap['loads']);
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

  Future<Response?> edit({required int loadID, required int quantity}) async {
    EditLoad editLoad = EditLoad();
    final temp = await editLoad.editLoadMethod(
      loadID: loadID,
      quantity: quantity,
    );
    editMap.addAll(EditLoadData.editLoadMap);

    return temp;
  }

  Future<Response?> delete({required int loadID}) async {
    DeleteLoad deleteLoad = DeleteLoad();
    final temp = await deleteLoad.deleteLoadMethod(loadId: loadID);
    deleteMap.addAll(DeleteLoadData.deleteLoadMap);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    fontSize = size.width / 20;
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).loads), centerTitle: true),
      body:
          (isload)
              ? const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              )
              : (invoiceLoadList.isEmpty)
              ? Center(
                child: Text(
                  S.of(context).no_loads_found,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: invoiceLoadList.length,
                  itemBuilder: (context, index) {
                    var item = invoiceLoadList[index];
                    var nestedItem = item['product'];
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              S.of(context).load_keyword,
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text('${S.of(context).number}:${item['id']}'),
                                  const SizedBox(width: 15),
                                  Text(
                                    '${S.of(context).status}:${item['status']}',
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    '${S.of(context).vehicle_id}:${item['vehicle_id'] ?? "?"}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 3 * size.width / 4,
                            height: size.height / 5,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              //color: Colors.grey,
                              border: Border.all(
                                color: Colors.indigoAccent,
                                width: 3,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  S.of(context).product,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${S.of(context).name} : ${nestedItem['name']}',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${S.of(context).desciption} : ${nestedItem['description']}',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${S.of(context).reserved_load} : ${item['reserved_load']} ',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
                                  onPressed: () async {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
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
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Spacer(),
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                          border: const OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    30,
                                                                  ),
                                                                ),
                                                          ),
                                                          focusedBorder:
                                                              const OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                      Radius.circular(
                                                                        30,
                                                                      ),
                                                                    ),
                                                              ),

                                                          labelText:
                                                              S
                                                                  .of(context)
                                                                  .quantity,
                                                          labelStyle:
                                                              const TextStyle(
                                                                color:
                                                                    Colors
                                                                        .black,
                                                                fontSize: 20,
                                                              ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                        ),
                                                        cursorColor:
                                                            Colors.black,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return S
                                                                .of(context)
                                                                .field_is_required;
                                                          }
                                                          if (!regex.hasMatch(
                                                            value,
                                                          )) {
                                                            return S
                                                                .of(context)
                                                                .quantity_is_invalid;
                                                          }

                                                          return null;
                                                        },
                                                        onSaved: (value) {
                                                          reservedQuantity =
                                                              int.parse(value!);
                                                        },
                                                      ),
                                                      const Spacer(),

                                                      InkWell(
                                                        onTap: () async {
                                                          if (formState
                                                              .currentState!
                                                              .validate()) {
                                                            formState
                                                                .currentState!
                                                                .save();
                                                            final Response?
                                                            response = await edit(
                                                              loadID:
                                                                  item['id'],
                                                              quantity:
                                                                  reservedQuantity,
                                                            );
                                                            if (response !=
                                                                    null &&
                                                                (response.statusCode ==
                                                                        201 ||
                                                                    response.statusCode ==
                                                                        202)) {
                                                              String? msg =
                                                                  editMap['msg'];
                                                              ScaffoldMessenger.of(
                                                                context,
                                                              ).showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    '$msg',
                                                                  ),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                ),
                                                              );
                                                              isload = true;
                                                              setState(() {});
                                                              check();
                                                            } else if (response !=
                                                                    null &&
                                                                (response.statusCode !=
                                                                        201 &&
                                                                    response.statusCode !=
                                                                        202)) {
                                                              String? message =
                                                                  editMap['msg'];
                                                              String? errorMsg =
                                                                  editMap['error'];
                                                              ScaffoldMessenger.of(
                                                                context,
                                                              ).showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    '${message ?? " "} \n ${errorMsg ?? " "} ',
                                                                  ),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                ),
                                                              );
                                                            }
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 16,
                                                                vertical: 12,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                          ),
                                                          child: Text(
                                                            S.of(context).ok,
                                                          ),
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
                                  color: Colors.pinkAccent,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Text(S.of(context).edit),
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    final Response? response = await delete(
                                      loadID: item['id'],
                                    );
                                    if (response != null &&
                                        (response.statusCode == 201 ||
                                            response.statusCode == 202)) {
                                      String? msg = deleteMap['msg'];
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('$msg'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      isload = true;
                                      setState(() {});
                                      check();
                                    } else if (response != null &&
                                        (response.statusCode != 201 &&
                                            response.statusCode != 202)) {
                                      String? message = deleteMap['msg'];
                                      String? errorMsg = deleteMap['error'];
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
                                  },
                                  color: Colors.red,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Text(S.of(context).delete),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
