final greetings = {
  "goodMorning": {
    "Tiongkok": "早上好",
    "Indonesia": "Selamat Pagi",
    "Inggris": "Good Morning",
    "Jepang": "おはようございます",
    "Korea": "좋은 아침이에요",
    "Italia": "Buongiorno",
    "Jerman": "Guten Morgen",
    "Spanyol": "Buenos días",
  },
  "goodAfternoon": {
    "Tiongkok": "下午好",
    "Indonesia": "Selamat Siang",
    "Inggris": "Good Afternoon",
    "Jepang": "こんにちは",
    "Korea": "좋은 오후입니다",
    "Italia": "Buon Pomeriggio",
    "Jerman": "Guten Tag",
    "Spanyol": "Buenas Tardes",
  },
  "goodNight": {
    "Tiongkok": "晚安",
    "Indonesia": "Selamat Malam",
    "Inggris": "Good Night",
    "Jepang": "おやすみなさい",
    "Korea": "안녕히 주무세요",
    "Italia": "Buona Notte",
    "Jerman": "Gute Nacht",
    "Spanyol": "Buenas Noches",
  },
};

enum GreetingTime {
  morning,
  afternoon,
  night,
}

class Greetings {
  static List<String> getListGreetingText(GreetingTime timeOfDay) {
    // Memilih waktu yang sesuai key
    if (timeOfDay == GreetingTime.morning) {
      return greetings["goodMorning"]?.values.toList() ?? [];
    } else if (timeOfDay == GreetingTime.afternoon) {
      return greetings["goodAfternoon"]?.values.toList() ?? [];
    } else if (timeOfDay == GreetingTime.night) {
      return greetings["goodNight"]?.values.toList() ?? [];
    } else {
      return [];
    }
  }

  static GreetingTime getGreetingTypeByHour(int hour) {
    if (hour >= 5 && hour < 12) {
      return GreetingTime.morning; // Pagi
    } else if (hour >= 12 && hour < 18) {
      return GreetingTime.afternoon; // Siang
    } else {
      return GreetingTime.night; // Malam
    }
  }
}
