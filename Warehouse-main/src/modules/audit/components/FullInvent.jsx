import { useEffect, useState, useRef } from 'react';
import WarehouseComponent from '../../../components/Warehouse-components';
import AudittWarehouse from './AuditWarehouse';
import ManagmentWarehouse from '../../warehouse-managment/components/Managment-warehouse';
import { fetchAllUsers } from '../../users/store/actions'
import { useDispatch, useSelector } from 'react-redux';
import { getWarehouse } from '../../constructor/store/actions';
import { fetchSingleWarehouse } from '../../../store/actions';
import { addFullIventTask } from '../store/actions';
import { toast } from "react-toastify";

function FullInvent(props, id) {
    const { state } = props
    const closeModal = () => {
        state(false)
    }
    let [selectedUser, setSelectedUser] = useState("");
    const [base64Data, setBase64Data] = useState([]);
    let fileInput = useRef()
    const [fileNames, setFileNames] = useState([]);



    let warehouses = useSelector(state => state.warehouse)
    const dispatch = useDispatch()
    const userList = useSelector(state => state.users)
    const warehouseList = useSelector(state => state.warehouse)
    let [selectedWarehouse, setSelectedWarehouse] = useState()

    useEffect( () => {
        dispatch(getWarehouse())
        dispatch(fetchAllUsers())
    }, [])


    let [pickedRack, setPickedRack] = useState([])

    const picked = (val) => {
        setPickedRack(val)
    }

    const handleFileChange = async (event) => {
        const files = Array.from(event.target.files);

        try {
            const base64Strings = await Promise.all(files.map(file => convertToBase64(file)));
            setBase64Data(base64Strings);
            setFileNames(files.map(file => file.name));
        } catch (error) {
            console.error('Ошибка:', error);
        }
    };

    const convertToBase64 = (file) => {
        return new Promise((resolve, reject) => {
            const reader = new FileReader();
            reader.onload = () => resolve(reader.result.split(',')[1]);
            reader.onerror = (error) => reject(error);
            reader.readAsDataURL(file);
        });
    };

    const addTask = () => {
        const shlefFilter = pickedRack.filter( item => item !== null).map(item => item.id)
        let data = {
            comments: "-",
            login: selectedUser,
            manager: localStorage.getItem('login'),
            constructorId: +selectedWarehouse,
            files: base64Data,
            shelves: shlefFilter,
            taskType: "inventory",
            task_status_id: 9
        }
        if (!data.login) {
            toast('Не выбран исполнитель')
        } else if (!data.constructorId) {
            toast('Не выбран склад')
        } else if (!data.shelves.length) {
            toast('Не выбран(ы) стелаж(и)')
        } else if (!data.files.length) {
            toast('Не загружены файлы')
        } else {
            dispatch(addFullIventTask(data))
            setTimeout( () => {
                window.location.reload()
            }, 1500)
        }
    }

    return (
        <div className="invent-modal">
            <div className="invent-modal-top">
                <h3>Полная инвентаризация</h3>
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
                    <select onChange={(e) => setSelectedUser(e.target.value)}>
                        <option value="">Выберите исполнителя</option>
                        {!userList.length
                        ? ""
                        : userList.map((item, index) => {
                            return (
                                <option key={index} value={item.login}>
                                {item.fio}
                                </option>
                            );
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
                <WarehouseComponent id={selectedWarehouse} pick={picked} pickedRack={pickedRack}/>
                <div className="right">
                    <div className="file-upload-container">
                        <p>Файл</p>
                        <input ref={fileInput} onChange={handleFileChange} className='form-document' type="file" required multiple/>
                        <ul className="file-list">
                            {fileNames.map((fileName, index) => (
                                <li key={index}>{fileName}</li>
                            ))}
                        </ul>
                    </div>
                    <div>
                        <span>Стеллажи:</span> <span>
                            {
                                pickedRack && pickedRack.length > 0 ? pickedRack.map( (item, index) => {
                                    if (item !== null) {
                                        return <h3 key={index}>Стеллаж -{item?.rack_id}</h3>
                                    }
                                }) : ''
                            }
                        </span>
                    </div>
                    <div></div>
                    <div></div>
                </div>
            </div>
        </div>
    )
}

export default FullInvent