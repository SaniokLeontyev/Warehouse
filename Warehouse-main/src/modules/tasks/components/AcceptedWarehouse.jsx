// import './constructor.css'
import { Stage, Layer, Rect, Text } from 'react-konva'
import { useState, useRef, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { fetchSingleWarehouse } from '../../../store/actions';
import { GET_SELECTED_SHELVES } from '../store/constants';
import { createPortal } from 'react-dom'

const Tooltip = ({ x, y, title, description }) => {
  return (
    <div style={{ position: 'absolute', top: y, left: x, backgroundColor: 'white', padding: '5px', border: '1px solid black' }}>
      <div><strong>Название:</strong> {title}</div>
      <div><strong>Описание:</strong> {description}</div>
    </div>
  );
};



function AcceptedWarehouse({id, data, rackId, getAttr}) {
  const [tooltipPosition, setTooltipPosition] = useState({ x: 0, y: 0 });
  const [tooltipContent, setTooltipContent] = useState({ title: '', description: '' });
  const [tooltipVisible, setTooltipVisible] = useState(false);

  const dispatch = useDispatch()
  const warehouse = useSelector(state => state.singleWarehouse)
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


  const getShelvAttr = async (data) => {
    getAttr(data.item_attributes)
  }


  const handleShapeClick = (shapeId, shelv) => {
    const updatedShapes = shelves.map((shape) => ({
      ...shape,
      fill: shape.rack_id === shapeId ? 'green' : 'gray',
    }));
    setShelves(updatedShapes);
    rackId(shapeId);

    dispatch({
      type: GET_SELECTED_SHELVES,
      payload: shelv
    })
  };
    const findRackId = (objectsA, arrayB) => {
      for (const objectA of objectsA) {
          const itemAttributesA = objectA.item_attributes;
          for (const item of itemAttributesA) {
              if (arrayB.some(itemB => itemB.uuid === item.uuid)) {
                  const matchingObject = objectsA.find(obj => obj.rack_id === objectA.rack_id);
                  if (matchingObject) {
                      matchingObject.fill = "blue";
                  }
              }
          }
      }
      
  }
  
  if (shelves && shelves.length) {
      findRackId(shelves, data)
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

    return (
        <div className="apps">
            <div className="planes">
                <div className="plane-nav">
                    <button className="zoomIn" data-type="in" onClick={zoomIn} disabled={zoom > 1.5}>+</button>
                    <button className="zoomOut" data-type="out" onClick={zoomOut} disabled={zoom < 0.45}>-</button>
                    <div className="zoomValue">{zoom.toFixed(2)}</div>
                </div>
                { !id ? '' : <Stage width={10000} height={10000} className='planes-area' style={zoomStyle}>
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
                                opacity={0.5}
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
                                fill={item.fill}
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
                                  text={item.shelf_level > 1 ? `${item.rack_id}.${item.shelf_level}` : `${item.rack_id}`}
                                  fontSize={item.shelf_level > 1 ? 10 : 18}
                                  fill="white"
                                  width={item.width}
                                  height={item.height}
                                  align="center"
                                  verticalAlign="middle"
                                  x={item.x}
                                  y={item.y}
                                  onClick={ () => {
                                    getShelvAttr(item)
                                    handleShapeClick(item.rack_id, item)
                                  }}
                                  rotation={item.rotation}
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
        </div>
    )
}

export default AcceptedWarehouse


