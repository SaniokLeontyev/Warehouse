import { useState, useEffect } from "react";
import "../audit.css";
import FullInvent from "../components/FullInvent";
import HalfInvent from "../components/HalfInvent";
import { useDispatch, useSelector } from "react-redux";
import { loaderStatus } from "../../../store/actions";
import { fetchSingleWarehouse } from "../../../store/actions";
import { getWarehouse } from "../../constructor/store/actions";
import { getTask } from "../../tasks/store/actions";
import { taskStatusRus, allRoles, taskTypeRus } from "../../tasks/labelList";
import { fetchAllUsers } from "../../users/store/actions";

function Invent() {

  const [currentPage, setCurrentPage] = useState(0);
  let tasks = useSelector((state) => state.tasks);
  let userList = useSelector((state) => state.users);
  let [userQuery, setUserQuery] = useState("");




  let [modalState, setModalState] = useState(false);
  let [modalType, setModalType] = useState(null);
  const dispatch = useDispatch();

  const openModal = (type) => {
    setModalType(type);
    setModalState(true);
  };
  const childModal = (newState) => {
    setModalState(newState);
  };

  useEffect(() => {
    dispatch(fetchAllUsers())
    dispatch(loaderStatus(true));
    dispatch(getTask(0, "&taskType=inventory"));
    dispatch(getWarehouse());
  }, []);

  useEffect(() => {
    const sendRequest = () => {
      const queryParams = [];
      if (userQuery) {
        queryParams.push(`login=${userQuery}&taskType=inventory`);
      }
      const queryString =
        queryParams.length > 0 ? `&${queryParams.join("&")}` : "";
      dispatch(getTask(currentPage, queryString));
    };

    sendRequest();
  }, [userQuery, currentPage]);

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

  const updateStatus = (id, status) => {
    dispatch(updateTaskStatus(id, status));
    dispatch(closeTask(id))
    window.location.reload();
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

  const classType = (statusId) => {
    if (statusId === 'acceptance') {
        return 's-1'
    }
    if (statusId === 'shipment') {
        return 's-2'
    }
    if (statusId === 'movement') {
        return 's-3'
    }
    if (statusId === 'receipt_from_warehouse') {
        return 's-4'
    }
    if (statusId === 'write_off') {
        return 's-5'
    }
    if (statusId === 'exchange') {
        return 's-6'
    }
    if (statusId === 'return') {
        return 's-7'
    }
    if (statusId === 'inventory') {
        return 's-8'
    }
    return null
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

  const setFilterUser = (event) => {
    const user = event.target.value;
    setUserQuery(user);
  };

  return (
    <div className="invent-page">
      <div className="invent-page__top">
        <h3>Инвентаризация</h3>
      </div>
      <div className="invent-task">
        {/* <button onClick={ () => openModal('half')}>
                    Добавить задачу - Номенклатурная инвентаризация
                </button> */}
        <button onClick={() => openModal("full")}>
          Добавить задачу - Полная инвентаризация
        </button>
      </div>
      {modalType === "full" && modalState === true ? (
        <FullInvent state={childModal} />
      ) : (
        ""
      )}
      {modalType === "half" && modalState === true ? (
        <HalfInvent state={childModal} />
      ) : (
        ""
      )}
      <div className="task-table">
        <div className="task-table__top">
          <h2>Список задач</h2>
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
              {Object.hasOwn(tasks, "body")
                ? tasks.body.map((item, index) => {
                    return (
                      <tr key={index}>
                        <td>{item.id}</td>
                        <td>{formatDateTime(item.createDate)}4</td>
                        <td>{`DOC000${item.id}`}</td>
                        <td>{`${item.userDto.name} ${item.userDto.surname}`}</td>
                        <td>
                          <button
                            className={classType(item.taskType)}
                          >
                            {action_type(item.taskType)}
                          </button>
                        </td>
                        <td>{item.comment}</td>
                        <td>
                          <button
                            className={`${classStatus(
                              item.taskStatusId
                            )} ${classStatus(item.taskStatusId)} ${
                              item.comment == '"Не влезла"' ? "nevlez" : ""
                            }`}
                          >
                            {item.comment !== '"Не влезла"'
                              ? taskStatusRus.find(
                                  (val) => val.id === item.taskStatusId
                                ).name
                              : item.comment.replace(/"/g, "")}
                          </button>
                        </td>
                        <td>
                          {item.taskStatusId == 11 ? (
                            <button
                              onClick={() => {
                                updateStatus(item.id, 13);
                                setTimeout(() => {
                                  // window.location.reload()
                                }, 1500);
                              }}
                              className="btn-task__item"
                            >
                              Закрыть задчу
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
          {currentPage !== 0 && (
            <button onClick={() => handlePageChange("back")}>Назад</button>
          )}
          <span>
            Страниц {currentPage + 1} из{" "}
            {Object.hasOwn(tasks, "pagination")
              ? tasks.pagination.maxPages
              : "-"}
          </span>
          {currentPage + 1 !==
            (Object.hasOwn(tasks, "pagination")
              ? tasks.pagination.maxPages
              : "") && (
            <button onClick={() => handlePageChange("forward")}>Вперед</button>
          )}
        </div>
      </div>
    </div>
  );
}

export default Invent;
