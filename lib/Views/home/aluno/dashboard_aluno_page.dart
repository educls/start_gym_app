import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:start_gym_app/utils/constants/color_constants.dart';
import "package:start_gym_app/utils/constants/path_contants.dart";

class DashboardAlunoPage extends StatefulWidget {
  const DashboardAlunoPage({super.key});

  @override
  State<DashboardAlunoPage> createState() => _DashboardAlunoPageState();
}

class _DashboardAlunoPageState extends State<DashboardAlunoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.darkBlue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cards com estatísticas
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatusCardFinished(
                    title: "Completos",
                    value: "15",
                    subtitle: "Treinos Concluídos",
                    iconPath: PathConstants.braco,
                    color: ColorConstants.darkYellow,
                    height: 237,
                    main: true,
                    width: 160,
                  ),
                  Column(
                    children: [
                      _buildStatusCard(
                        title: "Em progresso",
                        value: "2",
                        subtitle: "Treinos",
                        iconPath: PathConstants.progresso,
                        color: ColorConstants.darkYellow,
                        width: 200,
                        main: false,
                        height: 110,
                      ),
                      const SizedBox(height: 16),
                      _buildStatusCard(
                        title: "Tempo dedicado",
                        value: "57",
                        subtitle: "Minutos",
                        iconPath: PathConstants.cronometro,
                        color: Colors.green,
                        width: 200,
                        main: false,
                        height: 110,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Treinos da semana
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        PathConstants.logoStartGym,
                        width: 50,
                        height: 50,
                        color: ColorConstants.darkYellow,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "TREINOS DA SEMANA",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.darkYellow,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Calendário de treinos
                  _buildCalendar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCardFinished({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required bool main,
    IconData? icon,
    String? iconPath,
    double width = 140,
    double? height,
  }) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ícone customizado
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath!,
                height: 27,
                width: 27,
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.darkBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25), // Espaço entre a Row e a próxima linha
          Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centraliza verticalmente
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.darkYellow,
                ),
              ),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(26, 25, 68, 0.729)),
              ),
              const SizedBox(height: 25),
            ],
          )
        ],
      ),
    );
  }
}

Widget _buildStatusCard({
  required String title,
  required String value,
  required String subtitle,
  required Color color,
  required bool main,
  IconData? icon,
  String? iconPath,
  double width = 140,
  double? height,
}) {
  return Container(
    width: width,
    height: height,
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Ícone customizado
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath!,
              height: 27,
              width: 27,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstants.darkBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: ColorConstants.darkYellow,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 15, color: Color.fromRGBO(26, 25, 68, 0.729)),
            ),
          ],
        )
      ],
    ),
  );
}

// Função para construir o calendário
Widget _buildCalendar() {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: TableCalendar(
      firstDay: DateTime.utc(2020, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      calendarFormat: CalendarFormat.week,
      onDaySelected: (selectedDay, focusedDay) {
        // Lógica para o dia selecionado
      },
    ),
  );
}
