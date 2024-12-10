import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stepper_demo/const/path_name.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: PathName.home,
  routes: [
    GoRoute(
      path: PathName.home,
      name: PathName.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: PathName.reservation,
      name: PathName.reservation,
      builder: (context, state) => const DentalReservationPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'デンタルクリニック予約',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF40E0D0), // ターコイズブルー
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('俺ちゃんデンタルクリニック'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed(PathName.reservation),
          child: const Text('予約する'),
        ),
      )
    );
  }
}

class DentalReservationPage extends StatefulWidget {
  const DentalReservationPage({super.key});

  @override
  State<DentalReservationPage> createState() => _DentalReservationPageState();
}

class _DentalReservationPageState extends State<DentalReservationPage> {
  int _currentStep = 0;
  final Map<String, bool> _symptoms = {
    '歯がしみる': false,
    '歯が痛い': false,
    '歯茎が痛い': false,
    '歯が痺れる': false,
    '歯が折れた': false,
    '悪いところがないか検査してほしい': false,
  };

  List<Step> getSteps() {
    return [
      Step(
        title: const Text('症状の選択'),
        content: Column(
          children: _symptoms.entries.map((entry) {
            return CheckboxListTile(
              title: Text(entry.key),
              value: entry.value,
              onChanged: (bool? value) {
                setState(() {
                  _symptoms[entry.key] = value ?? false;
                });
              },
            );
          }).toList(),
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: const Text('予約内容の確認'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('選択された症状:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._symptoms.entries
                .where((entry) => entry.value)
                .map((entry) => Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 4),
                      child: Text('・${entry.key}'),
                    )),
          ],
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: const Text('完了'),
        content: const Column(
          children: [
            Icon(Icons.check_circle_outline, size: 48, color: Color(0xFF40E0D0)),
            SizedBox(height: 16),
            Text('予約申し込みが完了しました。\nご来院をお待ちしております。',
                textAlign: TextAlign.center),
          ],
        ),
        isActive: _currentStep >= 2,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('予約フォーム'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < getSteps().length - 1) {
            setState(() {
              _currentStep++;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
        steps: getSteps(),
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          final isLastStep = _currentStep == getSteps().length - 1;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: isLastStep
                ? Center(
                    child: ElevatedButton(
                      onPressed: () => context.goNamed(PathName.home),
                      child: const Text('ホームに戻る'),
                    ),
                  )
                : Row(
                    children: [
                      ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: const Text('次へ'),
                      ),
                      if (_currentStep > 0) ...[
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: details.onStepCancel,
                          child: const Text('戻る'),
                        ),
                      ],
                    ],
                  ),
          );
        },
      ),
    );
  }
}
