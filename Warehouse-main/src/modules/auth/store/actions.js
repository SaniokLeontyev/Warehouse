import { setCookie } from '../../../utils/cookies'
import { CLEAN_USER, USER_LOGIN, SET_ROLE } from './constants'
import axiosReq from '../../../utils/axios'
import { loaderStatus } from '../../../store/actions'
import { toast } from 'react-toastify'

export const auth = (data) => async (dispatch) => {
    axiosReq.post(`/api/accounts/login`, data)
        .then( res => {
            const startDate = new Date();
            const endDate = new Date(startDate.getTime() + ((5+60*60*1000)*2));
            setCookie('access_token', res.data.body.token, { expires: endDate });
            localStorage.setItem('role', res.data.body.role)
            localStorage.setItem('login', res.data.body.login)
            localStorage.setItem('userdata', JSON.stringify(res.data.body.user))
            dispatch({
                type: USER_LOGIN,
                payload: res.data
            })
            dispatch({
                type: SET_ROLE,
                payload: res.data.body.role
            })
        })
        .catch(err => {
            toast(err.response.data.message)
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}

export const clearUser = () => async (dispatch) => {
    dispatch({
        type: CLEAN_USER,
    })
}