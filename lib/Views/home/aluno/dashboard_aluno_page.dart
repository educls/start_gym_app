import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardAlunoPage extends StatefulWidget {
  const DashboardAlunoPage({super.key});

  @override
  State<DashboardAlunoPage> createState() => _DashboardAlunoPageState();
}

class _DashboardAlunoPageState extends State<DashboardAlunoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1546),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cards com estatísticas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatusCard(
                    title: "Completos",
                    value: "16",
                    subtitle: "Treinos Concluídos",
                    icon: Icons.fitness_center,
                    iconPath: 'assets/images/home_aluno/musculo-do-braco.png',
                    color: Colors.yellow.shade700,
                    height: 250,
                    main: true,
                  ),
                  Column(
                    children: [
                      _buildStatusCard(
                        title: "Em progresso",
                        value: "2",
                        subtitle: "Treinos",
                        icon: Icons.directions_run,
                        iconPath: 'assets/images/home_aluno/cronometro.png',
                        color: Colors.orange,
                        width: 200,
                        main: false,
                      ),
                      const SizedBox(height: 16),
                      _buildStatusCard(
                        title: "Tempo dedicado",
                        value: "57",
                        subtitle: "Minutos",
                        icon: Icons.timer,
                        iconPath: 'assets/images/home_aluno/progresso.png',
                        color: Colors.green,
                        width: 200,
                        main: false,
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
                  const Row(
                    children: [
                      Icon(Icons.fitness_center, color: Colors.yellow),
                      SizedBox(width: 8),
                      Text(
                        "TREINOS DA SEMANA",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
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
      padding: const EdgeInsets.all(10),
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
            children: [
              Image.asset(
                iconPath!,
                height: 24,
                width: 24,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
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
