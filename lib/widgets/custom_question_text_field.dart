import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../functions/date_formatter.dart';
import '../helpers/text_field_config.dart';
import '../mixin/question_text_field_state_mixin.dart';

class CustomTextField extends StatefulWidget {
  final bool isIntValue;
  final bool isStringValue;
  final bool isDateValue;
  final String pergunta;
  final TextEditingController respostaController;

  const CustomTextField({
    super.key,
    required this.isIntValue,
    required this.isStringValue,
    required this.isDateValue,
    required this.pergunta,
    required this.respostaController,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> with QuestionTextFieldStateHelper<CustomTextField> {
  TextFieldConfig getTextFieldConfig() {
    Map<String, TextFieldConfig> configs = {
      'Data de nascimento': TextFieldConfig(
        readOnly: true,
        onTap: () => pickDate(context),
        inputFormatters: [DataInputFormatter()],
        keyboardType: TextInputType.datetime,
        maxLines: 1,
        hintText: 'Selecione a Data',
        textAlign: TextAlign.center,
        textStyle: const TextStyle(fontSize: 30),
      ),
      'Peso': TextFieldConfig(
        readOnly: false,
        onTap: null,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, PesoInputFormatter()],
        keyboardType: TextInputType.number,
        maxLines: 1,
        hintText: '00',
        textAlign: TextAlign.center,
        textStyle: const TextStyle(fontSize: 30),
      ),
      'Altura': TextFieldConfig(
        readOnly: false,
        onTap: null,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, AlturaInputFormatter()],
        keyboardType: TextInputType.number,
        maxLines: 1,
        hintText: '00',
        textAlign: TextAlign.center,
        textStyle: const TextStyle(fontSize: 30),
      ),
    };

    return configs[widget.pergunta] ??
        TextFieldConfig(
          readOnly: false,
          onTap: null,
          inputFormatters: widget.isStringValue ? [] : [FilteringTextInputFormatter.digitsOnly],
          keyboardType: widget.isIntValue
              ? TextInputType.number
              : widget.isStringValue
                  ? TextInputType.multiline
                  : widget.isDateValue
                      ? TextInputType.datetime
                      : null,
          maxLines: widget.isStringValue ? null : 1,
          hintText: 'Digite sua resposta...',
          textAlign: TextAlign.left,
          textStyle: const TextStyle(fontSize: 18),
        );
  }

  String? getSuffixText() {
    if (widget.pergunta == 'Peso') {
      return 'Kg';
    } else if (widget.pergunta == 'Altura') {
      return 'cm';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final config = getTextFieldConfig();
    final suffixText = getSuffixText();

    widget.respostaController.text = widget.pergunta == 'Data de nascimento' ? DateFormatter().formatToDDMMYYYY(selectedDate) : widget.respostaController.text;

    return Row(
      children: [
        Expanded(
          child: TextField(
            style: config.textStyle,
            readOnly: config.readOnly,
            onTap: config.onTap,
            inputFormatters: config.inputFormatters,
            keyboardType: config.keyboardType,
            maxLines: config.maxLines,
            controller: widget.respostaController,
            textAlign: config.textAlign,
            decoration: InputDecoration(
              hintText: config.hintText,
            ),
          ),
        ),
        if (suffixText != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 20),
            child: Text(
              suffixText,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
