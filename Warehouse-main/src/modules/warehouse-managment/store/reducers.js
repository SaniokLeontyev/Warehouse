import { GET_WAREHOUSE_MANAGER_LIST } from "./constants";

export const warehouseManagerReducers = (state = [], action) => {
    switch (action.payload) {
        case GET_WAREHOUSE_MANAGER_LIST:
            return [...action.payload]
        default:
            return state
    }
}