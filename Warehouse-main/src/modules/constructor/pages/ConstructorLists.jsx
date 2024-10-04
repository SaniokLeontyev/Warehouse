import { useNavigate } from 'react-router-dom';
import '../constructor.css';
import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { getWarehouse, removeWarehouse } from '../store/actions';
import { loaderStatus } from '../../../store/actions';
function ConstructorList() {
    const navigate = useNavigate()
    const dispatch = useDispatch()
    const warehouse = useSelector(state => state.warehouse)
    const createStock = () => {
        navigate('/constructor-create')
    }

    useEffect( () => {
        dispatch(loaderStatus(true))
        dispatch(getWarehouse())
    }, [])

    const warehouseEdit = (id) => {
        const warehouseProps = {
            id: id
        }
        navigate('/constructor-edit', {state : warehouseProps})
    }

    const warehouseDelete = (id) => {
        const message = confirm('Вы хотите удалить склад? Все данные по данному складу и стеллажам будут удалены, включая номенклатуру размещенную на данном складе. Проверьте наличие номенклатры на склада перед удалением. Нажимая "ок" вы подтверждаете удаление, "отмена" отменить удаление')

        message ? dispatch(removeWarehouse(id)): alert('Удаление отменено')
    }


    return (
        <div className="constructor-list">
            <div className="constructor-list__top">
                <h2>Конструктор - склад</h2>
                <button onClick={createStock}>Создать склад</button>
            </div>
            <div className="constructor-list__table">
                {
                    warehouse.length ? warehouse.map( (item, index) => {
                        return (
                            <div key={index} className="constructor-list__table-item">
                                <h3>{item.name}</h3>
                                <div className="constructor-list__actions">
                                    <button className='constructor-list__actions-edit' onClick={() => warehouseEdit(item.id)}>Изменить склад</button>
                                    <button className='constructor-list__actions-delete' onClick={() => warehouseDelete(item.id)}>Удалить склад</button>
                                </div>
                            </div>
                        )
                    }) : 'нет созданных складов'
                }
            </div>
        </div>
    )
}

export default ConstructorList