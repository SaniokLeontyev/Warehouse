import { GET_WAREHOUSE } from "./constants";

export const warehouseReducers = ( state = [], action) => {
    switch (action.type) {
        case GET_WAREHOUSE:
            return [...action.payload]
        default:
            return state
    }
}