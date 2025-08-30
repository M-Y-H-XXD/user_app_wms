import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wms/apis/delete_invoice.dart';
import 'package:wms/apis/edit_invoice.dart';
import 'package:wms/apis/execute_invoice.dart';
import 'package:wms/apis/show_my_invoices.dart';
import 'package:wms/constants_components/type_of_transfer.dart';
import 'package:wms/generated/l10n.dart';
import 'package:wms/modles/constant_colors.dart';
import 'package:wms/screens/invoice_loads.dart';
import 'package:wms/static_classes/delete_invoice_data.dart';
import 'package:wms/static_classes/edit_invoice_data.dart';
import 'package:wms/static_classes/execute_invoice_data.dart';
import 'package:wms/static_classes/show_my_invoices_data.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  double fontSize = 20;
  bool isload = true;
  Map myInvoices = {};
  List invoices = [];
  Map acceptMap = {};
  Map editMap = {};
  Map deleteMap = {};
  late TypeOfTransfer typeOfTransfer;
  Future<void> fetchData() async {
    ShowMyInvoices showMyInvoices = ShowMyInvoices();
    await showMyInvoices.showMyInvoicesMethod();
    myInvoices = {};
    myInvoices.addAll(ShowMyInvoicesData.showMyInvoicesMap);
    invoices = [];
    invoices.addAll(myInvoices['invoices']);
  }

  void check() async {
    await fetchData();
    isload = false;
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  void moveToInvoiceLoads({
    required BuildContext context,
    required int invoiceID,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoiceLoads(invoiceId: invoiceID),
      ),
    );
  }

  Future<Response?> accept({required int invoiceId}) async {
    ExecuteInvoice executeInvoice = ExecuteInvoice();
    final temp = await executeInvoice.executeInvoiceMethod(
      invoiceId: invoiceId,
    );
    acceptMap.addAll(ExecuteInvoiceData.executeInvoiceMap);
    return temp;
  }

  Future<Response?> edit({
    required int invoiceID,
    required TypeOfTransfer typeOfTransfer,
  }) async {
    EditInvoice editInvoice = EditInvoice();
    final temp = await editInvoice.editInvoiceMethod(
      invoiceID: invoiceID,
      typeOfTransfer: typeOfTransfer,
    );
    editMap.addAll(EditInvoiceData.editInvoiceMap);
    return temp;
  }

  Future<Response?> delete({required int invoiceID}) async {
    DeleteInvoice deleteInvoice = DeleteInvoice();
    final temp = await deleteInvoice.deleteInvoiceMethod(invoiceId: invoiceID);
    deleteMap.addAll(DeleteInvoiceData.deleteInvoiceMap);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    fontSize = size.width / 20;
    return Scaffold(
      //appBar: AppBar(centerTitle: true, title: Text(S.of(context).my_invoices)),
      body:
          (isload)
              ? const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              )
              : (invoices.isEmpty)
              ? Center(
                child: Text(
                  S.of(context).no_invoices_found,
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
                  itemCount: invoices.length,
                  itemBuilder: (context, index) {
                    var item = invoices[index];
                    return InkWell(
                      onTap:
                          () => moveToInvoiceLoads(
                            invoiceID: item['id'],
                            context: context,
                          ),
                      child: Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                S.of(context).invoice,
                                style: TextStyle(
                                  fontSize: 90 * fontSize / 100,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text(
                                      '${S.of(context).number}:${item['id']}',
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      '${S.of(context).status}:${item['status']}',
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      '${S.of(context).type}:${item['type']}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(
                                    onPressed: () async {
                                      final Response? response = await accept(
                                        invoiceId: item['id'],
                                      );
                                      if (response != null &&
                                          (response.statusCode == 201 ||
                                              response.statusCode == 202)) {
                                        String? msg = acceptMap['msg'];
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text('$msg'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      } else if (response != null &&
                                          (response.statusCode != 201 &&
                                              response.statusCode != 202)) {
                                        String? message = acceptMap['msg'];
                                        String? errorMsg = acceptMap['error'];
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

                                    color: Colors.green,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      S.of(context).accept,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () async {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          String selectedOption0 =
                                              (item['type'] ==
                                                      TypeOfTransfer
                                                          .Un_transfered
                                                          .name)
                                                  ? S.of(context).un_transferred
                                                  : (item['type'] ==
                                                      TypeOfTransfer
                                                          .transfered
                                                          .name)
                                                  ? S.of(context).transferred
                                                  : S
                                                      .of(context)
                                                      .un_transferred;
                                          typeOfTransfer =
                                              (item['type'] ==
                                                      TypeOfTransfer
                                                          .Un_transfered
                                                          .name)
                                                  ? TypeOfTransfer.Un_transfered
                                                  : (item['type'] ==
                                                      TypeOfTransfer
                                                          .transfered
                                                          .name)
                                                  ? TypeOfTransfer.transfered
                                                  : TypeOfTransfer
                                                      .Un_transfered;
                                          final List<String> options = [
                                            S.of(context).transferred,
                                            S.of(context).un_transferred,
                                          ];
                                          String selectedOption =
                                              selectedOption0;
                                          bool isExpanded = false;

                                          return StatefulBuilder(
                                            builder: (context, setModalState) {
                                              return Container(
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
                                                      InkWell(
                                                        onTap: () {
                                                          setModalState(() {
                                                            isExpanded =
                                                                !isExpanded;
                                                          });
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 10,
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
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                selectedOption,
                                                              ),
                                                              Icon(
                                                                isExpanded
                                                                    ? Icons
                                                                        .arrow_drop_up
                                                                    : Icons
                                                                        .arrow_drop_down,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      if (isExpanded)
                                                        Container(
                                                          margin:
                                                              const EdgeInsets.only(
                                                                top: 4,
                                                              ),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 16,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  Colors
                                                                      .blueGrey,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            color:
                                                                ConstantColors
                                                                    .backgroundOfStatefulBuilder, ///////////////////////////////
                                                          ),
                                                          child: Column(
                                                            children:
                                                                options.map((
                                                                  option,
                                                                ) {
                                                                  return ListTile(
                                                                    title: Text(
                                                                      option,
                                                                    ),
                                                                    onTap: () {
                                                                      setModalState(() {
                                                                        selectedOption =
                                                                            option;
                                                                        isExpanded =
                                                                            false;
                                                                      });

                                                                      setState(() {
                                                                        selectedOption0 =
                                                                            option;
                                                                        if (option ==
                                                                            S
                                                                                .of(
                                                                                  context,
                                                                                )
                                                                                .transferred) {
                                                                          typeOfTransfer =
                                                                              TypeOfTransfer.transfered;
                                                                        } else if (option ==
                                                                            S
                                                                                .of(
                                                                                  context,
                                                                                )
                                                                                .un_transferred) {
                                                                          typeOfTransfer =
                                                                              TypeOfTransfer.Un_transfered;
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
                                                          final Response?
                                                          response = await edit(
                                                            invoiceID:
                                                                item['id'],
                                                            typeOfTransfer:
                                                                typeOfTransfer,
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

                                                            ScaffoldMessenger.of(
                                                              context,
                                                            ).showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  '${message ?? " "}  ',
                                                                ),
                                                                backgroundColor:
                                                                    Colors.red,
                                                              ),
                                                            );
                                                          }

                                                          Navigator.pop(
                                                            context,
                                                          );
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
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .appBarTheme
                                                                      .backgroundColor ??
                                                                  Colors
                                                                      .blueGrey,
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
                                    child: Text(
                                      S.of(context).edit,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  MaterialButton(
                                    onPressed: () async {
                                      final Response? response = await delete(
                                        invoiceID: item['id'],
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
                                    child: Text(
                                      S.of(context).delete,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
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
