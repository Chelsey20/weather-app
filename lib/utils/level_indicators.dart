String labelHeatIndex(double heatIndexCelsius) {
  if (heatIndexCelsius >= 50) {
    return "Extreme Danger";
  } else if (heatIndexCelsius >= 40) {
    return "Danger";
  } else if (heatIndexCelsius >= 33) {
    return "Extreme Caution";
  } else if (heatIndexCelsius >= 27) {
    return "Caution";
  } else {
    return "Normal"; // Optional: for heat index below 27°C
  }
}

String humidityLabel(double humidity) {
  if (humidity <= 30) {
    return 'Very Dry';
  } else if (humidity <= 50) {
    return 'Comfortable';
  } else if (humidity <= 60) {
    return 'Slightly Humid';
  } else if (humidity <= 70) {
    return 'Humid';
  } else if (humidity <= 80) {
    return 'Very Humid';
  } else {
    return 'Oppressive';
  }
}
