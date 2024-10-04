import { useDispatch, useSelector } from 'react-redux';
import '../my-task.css';
import { useEffect, useState, useRef } from 'react';
import { fetchTaskStatus, updateCommentByTask, updateTaskStatus, patchItemAttributeQuantity, revertItemAttributeNonAdded, exel} from '../store/actions';
import MyTaskWarehouse from '../components/MyTaskWarehouse';
import { toast } from 'react-toastify';
import { getTask } from '../../tasks/store/actions';
import { fetchSingleWarehouse, loaderStatus } from '../../../store/actions';
import { fetchAllUsers } from '../../users/store/actions';

const taskStatusRus = [
    {
        id: 9,
        name: "Активна",
    },
    {
        id: 10,
        name: "В процессе",
    },
    {
        id: 11,
        name: "Ожидает подтверждения",
    },
    {
        id: 12,
        name: "Подтверждена поручителем",
    },
    {
        id: 13,
        name: "Завершена",
    },
]

const taskTypeRus = [
    {
        eng: 'acceptance',
        name: "Приемка"
    },
    {
        eng: 'shipment',
        name: "Отгрузка"
    },
    {
        eng: 'movement',
        name: "Перемещение"
    },
    {
        eng: 'receipt_from_warehouse',
        name: "Получение"
    },
    {
        eng: 'write_off',
        name: "Списание"
    },
    {
        eng: 'exchange',
        name: "Обмен"
    },
    {
        eng: 'return',
        name: "Возврат"
    },
    {
        eng: 'inventory',
        name: "Инвентаризация"
    }
]

function MyTask() {
    const dispatch = useDispatch()
    const [taskType, setTaskType] = useState('')
    const userList = useSelector((state) => state.users);
    const tasks = useSelector((state) => state.tasks);
    const [modalState, setModalState] = useState(false);
    const [taskId, setTaskId] = useState(null)
    const [houseId, setHouseId] = useState('');
    const [taskData, setTaskData] = useState([]);
    const [taskTypeQuery, setTaskTypeQuery] = useState('');
    const [currentPage, setCurrentPage] = useState(0);
    const [userQuery, setUserQuery] = useState('');
    const warehouse = useSelector(state => state.singleWarehouse);
    const [dateQuery, setDateQuery] = useState('ASC')

    const quantityRef = useRef(null);

    const handlePageChange = (type) => {
        if (type === 'forward') {
            let newCurrPage = currentPage + 1;
            setCurrentPage(newCurrPage);
            dispatch(getTask(newCurrPage, `&sortType=ASC`));
        }
        if (type === 'back') {
            let newCurrPage = currentPage - 1;
            setCurrentPage(newCurrPage);
            dispatch(getTask(newCurrPage, `&sortType=ASC`));
        }
    };

    useEffect(() => {
        dispatch(loaderStatus(true));
        dispatch(getTask(currentPage, `&sortType=${dateQuery}`)).then(() => dispatch(fetchRoles()));
    }, [currentPage, dispatch, dateQuery]);

    useEffect(() => {
        const queryParams = [];
        if (userQuery) queryParams.push(`login=${userQuery}`);
        if (taskTypeQuery) queryParams.push(`taskType=${taskTypeQuery}`);
        const queryString = queryParams.length > 0 ? `&${queryParams.join("&")}` : "";
        dispatch(getTask(currentPage, queryString));
    }, [userQuery, taskTypeQuery, currentPage, dispatch]);

    useEffect(() => {
        dispatch(fetchAllUsers());
        dispatch(fetchTaskStatus());
        dispatch(getTask(currentPage, `&sortType=DESC`));
    }, [currentPage, dispatch]);

    useEffect(() => {
        dispatch(fetchSingleWarehouse(houseId));
    }, [houseId, dispatch]);

    const closeModal = () => {
        setHouseId('');
        setModalState(false);
    };

    const updateTaskComment = (id) => {
        dispatch(updateCommentByTask(id, 'Не влезла'));
        dispatch(getTask(currentPage, `&sortType=DESC`));
    };

    const updateStatus = (id, status) => {
        dispatch(updateTaskStatus(id, status));
        dispatch(getTask(currentPage, `&sortType=DESC`));
        setTimeout(() => {
            window.location.reload();
        }, 2000);
    };

    const classType = (statusId) => {
        switch (statusId) {
            case 'acceptance': return 's-1';
            case 'shipment': return 's-2';
            case 'movement': return 's-3';
            case 'receipt_from_warehouse': return 's-4';
            case 'write_off': return 's-5';
            case 'exchange': return 's-6';
            case 'return': return 's-7';
            case 'inventory': return 's-8';
            default: return null;
        }
    };

    const classStatus = (statusId) => {
        switch (statusId) {
            case 9: return 'b-1';
            case 10: return 'b-2';
            case 11: return 'b-3';
            case 12: return 'b-4';
            case 13: return 'b-5';
            default: return null;
        }
    };

    const getShelvAttr = async (data) => {
        setShelvData(data);
    };
    const [filteredRack, setFilteredRack] = useState({});
    const [cellsModal, setCellsModal] = useState(false);
    const [selectedItemAttr, setSelectedItemAttr] = useState(null);

    const showCellsModal = (type, item) => {
        setCellsModal(type);
        setSelectedItemAttr(item);

        const matchedShelv = warehouse.shelves.find(shelve => shelve.id === item.shelf_id);
        setFilteredRack(matchedShelv);
    };

    useEffect(() => {
        if (filteredRack) {
            const root = document.documentElement;
            root.style.setProperty('--cells-per-width', filteredRack?.cells_per_width);
        }
    }, [filteredRack?.cells_per_width]);

    const formatDateTime = (timeDate) => {
        const timestamp = timeDate;
        const date = new Date(timestamp);
        const year = date.getFullYear();
        const month = ("0" + (date.getMonth() + 1)).slice(-2);
        const day = ("0" + date.getDate()).slice(-2);
        const hours = ("0" + date.getHours()).slice(-2);
        const minutes = ("0" + date.getMinutes()).slice(-2);
        return `${year}-${month}-${day} ${hours}:${minutes}`;
    };

    const setFilterType = (e) => {
        const val = e.target.value;
        setTaskTypeQuery(val);
    };

    const setFilterUser = (event) => {
        const user = event.target.value;
        setUserQuery(user);
    };

    function groupItemsByRack(shelves, taskData) {
        const groupedItems = {};
        if (!shelves || !taskData) {
            return groupedItems;
        }
        taskData.forEach(taskItem => {
            shelves.forEach(shelf => {
                const matchingItem = shelf.item_attributes.find(item => item.id === taskItem.id);
                if (matchingItem) {
                    if (!groupedItems[shelf.rack_id]) {
                        groupedItems[shelf.rack_id] = [];
                    }
                    groupedItems[shelf.rack_id].push({ ...matchingItem, quantity: taskItem.quantity });
                }
            });
        });
        return groupedItems;
    }

    const result = groupItemsByRack(warehouse.shelves, taskData);

    const [groupedItems, setGroupedItems] = useState({});

    useEffect(() => {
        const initialGroupedItems = groupItemsByRack(warehouse.shelves, taskData);
        setGroupedItems(initialGroupedItems);
    }, [taskData, warehouse.shelves]);

    const handleQuantityChange = (rackId, itemId, quantity) => {
        setGroupedItems(prevGroupedItems => {
            const updatedItems = { ...prevGroupedItems };
            const shelfItems = updatedItems[rackId]?.map(item =>
                item.id === itemId ? { ...item, quantity: Number(quantity) } : item
            );
            if (shelfItems) {
                updatedItems[rackId] = shelfItems;
            }
            return updatedItems;
        });
    };

    const saveQuantity = () => {
        const data = Object.keys(groupedItems).map(rackId => ({
            rack_id: rackId,
            item_attributes: groupedItems[rackId]
        })).flatMap(rack => 
            rack.item_attributes.map(attr => ({
                measurement: "",
                nomenclature: attr.nomenclature,
                quantity: attr.quantity,
                shelf: rack.rack_id,
                uuid: attr.uuid
            }))
        );
        dispatch(exel(data))
    };

    return (
        <div className="my-task">
            <h3 className="my-task__title">Мои задачи</h3>
            <div className="my-task__filter">
            {localStorage.getItem('role') === 'ADMINISTRATOR' && (
                <div>
                    <h4>Исполнитель</h4>
                    <select name="" id="" onChange={setFilterUser}>
                        <option value="">Все</option>
                        {userList && userList.length > 0
                            ? userList.map((item, index) => (
                                <option key={index} value={item.login}>
                                    {item.fio}
                                </option>
                            ))
                            : ""}
                    </select>
                </div>
            )}
                <div>
                    <h3>Тип задачи</h3>
                    <select onChange={setFilterType}>
                        <option value="">Все</option>
                        {taskTypeRus.map((item, index) => {
                        return (
                            <option key={index} value={item.eng}>
                            {item.name}
                            </option>
                        );
                        })}
                    </select>
                </div>
                <div>
                <h3>Дата</h3>
                <select onChange={e => setDateQuery(e.target.value)}>
                    <option value="ASC">Старые</option>
                    <option value="DESC">Новые</option>
                </select>
                </div>
            </div>
            <div className="my-task__list">
                <div className="my-task__table-container">
                    <table className="my-task__table">
                        <thead>
                            <tr>
                                <th className="my-task__table-id">ID</th>
                                <th className="my-task__table-create">Дата создания</th>
                                <th className="my-task__table-user">Исполнитель</th>
                                <th className="my-task__table-manager">Назначил</th>
                                <th className="my-task__table-type">Тип задачи</th>
                                <th className="my-task__table-status">Статус</th>
                                <th className="my-task__table-comment">Комментарии</th>
                                <th>Действия</th>
                            </tr>
                        </thead>
                        <tbody>
                            { !Object.hasOwn(tasks, 'body') ? 'Нет задач' : tasks.body.map( (item,index) => {
                                return (
                                    <tr key={index}>
                                        <td className="my-task__table-id">{item.id}</td>
                                        <td className="my-task__table-create">{formatDateTime(item.createDate)}</td>
                                        <td>{`${item.userDto.name} ${item.userDto.surname}`}</td>
                                        <td>{item.manager.surname} {item.manager.name}</td>
                                        <td><button className={`my-task__table-btn ${classType(item.taskType)}`} onClick={ () => {
                                        setHouseId( prev => prev = item.constructorId)
                                        setModalState(true)
                                        setTaskType(item.taskType)
                                        setTaskData( prev => prev = item.itemAttributesDTO)
                                        setTaskId(prev => prev = item.id)
                                    }}>
                                        {taskTypeRus.find( val => val.eng === item.taskType).name}    
                                    </button></td>
                                        <td>
                                            <button className={`my-task__table-btn ${classStatus(item.taskStatusId)} ${item.comment == '"Не влезла"' ? 'nevlez': ''}`}>{
                                                item.comment !== '"Не влезла"' ? taskStatusRus.find( val => val.id === item.taskStatusId).name : item.comment.replace(/"/g, '')
                                            }</button>
                                        </td>
                                        <td>{item.comment}</td>
                                        <td className="my-task__table-action">
                                            {item.taskStatusId === 10 && <div className='my-task__item-sec'>
                                                <button className='my-task__orange' onClick={() => {
                                                        updateTaskComment(item.id)
                                                        updateStatus(item.id, 13)
                                                        deleteItemAttribute(item.itemAttributesDTO)
                                                    }
                                                }>
                                                    Не влезла
                                                </button>
                                            </div>}
                                            {item.taskStatusId === 9 && <div className='my-task__item-sec'>
                                                <button className='my-task__green' onClick={() => updateStatus(item.id ,10)}>Начать</button>
                                            </div>}
                                            {(item.taskStatusId === 10 && item.comment !== '"Не влезла"') && <div className='my-task__item-sec'>
                                                <button className='my-task__blue' onClick={() => updateStatus(item.id, 11)}>Заврешить</button>
                                            </div>}
                                        </td>
                                    </tr>
                                )
                            })
                            }
                        </tbody>
                    </table>
                </div>
                { modalState && <div className="my-task__modal">
                    <div className="my-task__modal-top">
                        <h3>Карта</h3>
                        <button onClick={closeModal}>x</button>
                    </div>
                    <div className="my-task__modal-wrapper">
                        <MyTaskWarehouse id={houseId} data={taskData} getAttr={getShelvAttr}/>
                        <div className="my-task__modal-right">
                            <h4>Информаци по номенклатуре</h4>
                            <div className="my-task__modal-list">
                                <div>
                                    {Object.keys(result).map(rackId => (
                                        <div key={rackId}>
                                            <h2>Номенклатура стеллажа {rackId}</h2>
                                                {result[rackId].map(item => (
                                                    <div className='my-task__modal-list__item' key={item.id}>
                                                        <a href={`http://91.201.214.168:8082/api/tasks/excel/${taskId}`}>Выгрузить exel</a>
                                                        <div>
                                                            <span>Номенклатура</span> <span>{item.nomenclature}</span>
                                                        </div>
                                                        <div>
                                                            <span>Уровень размещения</span> <span>{item.shelf_level}</span>
                                                        </div>
                                                        <div>
                                                            <span>Номер ячейки ну уровне</span> <span>{item.cell_number}</span>
                                                        </div>
                                                        { taskType !== "inventory" && <div>
                                                            <span>Количество</span> <span>{item.quantity}</span>
                                                        </div>}
                                                        { taskType !== "inventory" && <div>
                                                            <span>UUID</span> <span>{item.uuid}</span>
                                                        </div> }
                                                        <div>
                                                        <div>
                                                            <span>Ячейка на уровне</span> : <span>{item.cell_number}</span>
                                                        </div>
                                                        { taskType === 'inventory' && <div className='agara'>
                                                            <span>Факт кол-во</span> 
                                                            <input type="text" onChange={(e) => handleQuantityChange(rackId, item.id, e.target.value)}/> 
                                                        </div>  } 
                                                        <button className="managment-show__cell my-task-show-cell" onClick={() => showCellsModal(true, item)}>Показать ячейку</button>
                                                        </div>
                                                    </div>
                                                ))}
                                                <div className='agara' style={{ marginBottom: '20px'}}>
                                                    <button onClick={saveQuantity}>Сохранить</button>
                                                </div>
                                        </div>
                                    ))}
                                </div>
                                { cellsModal && <div className="warehouse-cell__modal">
                                    <div className="warehouse-cell__modal-top">
                                        <h4>Уровень {selectedItemAttr.shelf_level} Ячейка {selectedItemAttr.cell_number }</h4>
                                    <button className="warehouse-cell__modal-close" onClick={() => showCellsModal(false)}>x</button>
                                    </div>
                                    <div className="warehouse-cells">
                                        {Array.from({ length: filteredRack.cells_per_width * filteredRack.cells_per_depth }, (_, index) => {
                                        let hasItem = false
                                        if (selectedItemAttr.cell_number === index + 1) {
                                            hasItem = true
                                        }
                                        
                                        const cellClass = hasItem ? "warehouse-cell-item" : "";

                                        return (
                                            <div key={index + filteredRack.cells_per_width} className={cellClass}>
                                            {index + 1}
                                            </div>
                                        );
                                        })}
                                    </div>
                                </div> }
                            </div>
                        </div>
                    </div>
                </div> }
                <div className="task-pagination">
                    { currentPage !== 0 && <button onClick={() => handlePageChange('back')}>
                        Назад
                    </button>}
                    <span>Страниц {currentPage + 1} из {Object.hasOwn(tasks, 'pagination') ? tasks.pagination.maxPages : '-'}</span>
                    { currentPage + 1 !== (Object.hasOwn(tasks, 'pagination') ? tasks.pagination.maxPages : '') && <button onClick={() => handlePageChange('forward')}>
                        Вперед
                    </button>}
                </div>
            </div>
        </div>
    )
}

export default MyTask