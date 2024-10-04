package kz.setdata.warehousemanager.service.constructor;

import kz.setdata.warehousemanager.exception.CRUDOperationException;
import kz.setdata.warehousemanager.model.*;
import kz.setdata.warehousemanager.model.dto.constructor.*;
import kz.setdata.warehousemanager.repository.impl.*;
import kz.setdata.warehousemanager.service.mapper.EntityMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class WarehouseConstructorService {

    private final ConstructorService constructorService;
    private final EntityMapper entityMapper;
    private final WallsService wallsService;
    private final DoorwaysService doorwaysService;
    private final WindowsService windowsService;
    private final ShelfService shelfService;
    private final ZoneService zoneService;

    private final ZoneShelvesService zoneShelvesService;
    private final ItemAttrShelfService itemAttrShelfService;

    public List<ConstructorDTO> getAllWarehouses(){
        List<Constructor> constructors = constructorService.getAll();
        List<ConstructorDTO> constructorDTOS = new ArrayList<>();
        for (Constructor constructor : constructors){
            ConstructorDTO constructorDTO = entityMapper.buildConstructorDTO(constructor);
            constructorDTOS.add(constructorDTO);
        }
        return constructorDTOS;
    }

    public ConstructorDTO getWarehouseById(long warehouseId){
        Constructor constructor = constructorService.getById(warehouseId);
        return entityMapper.buildConstructorDTO(constructor);
    }

    public long saveWarehouse(ConstructorDTO constructorDTO){
        try {
            Constructor constructor = EntityMapper.mapConstructor(constructorDTO);
            constructor = constructorService.save(constructor);
            List<Walls> walls = EntityMapper.mapWalls(EntityMapper.nullifyWallsDtoIds(constructorDTO.getWalls()), constructor);
            wallsService.saveWalls(walls);
            List<Doorways> doorways = EntityMapper.mapDoorways(constructorDTO.getDoorways(), constructor);
            doorwaysService.saveDoorways(doorways);
            List<Windows> windows = EntityMapper.mapWindows(constructorDTO.getWindows(), constructor);
            windowsService.saveWindows(windows);
            //shelfService.saveShelves(shelves);
            List<Zone> zones = entityMapper.mapZones(constructorDTO.getZones(),constructor);
            //zoneService.saveZones(zones);
            for (Zone zone : zones){
                zoneShelvesService.saveZoneShelvesFromDto(
                        zone,EntityMapper.getShelfDtosByZoneName(
                                zone.getName(),constructorDTO.getShelves()), constructor);
            }
            itemAttrShelfService.saveItemAttrShelves(constructorDTO);
            return constructor.getId();
        }catch (Exception exception){
            log.error("[CONSTRUCTOR] Error while saving constructor: {}",exception.getMessage());
            throw new CRUDOperationException("Error while saving constructor: " + exception.getMessage());
        }
    }

    public long saveWarehouseConstructor(ConstructorDTO constructorDTO){
        Constructor constructor = EntityMapper.extractConstructor(constructorDTO);
        constructor.setId(0L);
        return constructorService.save(constructor).getId();
    }

    public ConstructorDTO saveWarehouseZones(ConstructorDTO constructorDTO, long constructorId) throws CRUDOperationException{
        Constructor constructor = constructorService.getById(constructorId);
        List<Zone> zones = entityMapper.mapZones(constructorDTO.getZones(),constructor);
        zones.removeIf(zone -> zoneService.checkIfPossibleAddZoneByCoordinates(zone, constructorId));
        zones = zoneService.saveZones(zones);
        List<ZoneDTO> zoneDTOS = entityMapper.mapZoneDTOList(zones);
        constructorDTO.setZones(zoneDTOS);
        return constructorDTO;
    }

    public ConstructorDTO saveWarehouseShelves(ConstructorDTO constructorDTO, long constructorId) throws CRUDOperationException{
        Constructor constructor = constructorService.getById(constructorId);
        List<Shelf> shelves = EntityMapper.mapShelves(constructorDTO.getShelves(),constructor);
        shelves.removeIf(shelf -> shelfService.checkIfPossibleAddShelfByCoordinates(shelf, constructorId));
        shelves = shelfService.saveShelves(shelves);
        if (!shelves.isEmpty()) {
            itemAttrShelfService.saveItemAttrShelves(constructorDTO);
            zoneShelvesService.saveZoneShelves(shelves,constructorDTO);
        }
        List<ShelfDTO> shelfDTOS = entityMapper.mapShelfDTOList(shelves);
        constructorDTO.setShelves(shelfDTOS);
        return constructorDTO;
    }

    @Transactional
    public boolean delete(long warehouseId){
        Constructor constructor = constructorService.getById(warehouseId);
        if(constructor != null){
            try {
                constructorService.deleteConstructor(warehouseId);
                return true;
            }catch (Exception e){
                return false;
            }
        }
        return false;
    }

}
