import axiosReq from "../../../utils/axios";
import { GET_ALL_USER, GET_ALL_ROLE, GET_USER_BY_ID } from "./constants";
import { toast } from "react-toastify";
import { loaderStatus } from "../../../store/actions";

export const createUser = (data) => async () => {
    axiosReq.post('/api/users/create', data)
        .then( res => {
            toast('Новый пользователь успешно создан')
            window.history.go(-1)
        })
        .catch( err => {
            toast('Произошла ошибка')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}

export const updatePassword = (data) => async () => {
    axiosReq.patch('/api/accounts/password', data)
}

export const fetchAllUsers = () => async (dispatch) => {
    axiosReq.get('/api/users/getAll')
        .then( res => {
            dispatch({
                type: GET_ALL_USER,
                payload: res.data
            })
        })
        .catch( err => {
            toast('Ошибка запроса на получение пользователей')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}

export const deleteUser = (id) => async (dispatch) => {
    axiosReq.delete(`/api/users/${id}`)
        .then( res => {
            toast('Пользователь удален')
            dispatch(fetchAllUsers())
        })
        .catch( err => {
            toast('Ошибка запроса на удаление пользователей')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}

export const fetchRoles = () => async (dispatch) => {
    axiosReq.get('/api/roles/getAll')
        .then( res => {
            dispatch({
                type: GET_ALL_ROLE,
                payload: res.data
            })
            localStorage.setItem('roles', JSON.stringify(res.data.body))
        })
        .catch( err => {
            toast('Ошибка запроса на получение Ролей')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}

export const updateUser = (data) => async (dispatch) => {
    dispatch(loaderStatus(true))
    axiosReq.patch(`/api/users`, data)
        .then( res => {
            toast('Данные пользователя обновлены')
            window.history.go(-1)
        })
        .catch( err => {
            toast('Ошибка редактирования')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}

export const getSingleUser = (id) => async (dispatch) => {
    dispatch(loaderStatus(true))
    axiosReq.get(`/api/users/${id}`)
        .then( res => {
            dispatch({
                type: GET_USER_BY_ID,
                payload: res.data
            })
        })
        .catch( err => {
            toast('Ошибка данных пользователя')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}