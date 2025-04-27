String humidityLabel(int humidity) {
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
