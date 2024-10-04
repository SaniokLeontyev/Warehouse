import { GET_DOCS } from "./constants";
import axiosReq from '../../../utils/axios';
import { toast } from "react-toastify";
import { loaderStatus } from "../../../store/actions";

export const getDocs = (type, dateFrom, dateTo) => async (dispatch) => {
    axiosReq.get(`/api/1c/documents/${type}/${dateFrom}/${dateTo}`)
        .then( res => {
            dispatch({
                type: GET_DOCS,
                payload: res.data
            })
        })
        .catch(err => {
            toast('Не удалось получить список документов')
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}