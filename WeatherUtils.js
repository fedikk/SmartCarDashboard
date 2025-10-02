function weatherImageFor(desc) {
    switch (desc) {
        case "clear": return "images/meteo/clearbg.jpg"
        case "clouds": return "images/cloudy_sky.jpg"
        case "rain": case "drizzle": return "images/meteo/rainbg.png"
        case "thunderstorm": return "images/thunderstorm.jpg"
        case "snow": return "images/snow.jpg"
        case "mist": case "fog": return "images/fog.jpg"
        default: return "images/default_sky.jpg"
    }
}

function fetchWeather(lat, lon) {
    var xhr = new XMLHttpRequest();
    var url = "https://api.openweathermap.org/data/2.5/forecast?lat=" + lat +
              "&lon=" + lon + "&units=metric&appid=" + apiKey;
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
            var data = JSON.parse(xhr.responseText);
            var tempsMin = data.list.map(e => e.main.temp_min);
            var tempsMax = data.list.map(e => e.main.temp_max);
            var minTemp = Math.round(Math.min(...tempsMin));
            var maxTemp = Math.round(Math.max(...tempsMax));
            var first = data.list[0];
            weatherData = {
                temp: Math.round(first.main.temp),
                tempMin: minTemp,
                tempMax: maxTemp,
                state: first.weather[0].main,
                description: first.weather[0].description,
                humidity: first.main.humidity,
                rainChance: first.pop !== undefined ? Math.round(first.pop * 100) : 0,
                windSpeed: first.wind.speed,
                city: data.city.name
            };
            iconCode = first.weather[0].icon;
        }
    }
    xhr.open("GET", url);
    xhr.send();
}
