import '../auth.css'
import { Link } from 'react-router-dom'
import { useDispatch, useSelector } from 'react-redux'
import { auth } from '../store/actions'
import { useEffect, useRef } from 'react'
import { loaderStatus } from '../../../store/actions'

function Auth () {
    const dispatch = useDispatch()
    const authState = useSelector(state => state.accessToken)
    const ref = useRef(null)
    const goToMainApp = (e) => {
        e.preventDefault()
        e.stopPropagation()
        
        const data = {
            username: ref.current[0].value,
            password: ref.current[1].value
        }
        dispatch(loaderStatus(true))
        dispatch(auth(data))
    }
    
    useEffect( () => {
        if (authState) {
            window.location.href = '/'
        }
    })

    return (
        <div className="auth-layout">
            <form ref={ref} onSubmit={goToMainApp} action="" className='auth-form'>
                <div>
                    <p>Логин</p>
                    <input name='username' autoComplete="off" type="text" />
                </div>
                <div>
                    <p>Пароль</p>
                    <input name='password' autoComplete="off" type="text" />
                </div>
                <button type='submit'>Войти</button>
            </form>
        </div>
    )
}

export default Auth