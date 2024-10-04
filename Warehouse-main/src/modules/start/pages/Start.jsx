import '../start.css'
import StartClock from '../components/StartClock'
import StartWeather from '../components/StartWeather'


const StartPage = () => {
    return (
        <div className="start-page-container">
            <div className="start-page">
                <h3 className='start-page__title'>
                    Главная
                </h3>
                <div className="start-page__wrapper">
                    <StartWeather></StartWeather>
                    <StartClock></StartClock>
                </div>
            </div>
        </div>
    )
}

export default StartPage