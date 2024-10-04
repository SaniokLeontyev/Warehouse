import {
    GET_TASK, ALL_UUID, GET_SELECTED_SHELVES
} from './constants'

export const taskReducer = ( state = {}, action) => {
    switch (action.type) {
        case GET_TASK:
            return {...action.payload}
        default: 
            return state
    }
}

export const nomenclaturesUUID = ( state = [], action ) => {
    switch (action.type) {
        case ALL_UUID:
            return [...action.payload]
        default:
            return state
    }
}

export const selectedShelvesReducers = ( state = {}, action ) => {
    switch (action.type) {
        case GET_SELECTED_SHELVES:
            return {...action.payload}
        default:
            return state
    }
}