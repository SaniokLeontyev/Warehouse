import '../constructor.css';
import { Stage, Layer, Transformer, Rect, Group, Text } from 'react-konva'
import { useState, useRef, Fragment, useEffect } from 'react';
import { createWarehouse, addDoorwaysById, addZonesById, addShelvById, addWindowsById, addWallsById, deleteFigure, updateWalls, updateWindow, updateShelves, updateZone, updateDoor } from '../store/actions';
import { useDispatch, useSelector } from 'react-redux';
import { useLocation } from 'react-router-dom';
import { fetchSingleWarehouse } from '../../../store/actions';
import { toast } from 'react-toastify';

const Rectangle = ({ shapeProps, isSelected, onSelect, onChange, data }) => {
  const shapeRef = useRef();
  const trRef = useRef();

  useEffect(() => {
    if (isSelected) {
      trRef.current.nodes([shapeRef.current]);
      trRef.current.getLayer().batchDraw();
    }
  }, [isSelected]);

  return (
    <Fragment>
      <Group 
        onClick={onSelect}
        onTap={onSelect}
        ref={shapeRef}
        {...shapeProps}
        draggable
        opacity={data.name === 'zone' ? 0.5 : 1}
        onDragEnd={(e) => {
          onChange({
            ...shapeProps,
            x: e.target.x(),
            y: e.target.y(),
          });
        }}
        onTransformEnd={(e) => {
          const node = shapeRef.current;
          const scaleX = node.scaleX();
          const scaleY = node.scaleY();
          node.scaleX(1);
          node.scaleY(1);
          if (data.name !== 'rack') {
            onChange({
              ...shapeProps,
              x: node.x(),
              y: node.y(),
              rotation: e.target.attrs.rotation,
              width: Math.max(5, node.width() * scaleX),
              height: Math.max(node.height() * scaleY),
            });
          }
        }}>
        <Rect
          width={data.width}
          height={data.height}
          fill={data.name === 'window' || data.name === 'door' ? data.fill_pattern_image : data.fill}
          stroke="red"
          strokeWidth={data.name === 'shelv' ? 1.5 : 0}
        />
        <Text
          text={data.title || data.rack_id}
          fontSize={15}
          fill="white"
          width={data.width}
          height={data.height}
          align="center"
          verticalAlign="middle"
        />
      </Group>
      {isSelected && (
          <Transformer
            ref={trRef}
            rotationSnaps={[0,45,90,135,180,225,270,315]}
            boundBoxFunc={(oldBox, newBox) => {
              // limit resize
              if (newBox.width < 5 || newBox.height < 5) {
                return oldBox;
              }
              return newBox;
            }}
          />
        )}
    </Fragment>
  );
};



function ConstruktorEdit() {
    let [gridSizeValue, setGridSizeValue] = useState(45)
    let [gridState, setGridState] = useState(false)
    let gridSizeInput = useRef()
    const dispatch = useDispatch()
    const [posX, setPosX] = useState(0)
    const [posY, setPosY] = useState(0)
    const square = useRef()
    let figure = useSelector(state => state.singleWarehouse)
    const location = useLocation()
    useEffect( () => {
      if (location.state) {
        dispatch(fetchSingleWarehouse(location.state.id))
      }
    }, [])

    const constructorJSON = {
      id: 0,
      name: 'Stage',
      width: window.innerWidth,
      height: window.innerHeight,
      walls: [],
      doorways: [],
      windows: [],
      zones: [],
      shelves: []
    }

    const test = (e) => {
      let shadowSquare = square.current
      let x = e.target._changedPointerPositions[0].x
      let y = e.target._changedPointerPositions[0].y
      let xFake = e.evt.clientX
      let yFake = e.evt.clientY
      setPosX(oldVal => oldVal = x)
      setPosY(oldVal => oldVal = y)
      shadowSquare.setAttribute('style', `left: ${xFake}px; top: ${yFake}px; width: ${gridSizeValue}px; height: ${gridSizeValue}px`)
    }

    let [countChange, setCountChange] = useState('1')
    const handleCountChange = (e) => {
      let oldCount = e.target.value
      setCountChange(oldCount)
    }

    let [directionVal, setDirectionVal] = useState('1')
    const handleDirection = (e) => {
      let oldDirection = e.target.value
      setDirectionVal(oldDirection)
    }

    let rectCount = useRef()

    // grid start
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

    // zoom Start
    let [zoom, setZoom] = useState(1)
    let [translateIndex, setTranslateIndex] = useState(0)
    let [zoomStyle, setZoomStyle] = useState()
    function check() {
      if (zoom.toFixed(2) >= 1.14) {
        translateIndex = 6.5
      } 
      if (zoom.toFixed(2) >= 1.3) {
        translateIndex = 11.5
      }
      if (zoom.toFixed(2) >= 1.45) {
        translateIndex = 15.5
      }
      if (zoom.toFixed(2) >= 1.6) {
        translateIndex = 18.5
      }
      if (zoom.toFixed(2) == 1) {
        translateIndex = 0
      }
      if (zoom.toFixed(2) <= 0.85) {
        translateIndex = -8.5
      } 
      if (zoom.toFixed(2) <= 0.7) {
        translateIndex = -21.5
      }
      if (zoom.toFixed(2) <= 0.55) {
        translateIndex = -40.5
      }
      if (zoom.toFixed(2) <= 0.4) {
        translateIndex = -74.5
      }
      setZoomStyle(zoomStyle = {
        transform: `scale(${zoom}) translate(${translateIndex}%, ${translateIndex}%)`,
        backgroundSize: `${figure.shelves[0].width || gridSizeValue}px`
      })
    }
    const zoomIn = () => {
      setZoom(zoom+=0.15) 
      check()
    }
    const zoomOut = () => {
      setZoom(zoom-=0.15)
      check()
    }
    // zoom End

    // rectagle create start
    let [rectangle, setRectangle] = useState([]);
    let [selectedId, selectShape] = useState(null);
    const checkDeselect = (e) => {
      const clickedOnEmpty = e.target === e.target.getStage();
      if (clickedOnEmpty) {
        selectShape(null);
      }
    }

    useEffect(() => {
      const combinedArray = [
        ...(Array.isArray(figure.walls) ? figure.walls : []),
        ...(Array.isArray(figure.doorways) ? figure.doorways : []),
        ...(Array.isArray(figure.windows) ? figure.windows : []),
        ...(Array.isArray(figure.zones) ? figure.zones : []),
        ...(Array.isArray(figure.shelves) ? figure.shelves : []),
      ];

      const rectanglesWithNumbers = combinedArray.map(item => ({
        ...item,
        x: parseFloat(item.x), 
        y: parseFloat(item.y)
      }));
    
      setRectangle(rectanglesWithNumbers);
    }, [figure]);
    //rectagle create end

    
    // create Wall
    const Wall = {
      id: 0,
      x: posX,
      y: posY,
      fill: "black",
      opacity: 1,
      draggable: true,
      name: 'wall',
      width: gridSizeValue,
      height: gridSizeValue,
      type: 'wall',
      rotation: 0
    }
    const addWall = async () => {
      setRectangle(rect => [...rect, Wall])
      createFigure()
      setTimeout( () => {
        dispatch(fetchSingleWarehouse(location.state.id))
      }, 500)
    }

    //create window start
    

    const Win = {
      id: 0,
      x: posX,
      y: posY,
      fill: "orange",
      opacity: 1,
      draggable: true,
      name: 'window',
      width: 145,
      height: 45,
      fill_pattern_image: "orange",
      type: 'window',
      rotation: 0
    }
    let addWindow = () => {
      setRectangle(rect => [...rect, Win])
      createFigure()
      setTimeout(() => {
        dispatch(fetchSingleWarehouse(location.state.id))
      }, 500)
    }
    //create window end


    //create door start
    const addDoorways = () => {
      setRectangle(rect => [...rect, {
        id: 0,
        x: posX,
        y: posY,
        fill: "red",
        opacity: 1,
        draggable: true,
        name: 'door',
        width: 200,
        height: 45,
        type: 'doorways',
        fill_pattern_image: "red",
        rotation: 0
      }])
      createFigure()
      setTimeout(() => {
        dispatch(fetchSingleWarehouse(location.state.id))
      }, 500)
      console.log(rectangle);
    }
    //create door end

    //create zone start
    let [zoneState, setZoneState] = useState(false)
    let zOne = {
      id: 0,
      name: "zone",
      description: "test123123",
      draggable: true,
      fill: '',
      opacity: 0.5,
      title: "sadsad",
      width: gridSizeValue,
      height: gridSizeValue,
      x: 0,
      y: 0,
    }
    let [Zone, SetZone] = useState(zOne)

    const handleChange = (e) => {
      const { name, value } = e.target;
      SetZone(prevZone => ({
        ...prevZone,
        opacity: 0.5,
        [name]: value
      }));
    };

    const addZone = () => {
        setRectangle(rect => [...rect, {...Zone, x: posX, y: posY}])
        createFigure()
        setTimeout(() => {
          dispatch(fetchSingleWarehouse(location.state.id))
        }, 500)
    }
    const showZone = ()  => {
      setZoneState(zoneState = !zoneState)
    }
    //create zone end

    //create Rack
    let [rackState, setRackState] = useState(false)
    const [Rack, setRack] = useState({
        id: 0,
        shelf_level: 1,
        cells_per_width: 0,
        cells_per_depth: 0,
        x: 0,
        y: 0,
        fill: "gray",
        opacity: 1,
        draggable: true,
        name: "shelv",
        width: gridSizeValue,
        height: gridSizeValue,
        rack_height: 0,
        rack_id: '',
        item_attributes: [],
        zone_names: ['test'],
    })
    const handleChangeRack = (e) => {
      const { name, value } = e.target;
      setRack(prevRack => ({
        ...prevRack,
        [name]: value,
      }));
    }
    const addRack = () => {
      if (countChange === '2') {
        if (directionVal === '1') {
          const rackCopies = [];

            for (let i = 0; i < rectCount.current.value; i++) {
              const copy = { ...Rack, rack_id: Rack.shelf_level > 1 ? `${Rack.rack_id}.${(i+1)}.${Rack.shelf_level}` : `${Rack.rack_id}.${(i+1)}`, x: posX + i*Rack.width, y: posY};
              rackCopies.push(copy);
            }

          setRectangle(rect => [...rect, ...rackCopies])
        
        } else {
          const rackCopies = [];

          for (let i = 0; i < rectCount.current.value; i++) {
            const copy = { ...Rack, rack_id:  Rack.shelf_level > 1 ? `${Rack.rack_id}.${(i+1)}.${Rack.shelf_level}` : `${Rack.rack_id}.${(i+1)}`, y: posY + i*Rack.width, x: posX};
            rackCopies.push(copy);
          }

        setRectangle(rect => [...rect, ...rackCopies])
        }
      } else {
        setRectangle(rect => [...rect, {...Rack, x: posX, y: posY}])
      }

      createFigure()

      setTimeout(() => {
        dispatch(fetchSingleWarehouse(location.state.id))
      }, 500)
    }

    
    const showRack = () => {
      setRackState(rackState = !rackState)
    }
    

    function createFigure() {
      constructorJSON.name = warehouseName
      rectangle.forEach(item => {
        if (item.name === 'wall' && item.id == 0) {
          constructorJSON.walls.push(item)
        }
        if (item.type === 'window' && item.id == 0) {
          constructorJSON.windows.push(item)
        }
        if (item.name === 'door' && item.id == 0) {
          constructorJSON.doorways.push(item)
        }
        if (item.name === 'zone' && item.id == 0) {
          constructorJSON.zones.push(item)
        }
        if (item.name === 'shelv' && item.id == 0) {
          constructorJSON.shelves.push(item)
        }
      })
    }
    
    useEffect(() => {
      const updatedRect = [...rectangle];
      if (updatedRect.length > 0) {
        createFigure(updatedRect);
        const lastAddedItem = updatedRect[updatedRect.length - 1];
        switch (lastAddedItem.name) {
          case 'wall':
            dispatch(addWallsById(figure.id, constructorJSON.walls));
            break;
          case 'window':
            dispatch(addWindowsById(figure.id, constructorJSON.windows));
            break;
          case 'zone':
            dispatch(addZonesById(figure.id, constructorJSON.zones));
            break;
          case 'door':
            dispatch(addDoorwaysById(figure.id, constructorJSON.doorways));
            break;
          case 'shelv':
            dispatch(addShelvById(figure.id, constructorJSON.shelves));
            break;
          default:
            break;
        }
        
      }
    }, [rectangle]);

    const createSklad = () => {
      toast('Редактирование завершено')
    }
    
    // const addedZone = (rect) => {
    //   let rectTopLeft = {x: rect.x, y: rect.y}
    //   let rectTopRigth = {x: rect.x + rect.width, y: rect.y}
    //   let rectBottomLeft = {x: rect.x, y: rect.y + rect.height}
    //   let rectBottomRight = {x: rect.x + rect.width, y: rect.y+ rect.height}

    //   let rackZones = []
    //   rectangle.forEach(item => {
    //     if (item.type === 'zone') {
    //       let zoneTopLeft = {x: item.x, y: item.y}
    //       let zoneTopRigth = {x: item.x + item.width, y: item.y}
    //       let zoneBottomRight = {x: item.x + item.width, y: item.y+ item.height}
    //       console.log(rectangle);
    //       if (
    //         (rectTopLeft.x >= zoneTopLeft.x && rectTopLeft.x <= zoneTopRigth.x) && (rectTopLeft.y >= zoneTopLeft.y && rectTopLeft.y <= zoneBottomRight.y) ||
    //         (rectTopRigth.x >= zoneTopLeft.x && rectTopRigth.x <= zoneTopRigth.x) && (rectTopRigth.y >= zoneTopLeft.y && rectTopRigth.y <= zoneBottomRight.y) ||
    //         (rectBottomLeft.x >= zoneTopLeft.x && rectBottomLeft.x <= zoneTopRigth.x) && (rectBottomLeft.y >= zoneTopLeft.y && rectBottomLeft.y <= zoneBottomRight.y) ||
    //         (rectBottomRight.x >= zoneTopLeft.x && rectBottomRight.x <= zoneTopRigth.x) && (rectBottomRight.y >= zoneTopLeft.y && rectBottomRight.y <= zoneBottomRight.y)
    //         ) {
    //         rackZones.push(item.title)
    //         rect.zone = rackZones

    //         console.log(Stage)
    //         console.log(Layer)
    //       }
    //     }
    //   })
    // }

    const [rackTypeChange, setRackType] = useState(null)
    const rackType = (e) => {
      setRackType(e.target.value)
    }
    
    const [selectedRackObj, setSelectedRackObj] = useState(null)
    const selectedRack = (selected) => {
      setSelectedRackObj(selected)
      console.log(selectedRackObj);
    }
    const selectedNone = () => {
      setSelectedRackObj(null)
      console.log(selectedRackObj);
    }
    
    const [figureIndex, setFigureIndex] = useState(null)
    let [figureObj, setFigureObj] = useState(null)
    const getFigure = (i, rect) => {
      let val = i
      let obj = rect
      setFigureIndex(val)
      setFigureObj(obj)
    }

    const [warehouseName, setWarehouseName] = useState({
      name: 'Склад'
    })

    const [ warehouseNameState, setWarehouseNameState ] = useState(false)
    const warehouseNameRef = useRef()

    const showWarehouseNameArea = () => {
      setWarehouseNameState(!warehouseNameState)
    }
    const updateWarehouseName = () => {
      setWarehouseName(warehouseNameRef.current.value)
      setWarehouseNameState(!warehouseNameState)
      constructorJSON.name = warehouseNameRef.current.value
    }

    useEffect( () => {
      const handleKeyDown = (e) => {
        if (e.key === 'Delete' && figureIndex !== null) {
          const newRectangles = [...rectangle];
          newRectangles.splice(figureIndex, 1)
          setRectangle(newRectangles);
          setFigureIndex(prev => {return null});
          console.log(figureObj.name);
          if (figureObj.name === 'window') {
            dispatch(deleteFigure('windows', [figureObj.id]))
          }
          if (figureObj.name === 'zone') {
            dispatch(deleteFigure('zones', [figureObj.id]))
          }
          if (figureObj.name === 'door') {
            dispatch(deleteFigure('doorways', [figureObj.id]))
          }
          if (figureObj.name === 'wall') {
            dispatch(deleteFigure('walls', [figureObj.id]))
          }
          if (figureObj.name === 'shelv') {
            if (!figureObj.item_attributes.length) {
              dispatch(deleteFigure('shelves', [figureObj.id]))
            } else {
              toast('На стеллаже есть номенклатура. Удаление не возможно')
            }
          }
        }
      };
      
      window.addEventListener('keydown', handleKeyDown);
      return () => {
        window.removeEventListener('keydown', handleKeyDown);
      };

      
    }, [figureIndex, rectangle, figureObj])

    const patchFigure = async (figure) => {
      if (figure.name === 'wall') {
        dispatch(updateWalls({id: location.state.id, walls: [figure]}))
      }
      if (figure.name === 'window') {
        dispatch(updateWindow({id: location.state.id, windows: [figure]}))
      }
      if (figure.name === 'door') {
        dispatch(updateDoor({id: location.state.id, doorways: [figure]}))
      }
      if (figure.name === 'zone') {
        dispatch(updateZone({id: location.state.id, zones: [figure]}))
      }
      if (figure.name === 'shelv') {
        dispatch(updateShelves({id: location.state.id, shelves: [figure]}))
      }
    }

    return (
        <div className="app">
            <div ref={square} className='square'></div>
            <div className="plane">
                <div className="plane-nav">
                    <button className="zoomIn" data-type="in" onClick={zoomIn} disabled={zoom > 1.5}>+</button>
                    <button className="zoomOut" data-type="out" onClick={zoomOut} disabled={zoom < 0.45}>-</button>
                    { selectedRackObj !== null && selectedRackObj.shelf_level > 1 ? <div><button className="zoomIn" data-type="in" onClick={zoomIn}>+1</button> <br /> <br />
                    <button className="zoomOut" data-type="out" onClick={zoomOut}>-1</button></div> : '' }
                    <div className="zoomValue">{zoom.toFixed(2)}</div>
                </div>
                <Stage name={warehouseName} width={10000} height={10000} className='plane-area' onMouseDown={checkDeselect} onTouchStart={checkDeselect} style={zoomStyle} onDblClick={test} onClick={selectedNone}>
                    <Layer>
                    {rectangle.map((rect, i) => {
                      return (
                        <Rectangle
                          data={rect}
                          key={i}
                          shapeProps={rect}
                          isSelected={rect.id === selectedId}
                          onSelect={() => {
                            selectShape(rect.id);
                            selectedRack(rect)
                            getFigure(i, rect)
                          }}
                          stroke="black"
                          strokeWidth={1}
                          onChange={(newAttrs) => {
                            const rects = rectangle.slice();
                            rects[i] = newAttrs;
                            setRectangle(rects);
                            rectangle[i] = newAttrs
                            patchFigure(newAttrs)
                            // addedZone(rectangle[i])
                          }}
                        />
                      );
                    })}
                    </Layer>
                </Stage>
            </div>
            <div className="plane-right">
                <div className="plane-functions">
                    <button className="grid-config" onClick={showWarehouseNameArea}>Название склада</button>
                    <button className="grid-config" onClick={showGridSize}>Задать сетку</button>
                    <button className="add-wall" onClick={addWall}>Добавить стену</button>
                    <button className="add-opening" onClick={addDoorways}>Добавить проем</button>
                    <button className="add-window" onClick={addWindow}>Добавить окно</button>
                    <button className="add-zone" onClick={showZone}>Добавить зону</button>
                    <button className="add-rack" onClick={showRack}>Добавить стеллаж</button>
                    <button onClick={createSklad}>Заврешить</button>
                </div>
                <div className={warehouseNameState ? 'input-area grid-input active' : 'input-area grid-input'}>
                    <p>Название склада</p>
                    <div>
                        <input type="text" ref={warehouseNameRef}/>
                        <button className="plane-right__btn" onClick={updateWarehouseName}>Сохранить</button>
                    </div>
                </div>
                <div className={gridState ? 'input-area grid-input active' : 'input-area grid-input'}>
                    <p>Задать размер одной сетки (квадрат)</p>
                    <div>
                        <input type="text" ref={gridSizeInput}/>
                        <button className="plane-right__btn" onClick={gridSizeSet}>Сохранить</button>
                    </div>
                </div>
                <div className={zoneState ? 'input-area zone-input active' : 'input-area zone-input'}>
                    <div>
                        <p>Название зоны</p>
                        <input className="zone-name" name='title' value={Zone.title} onChange={handleChange} type="text"/>
                    </div>
                    <div>
                        <p>Цвет зоны</p>
                        <input className="zone-color" name='fill' value={Zone.fill} onChange={handleChange} type="color"/>
                    </div>
                    <div>
                        <p>Описание зоны</p>
                        <input className="zone-descr" name='description' value={Zone.description} onChange={handleChange} type="text"/>
                    </div>
                    <button className="plane-right__btn" onClick={addZone}>
                        Добавить
                    </button>
                </div>
                <div className={rackState ? 'input-area rack-input active' : 'input-area rack-input'}>
                    <div>
                      <p>Единичный или множество</p>
                      <select onChange={handleCountChange}>
                        <option value="1">Единичный стеллаж</option>
                        <option value="2">Множество стеллажей</option>
                      </select>
                    </div>
                    { countChange === '2' ? <>
                      <div>
                        <p>Направление</p>
                        <select onChange={handleDirection}>
                          <option value="1">По горизонтали</option>
                          <option value="2">По вертикали</option>
                        </select>
                      </div>
                      <div>
                        <p>Количество</p>
                        <input type="text" ref={rectCount}/>
                      </div>
                    </> : '' }
                    <div>
                        <p>Идентификтор стелажа</p>
                        <input type="text"name="rack_id" value={Rack.rack_id} onChange={handleChangeRack} />
                    </div>
                    {rackTypeChange == '2' ? <div>
                        <p>Количество ячеек в ширину</p>
                        <input type="text" name="cells_per_width" value={Rack.cells_per_width} onChange={handleChangeRack}/>
                    </div> : '' }
                    { rackTypeChange == '2' ? <div>
                        <p>Количество ячеек в глубину</p>
                        <input type="text" name="cells_per_depth" value={Rack.cells_per_depth} onChange={handleChangeRack}/>
                    </div>: '' }
                    {rackTypeChange == '2' ? <div>
                        <p>Высота ячейки</p>
                        <input type="text" name="rack_height" value={Rack.rack_height} onChange={handleChangeRack}/>
                    </div>: ''}
                    {rackTypeChange == '2' ? <div>
                        <p>Ширина ячейки</p>
                        <input type="text" name="rack_height"/>
                    </div>: ''}
                    {rackTypeChange == '2' ? <div>
                        <p>Глубина ячейки</p>
                        <input type="text" name="rack_height"/>
                    </div>: ''}
                    { rackTypeChange == '2' ? <div>
                        <p>Количество уровней</p>
                        <input type="text" name="shelf_level" value={Rack.shelf_level} onChange={handleChangeRack}/>
                    </div>: '' }
                    <div>
                        <p>Тип</p>
                        <select name="zone" onChange={rackType}>
                            <option value="0">Укажите тип</option>
                            <option value="1">паллетоместо (плоское)</option>
                            <option value="2">Стеллаж (многоуровненвый)</option>
                        </select>
                    </div>
                    <button className="plane-right__btn" onClick={addRack}>
                        Добавить ячейку
                    </button>
                </div>
            </div>
        </div>
    )
}

export default ConstruktorEdit