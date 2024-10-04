import { GET_SINGLE_WAREHOUSE, LOADER } from "./constants";

export const loaderReducers = (state = '', action) => {
    switch (action.type) {
        case LOADER:
            return action.payload
        default:
            return state
    }
}

export const singleWarehouseRedusers = (state = {}, action) => {
    switch (action.type) {
        case GET_SINGLE_WAREHOUSE:
            return {...state, ...action.payload}
        default:
            return state
    }
}