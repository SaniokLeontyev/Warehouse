import '../users.css';
import { useDispatch } from 'react-redux';
import { createUser } from '../store/actions';
import { useState, useRef } from 'react';
import { loaderStatus } from '../../../store/actions';

function AddUser () {
    const dispatch = useDispatch()
    let fileInput = useRef()
    const [base64Data, setBase64Data] = useState('');
    const [selectedOption, setSelectedOption] = useState("");

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
    
    const createNewUser = () => {
        const newUser = {
            account: {
                username: document.getElementById('login').value,
                password: document.getElementById('pass').value
            },
            base64: base64Data,
            roleId: document.getElementById('role').value,
            user: {
                name : document.getElementById('name').value,
                surname : document.getElementById('lastname').value,
                patronymic : document.getElementById('patronymic').value,
                jobTitle: selectedOption,
            }
        }
        dispatch(loaderStatus(true))
        dispatch(createUser(newUser))
    }

    return (
        <div className="add-users">
            <h3>Создание пользователя</h3>
            <form id='user-form' encType='multipart/form-data' onSubmit={ (e) => {e.preventDefault(); createNewUser()}}>
                <div>
                    <p>Логин</p>
                    <input type="text" id="login" placeholder='login' required/>
                </div>
                <div>
                    <p>Пароль</p>
                    <input type="text" id="pass" placeholder='Пароль' required/>
                </div>
                <div>
                    <p>Фамилия</p>
                    <input type="text" id="lastname" placeholder='Фамилия' required/>
                </div>
                <div>
                    <p>Имя</p>
                    <input type="text" id="name" placeholder='Имя' required/>
                </div>
                <div>
                    <p>Отчество</p>
                    <input type="text" id="patronymic" placeholder='Отчество'/>
                </div>
                <div>
                    <p>Должность</p>
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
                    <input ref={fileInput} onChange={handleFileChange} className='form-document' type="file" required/>
                </div>
                <button type="submit">Создать</button>
            </form>
        </div>
    )
}

export default AddUser