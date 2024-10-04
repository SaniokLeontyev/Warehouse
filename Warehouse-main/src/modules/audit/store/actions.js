import { GET_INVENT_TASK } from "./constants";
import axiosReq from "../../../utils/axios";
import { toast } from "react-toastify";
import { loaderStatus } from "../../../store/actions";

export const fetchInventTask = (taskType) => async (dispatch) => {
    axiosReq.get(`/api/tasks/byTaskType/${taskType}`)
        .then( res => {
            dispatch({
                type: GET_INVENT_TASK,
                payload: res.data
            })
        })
        .catch( err => {
            toast('Не удалось получить список задач на инвентаризацию')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}

export const addFullIventTask = (data) => async () => {
    axiosReq.put(`/api/tasks/withShelf`, data)
        .then( () => {
            toast('Задача создана')
        })
        .catch( () => {
            toast('Ошибка создания задачи')
        })
}