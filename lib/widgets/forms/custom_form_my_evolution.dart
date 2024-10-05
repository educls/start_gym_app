import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_widget/round_button.dart';
import '../../functions/questionary/questionary_helper.dart';
import '../../mixin/image_picker_mixin.dart';
import '../../utils/enums/questionary_roles.dart';
// import '../../utils/provider/data_provider.dart';

class CustomFormMyEvolution extends StatefulWidget {
  final TypeQuestionary type;
  final Function setLoading;
  const CustomFormMyEvolution({
    super.key,
    required this.type,
    required this.setLoading,
  });

  @override
  State<CustomFormMyEvolution> createState() => _CustomFormMyEvolutionState();
}

class _CustomFormMyEvolutionState extends State<CustomFormMyEvolution> with ImagePickerStateHelper<CustomFormMyEvolution> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(base64Images.length, (index) {
                return GestureDetector(
                  onTap: () => showPickerDialog((base64) => setBase64ImageList(index, base64)),
                  child: Container(
                    width: media.width * 0.47,
                    height: media.height * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: base64Images[index] == null
                        ? const Center(child: Text('Adicionar foto'))
                        : Image.memory(
                            base64Decode(base64Images[index]!),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: RoundButton(
                width: 330,
                title: 'Enviar',
                onPressed: () async {
                  // SendImageListMinhaEvolucaoHelper(
                  //   context: context,
                  //   value: Provider.of<DataAppProvider>(context, listen: false),
                  //   base64Images: base64Images,
                  //   setLoading: widget.setLoading,
                  //   type: widget.type,
                  // ).onPressedForSendImageListMinhaEvolucao();
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
