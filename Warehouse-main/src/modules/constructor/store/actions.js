import { loaderStatus } from "../../../store/actions";
import axiosReq from "../../../utils/axios";
import { toast } from "react-toastify";
// import { useNavigate } from "react-router-dom";
import { fetchSingleWarehouse } from "../../../store/actions";
import { GET_WAREHOUSE, UPDATE_WAREHOUSE } from "./constants";

export const getWarehouse = () => async (dispatch) => {
    axiosReq.get('/api/warehouse')
        .then( res => {
            dispatch({
                type: GET_WAREHOUSE,
                payload: res.data.body
            })
        })
        .catch( err => {
            console.log(err);
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}

export const createWarehouse = (data) => async (dispatch) => {
    axiosReq.put('/api/warehouse', data)
        .then( res => {
            toast('Склад создан')
            console.log(res);

            dispatch(addShelvById(res.data.body, data.shelves))
            dispatch(addZonesById(res.data.body, data.zones))
        })
        .catch( err => {
            console.log('error');
        })
        .finally( () => {
            dispatch(loaderStatus(false))
        })
}

export const saveWarehouse = (data) => async () => {
    axiosReq.put('/api/warehouse/constructor', data)
        .then(res => {
            console.log('saveDone');
        })
        .catch(() => {
            toast('Ошибка сохранения')
        })
}

export const addShelvById = (id, data) => async () => {
    axiosReq.put(`/api/warehouse/shelves/${id}`, {shelves: data})
        .then( res => {
            //
        })
        .catch( () => {
            toast('Ошибка создания стеллажей')
        })
}

export const addZonesById = (id, data) => async () => {
    axiosReq.put(`/api/warehouse/zones/${id}`, {zones: data})
        .then( res => {
            //
        })
        .catch( () => {
            toast('Ошибка создания зон')
        })
}

export const addDoorwaysById = (id, data) => async () => {
    axiosReq.put(`/api/warehouse/doorways/${id}`, {doorways: data})
        .then( res => {
            //
        })
        .catch( () => {
            toast('Ошибка создания дверей')
        })
}
export const addWindowsById = (id, data) => async () => {
    axiosReq.put(`/api/warehouse/windows/${id}`, {windows: data})
        .then( res => {
            //
        })
        .catch( () => {
            toast('Ошибка создания дверей')
        })
}
export const addWallsById = (id, data) => async () => {
    axiosReq.put(`/api/warehouse/walls/${id}`, {walls: data})
        .then( res => {
            //
        })
        .catch( () => {
            toast('Ошибка создания стен')
        })
}

export const deleteFigure = (name, data) => async () => {
    console.log(data);
    axiosReq.delete(`/api/warehouse/${name}`, {data: data})
        .then( res => {
            toast('Элемент удален')
        })
        .catch( () => {
            console.log('figure Deleted');
        })
}

export const removeWarehouse = (id) => async () => {
    axiosReq.delete(`/api/warehouse/${id}`)
        .then( res => {
            toast('Склад удален')
            setTimeout( () => {
                window.location.reload()
            }, 3000)
        })
        .catch( () => {
            toast('Ошибка удаления склада')
        })
}


export const updateWalls = (data) => async () => {
    axiosReq.patch(`/api/warehouse/walls`, data)
        .then( res => {
            dispatch(fetchSingleWarehouse(data.id))
        })
        .catch( () => {
            toast('Не удалсь сохранить параметры фигуры')
        })
}
export const updateZone = (data) => async () => {
    axiosReq.patch(`/api/warehouse/zones`, data)
        .then( res => {
            dispatch(fetchSingleWarehouse(data.id))
        })
        .catch( () => {
            toast('Не удалсь сохранить параметры фигуры')
        })
}
export const updateDoor = (data) => async () => {
    axiosReq.patch(`/api/warehouse/doorways`, data)
        .then( res => {
            dispatch(fetchSingleWarehouse(data.id))
        })
        .catch( () => {
            toast('Не удалсь сохранить параметры фигуры')
        })
}
export const updateWindow = (data) => async () => {
    axiosReq.patch(`/api/warehouse/windows`, data)
        .then( res => {
            dispatch(fetchSingleWarehouse(data.id))
        })
        .catch( () => {
            toast('Не удалсь сохранить параметры фигуры')
        })
}
export const updateShelves = (data) => async () => {
    axiosReq.patch(`/api/warehouse/shelves`, data)
        .then( res => {
            dispatch(fetchSingleWarehouse(data.id))
        })
        .catch( () => {
            toast('Не удалсь сохранить параметры фигуры')
        })
}