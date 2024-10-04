import '../docs.css'

function ReadDocs(props) {
    const { state, data } = props

    const closeModal = () => {
        state(false)
    }

    return (
        <div className="docs-modal-overlay">
            <div className='docs-modal'>
            <button className='docs-modal__close-btn' onClick={closeModal}>x</button>
                <div className="docs-modal__top">
                    <h3>Просмотр сведений</h3>
                </div>
                <div className="docs-modal__body">
                        <div><span className='docs-modal__table'>Дата</span>: <span className='docs-modal_table-value'>{data.date}</span></div>
                        <div><span className='docs-modal__table'>Номер</span>: <span className='docs-modal_table-value'>{data.number}</span></div>
                        <div><span className='docs-modal__table'>Название</span>: <span className='docs-modal_table-value'>{data.title}</span></div>
                        <div><span className='docs-modal__table'>UUID</span>: <span className='docs-modal_table-value'>{data.uuid}</span></div>
                        <div><span className='docs-modal__table'>Stock</span>: <span className='docs-modal_table-value'>{data.stock}</span></div>
                        <div><span className='docs-modal__table'>Номенклатура</span>: 
                            <span>
                            <div className='docs-modal__table-head'>
                                <span className='docs-modal__table'>Название</span>
                                <span className='docs-modal__table'>Количество</span>
                            </div>
                            {
                                data.products.map( (item, index) => {
                                    return (
                                        <div key={index} className='docs-modal__table-head'>
                                            <span className='docs-modal-aaa'>{item.NomenclatureName}</span>
                                            <span className='docs-modal-aaa'>{item.quantity}</span>
                                        </div>
                                    )
                                })
                            }
                            </span>
                        </div>
                </div>
            </div>
        </div>
    )
}

export default ReadDocs