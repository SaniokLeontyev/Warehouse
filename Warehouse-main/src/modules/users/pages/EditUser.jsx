import '../users.css';
import { useDispatch, useSelector } from 'react-redux';
import { updateUser, updatePassword, getSingleUser } from '../store/actions';
import { useState, useRef, useEffect } from 'react';
import { loaderStatus } from '../../../store/actions';
import { useParams, useLocation } from 'react-router-dom';

function EditUser (props) {
    const dispatch = useDispatch()
    let { id, login } = useParams();  
    let singleUserData = useSelector(state => state.singleUser)
    const location = useLocation()  
    let fileInput = useRef()
    const [base64Data, setBase64Data] = useState('');
    const [selectedOption, setSelectedOption] = useState("");
    const [userValues, setUserValues] = useState({});
    const [userPassword, setUserPassword] = useState('')
    const loginProps = location.state ? location.state.login : null
    
    useEffect(() => {
        dispatch(getSingleUser(id, login))
    }, [id])

    useEffect( () => {
        setSelectedOption(singleUserData.jobTitle)
        setUserValues({...singleUserData})
    }, [singleUserData])

    const handleFileChange = async (event) => {
        const selectedFile = event.target.files[0];

        if (selectedFile) {
            try {
                const base64String = await convertToBase64(selectedFile);
                setBase64Data(base64String);
            } catch (error) {
                console.error('Error:', error);
            }
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

    const selectedRole = (e) => {
        const selectedOption = e.target.options[e.target.selectedIndex];
        setSelectedOption(selectedOption.textContent)
    }

    const updateUserHandle = () => {
        const newUser = {
            account: {
                username: document.getElementById('login').value,
                password: userPassword
            },
            base64: base64Data,
            roleId: +document.getElementById('role').value,
            user: {
                id: +id,
                name : document.getElementById('name').value,
                surname : document.getElementById('lastname').value,
                patronymic : document.getElementById('patronymic').value,
                jobTitle: selectedOption,
            }
        }
        dispatch(loaderStatus(true))
        dispatch(updateUser(newUser))

        if (userPassword.trim() !== '') {
            const data = {
                username: document.getElementById('login').value,
                password: userPassword
            }
            dispatch(updatePassword(data))
        }
    }

    

    return (
        <div className="add-users">
            <h3>Редактирование пользователя</h3>
            <form id='user-form' encType='multipart/form-data' onSubmit={ (e) => {e.preventDefault(); updateUserHandle()}}>
                <div>
                    <p>Логин</p>
                    <input type="text" id="login" placeholder='login' defaultValue={loginProps}/>
                </div>
                <div>
                    <p>Пароль</p>
                    <input type="text" id="pass" placeholder='Пароль' onInput={e => setUserPassword(e.target.value)} />
                </div>
                <div>
                    <p>Фамилия</p>
                    <input type="text" id="lastname" placeholder='Фамилия' required defaultValue={userValues.surname}/>
                </div>
                <div>
                    <p>Имя</p>
                    <input type="text" id="name" placeholder='Имя' required defaultValue={userValues.name}/>
                </div>
                <div>
                    <p>Отчество</p>
                    <input type="text" id="patronymic" placeholder='Отчество' defaultValue={userValues.patronymic}/>
                </div>
                <div>
                    <p>Текущая должность: <span>{ userValues.jobTitle }</span></p>
                    <select name="" id="role" onChange={(e) => selectedRole(e)} required>
                        <option value="">Выберите роль</option>
                        <option value="2">Заведующий складом</option>
                        <option value="3">Кладовщик</option>
                        <option value="4">Комплектовщик</option>
                        <option value="5">Карщик</option>
                        <option value="6">Грузчик</option>
                        <option value="7">Аудитор</option>
                    </select>
                </div>
                <div>
                    <p>Файл</p>
                    <input ref={fileInput} onChange={handleFileChange} className='form-document' type="file"/>
                </div>                
                <button type="submit">Обновить данные</button>
            </form>
        </div>
    )
}

export default EditUser