import { GET_INVENT_TASK } from "./constants";

export const inventTaskReducer = (state = [], action) => {
    switch (action.type) {
        case GET_INVENT_TASK:
            return {...state, ...action.payload}
        default:
            return state
    }
}