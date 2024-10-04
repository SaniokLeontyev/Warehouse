import { toast } from "react-toastify";
import axiosReq from "../../../utils/axios";
import { GET_TASK_BY_LOGIN, GET_TASK_STATUS } from "./constants";
import { loaderStatus } from "../../../store/actions";

export const fetchTaskByLogin = (page, login, query) => async (dispatch) => {
    dispatch(loaderStatus(true))
    if (localStorage.getItem('role') !== 'ADMINISTRATOR') {
        axiosReq.get(`/api/tasks/sorted/byCreateDate?page=${page}${query}&login=${login}`)
            .then( res => {
                dispatch({
                    type: GET_TASK_BY_LOGIN,
                    payload: res.data
                })
            })
            .catch( () => {
                toast('Не удалось получить список задач')
            })
            .finally( () => {
                dispatch(loaderStatus(false))
            })
    } else {
        axiosReq.get(`/api/tasks/sorted/byCreateDate?page=${page}${query}`)
            .then( res => {
                dispatch({
                    type: GET_TASK_BY_LOGIN,
                    payload: res.data
                })
            })
            .catch( () => {
                toast('Не удалось получить список задач')
            })
            .finally( () => {
                dispatch(loaderStatus(false))
            })
    }
}

export const revertItemAttributeNonAdded = (data) => async () => {
    axiosReq.delete('/api/warehouse/itemAttributes', {data})
}

export const fetchTaskStatus = () => async (dispatch) => {
    axiosReq.get('/api/taskStatus')
        .then( res => {
            dispatch({
                type: GET_TASK_STATUS,
                payload: res.data.body
            })
        })
        .catch(err => {
            toast('Не удалось получить список статусов')
        })
}

export const updateCommentByTask = (id, data) => (dispatch) => {
    dispatch(loaderStatus(true))
    axiosReq.patch(`/api/tasks/comment/${id}`, data)
        .then( () => {
            toast('Комментарий к задаче обновлен')
        })
        .catch( () => {
            toast('Не удалось обновить коммнетарий')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}

export const updateTaskStatus = (id, status) => async (dispatch) => {
    dispatch(loaderStatus(true))
    axiosReq.patch(`/api/tasks/taskStatus/${id}/${status}`)
        .then( res => {
            console.log(res);
            toast('Изменен статус задачи')
        })
        .catch(() => {
            toast('Не удалсоь измеить статус задачи')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}

export const patchItemAttributeQuantity = (data) => async (dispatch) => {
    dispatch(loaderStatus(true))
    axiosReq.patch('/api/warehouse/itemAttributes', data)
        .then(res => {
            toast('Сохранено')
        })
        .catch( err => {
            toast('Ошбика сохранения')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}

export const exel = (data) => async (dispatch) => {
    dispatch(loaderStatus(true))
    axiosReq.post('/api/tasks/excel', data, {
        responseType: 'blob'
    })
        .then(res => {
            const blob = new Blob([res.data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'report.xlsx';
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(url);
        })
        .catch(err => {
            toast('Ошбика сохранения')
        })
        .finally(() => {
            dispatch(loaderStatus(false))
        })
}