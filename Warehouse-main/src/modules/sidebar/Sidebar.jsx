import { NavLink } from 'react-router-dom'
import './sidebar.css'
import { useSelector } from 'react-redux'
import { removeCookie } from '../../utils/cookies.js'
import { useState } from 'react'

const setActive = ({isActive}) => isActive ? 'active-link' : ''

const Sidebar = () => {
    const auth = useSelector(state => state.accessToken)
    const role = useSelector(state => state.role)
    const [sidebarState, setSidebarState] = useState(false)
    const roleList = ['STOREKEEPER', 'WAREHOUSE_MANAGER', 'FORKLIFT_DRIVER', 'PICKER', 'LOADER', 'WAREHOUSE_AUDITOR', 'ADMINISTRATOR']

    const links = [
        { to: '/', label: 'Главная', roles: roleList },
        { to: '/docs', label: 'Документы', roles: ['ADMINISTRATOR', 'STOREKEEPER', 'WAREHOUSE_MANAGER'] },
        { to: '/users', label: 'Учетные записи', roles: ['ADMINISTRATOR'] },
        { to: '/invent', label: 'Инвентаризация', roles: ['ADMINISTRATOR', 'PICKER', 'WAREHOUSE_AUDITOR', 'STOREKEEPER', 'WAREHOUSE_MANAGER'] },
        { to: '/managment', label: 'Ведение склада', roles: ['ADMINISTRATOR', 'STOREKEEPER', 'WAREHOUSE_MANAGER', 'WAREHOUSE_AUDITOR'] },
        { to: '/task', label: 'Постановка задач', roles: ['ADMINISTRATOR', 'STOREKEEPER', 'WAREHOUSE_MANAGER'] },
        { to: '/constructor', label: 'Конструктор', roles: ['ADMINISTRATOR', 'STOREKEEPER'] },
        { to: '/my-task', label: 'Мои задачи', roles: roleList },
    ];
    
    const isLinkVisible = linkRoles => linkRoles.some(linkRole => role === linkRole);

    const logout = () => {
        removeCookie('access_token')
        window.location.reload()
    }

    const sidebarVisibility = () => {
        setSidebarState(!sidebarState)
        console.log(sidebarState);
    }

    const userdata = JSON.parse(localStorage.getItem('userdata'))

    return (
        <div className={auth ? 'sidebar-show' : 'sidebar-none'}>
            <div className={sidebarState ? 'sidebar-overlay' : 's-none'} onClick={sidebarVisibility}>
                <div className={sidebarState ? 'sidebar sidebar-open' : 'sidebar'}>
                    
                    <ul>
                        {localStorage.getItem('userdata') && <h3 style={{color: '#fff', fontSize: '18px'}}>
                            {userdata.jobTitle}: <br />
                            <span style={{ color: '#fff', textTransform: 'capitalize', fontWeight: 'bold', fontSize: '16px'}}>
                                {userdata.surname} {userdata.name} 
                            </span>
                        </h3>}
                        {links.map(link => (
                            isLinkVisible(link.roles) && (
                                <li key={link.to}>
                                    <NavLink onClick={sidebarVisibility} className={setActive} to={link.to}>{link.label}</NavLink>
                                </li>
                            )
                        ))}
                        <button onClick={ () => logout()} className="logout">Выход</button>
                    </ul>
                    <button className={sidebarState ? 'sidebar-btn sidebar-btn-rotate' : 'sidebar-btn'} onClick={sidebarVisibility}>&#10140;</button>
                </div>
            </div>
        </div>
    )
}

export default Sidebar