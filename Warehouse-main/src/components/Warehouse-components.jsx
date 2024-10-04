import './constructor.css'
import { Stage, Layer, Rect, Text } from "react-konva";
import { useEffect, useState, useRef } from "react";
import { fetchSingleWarehouse } from '../store/actions'
import { useDispatch, useSelector } from "react-redux";


function WarehouseComponent({id, pick, pickedRack}) {
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


  const closeModal = () => {
    onSetClose(false);
  };
  // stage & modal

  // shelv click info
  const [shelvData, setShelvData] = useState(null)
  const getShelvAttr = (data) => {
    setShelvData(data);
    pick(prevPick => {
      const isPicked = prevPick.find(item => item.rack_id === data.rack_id);
      if (isPicked) {
        return prevPick.filter(item => item.rack_id !== data.rack_id);
      } else {
        return [...prevPick, data];
      }
    });
  };
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
  }

  useEffect(() => {
    if (shelvData) {
      const root = document.documentElement;
      root.style.setProperty('--cells-per-width', shelvData?.cells_per_width);
    }
  }, [shelvData?.cells_per_width]);

    return (
        <div className="apps apps4">
            <div className="planes">
                <div className="plane-nav">
                    <button className="zoomIn" data-type="in" onClick={zoomIn} disabled={zoom > 1.5}>+</button>
                    <button className="zoomOut" data-type="out" onClick={zoomOut} disabled={zoom < 0.45}>-</button>
                    <div className="zoomValue">{zoom.toFixed(2)}</div>
                </div>
                <Stage width={10000} height={10000} className="managment-modal__warehouse" style={zoomStyle}>
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
                                opacity={item.opacity}
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
                                stroke="black"
                                strokeWidth={1}
                                key={index}
                                x={item.x}
                                y={item.y}
                                fill={pickedRack.some(rack => rack.rack_id === item.rack_id) ? 'green' : 'gray'}
                                width={item.width}
                                height={item.height}
                                onClick={ () => {
                                  getShelvAttr(item)
                                }}
                                rotation={item.rotation}
                              />
                              <Text
                                  text={item.title || item.rack_id}
                                  fontSize={item.shelf_level > 1 ? 12 : 20}
                                  fill="white"
                                  width={item.width}
                                  height={item.height}
                                  align="center"
                                  verticalAlign="middle"
                                  x={item.x}
                                  y={item.y}
                                  onClick={ () => {
                                    getShelvAttr(item)
                                    handleShapeClick(item.rack_id)
                                  }}
                                  rotation={item.rotation}
                              />
                            </>
                        )
                    }) : '' }
                </Layer>
            </Stage>
            </div>
        </div>
    )
}

export default WarehouseComponent


