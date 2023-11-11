String findIcon(String name, bool type) {
  if (type) {
    switch (name) {
      case "Clouds":
        return "assets/images/sunny.png";
      case "Rain":
        return "assets/images/rainy.png";

      case "Drizzle":
        return "assets/images/rainy.png";

      case "Thunderstorm":
        return "assets/images/thunder.png";

      case "Snow":
        return "assets/images/snow.png";

      default:
        return "assets/images/sunny.png";
    }
  } else {
    switch (name) {
      case "Clouds":
        return "assets/images/sunny_2d.png";

      case "Rain":
        return "assets/images/rainy_2d.png";

      case "Drizzle":
        return "assets/images/rainy_2d.png";

      case "Thunderstorm":
        return "assets/images/thunder_2d.png";

      case "Snow":
        return "assets/images/snow_2d.png";

      default:
        return "assets/images/sunny_2d.png";
    }
  }
}
