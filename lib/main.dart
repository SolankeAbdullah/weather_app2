import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/services/weather_api_service.dart';
import 'package:weather_app/weather_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WeatherApiService weatherApiService = WeatherApiService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherApiService),
        child: WeatherPage(),
      ),
    );
  }
}

class WeatherPage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final cityName = _textEditingController.text;
                weatherBloc.add(GetWeatherEvent(cityName));
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherLoadedState) {
                  final weather = state.weather;
                  return Column(
                    children: [
                      Text('City: ${weather.cityName}'),
                      Text('Temperature: ${weather.temperature}'),
                      Text('Condition: ${weather.weatherCondition}'),
                    ],
                  );
                } else if (state is WeatherErrorState) {
                  return Text('Failed to load weather data');
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
