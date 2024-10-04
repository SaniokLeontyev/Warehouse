import { Link } from 'react-router-dom'
import '../users.css'
import IconDelete from '../../../assets/img/delete.png'
import { useSelector, useDispatch } from 'react-redux'
import { fetchAllUsers, deleteUser } from '../store/actions'
import { useEffect, useState } from 'react'
import { loaderStatus } from '../../../store/actions'
import { getSingleUser } from '../store/actions'

function UserPage() {
    const dispatch = useDispatch()
    const users = useSelector(state => state.users)
    const [userModalLogin, setUserModalLogin] = useState('')
    const [userModalState, setUserModalState] = useState(false)
    let singleUserData = useSelector(state => state.singleUser)
    
    useEffect( () => {
        dispatch(loaderStatus(true))
        dispatch(fetchAllUsers())
    }, [])

    

    const userDelete = (id) => {
        dispatch(loaderStatus(true))
        dispatch(deleteUser(id))
    }

    const getSingleUserDataById = (id, login) => {
        dispatch(getSingleUser(id))
        setUserModalLogin(login)
    }

    return (
        <div className="users-page">
            <div className="users-page__top">
                <h3>Пользователи</h3>
                <Link to="/add-user">Создать пользователя</Link>
            </div>
            { (userModalState && singleUserData) &&
                <div className="user-page__modal">
                    <div>
                        <span className="user-page__modal-label">Фамилия:</span>
                        <span className="user-page__modal-value">{ singleUserData.surname }</span>
                    </div>
                    <div>
                        <span className="user-page__modal-label">Имя:</span>
                        <span className="user-page__modal-value">{ singleUserData.name }</span>
                    </div>
                    <div>
                        <span className="user-page__modal-label">Отчество:</span>
                        <span className="user-page__modal-value">{ singleUserData.patronymic }</span>
                    </div>
                    <div>
                        <span className="user-page__modal-label">Логин:</span>
                        <span className="user-page__modal-value">{ userModalLogin }</span>
                    </div>
                    <div>
                        <span className="user-page__modal-label">Роль:</span>
                        <span className="user-page__modal-value">{ singleUserData.jobTitle }</span>
                    </div>
                    <div>
                        <span className="user-page__modal-label">Файл:</span>
                        { singleUserData.file_url && 
                            <span className="user-page__modal-value">
                                <a target='_blank' href={ singleUserData.file_url }>Просмотреть</a>
                            </span> 
                        }
                    </div>
                    <button className="user-page__modal-close" onClick={() => {
                        setUserModalState(false)
                    }}>
                        X
                    </button>
                </div> 
            }
            <div className="users-table">
                {
                    users.length ? users.map(item => {
                        return (
                            <div key={item.id} className="users-table__item">
                                <div
                                style={{ cursor: 'pointer' }} 
                                onClick={() => {
                                    setUserModalState(true)
                                    getSingleUserDataById(item.id, item.login)
                                }}>{`${item.surname} ${item.name} ${item.patronymic}`}</div>
                                <div>{item.role}</div>
                                <div>{item.jobTitle}</div>
                                <Link to={`/edit-user/${item.id}`} state={{login: item.login}} className='users-table__item-edit'>&#9998;</Link>
                                <button onClick={ () => userDelete(item.id)} className='users-table__item-delete'><img src={IconDelete} alt="" /></button>
                            </div>
                        )
                    }) : 'нет пользователей'
                }
            </div>
        </div>
    )
}

export default UserPage