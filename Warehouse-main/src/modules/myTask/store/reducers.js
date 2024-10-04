import { GET_TASK_BY_LOGIN, GET_TASK_STATUS } from "./constants";

export const myTaskReducer = (state = {}, action) => {
    switch (action.type) {
        case GET_TASK_BY_LOGIN:
            return {...action.payload}
        default:
            return state
    }
}

export const taskStatusReducer = (state = [], action) => {
    switch (action.type) {
        case GET_TASK_STATUS:
            return [...state, ...action.payload]
        default:
            return state
    }
}