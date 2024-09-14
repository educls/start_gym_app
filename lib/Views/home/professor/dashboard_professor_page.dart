import 'package:flutter/material.dart';
import 'package:start_gym_app/views/home/admin/alunos_admin_page.dart';
import 'package:start_gym_app/views/home/professor/exercicios/treino_por_categoria_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardProfessorPage extends StatefulWidget {
  const DashboardProfessorPage({super.key});

  @override
  State<DashboardProfessorPage> createState() => _DashboardProfessorPageState();
}

class _DashboardProfessorPageState extends State<DashboardProfessorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1546),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Card grande à esquerda
                _buildStatusCard(
                  onPressed: () {},
                  title: "Completos",
                  value: "16",
                  subtitle: 'Treinos\nConcluídos\nEsta Semana',
                  icon: Icons.fitness_center,
                  iconPath: 'assets/images/home_professor/musculo-do-braco.png',
                  color: Colors.yellow.shade700,
                  height: 250,
                  main: true,
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _buildStatusCard(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AlunosAdminPage()));
                        },
                        title: 'Alunos',
                        value: '5',
                        subtitle: 'Ativos',
                        iconPath: 'assets/images/home_professor/aluna_peso.png',
                        color: Colors.yellow.shade700,
                        width: 200,
                        icon: Icons.timer,
                        main: false,
                      ),
                      const SizedBox(height: 16),
                      _buildStatusCard(
                        onPressed: () {
                          Navigator.pushNamed(context, '/sign-up-new-aluno');
                        },
                        title: 'Adicionar',
                        subtitle: 'Aluno',
                        iconPath: 'assets/images/home_professor/alunoAdd.png',
                        color: Colors.black,
                        main: false,
                        width: 200,
                      ),
                      const SizedBox(height: 16),
                      _buildStatusCard(
                        onPressed: () {
                          Navigator.pushNamed(context, '/adicionar-treino');
                        },
                        title: 'Adicionar',
                        subtitle: 'Treino',
                        iconPath: 'assets/images/home_professor/treinoAdd.png',
                        color: Colors.black,
                        main: false,
                        width: 200,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Image(
                        image: AssetImage("assets/images/logoStartGymAmarelo.png"),
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "HORARIOS DA SEMANA",
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
    required String subtitle,
    required Color color,
    required bool main,
    required Function onPressed,
    String? value,
    IconData? icon,
    String? iconPath,
    double width = 140,
    double? height,
  }) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
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
                  height: !main ? 40 : 24,
                  width: !main ? 40 : 24,
                ),
                const SizedBox(width: 8),
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

            main
                ? Column(
                    children: [
                      Text(
                        value!,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  )
                : value != null
                    ? Row(
                        mainAxisAlignment: (main == true) ? MainAxisAlignment.start : MainAxisAlignment.center,
                        children: [
                          Text(
                            value,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      )
          ],
        ),
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
