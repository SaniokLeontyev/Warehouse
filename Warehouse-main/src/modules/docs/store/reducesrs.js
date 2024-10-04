import { GET_DOCS } from "./constants";

export const docsReducer = (state = {}, action) => {
    switch(action.type){
        case GET_DOCS:
            return {...action.payload}
        default:
            return state
    }
}