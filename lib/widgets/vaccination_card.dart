import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:vaccination/Logic/cubit/auth_cubit_cubit.dart';

import '../Data/pdf_service.dart';

class VaccinationCard extends StatefulWidget {
  final Color? color;
  final String nom;
  final String prenom;
  final String centre;
  final String status;
  const VaccinationCard({
    Key? key,
    this.color,
    required this.nom,
    required this.prenom,
    required this.centre,
    required this.status,
  }) : super(key: key);

  @override
  State<VaccinationCard> createState() => _VaccinationCardState();
}

class _VaccinationCardState extends State<VaccinationCard> {
  final PdfInvoiceService service = PdfInvoiceService();

  String font = 'JetBrainsMono';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubitCubit, AuthCubitState>(
      builder: (context, state) {
        if (state is AuthCubitSuccess) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // color: Colors.greenAccent[200],
                  color: widget.color ?? Colors.greenAccent[200],
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black26,
                      // offset: Offset(2, 2),
                    ),
                  ]),
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width / 1.09,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'Img/vaccine.png',
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Carte de vaccination',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: font,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    // color: Colors.purple,
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FieldSet(
                          title: 'Nom:',
                          content: widget.nom,
                        ),
                        FieldSet(
                          title: 'Prenom :',
                          content: widget.prenom,
                        ),
                        FieldSet(
                          title: 'Centre :',
                          content: widget.centre,
                        ),
                        FieldSet(
                          title: 'Status:',
                          content: widget.status,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.document_scanner),
                            onPressed: () async {
                              // final data = await PdfInvoiceService.createHelloWorld();
                              final data = await service.createHelloWorld(
                                widget.nom,
                                widget.centre,
                                widget.centre,
                                widget.status,
                              );
                              service.savePdfFile('Vaccination', data);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: QrImageView(
                              data:
                                  'Nom: ${widget.nom}\nPrenom: ${widget.prenom}\nCentre: ${widget.centre}\n',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text(state.toString()),
            ),
          );
        }
      },
    );
    // );
  }
}

class FieldSet extends StatelessWidget {
  String? title;
  String? content;
  FieldSet({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? ''),
        Text(
          content ?? '',
          style: const TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}
