import { USER_LOGIN, CLEAN_USER, SET_ROLE } from "./constants";

export const authRecuer = ( state = {}, action) => {
    switch (action.type){
        case USER_LOGIN:
            return {...state, ...action.payload}
        case CLEAN_USER:
            return {}
        default: 
            return state;
    }
}

export const roleReducer = ( state = '', action) => {
    switch (action.type) {
        case SET_ROLE:
            return action.payload
        default:
            return state
        }
}