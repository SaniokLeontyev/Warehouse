import '../docs.css';
import { useDispatch, useSelector } from 'react-redux';
import { useEffect, useState } from 'react';
import { getDocs } from '../store/actions';
import ReadDocs from '../components/Read-docs';
import { loaderStatus } from '../../../store/actions';

function Docs() {
    const today = new Date();
    const startOfDay = new Date(today);
    const endOfDay = new Date(today);

    startOfDay.setHours(0, 0, 0, 0);
    endOfDay.setHours(23, 59, 59, 999);

    const formatDate = (date) => {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        const seconds = String(date.getSeconds()).padStart(2, '0');
    
        return `${year}${month}${day}${hours}${minutes}${seconds}`;
    };

    const dispatch = useDispatch()
    const docs = useSelector(state => state.docs)
    let [filterType, setFilterType] = useState('buying')
    const [selectedValue, setSelectedValue] = useState("from_to");
    let [modalState, setModalState] = useState(false)
    let [modalData, setModalData] = useState(null)
    const [currentPage, setCurrentPage] = useState(0);
    const [startDate, setStartDate] = useState(formatDate(startOfDay));
    const [endDate, setEndDate] = useState(formatDate(endOfDay));


    const openModal = (val) => {
        setModalState(val)
    }
    
    const dateFilterHandler = (e) => {
        const selectedOptionValue = e.target.value;

        const today = new Date();
        const endDate = new Date(today);

        if (selectedOptionValue === "1") {
            endDate.setDate(today.getDate());
        } else if (selectedOptionValue === "7") {
            endDate.setDate(today.getDate() - 6);
        } else if (selectedOptionValue === "30") {
            endDate.setMonth(today.getMonth() - 1);
        } else if (selectedOptionValue === "120") {
            endDate.setMonth(today.getMonth() - 3);
        } else if (selectedOptionValue === "365") {
            endDate.setFullYear(today.getFullYear() - 1);
        }
        setSelectedValue(selectedOptionValue);

        const formatDate = (date) => {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
        
            return `${year}${month}${day}000000`;
        };

        const formattedStartDate = formatDate(today);
        const formattedEndDate = formatDate(endDate);
        setStartDate(formattedStartDate);
        setEndDate(formattedEndDate);
        dispatch(getDocs(filterType, formattedEndDate,formattedStartDate))
    };

    const typeFilterHandler = (e) => {
        const selectedValue = e.target.value;
        setFilterType(selectedValue);
        // dispatch(loaderStatus(true))
        dispatch(getDocs(selectedValue, endDate, startDate))
    }
    useEffect( () => {
        dispatch(loaderStatus(true))
        dispatch(getDocs(filterType, endDate, startDate))
    }, [currentPage, startDate, endDate])

    
    const handlePageChange = (type) => {
        if (type === 'forward') {
            let newCurrPage = currentPage + 1
            setCurrentPage(newCurrPage)
        }
        if (type === 'back') {
            let newCurrPage = currentPage - 1
            setCurrentPage(newCurrPage)
        }
    };

    const handleChangeDateFromTo = (type, value) => {
        if (type === 'from') {
            setStartDate(value.replace(/-/g, "") + "000000")
        }
        if (type === 'to') {
            setEndDate(value.replace(/-/g, "") + "000000")
        }
        dispatch(getDocs(filterType,  startDate, endDate))
    }

    return (
        <div className="docs-page-container">
            <div className="docs-page">
                { modalState ? <ReadDocs state={openModal} data={modalData}/> : ''}
                <div className="docs-page__top">
                    <h3>Документы</h3>
                </div>
                <div className="docs-filters">
                    {/* <div>
                        <label htmlFor="executor">По исполнителю</label>
                        <select name="" id="executor">
                            <option value="">Арыстанов А.А</option>
                            <option value="">Ахмадов Б.А</option>
                            <option value="">Алтынбеков С.К</option>
                            <option value="">Сергеев Ф.М</option>
                            <option value="">Морозов Н.В</option>
                        </select>
                    </div> */}
                    <div>
                        <label htmlFor="operation">По операции</label>
                        <select name="" id="operation" onChange={typeFilterHandler}>
                            <option value="inventory">Выберите Операцию</option>
                            <option value="inventory">Инвентаризация</option>
                            <option value="writingOf">Списание</option>
                            <option value="buying">Получение</option>
                            <option value="moving">Перемещение</option>
                        </select>
                    </div>
                    { selectedValue === 'from_to'  && 
                        <>
                            <div className="docs-date__filter-period">
                                <label htmlFor="from">С</label>
                                <input type="date" name="" id="from" onChange={e => handleChangeDateFromTo('from', e.target.value)}/>
                            </div>
                            <div className="docs-date__filter-period">
                                <label htmlFor="to">По</label>
                                <input type="date" name="" id="to" onChange={e => handleChangeDateFromTo('to', e.target.value)}/>
                            </div>
                        </>
                    }
                    <div className="docs-date__filter">
                        <label htmlFor="date">По дате</label>
                        <select name="" id="date" onChange={ (e) => dateFilterHandler(e)}>
                            <option value="from_to">За период</option>
                            <option value="1">За день</option>
                            <option value="7">За неделю</option>
                            <option value="30">За Месяц</option>
                            <option value="120">За Квартал</option>
                            <option value="365">За Год</option>
                        </select>
                    </div>
                    {/* <div>
                        <label htmlFor="sort">Сортировка по дате</label>
                        <select name="" id="sort">
                            <option value="">Сначало новые</option>
                            <option value="">Сначало старые</option>
                        </select>
                    </div> */}
                </div>
                <div className="docs-table">
                    <div className="docs-table__item">
                        <div>Заголовок</div>
                        <div>Исполнитель</div>
                        {/* <div>Операция</div> */}
                        <div>Дата</div>
                    </div>
                    {Object.hasOwn(docs, 'body') && docs.body.length ? docs.body.map( (item, index) => {
                        return (
                            <div onClick={ () => {
                                openModal(true)
                                setModalData(item)
                            }} key={index} className="docs-table__item">
                                <div>{item.title}</div>
                                <div>{item.shipper}</div>
                                {/* <div>Отгрузка</div> */}
                                <div>{item.date}</div>
                            </div>
                        )
                    }) : 'Нет документов соответствущие фильтрам'}        
                </div>
                <div className="task-pagination">
                    { currentPage !== 0 && <button onClick={() => handlePageChange('back')}>
                        Назад
                    </button>}
                    <span>Страниц {currentPage + 1} из {Object.hasOwn(docs, 'pagination') ? docs.pagination.maxPages : 1}</span>
                    { currentPage + 1 !== (Object.hasOwn(docs, 'pagination') ? docs.pagination.maxPages : 1) && <button onClick={() => handlePageChange('forward')}>
                        Вперед
                    </button>}
                </div>
            </div>
        </div>
    )
}

export default Docs