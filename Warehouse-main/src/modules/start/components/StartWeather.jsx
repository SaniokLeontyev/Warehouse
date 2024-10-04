import '../start.css'
import { useEffect, useState } from 'react';

const StartWeather = () => {
  const [latitude, setLatitude] = useState(null);
  const [longitude, setLongitude] = useState(null);
  const [weatherData, setWeatherData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchWeatherData = async () => {
      try {
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(
            (position) => {
              setLatitude(position.coords.latitude);
              setLongitude(position.coords.longitude);
            },
            (error) => {
              console.error('Ошибка получения геопозиции:', error);
              setLoading(false);
            }
          );
        } else {
          console.error('Геолокация не поддерживается');
          setLoading(false);
        }
      } catch (error) {
        console.error('Ошибка получения геопозиции:', error);
        setLoading(false);
      }
    };

    fetchWeatherData();
  }, []);

  useEffect(() => {
    const fetchWeatherByCoordinates = async () => {
      try {
        if (latitude && longitude) {
          const apiKey = '5d721f968e082c8994f516bfa30bf210'; 

          const response = await fetch(
            `https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${apiKey}`
          );

          if (response.ok) {
            const data = await response.json();
            setWeatherData(data);
            setLoading(false);
          } else {
            console.error('Ошибка получения данных о погоде:', response.status);
            setLoading(false);
          }
        }
      } catch (error) {
        console.error('Ошибка получения данных о погоде:', error);
        setLoading(false);
      }
    };

    fetchWeatherByCoordinates();
  }, [latitude, longitude]);

  return (
    <div className='start-page__weather'>
      {loading ? (
        <p>Загрузка...</p>
      ) : weatherData ? (
        <div>
          <h2>Погода</h2>
          <p>Местоположение: {weatherData.name}</p>
          <p>Температура: {Math.round(weatherData.main.temp - 273.15)}°C</p>
          <p>Влажность: {weatherData.main.humidity}%</p>
          <p>Скорость ветра: {weatherData.wind.speed} м/c</p>
          {weatherData.rain && weatherData.rain['1h'] && (
            <p>Вероятность осадков: {weatherData.rain['1h']} мм</p>
          )}
        </div>
      ) : (
        <p>Не удалось получить данные о погоде</p>
      )}
    </div>
  );
};

export default StartWeather;
