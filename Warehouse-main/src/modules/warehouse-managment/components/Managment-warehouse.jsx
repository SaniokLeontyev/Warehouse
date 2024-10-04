import "../managment.css";
import { Stage, Layer, Rect, Text } from "react-konva";
import { useEffect, useState, useRef } from "react";
import { fetchSingleWarehouse } from '../../../store/actions'
import { useDispatch, useSelector } from "react-redux";
import { createPortal } from 'react-dom'

const Tooltip = ({ x, y, title, description }) => {
  return (
    <div style={{ position: 'absolute', top: y, left: x, backgroundColor: 'white', padding: '5px', border: '1px solid black' }}>
      <div><strong>Название:</strong> {title}</div>
      <div><strong>Описание:</strong> {description}</div>
    </div>
  );
};

function ManagmentWarehouse({id, onSetClose}) {
  const [tooltipPosition, setTooltipPosition] = useState({ x: 0, y: 0 });
  const [tooltipContent, setTooltipContent] = useState({ title: '', description: '' });
  const [tooltipVisible, setTooltipVisible] = useState(false);

  const dispatch = useDispatch()
  const warehouse = useSelector(state => state.singleWarehouse)
  let [totalSearchResutl, setTotalSearchResutl] = useState([]);
  let uuid = useSelector((state) => state.all_uuid);
  let [resultUUID, setResultUUID] = useState({});
  let [resultInShelf, setResultInShelf] = useState([])

  let [shelves, setShelves] = useState([])
  useEffect( () => {
      if (id) {
          dispatch(fetchSingleWarehouse(id))
      }
  }, [])

  useEffect(() => {
    if (warehouse) {
      setShelves(warehouse.shelves);
    }
  }, [warehouse]);

  // grid start
  let [gridSizeValue, setGridSizeValue] = useState(1)
  let [gridState, setGridState] = useState(false)
  let gridSizeInput = useRef()
  const showGridSize = () => {
    setGridState(gridState = !gridState)
  }
  const gridSizeSet = () => {
    setGridSizeValue(+gridSizeInput.current.value)
    setZoomStyle(zoomStyle = {
      backgroundSize: `${gridSizeValue}px`
    })
  }
  // grid end

  // zoom
  let [zoom, setZoom] = useState(1);
  let [translateIndex, setTranslateIndex] = useState(0);
  let [zoomStyle, setZoomStyle] = useState();
  function check() {
    if (zoom.toFixed(2) >= 1.14) {
      translateIndex = 6.5;
    }
    if (zoom.toFixed(2) >= 1.3) {
      translateIndex = 11.5;
    }
    if (zoom.toFixed(2) >= 1.45) {
      translateIndex = 15.5;
    }
    if (zoom.toFixed(2) >= 1.6) {
      translateIndex = 18.5;
    }
    if (zoom.toFixed(2) == 1) {
      translateIndex = 0;
    }
    if (zoom.toFixed(2) <= 0.85) {
      translateIndex = -8.5;
    }
    if (zoom.toFixed(2) <= 0.7) {
      translateIndex = -21.5;
    }
    if (zoom.toFixed(2) <= 0.55) {
      translateIndex = -40.5;
    }
    if (zoom.toFixed(2) <= 0.4) {
      translateIndex = -74.5;
    }
    setZoomStyle(
      (zoomStyle = {
        transform: `scale(${zoom}) translate(${translateIndex}%, ${translateIndex}%)`,
        backgroundSize: `${45}px`,
      })
    );
  }
  const zoomIn = () => {
    setZoom((zoom += 0.15));
    check();
  };
  const zoomOut = () => {
    setZoom((zoom -= 0.15));
    check();
  };
  // zoom

  let doorways = warehouse?.doorways ?? []
  let zones = warehouse?.zones ?? []
  let windows = warehouse?.windows ?? []
  let walls = warehouse?.walls ?? []


  const closeModal = () => {
    onSetClose(false);
  };
  // stage & modal

  // shelv click info
  const [shelvData, setShelvData] = useState(null)
  const getShelvAttr = async (data) => {
    setShelvData(prev => prev = data)
  }
  // shelv click info


  const handleShapeClick = (shapeId) => {
    const updatedShapes = shelves.map((shape) => ({
      ...shape,
      fill: shape.rack_id === shapeId ? 'green' : 'gray',
    }));
    setShelves(updatedShapes);
  };

  const [cellsModal, setCellsModal] = useState(false)
  let [selectedItemAttr, setSelectedItemAttr] = useState(null)
  const showCellsModal = (type, item) => {
      let t = type
      setCellsModal(t)

      let itemAttr = item
      setSelectedItemAttr(itemAttr)

      console.log(selectedItemAttr);
  }

  useEffect(() => {
    if (shelvData) {
      const root = document.documentElement;
      root.style.setProperty('--cells-per-width', shelvData?.cells_per_width);
    }
  }, [shelvData?.cells_per_width]);
  let [foundItemInShelf, setFoundItemInShelf] = useState(null)
  const searchUUID = (e) => {
    const searchValue = e.target.value;
    if (!searchValue) {
        setTotalSearchResutl([]);
        setResultUUID(null);
        shelves.map(item => {
          item.fill = 'gray'
        })
        setShelvData(null)
        setFoundItemInShelf(null)
        return;
    }

    const foundItems = uuid.filter(item => {
        return item.uuid.includes(searchValue) || item.name.includes(searchValue);
    });

    if (foundItems.length === 1) {
        setResultUUID(foundItems[0]);
        matchInShelf(foundItems[0]);
    } else {
        setResultUUID([]);
    }
    setTotalSearchResutl(foundItems);
};

const matchInShelf = (resultUUID) => {
  if (!resultUUID) return;

  const foundItem = shelves.flatMap(shelf => shelf.item_attributes).find(item => item.uuid === resultUUID.uuid);
  if (foundItem) {
      setFoundItemInShelf(foundItem);
      const foundShelf = shelves.find(shelf =>
          shelf.item_attributes.some(item => item.uuid === foundItem.uuid)
      );
      if (foundShelf) {
          console.log(foundShelf);
          foundShelf.fill = "red"; 
          console.log("Фигура найдена и подкрашена.");
          setShelvData(foundShelf);
      } else {
          console.log("Фигура не найдена.");
      }
  } else {
      console.log("Номенклатура не найдена.");
  }
}

  const handleShapeClickZone = (event, shape) => {
    console.log(event, shape);
    const { clientX, clientY } = event.evt;
    setTooltipPosition({ x: clientX, y: clientY });
    setTooltipContent({ title: shape.title, description: shape.description });
    setTooltipVisible(true);

    setTimeout( () => {
      setTooltipVisible(false);
    }, 2000)
  };

  const calculateShelfColor = (item) => {
    const now = new Date();
    const itemColors = item.item_attributes.map(attr => {
        const startDate = new Date(attr.start_date);
        const endDate = new Date(attr.end_date);
        const totalDuration = endDate - startDate;
        const elapsedDuration = now - startDate;
        const elapsedPercent = elapsedDuration / totalDuration;
        console.log(elapsedPercent);
        if (elapsedPercent < 0) return 'black';
        if (elapsedPercent >= 0.75 && elapsedPercent < 1) return 'red';
        if (elapsedPercent >= 0.4 && elapsedPercent <= 0.75) return 'yellow';
        return item.fill;
    });
    if (itemColors.includes('yellow')) return 'yellow';
    if (itemColors.includes('black')) return 'black';
    if (itemColors.includes('red')) return 'red';
    return item.fill;
  };

  const showConditionDateText = (item) => {
    const now = new Date();
      const startDate = new Date(item.start_date);
      const endDate = new Date(item.end_date);
      const totalDuration = endDate - startDate;
      const elapsedDuration = now - startDate;
      const elapsedPercent = elapsedDuration / totalDuration;

      if (elapsedPercent > 1) return <h4 style={{ color: 'red', marginTop: '10px' }}>Просрочено</h4>
      if (elapsedPercent > 0.55 && elapsedPercent <= 1) return <h4 style={{ color: 'purple', marginTop: '10px' }}>Прошло больше 45% срока годности</h4>
      if (elapsedPercent > 0.25 && elapsedPercent <= 0.55) return <h4 style={{ color: 'orange', marginTop: '10px'}}>Прошло больше 75% срока годности</h4>;
      if (elapsedPercent > 0 && elapsedPercent <= 0.25) return <h4 style={{ color: 'green', marginTop: '10px' }}>Срок годности в норме</h4>;

    //return <h4 style={{ color: 'green', marginTop: '10px'}}>Срок годности в норме</h4>;
  }

  const formatedDate = (value) => {
    return new Date(value).toISOString().split('T')[0];
  }

  return (
    <div className="managment-modal">
      <div className="managment-modal__top">
        <h3>Карта номенклатур</h3>
        <button onClick={closeModal} className="managment-modal__close">
          X
        </button>
      </div>
      <div className="managment-modal__body">
        <div className="managment-modal__left">
          <div className="plane-nav">
            <button
              className="zoomIn"
              data-type="in"
              onClick={zoomIn}
              disabled={zoom > 1.5}
            >
              +
            </button>
            <button
              className="zoomOut"
              data-type="out"
              onClick={zoomOut}
              disabled={zoom < 0.45}
            >
              -
            </button>
            <div className="zoomValue">{zoom.toFixed(2)}</div>
          </div>
          { !id ? '' : <Stage width={10000} height={10000} className="managment-modal__warehouse" style={zoomStyle}>
                <Layer>
                    { zones.length ? zones.map( (item, index) => {
                        return (
                          <>
                            <Rect
                                key={index}
                                x={item.x}
                                y={item.y}
                                fill={item.fill}
                                width={item.width}
                                height={item.height}
                                opacity={0.4}
                                rotation={item.rotation}
                            />
                            <Text
                                text={item.title || item.rack_id}
                                fontSize={20}
                                fill="white"
                                width={item.width}
                                height={item.height}
                                align="center"
                                verticalAlign="middle"
                                x={item.x}
                                y={item.y}
                                rotation={item.rotation}
                                onClick={(event) => handleShapeClickZone(event, item)}
                            />
                          </>      
                        )
                    }) : '' }
                    { walls.length ? walls.map( (item, index) => {
                        return (
                            <Rect
                                key={index}
                                x={item.x}
                                y={item.y}
                                fill={item.fill}
                                width={item.width}
                                height={item.height}
                                rotation={item.rotation}
                            />
                        )
                    }) : '' }
                    { windows.length ? windows.map( (item, index) => {
                        return (
                            <Rect
                                key={index}
                                x={item.x}
                                y={item.y}
                                fill={item.fill_pattern_image}
                                width={item.width}
                                height={item.height}
                                rotation={item.rotation}
                            />
                        )
                    }) : '' }
                    { doorways.length ? doorways.map( (item, index) => {
                        return (
                            <Rect
                                key={index}
                                x={item.x}
                                y={item.y}
                                fill={item.fill_pattern_image}
                                width={item.width}
                                height={item.height}
                                rotation={item.rotation}
                            />
                        )
                    }) : '' }
                    { shelves && shelves.length > 0 ? shelves.map( (item, index) => {
                        return (
                            <>
                              <Rect
                                key={index}
                                x={item.x}
                                y={item.y}
                                fill={calculateShelfColor(item)}
                                width={item.width}
                                height={item.height}
                                onClick={ () => {
                                  getShelvAttr(item)
                                }}
                                rotation={item.rotation}
                                stroke="black"
                                strokeWidth={1}
                              />
                              <Text
                                  text={item.shelf_level < 1 ? `${item.rack_id}.${item.shelf_level}` : `${item.rack_id}`}
                                  fontSize={item.shelf_level > 1 ? 12 : 20}
                                  fill="white"
                                  width={item.width}
                                  height={item.height}
                                  align="center"
                                  verticalAlign="middle"
                                  rotation={item.rotation}
                                  x={item.x}
                                  y={item.y}
                                  onClick={ () => {
                                    getShelvAttr(item)
                                    handleShapeClick(item.rack_id)
                                    setFoundItemInShelf(null)
                                    setResultUUID('')
                                  }}
                                  onTap={() => {
                                    getShelvAttr(item)
                                    handleShapeClick(item.rack_id)
                                    setFoundItemInShelf(null)
                                    setResultUUID('')
                                  }}
                              />
                            </>
                        )
                    }) : '' }
                </Layer>
            </Stage> }
            {(tooltipVisible && tooltipContent.title) && (
              createPortal(
                <Tooltip x={tooltipPosition.x} y={tooltipPosition.y} title={tooltipContent.title} description={tooltipContent.description} />,
                document.body
              )
            )}
        </div>
        <div className="managment-modal__right">
          <section className="managment-modal__right-search">
            <input
              type="text"
              placeholder="Укажите номенклатуру"
              onChange={searchUUID}
              id="for-num"
              name="for-nom"
              list="for-nom"
            />
            <datalist id="for-nom">
            {totalSearchResutl.map((item, index) => (
                <option key={index} value={item.uuid}>
                {item.name}
                </option>
            ))}
            </datalist>
          </section>
          { foundItemInShelf !== null && <h4>Найдено на стеллаже {shelvData?.rack_id}</h4>}
          { foundItemInShelf !== null && 
            <div>
              <div className="managment-modal__right-item">
                <span>Номенклатура :</span> : <span>{foundItemInShelf.nomenclature}</span> <br />
                <span>Количество :</span> : <span>{foundItemInShelf.quantity}</span> <br />
                {/* <span>Units</span> : <span>{item.units}</span> <br /> */}
                <span>Уровень хранения :</span> : <span>{foundItemInShelf.shelf_level}</span> <br />
                <span>Ячейка на уровне :</span> : <span>{foundItemInShelf.cell_number}</span> <br /> <button className="managment-show__cell" onClick={() => showCellsModal(true, foundItemInShelf)}>Показать ячейку</button> <br />
                <span>Дата производста :</span> : <span>{formatedDate(foundItemInShelf.start_date)}</span>
                <span>Дата истечения срока :</span> : <span>{formatedDate(foundItemInShelf.end_date)}</span>
                { showConditionDateText(foundItemInShelf) }
              </div>
            </div>
            
          }
          <h4 style={{ margin: '20px 0px 0px 0px' }}>Вся номенклатура на стеллаже :{shelvData?.rack_id}</h4>
          { !shelvData?.item_attributes.length ? 'Нет номенклатуры' : shelvData.item_attributes.map( (item, index) => {
            return (
              <div className="managment-modal__right-item" key={index}>
                <span>Номенклатура :</span> : <span>{item.nomenclature}</span> <br />
                <span>Количество :</span> : <span>{item.quantity}</span> <br />
                {/* <span>Units</span> : <span>{item.units}</span> <br /> */}
                <span>Уровень хранения :</span> : <span>{item.shelf_level}</span> <br />
                <span>Ячейка на уровне :</span> : <span>{item.cell_number}</span> <br /> <button className="managment-show__cell" onClick={() => showCellsModal(true, item)}>Показать ячейку</button> <br />
                <span>Дата производста :</span> : <span>{formatedDate(item.start_date)}</span> <br />
                <span>Дата истечения :</span> : <span>{formatedDate(item.end_date)}</span>
                {showConditionDateText(item)}
              </div>
            )
          })}
          { cellsModal && <div className="warehouse-cell__modal">
              <div className="warehouse-cell__modal-top">
                  <h4>Уровень {selectedItemAttr.shelf_level} Ячейка {selectedItemAttr.cell_number }</h4>
              <button className="warehouse-cell__modal-close" onClick={() => showCellsModal(false)}>x</button>
              </div>
              <div className="warehouse-cells">
                {Array.from({ length: shelvData.cells_per_width * shelvData.cells_per_depth }, (_, index) => {
                  let hasItem = false
                  if (selectedItemAttr.cell_number === index + 1) {
                    hasItem = true
                  }
                  
                  const cellClass = hasItem ? "warehouse-cell-item" : "";

                  return (
                    <div key={index + shelvData.cells_per_width} className={cellClass}>
                      {index + 1}
                    </div>
                  );
                })}
              </div>
          </div> }
        </div>
      </div>
    </div>
  );
}

export default ManagmentWarehouse;
