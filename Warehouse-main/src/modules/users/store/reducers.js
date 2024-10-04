import { GET_ALL_ROLE, GET_ALL_USER, GET_USER_BY_ID } from "./constants";

export const userReducer = ( state = [], action) => {
    switch (action.type) {
        case GET_ALL_USER:
            return [...action.payload]
        default:
            return state
    }
}


export const rolesReducers = (state = [], action) => {
    switch (action.type) {
        case GET_ALL_ROLE:
            return [...action.payload]
        default:
            return state
    }
}

export const userById = ( state = {}, action) => {
    switch (action.type) {
        case GET_USER_BY_ID:
            return {...state, ...action.payload}
        default:
            return state
    }
}