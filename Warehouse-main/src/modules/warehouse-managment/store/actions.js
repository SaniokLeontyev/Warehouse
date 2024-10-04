import { GET_WAREHOUSE_MANAGER_LIST } from "./constants";
import axiosReq from '../../../utils/axios'

export const getAllNomneclature = () => async (dispatch) => {
    axiosReq.get('/api/warehouse')
        .then( res => {
            dispatch({
                type: GET_WAREHOUSE_MANAGER_LIST,
                payload: res.data.body
            })
        })
}