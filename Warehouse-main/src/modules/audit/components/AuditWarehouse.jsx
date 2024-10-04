import "../../warehouse-managment/managment.css";
import { Stage, Layer, Rect } from "react-konva";
import { useEffect, useState } from "react";
import { fetchSingleWarehouse } from '../../../store/actions'
import { useDispatch, useSelector } from "react-redux";

function AudittWarehouse(props) {
  const { onSetClose } = props;
  let singleWare = useSelector(state => state.singleWarehouse)
  const dispatch = useDispatch()
  useEffect( () => {
    dispatch(fetchSingleWarehouse(46))
  }, [])
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

  // stage & modal
  // const [stage, setStage] = useState(wareData);
  const closeModal = () => {
    onSetClose(false);
  };
  // stage & modal

  // shelv click info
  const [shelvData, setShelvData] = useState(null)
  const getShelvAttr = (data) => {
    setShelvData(data)
  }
  // shelv click info

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
          <Stage
            width={10000}
            height={10000}
            className="managment-modal__warehouse"
            style={zoomStyle}
          >
            <Layer>
              { singleWare.walls.length ? singleWare?.walls.map( (item, index) => {
                return <Rect key={index} x={item.x} y={item.y} fill={item.fill} width={item.width} height={item.height}/>
              }) : ''}
              { singleWare.shelves.length ? singleWare?.shelves.map( (item, index) => {
                return <Rect key={index} x={item.x} y={item.y} fill={item.fill} width={item.width} height={item.height} onClick={() => getShelvAttr(item)}/>
              }) : ''}
            </Layer>
          </Stage>
        </div>
        <div className="managment-modal__right">
          { !shelvData?.item_attributes.length ? 'Нет номенклатуры' : shelvData.item_attributes.map( (item, index) => {
            return (
              <div className="managment-modal__right-item" key={index}>
                <span>Тип кондиции</span> : <span>{item.condition_type}</span> <br />
                <span>Номенклатура</span> : <span>{item.nomenclature}</span> <br />
                <span>Количество</span> : <span>{item.quantity}</span> <br />
                <span>Units</span> : <span>{item.units}</span>
              </div>
            )
          })}
        </div>
      </div>
    </div>
  );
}

export default AudittWarehouse;
