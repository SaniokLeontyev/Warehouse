import { combineReducers, createStore, applyMiddleware } from "redux";
import thunk from "redux-thunk";
import { composeWithDevTools } from "redux-devtools-extension";
import { authRecuer, roleReducer } from "../modules/auth/store/reducers";
import { rolesReducers, userReducer, userById } from "../modules/users/store/reducers";
import { warehouseReducers } from "../modules/constructor/store/reducers";
import { taskReducer, nomenclaturesUUID, selectedShelvesReducers } from "../modules/tasks/store/reducers";

import { getCookie } from "../utils/cookies";
import { inventTaskReducer } from "../modules/audit/store/reducers";
import { docsReducer } from "../modules/docs/store/reducesrs";
import { singleWarehouseRedusers, loaderReducers } from "./reducers";
import { myTaskReducer, taskStatusReducer } from "../modules/myTask/store/reducers";

const reducer = combineReducers({
    accessToken: authRecuer,
    users: userReducer,
    warehouse: warehouseReducers,
    tasks: taskReducer,
    all_uuid: nomenclaturesUUID,
    role: roleReducer,
    taskByInvent: inventTaskReducer,
    docs: docsReducer,
    roles: rolesReducers,
    loader: loaderReducers,
    singleWarehouse: singleWarehouseRedusers,
    myTask: myTaskReducer,
    taskStatus: taskStatusReducer,
    selectedShelves: selectedShelvesReducers,
    singleUser: userById
})

const authFromStorage = getCookie('access_token') ? getCookie('access_token') : null 
const roleFromStorage = localStorage.getItem('role') ? localStorage.getItem('role') : ''
const allUUIDdefault = localStorage.getItem('db') ? JSON.parse(localStorage.getItem('db')) : []

const initialState = {
    accessToken: authFromStorage,
    users: [],
    warehouse: [],
    tasks: [],
    all_uuid: allUUIDdefault,
    role: roleFromStorage,
    taskByInvent: [],
    docs: [],
    roles: [],
    loader: false,
    singleWarehouse: {},
    myTask: [],
    taskStatus: [],
    selectedShelves: {},
    singleUser: {}
}

const middleware = [thunk]
const store = createStore(reducer, initialState, composeWithDevTools(applyMiddleware(...middleware)))

export default store