import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/weather_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WeatherEvent {}

class GetWeatherEvent extends WeatherEvent {
  final String cityName;

  GetWeatherEvent(this.cityName);
}

class WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final Weather weather;

  WeatherLoadedState(this.weather);
}

class WeatherErrorState extends WeatherState {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherApiService weatherApiService;

  WeatherBloc(this.weatherApiService) : super(WeatherLoadingState());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeatherEvent) {
      yield WeatherLoadingState();
      try {
        final weather = await weatherApiService.fetchWeather(event.cityName);
        yield WeatherLoadedState(weather);
      } catch (e) {
        yield WeatherErrorState();
      }
    }
  }
}
