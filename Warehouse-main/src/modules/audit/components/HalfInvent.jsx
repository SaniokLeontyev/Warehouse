import { useEffect, useState } from 'react';
import WarehouseComponent from '../../../components/Warehouse-components';
import { fetchAllUsers } from '../../users/store/actions'
import { useDispatch, useSelector } from 'react-redux';
import { getWarehouse } from '../../constructor/store/actions';
import { fetchNomenclature, saveTask } from '../../tasks/store/actions';
import { fetchSingleWarehouse } from '../../../store/actions';

function HalfInvent(props) {
    const { state } = props
    const closeModal = () => {
        state(false)
    }
    const dispatch = useDispatch()
    const userList = useSelector(state => state.users)
    let warehouses = useSelector(state => state.warehouse)
    let singleWarehouse = useSelector(state => state.singleWarehouse)
    let nomenclature = useSelector(state => state.all_uuid)
    let [findedUUID, setFindedUUID] = useState([])
    let [inventArray, setInventArray] = useState([])

    useEffect( () => {
        dispatch(getWarehouse())
        dispatch(fetchAllUsers())
        dispatch(fetchNomenclature())
    }, [])

    const searchUUID = (e) => {
        setFindedUUID(nomenclature.filter(item => item.uuid === e.target.value))
    }

    const addInventoryList = (item) => {
        const newData = [...inventArray, item.uuid]
        setInventArray(newData)
        console.log(inventArray);
    }

    const addTask = () => {
        const data = {
            active: true,
            comments: "-",
            constructorId: singleWarehouse.id,
            login: "test",
            nomenclatureUUID: inventArray,
            taskType: "inventory",
            taskStatusId: 1
          }
        dispatch(saveTask(data))
        setTimeout( () => {
            window.location.reload()
        }, 1500)
    }

    let [selectedWarehouse, setSelectedWarehouse] = useState()

    return (
        <div className="invent-modal">
            <div className="invent-modal-top">
                <h3>Номенклатурная инвентаризация</h3>
                <div onClick={closeModal}>x</div>
            </div>
            <div className="invent-modal_task">
                {/* <div>
                    <p>Указать ответственного за зону</p>
                    <select name="" id="">
                        { userList.map( (item,index) => {
                            return (
                                <option key={index} value={item.id}>{item.fio}</option>
                            )
                        })}
                    </select>
                </div> */}
                <div>
                    <select name="" id="">
                        <option value="">Выбор исполнителя</option>
                        { userList.map( (item,index) => {
                            return (
                                <option key={index} value={item.id}>{item.fio}</option>
                            )
                        })}
                    </select>
                </div>
                <select name="" id="" onChange={(e) => {
                            setSelectedWarehouse(e.target.value)
                            dispatch(fetchSingleWarehouse(e.target.value))
                        }}>
                        <option value="" >Выберите склад</option>
                        { !warehouses.length ? '' : warehouses.map( (item, index) => {
                            return (
                                <option key={index} value={item.id}>{item.name}</option>
                            )
                        })}
                    </select>
                <button className='invent-add-task__btn' onClick={addTask}>Создать задачу</button>
            </div>
            <div className="invent-modal_warehouse">
                <WarehouseComponent id={selectedWarehouse}/>
                <div className="right">
                    <input type="text" placeholder='Укажите номенклатуру' onInput={ (e) => searchUUID(e)}/>
                    <div className="inventory-find">
                        { !findedUUID.length ? 'Не найдено' : findedUUID.map( (item, index) => {
                            return (
                                <div className='inventory-find__res' key={index}>
                                    <div><span>Баркод:</span> <span>{item.barcode}</span> </div>
                                    <div><span>Код:</span> <span>{item.cod}</span> </div>
                                    <div><span>Название:</span> <span>{item.name}</span> </div>
                                    <div><span>Артикул:</span> <span>{item.articul}</span></div>
                                    <div><button onClick={() => addInventoryList(item)}>Добавить в инвентаризацию</button></div>
                                </div>
                            )
                        })}
                    </div>
                    <div className="inventory-list">
                        <div>
                            { !inventArray.length ? '' : inventArray.map( (item, index) => {
                                return (
                                    <div className='inventory-find__res' key={index}>
                                        <h4>Номенклатура {item}</h4>
                                    </div>
                                )
                            })}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default HalfInvent