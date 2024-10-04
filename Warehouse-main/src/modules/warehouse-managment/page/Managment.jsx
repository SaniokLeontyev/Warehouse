import { useEffect, useState } from 'react'
import '../managment.css'
import ManagmentWarehouse from '../components/Managment-warehouse';
import { fetchSingleWarehouse,  } from '../../../store/actions';
import { useDispatch,useSelector } from 'react-redux';
import { getWarehouse } from '../../constructor/store/actions'

function Managment() {
    let warehouses = useSelector(state => state.warehouse)
    const dispatch = useDispatch()
    let [mapState, setMapState] = useState(false)
    let [selectedWarehouse, setSelectedWarehouse] = useState('')
    useEffect( () => {
        dispatch(fetchSingleWarehouse(selectedWarehouse))
        dispatch(getWarehouse())
    }, [])
    
    const showMap = (state) => {
        setMapState(state)
    }
    const onSelectWarehouse = (e) => {
        setSelectedWarehouse( prev => prev = e.target.value)
    }

    return (
        <div className="managment-container">
            <div className="managment">
                { mapState ? <ManagmentWarehouse id={selectedWarehouse} onSetClose={showMap}/> : ''}
                <h3 className='managment-title'>Ведение склада</h3>
                <div className="managment-top">
                    <h4 className='managment-subtitle'>Список номенклатур</h4>
                    <button className="open-map open-map__top" onClick={() => showMap(true)} disabled={!selectedWarehouse}>Карта склада</button>
                    <select name="" id="" onChange={onSelectWarehouse}>
                        <option value="">Выберите склад</option>
                        { !warehouses.length ? '' : warehouses.map( (item, index) => {
                            return (
                                <option key={index} value={item.id}>{item.name}</option>
                            )
                        })}
                    </select>
                </div>
            </div>
        </div>
    )
}


export default Managment