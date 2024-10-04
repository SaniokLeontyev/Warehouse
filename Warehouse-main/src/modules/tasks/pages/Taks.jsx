import { useSelector } from "react-redux";
import "../task.css";
import axiosReq from "../../../utils/axios";
import { useEffect, useState } from "react";
import {
  getTask,
  getTaskEnd,
  fetchNomenclature,
  saveTask,
  movingItemAttr,
  closeTask
} from "../store/actions";
import { useDispatch } from "react-redux";
import { useRef } from "react";
import { fetchAllUsers, fetchRoles } from "../../users/store/actions";
import { getWarehouse } from "../../constructor/store/actions";
import { loaderStatus, fetchSingleWarehouse } from "../../../store/actions";
import AcceptedWarehouse from "../components/AcceptedWarehouse";
import { updateTaskStatus } from "../../myTask/store/actions";
import MoreTaskDetails from "../components/TaskMoreDetails";
import { taskStatusRus, allRoles, taskTypeRus } from "../labelList";
import { toast } from "react-toastify";





function Task() {
  const dispatch = useDispatch();
  // selectors
  let userList = useSelector((state) => state.users);
  let roleList = useSelector((state) => state.roles);
  let warehouses = useSelector((state) => state.warehouse);
  let tasks = useSelector((state) => state.tasks);
  let uuid = useSelector((state) => state.all_uuid);
  let singleWarehouse = useSelector((state) => state.singleWarehouse);
  let selectedShelves = useSelector((state) => state.selectedShelves);
  //states
  let [mapState, setMapState] = useState(false)
  let [modalState, setModalState] = useState(false);
  let [modalTitle, setModalTitle] = useState(null);
  let [resultUUID, setResultUUID] = useState([]);
  let [totalSearchResutl, setTotalSearchResutl] = useState([]);
  let [items, setItem] = useState([]);
  let [taskTypes, setTaskTypes] = useState(null);
  let [selectedUser, setSelectedUser] = useState("");
  let [selectedWarehouse, setSelectedWarehouse] = useState('');
  let [selectedTaskType, setSelectedTaskType] = useState(null);
  let [selectedRackId, setSelectedRackId] = useState("");
  const [currentPage, setCurrentPage] = useState(0);
  const [rack, setRack] = useState(null);
  const [maxPages, setMaxPages] = useState(1);
  const [cellsModal, setCellsModal] = useState(false);
  const [base64Data, setBase64Data] = useState([]);
  let fileInput = useRef()
  const [fileNames, setFileNames] = useState([]);
  const [dateQuery, setDateQuery] = useState('ASC')
  const [taskTableType, setTaskTableType] = useState('1');

  //open cell modals
  const showCellsModal = (type) => {
    let t = type;
    setCellsModal(t);
  };

  let itemQuantity = useRef();
  let startDate = useRef();
  let endDate = useRef();
  useEffect(() => {
    if (taskTableType === '1') {
      const allRequset = () => {
        dispatch(loaderStatus(true));
        dispatch(getTask(currentPage, `&sortType=${dateQuery}`))
          .then(() => dispatch(fetchAllUsers()))
          .then(() => dispatch(fetchRoles()))
          .then(() => dispatch(getWarehouse()));
        
        if (!localStorage.getItem('db')) {
          dispatch(fetchNomenclature())
        }
      };
      allRequset();
    } else {
      const allRequset = () => {
        dispatch(loaderStatus(true));
        dispatch(getTaskEnd(currentPage, `&sortType=${dateQuery}`))
          .then(() => dispatch(fetchAllUsers()))
          .then(() => dispatch(fetchRoles()))
          .then(() => dispatch(getWarehouse()));
        
        if (!localStorage.getItem('db')) {
          dispatch(fetchNomenclature())
        }
      };
  
      allRequset();
    }
  }, [dispatch, dateQuery, taskTableType]);

  //open set taskmodal
  const showModal = (title, taskType) => {
    setModalState(true);
    setModalTitle(title);
    setTaskTypes(taskType);
  };


  //get rack id after click
  const getRackId = (val) => {
    setSelectedRackId(val);
  };

  const action_type = (type) => {
    if (type === "acceptance") {
      return "приемка";
    }
    if (type === "shipment") {
      return "отгрузка";
    }
    if (type === "movement") {
      return "перемещение";
    }
    if (type === "receipt_from_warehouse") {
      return "получение со склада";
    }
    if (type === "write_off") {
      return "списание";
    }
    if (type === "exchange") {
      return "обмен";
    }
    if (type === "return") {
      return "возврат";
    }
    if (type === "inventory") {
      return "инвентаризация";
    }
  };


  // search products
  const [searchhInputValue, setSearchInputValue] = useState('')
  const searchUUID = (e) => {
    const searchValue = e.target.value;
    if (!searchValue) {
      setTotalSearchResutl([]);
      return;
    }

    const foundItems = uuid.filter(item => {
      return item.uuid.includes(searchValue) || item.name.includes(searchValue);
    });
    if (foundItems.length === 1) {
      setResultUUID(foundItems)
      setSearchInputValue(foundItems.uuid)
    } else {
      setResultUUID([])
    }
    setTotalSearchResutl(foundItems);
  };


  //update task status
  const updateStatus = (id, status) => {
    dispatch(updateTaskStatus(id, status));
    dispatch(closeTask(id))
    window.location.reload();
  };


  const classType = (statusId) => {
    if (statusId === "acceptance") {
      return "s-1";
    }
    if (statusId === "shipment") {
      return "s-2";
    }
    if (statusId === "movement") {
      return "s-3";
    }
    if (statusId === "receipt_from_warehouse") {
      return "s-4";
    }
    if (statusId === "write_off") {
      return "s-5";
    }
    if (statusId === "exchange") {
      return "s-6";
    }
    if (statusId === "return") {
      return "s-7";
    }
    if (statusId === "inventory") {
      return "s-8";
    }
    return null;
  };

  const classStatus = (statusId) => {
    if (statusId === 9) {
      return "b-1";
    }
    if (statusId === 10) {
      return "b-2";
    }
    if (statusId === 11) {
      return "b-3";
    }
    if (statusId === 12) {
      return "b-4";
    }
    if (statusId === 13) {
      return "b-5";
    }

    return null;
  };

  const [lelevOpt, setLevelOpt] = useState([]);
  useEffect(() => {
    if (selectedShelves) {
      const options = [];
      for (let i = 1; i <= selectedShelves.shelf_level; i++) {
        options.push(i);
      }

      setLevelOpt(options);
    }
  }, [selectedShelves]);

  const [cellOpt, setCellOpt] = useState([]);
  useEffect(() => {
    if (selectedShelves) {
      const cellNumbersPerLevel = [];

      for (let level = 1; level <= selectedShelves.shelf_level; level++) {
        const numCells =
          selectedShelves.cells_per_width * selectedShelves.cells_per_depth;
        const cellNumbers = Array.from(
          { length: numCells },
          (_, index) => index+=1
        );
        cellNumbersPerLevel.push(cellNumbers);
      }

      setCellOpt(cellNumbersPerLevel);
    }
    console.log(cellOpt);
  }, [selectedShelves]);

  let [levelId, setLevelId] = useState(1);
  const selectShelfLevel = (e) => {
    setLevelId((level) => (level = e.target.value));
  };

  let [cellNum, setCellNum] = useState(0);
  const selectedCellNumber = (e) => {
    setCellNum((cell) => (cell = e.target.value));
  };

  let [userQuery, setUserQuery] = useState("");
  let [taskTypeQuery, setTaskTypeQuery] = useState("");

  useEffect(() => {
    if (taskTableType === '1') {
      const sendRequest = () => {
        const queryParams = [];
        if (userQuery) {
          queryParams.push(`login=${userQuery}`);
        }
        if (taskTypeQuery) {
          queryParams.push(`taskType=${taskTypeQuery}`);
        }
        const queryString =
          queryParams.length > 0 ? `&${queryParams.join("&")}` : "";
        dispatch(getTask(currentPage, queryString));
      };

      sendRequest();
    } else {
      const sendRequest = () => {
        const queryParams = [];
        if (userQuery) {
          queryParams.push(`login=${userQuery}`);
        }
        if (taskTypeQuery) {
          queryParams.push(`taskType=${taskTypeQuery}`);
        }
        const queryString =
          queryParams.length > 0 ? `&${queryParams.join("&")}` : "";
        dispatch(getTaskEnd(currentPage, queryString));
      };

      sendRequest();
    }
  }, [userQuery, taskTypeQuery, currentPage]);

  const handlePageChange = (type) => {
    if (type === 'forward') {
      let newCurrPage = currentPage + 1
      setCurrentPage(newCurrPage)
      dispatch(getTask(newCurrPage, `&sortType=ASC`))
    }
    if (type === 'back') {
        let newCurrPage = currentPage - 1
        setCurrentPage(newCurrPage)
        dispatch(getTask(newCurrPage, `&sortType=ASC`))
    }
  };

  const setFilterUser = (event) => {
    const user = event.target.value;
    setUserQuery(user);
  };

  const setFilterType = (e) => {
    const val = e.target.value;
    setTaskTypeQuery(val);
  };

  const openTaskDetails = async (status_id, warehouse_id) => {
    if (status_id >= 11) {
      setSelectedWarehouse(warehouse_id)
      setMapState(true)
    }
  }

  const showMap = (state) => {
    setMapState(state)
  }
  
  const formatDateTime = (timeDate) => {
    const timestamp = timeDate;
    const date = new Date(timestamp);

    const year = date.getFullYear();
    const month = ("0" + (date.getMonth() + 1)).slice(-2);
    const day = ("0" + date.getDate()).slice(-2);
    const hours = ("0" + date.getHours()).slice(-2);
    const minutes = ("0" + date.getMinutes()).slice(-2);

    return `${year}-${month}-${day} ${hours}:${minutes}`;
  }


  const [userRoleState, setUserRoleState] = useState('')
  const sortUsersByRole = (e) => {
    setUserRoleState(e)
  }
  
  const searchInputArea = useRef(null)
  const [itemAttrInShelf, setItemAttrInShelf] = useState([])
  const getItemAfterClick = (val) => {
    setItemAttrInShelf(val)
    console.log(val);

    if (modalTitle !== 'Приемка' || modalTitle === 'Возврат') {
      if (itemAttrInShelf.length) {
        const foundItems = itemAttrInShelf.filter(item => {
          return item.uuid.includes(searchInputArea.current.value)
        });
        
        setResultUUID(foundItems)
      }
    }
  }
  const [cellCol, setCellCol] = useState(null)

  useEffect(() => {
    if (cellCol) {
      const root = document.documentElement;
      root.style.setProperty('--cells-per-width', cellCol);
    }
  }, [cellCol]);

  let [houseId, setHouseId] = useState('')
  let [modalStateDetail, setModalStateDetail] = useState(false);
  let [taskTypeQuerys, setTaskTypeQuerys] = useState("");
  let [taskData, setTaskData] = useState([]);
  const setFilterTypes = (e) => {
      const val = e.target.value;
      setTaskTypeQuerys(val);
  };
const closeModal = () => {
  setHouseId( prev => prev = '')
  setModalState(false)
}
const [shelvData, setShelvData] = useState(null)
    const getShelvAttr = async (data) => {
        setShelvData(prev => prev = data)
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

  const [itemsPreview, setItemsPreview] = useState([])
  const addItem = async (data) => {
    const attr = {
      shelves: [
        {
          rack_id: selectedRackId,
          item_attributes: [
            {
              cell_number: +cellNum,
              nomenclature: data.name,
              units: data.uuid,
              quantity: +itemQuantity.current.value,
              condition_type: data.uuid,
              uuid: data.uuid,
              start_date: new Date(startDate.current.value).toISOString(),
              end_date: new Date(endDate.current.value).toISOString(),
              shelf_level: +levelId,
            },
          ],
        },
      ],
    };
    

    axiosReq.put(`/api/warehouse/itemAttributes/${selectedWarehouse}`, attr)
      .then( res => {
        const itemsNow = res.data.body.map(obj => ({
          id: obj.id,
          quantity: +obj.quantity
        }));
        setItem(item => [...item, ...itemsNow]);
        setItemsPreview(item => [...item, ...res.data.body]);
        toast('Добавлено в задачу')
      })
      .catch( err => {
        toast('Ошибка добавления в задачу')
        console.log(err);
      })
  };
  const addItem2 = async (data) => {
    if (itemAttrInShelf.length) {
      const foundItems = itemAttrInShelf.filter(item => {
        return item.uuid.includes(searchInputArea.current.value)
      });
      if (foundItems.length) {
        const itemNow = {
          id: foundItems[0].id,
          quantity: +itemQuantity.current.value,
        }
        console.log(itemNow);
        setItem((item) => [...item, itemNow]);
        setItemsPreview((item) => [...item, foundItems[0]]);
      }
    }
  };

  const movingItem = async (data) => {
    const movingData = {
      from_shelf_id: 0,
      id: 0,
      to_shelf_id: 0
    }
  }

  const fakeApi = () => {
    const taskData = {
      comments: "",
      login: selectedUser,
      manager: localStorage.getItem('login'),
      constructorId: +selectedWarehouse,
      files: base64Data,
      nomenclatures: items,
      taskType: taskTypes,
      taskStatusId: 9,
    };

    if (!taskData.login) {
      toast('Не выбран исполнитель')
    } else if (!taskData.constructorId) {
      toast('Не выбран склад')
    } else if (!taskData.nomenclatures.length) {
      toast('Не добавлена номенклатура к задаче')
    } else if (!taskData.files.length) {
      toast('Не загружены файлы')
    } else {
      dispatch(loaderStatus(true));
      dispatch(saveTask(taskData));
      dispatch(getTask(currentPage, `&sortType=DESC`));
      setTimeout( () => {
        window.location.reload()
      }, 2500)
      setModalState(false);
    }
  };
  
  return (
    <div className="task-page">
      { modalStateDetail && <div className="my-task__modal">
                    <div className="my-task__modal-top">
                        <h3>Карта</h3>
                        <button onClick={closeModal}>x</button>
                    </div>
                    <div className="my-task__modal-wrapper">
                        <MoreTaskDetails id={houseId} data={taskData} getAttr={getShelvAttr}/>
                        <div className="my-task__modal-right">
                            <h4>Информаци по номенклатуре</h4>
                            <div className="my-task__modal-list">
                                { !taskData.length ? '' : taskData.map( (item, index) => {
                                    return (
                                        <div className='my-task__modal-list__item' key={index}>
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
                                                <span>Номенклатура :</span> <span>{item.nomenclature}</span>
                                            </div>
                                            <div>
                                                <span>Уровень размещения :</span> <span>{item.shelf_level}</span>
                                            </div>
                                            <div>
                                                <span>Номер ячейки на уровне :</span> <span>{item.cell_number}</span>
                                            </div>
                                            <div>
                                                <span>Количество :</span> <span>{item.quantity}</span>
                                            </div>
                                            <div>
                                                <span>UUID</span> <span>{item.uuid}</span>
                                            </div>
                                            <div>
                                            <div>
                                                <span>Ячейка на уровне :</span> : <span>{item.cell_number}</span>
                                            </div>
                                            { taskTypes === 'inventory' && <div className='agara'>
                                                <span>Факт кол-во :</span> 
                                                <input type="text" /> 
                                                <button onClick={fakseSaveQuantity}>Сохранить</button>
                                            </div>  }
                                            <button className="managment-show__cell my-task-show-cell" onClick={() => showCellsModal(true, item)}>Показать ячейку</button>
                                            </div>
                                        </div>
                                    )
                                })}
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
      <div className={modalState ? "task-layer" : "task-none"}></div>
      <div className={modalState ? "task-modal" : "task-none"}>
        <div className="task-modal__top">
          <h3>{modalTitle}</h3>
          <button onClick={() => setModalState(false)}>X</button>
        </div>
        <div className="task-modal__body">
          <select onChange={e => sortUsersByRole(e.target.value)}>
            <option value="">Выберите должность</option>
            {!allRoles.length
              ? ""
              : allRoles.map((item, index) => {
                  return (
                    <option key={index} value={item.rus}>
                      {item.rus}
                    </option>
                  );
                })}
          </select>
          <select onChange={(e) => setSelectedUser(e.target.value)}
          >
            <option value="">Выберите сотрудника</option>
            {!userList.length
              ? ""
              : userList.filter(item => item.jobTitle === userRoleState).map((item, index) => {
                  return (
                    <option key={index} value={item.login}>
                      {item.fio}
                    </option>
                  );
                })}
          </select>
          <select
            name=""
            id=""
            onChange={(e) => {
              setSelectedWarehouse(e.target.value);
              dispatch(fetchSingleWarehouse(e.target.value));
            }}
          >
            <option value="">Выберите склад</option>
            {!warehouses.length
              ? ""
              : warehouses.map((item, index) => {
                  return (
                    <option key={index} value={item.id}>
                      {item.name}
                    </option>
                  );
                })}
          </select>
        </div>
        <div className="task-modal__area">
          {cellsModal && (
            <div className="warehouse-cell__modal">
              <div className="warehouse-cell__modal-top">
                <h4>
                  Уровень {!levelId ? "-" : levelId} Ячейка{" "}
                  {!cellNum ? "-" : cellNum}
                </h4>
                <button
                  className="warehouse-cell__modal-close"
                  onClick={() => showCellsModal(false)}
                >
                  x
                </button>
              </div>
              <div className="warehouse-cells" style={{ display: 'grid', gridTemplateColumns: `${cellCol} !important` }}>
                { cellOpt.length && cellOpt[0].map( (item, index) => {
                  return (
                    <div style={cellNum === index + 1 ? { background: 'green', color: '#fff' } : {}}>
                      {item}
                    </div>
                  )
                }) }
              </div>
            </div>
          )}
          <AcceptedWarehouse
            id={selectedWarehouse}
            data={resultUUID}
            rackId={getRackId}
            val={cellsModal}
            getAttr={getItemAfterClick}
          />
          <div className="task-modal__search">
            {/* 029e2f54-27b4-11ee-9058-001dd8b72b51 */}
            <input
              type="text"
              placeholder="Укажите номенклатуру"
              onChange={searchUUID}
              id="for-num"
              name="for-nom"
              list="for-nom"
              ref={searchInputArea}
            />
            <datalist id="for-nom">
              {totalSearchResutl.map((item, index) => (
                <option key={index} value={item.uuid}>
                  {item.name}
                </option>
              ))}
            </datalist>
            <div>
              {/* <h3>Принимаемая номенклатура</h3> */}
              {!resultUUID.length
                ? "Номенклатура не найдена"
                : resultUUID.map((item) => {
                    return (
                      <div className="task-modal__area-form" key={item}>
                        <div className="file-upload-container">
                          <p>Файл</p>
                            <input ref={fileInput} onChange={handleFileChange} className='form-document' type="file" required multiple/>
                            <ul className="file-list">
                                {fileNames.map((fileName, index) => (
                                    <li key={index}>{fileName}</li>
                                ))}
                            </ul>
                        </div>
                        <div className="file-upload-container task-modal__area-data">
                          <div>
                            <span>Артикул:</span> <span>{item.articul}</span>
                          </div>
                          <div>
                            <span>Код</span> <span>{item.cod}</span>
                          </div>
                          <div>
                            <span>Название</span> <span>{item.name}</span>
                          </div>
                          <div>
                            <span>
                              Количество:</span> <input ref={itemQuantity} type="text" name="" id="" />
                          </div>
                          { taskTypes === 'acceptance' && 
                            <>
                              <div>
                                <span>
                                  Дата производства:
                                </span>
                                <input ref={startDate} type="date" name="" id="" />
                              </div>
                              <div>
                                <span>
                                  Дата истечения срока годности:
                                </span>
                                <input ref={endDate} type="date" name="" id="" />
                              </div>
                            </>
                          }
                          <div>
                            <span>
                              Уровень хранения
                            </span>
                            <select name="" id="" onChange={selectShelfLevel}>
                              <option value="val"></option>
                              {lelevOpt && lelevOpt.length
                                ? lelevOpt.map((item, index) => {
                                    return (
                                      <option key={index} value={item}>
                                        {item}
                                      </option>
                                    );
                                  })
                                : ""}
                            </select>
                          </div>
                          <div>
                            <span>
                              Ячейка хранения на уровне:
                            </span>
                            <select name="" id="" onChange={selectedCellNumber}>
                              {cellOpt && cellOpt.length
                                ? cellOpt[levelId - 1].map((item, index) => {
                                    return (
                                      <option value={item} key={index}>
                                        {item}
                                      </option>
                                    );
                                  })
                                : ""}
                            </select>
                          </div>
                          <div>
                            <button
                              className="show-cell_modal"
                              onClick={() => {
                                showCellsModal(true)
                              }}
                            >
                              Показать ячейки
                            </button>
                            {selectedTaskType && (selectedTaskType === "acceptance" || selectedTaskType === "return") ? (
                              <button onClick={() => addItem(item)}>
                                Добавить в задачу
                              </button>
                            ) : (
                              <button onClick={() => addItem2(item)}>
                                Добавить в задачу
                              </button>
                            )}
                          </div>
                        </div>
                      </div>
                    );
                  })}{" "}
              <br />
              <button
                className="saveTaskButton"
                onClick={() => {
                  fakeApi();
                }}
              >
                Создать задачу
              </button>
            </div>
            <div className="">
              <h3>В работе</h3>
              { itemsPreview.length &&
                itemsPreview.map( item => {
                  return (
                    <div className="task-modal__area-form item-list-click" key={item.id}>
                        <span>Название : {item.nomenclature}</span> <br />
                        <span>
                          Количество : {item.quantity}
                        </span>{" "}
                        <span>
                          UUID : {item.uuid}
                        </span>{" "}
                        <br />
                        <span>
                          Уровень хранения: {item.shelf_level}
                        </span>{" "}
                        <br />
                        <span>
                          Ячейка хранения на уровне: {item.cell_number}
                        </span>
                        <br />
                      </div>
                  )
                })
              }
            </div>
            <div className="">
              <h3>На выбранном стелаже</h3>
              { itemAttrInShelf.length &&
                itemAttrInShelf.map( item => {
                  return (
                    <div className="task-modal__area-form item-list-click" key={item.id}>
                        <span>Название : {item.nomenclature}</span> <br />
                        <span>
                          Количество : {item.quantity}
                        </span>{" "}
                        <br />
                        <span>
                          Уровень хранения: {item.shelf_level}
                        </span>{" "}
                        <br />
                        <span>
                          Ячейка хранения на уровне: {item.cell_number}
                          <button
                            className="show-cell_modal"
                            onClick={() => {
                              showCellsModal(true)
                              setCellNum(item.cell_number)
                              setLevelId(item.shelf_level)
                              setCellCol(item.cells_per_width)
                            }
                          }>
                            Показать ячейки
                          </button>
                        </span>
                        <br />
                        {/* {selectedTaskType &&
                        selectedTaskType === "acceptance" ? (
                          <button onClick={() => addItem(item)}>
                            Добавить в задачу
                          </button>
                        ) : (
                          <button onClick={() => addItem2(item)}>
                            Добавить в задачу
                          </button>
                        )} */}
                      </div>
                  )
                })
              }
            </div>
          </div>
        </div>
      </div>
      <div className="task-page__top">
        <h3>Постановка задач</h3>
      </div>
      <div className="task-page__add">
        <h4>Выбор операции</h4>
        <div>
          <button
            onClick={() => {
              showModal("Приемка", "acceptance");
              setSelectedTaskType("acceptance");
            }}
          >
            Приемка
          </button>
          {/* <button onClick={() => showModal('Погрузка', '')}>Погрузка</button> */}
          <button
            onClick={() => {
              showModal("Отгрузка", "shipment");
              setSelectedTaskType("shipment");
            }}
          >
            Отгрузка
          </button>
          <button
            onClick={() => {
              showModal("Получение", "receipt_from_warehouse");
              setSelectedTaskType("receipt_from_warehouse");
            }}
          >
            Получение
          </button>
          <button
            onClick={() => {
              showModal("Перемещение", "movement");
              setSelectedTaskType("movement");
            }}
          >
            Перемещение
          </button>
          {/* <button
            onClick={() => {
              showModal("Обмен", "exchange");
              setSelectedTaskType("exchange");
            }}
          >
            Обмен
          </button> */}
          <button
            onClick={() => {
              showModal("Возврат", "return");
              setSelectedTaskType("return");
            }}
          >
            Возврат
          </button>
          <button
            onClick={() => {
              showModal("Списание", "write_off");
              setSelectedTaskType("write_off");
            }}
          >
            Списание
          </button>
        </div>
      </div>
      <div className="task-table">
        <div className="task-table__top">
          <h2>Список задач</h2> 
          <button onClick={() => setTaskTableType('1')} className={taskTableType === '1' ? 'task-table-type-btn task-table-type-btn-active' : 'task-table-type-btn'}>Активные задачи</button> 
          <button onClick={() => setTaskTableType('2')} className={taskTableType === '2' ? 'task-table-type-btn task-table-type-btn-active' : 'task-table-type-btn'}>Завершенные задачи</button>
          <div className="task-table__top-wrapper">
            <div>
              <h4>Исполнитель</h4>
              <select name="" id="" onChange={setFilterUser}>
                <option value="">Все</option>
                {userList && userList.length > 0
                  ? userList.map((item, index) => {
                      return (
                        <option key={index} value={item.login}>
                          {item.fio}
                        </option>
                      );
                    })
                  : ""}
              </select>
            </div>
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
                <option value="ASC"> От старых к новым</option>
                <option value="DESC">От новых к старым</option>
              </select>
            </div>
          </div>
        </div>
        <div className="task-table__container">
          <table className="task__table">
            <thead>
              <tr>
                <th className="task__table-id">ID</th>
                <th className="task__table-create">Дата создания</th>
                <th className="task__table-doc__number">Номер документа</th>
                <th className="task__table-user">Исполнитель</th>
                <th className="task__table-type">Операция</th>
                <th className="task__table-comment">Комментарии</th>
                <th className="task__table-status">Статус</th>
                <th className="task__table-action">Действия</th>
              </tr>
            </thead>
            <tbody>
            {Object.hasOwn(tasks, 'body')
              ? tasks.body.map((item, index) => {
                  return (
                    <tr key={index}>
                      <td>{item.id}</td>
                      <td>{ item?.createDate ? formatDateTime(item.createDate) : formatDateTime(item.create_date)}</td>
                      <td>{`DOC000${item.id}`}</td>
                      <td>{item?.userDto ? `${item.userDto.name} ${item.userDto.surname}` : `${item.user_name} ${item.user_surname}`}</td>
                      <td>
                        <button className={classType(item.taskType || item.task_type)} onClick={ () => {
                            setHouseId( prev => prev = item.constructorId)
                            setModalStateDetail(modalStateDetail = true)
                            setTaskTypes(item.taskType)
                            setTaskData( prev => prev = item.itemAttributesDTO)
                        }}>
                        {action_type(item.taskType || item.task_type)}    
                        </button>
                      </td>
                      <td>{item.comment}</td>
                      <td>
                        <button className={`${classStatus(item.taskStatusId ? item.taskStatusId : 13)} ${item?.comment == '"Не влезла"' || item?.comments == '"Не влезла"' ? 'nevlez': ''}`}>
                          {
                            item.comment !== '"Не влезла"' ? taskStatusRus.find( val => val.id === item.taskStatusId || val.en === item.task_status)?.name : item.comment.replace(/"/g, '')
                          }
                        </button>
                      </td>
                      <td>
                        {item.taskStatusId == 11 ? (
                            <button
                              onClick={() => {
                                updateStatus(item.id, 13)
                                setTimeout( () => {
                                  // window.location.reload()
                              }, 1500)
                              }}
                              className="btn-task__item"
                            >
                              Закрыть задачу
                            </button>
                          ) : (
                            <div></div>
                          )}
                      </td>
                    </tr>
                  );
                })
              : "Нет активных задач"}
            </tbody>
          </table>
        </div>
        {/* { mapState ? <MoreTaskDetails id={houseId} data={taskData} getAttr={getShelvAttr}/> : ''} */}
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
  );
}

export default Task;
