import '../start.css'
import { useEffect, useState } from 'react'

const StartClock = () => {
    const [currentTime, setCurrentTime] = useState(new Date());

    useEffect(() => {
        const interval = setInterval(() => {
        setCurrentTime(new Date());
        }, 1000);

        return () => clearInterval(interval);
    }, []);

    const formatTime = (date) => {
        const daysOfWeek = ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'];
        const day = daysOfWeek[date.getDay()];
        const dayOfMonth = date.getDate();
        const month = date.getMonth() + 1;
        const year = date.getFullYear();
        const hours = date.getHours();
        const minutes = date.getMinutes();
        const seconds = date.getSeconds();

        return `${day} ${dayOfMonth < 10 ? '0' : ''}${dayOfMonth}.${month < 10 ? '0' : ''}${month}.${year} ${hours < 10 ? '0' : ''}${hours}:${minutes < 10 ? '0' : ''}${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
    };

    const userdata = JSON.parse(localStorage.getItem('userdata'))

    return (
        <div className="start-clock">
            <h3 className="start-clock__title">
                {userdata.jobTitle}- 
                <span style={{ color: 'green', textTransform: 'capitalize'}}>
                    {userdata.surname} {userdata.name}
                </span>
            </h3>
            <h3 className='start-clock__title'>
                Время
            </h3>
            <p className='start-clock__time'>{formatTime(currentTime)}</p>
        </div>
    )
}

export default StartClock