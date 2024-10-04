import {
    GET_TASK, ALL_UUID
} from './constants'
import { toast } from "react-toastify";
import axiosReq from '../../../utils/axios'
import { loaderStatus } from '../../../store/actions';

export const getTask = (page, query) => async (dispatch) => {
    dispatch(loaderStatus(true))
    if (localStorage.getItem('role') == 'ADMINISTRATOR' || localStorage.getItem('role') == 'WAREHOUSE_MANAGER' || localStorage.getItem('role') == "STOREKEEPER") {
        axiosReq.get(`/api/tasks/sorted/byCreateDate?page=${page}${query}`)
        .then( res => {
            dispatch({
                type: GET_TASK,
                payload: res.data
            })
        })
        .catch( err => {
            toast('Ошибка запроса на получение задач')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
    } else {
        axiosReq.get(`/api/tasks/sorted/byCreateDate?page=${page}&login=${localStorage.getItem('login')}${query}`)
        .then( res => {
            dispatch({
                type: GET_TASK,
                payload: res.data
            })
        })
        .catch( err => {
            toast('Ошибка запроса на получение задач')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
    }
}

export const getTaskEnd = (page, query) => async (dispatch) => {
    dispatch(loaderStatus(true))
    if (localStorage.getItem('role') == 'ADMINISTRATOR' || localStorage.getItem('role') == 'WAREHOUSE_MANAGER' || localStorage.getItem('role') == "STOREKEEPER") {
        axiosReq.get(`/api/tasksHistory?page=${page}${query}`)
        .then( res => {
            dispatch({
                type: GET_TASK,
                payload: res.data
            })
        })
        .catch( err => {
            toast('Ошибка запроса на получение задач')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
    } else {
        axiosReq.get(`/api/tasksHistory?page=${page}&login=${localStorage.getItem('login')}${query}`)
        .then( res => {
            dispatch({
                type: GET_TASK,
                payload: res.data
            })
        })
        .catch( err => {
            toast('Ошибка запроса на получение задач')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
    }
}

export const fetchNomenclature = () => async (dispatch) => {
    axiosReq.get('/api/1c/nomenclatures', {
        headers: { 
            'Cache-control': 'max-age=604800'
        }
    })
        .then( ({data}) => {
            dispatch({
                type: ALL_UUID,
                payload: data.body
            })
            localStorage.setItem('db', JSON.stringify(data.body))
        })
        .catch( err => {
            toast('Ошибка запроса на получение номенклатуры из 1C')
        })
}

export const saveTask = (data) => async (dispatch) => {
    axiosReq.put('/api/tasks', data)
        .then( ({data}) => {
            dispatch({
                type: ALL_UUID,
                payload: data.body
            })
            toast('Задача создана')
        })
        .catch( err => {
            // toast('Не удалось создать задачу, код ошибки 500')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}


export const movingItemAttr = (data) => async () => {
    axiosReq.put(`/api/warehouse/itemAttributes/move`, data)
        .then( res => {
            console.log(res);
        })
        .catch( err => {
            console.log(err);
        })
}

export const closeTask = (id) => async () => {
    axiosReq.patch(`/api/tasks/closeTask/${id}`)
        .then( () => {
            toast('Статус обновлен')
        })
        .catch( () => {
            toast('Ошибка закрытия задачи')
        })
}