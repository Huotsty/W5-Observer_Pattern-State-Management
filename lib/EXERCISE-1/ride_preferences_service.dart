import 'package:week5/EXERCISE-1/location.dart';
import 'package:week5/EXERCISE-1/ride_preference.dart';
// observer
abstract class RidePreferencesListener{
  void onPreferenceSelected(RidePreference selectedPreference);
}
// subject
class RidePreferencesService{
  RidePreference _ridePreferenceSelected = RidePreference(departure: Location(name: 'Siem Reap', country: Country.cambodia), departureDate: DateTime.now(), arrival: Location(name: 'Battambang', country: Country.cambodia), requestedSeats: 1);
  final List<RidePreferencesListener> _listener= [];
  
  void addListener(RidePreferencesListener listener){
    _listener.add(listener);
  }
  void setRidePreference(RidePreference newRidePreferenceSelected){
    _ridePreferenceSelected = newRidePreferenceSelected;
    _notifyListener();
  }
  void _notifyListener(){
    for(var listener in _listener){
      listener.onPreferenceSelected(_ridePreferenceSelected);
    }
  }
}
class ConsoleLogger implements RidePreferencesListener{
  @override
  void onPreferenceSelected(RidePreference selectedPreference) {
     var string = selectedPreference.toString();
    print('new ride preference set to: $string');
  }
}
void main(){
  RidePreferencesService ridePreferencesService = RidePreferencesService();
  ConsoleLogger consoleLogger = ConsoleLogger();
  ConsoleLogger consoleLogger1 = ConsoleLogger();
  // Register observers
  ridePreferencesService.addListener(consoleLogger);
  ridePreferencesService.addListener(consoleLogger1);
  print('set a ride preference');
  ridePreferencesService.setRidePreference(RidePreference(departure: Location(name: 'Siem Reap', country: Country.cambodia), departureDate: DateTime.now(), arrival: Location(name: 'Battambang', country: Country.cambodia), requestedSeats: 1));
  print('set new ride Preference');
  ridePreferencesService.setRidePreference(RidePreference(departure: Location(name: 'Battambang', country: Country.cambodia), departureDate: DateTime.now(), arrival: Location(name: 'Siem Reap', country: Country.cambodia), requestedSeats: 3));

}