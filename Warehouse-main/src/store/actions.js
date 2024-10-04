import { toast } from "react-toastify";
import axiosReq from "../utils/axios";
import { GET_SINGLE_WAREHOUSE, LOADER } from "./constants";

export const loaderStatus = (val) => async (dispatch) => {
    dispatch({
        type: LOADER,
        payload: val
    })
}

export const fetchSingleWarehouse = (id) => async (dispatch) => {
    dispatch(loaderStatus(true))
    axiosReq.get(`/api/warehouse/${id}`)
        .then( res => {
            dispatch({
                type: GET_SINGLE_WAREHOUSE,
                payload: res.data.body
            })
        })
        .catch( err => {
            toast('Не удалось получить склад')
            console.log(err);
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}