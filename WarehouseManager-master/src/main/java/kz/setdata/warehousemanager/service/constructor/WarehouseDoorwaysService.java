package kz.setdata.warehousemanager.service.constructor;

import kz.setdata.warehousemanager.model.Constructor;
import kz.setdata.warehousemanager.model.Doorways;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.constructor.DoorwaysDTO;
import kz.setdata.warehousemanager.service.mapper.EntityMapper;
import kz.setdata.warehousemanager.service.WarehouseCRUD;
import kz.setdata.warehousemanager.repository.impl.ConstructorService;
import kz.setdata.warehousemanager.repository.impl.DoorwaysService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WarehouseDoorwaysService implements WarehouseCRUD {

    private final DoorwaysService doorwaysService;
    private final ConstructorService constructorService;

    @Override
    public ConstructorDTO getAll() {
        ConstructorDTO constructorDTO = new ConstructorDTO();
        List<DoorwaysDTO> doorwaysList = EntityMapper.mapDoorwaysDTO(doorwaysService.getAll());
        constructorDTO.setDoorways(doorwaysList);
        return constructorDTO;
    }

    @Override
    public ConstructorDTO save(ConstructorDTO constructorDTO, long constructorId) {
        Constructor constructor = constructorService.getById(constructorId);
        List<Doorways> doorways = EntityMapper.mapDoorways(constructorDTO.getDoorways(),constructor);
        doorways.removeIf(doorway -> doorwaysService.checkIfPossibleAddDoorwayByCoordinates(doorway, constructorId));
        doorways = doorwaysService.saveDoorways(doorways);
        List<DoorwaysDTO> doorwaysDTOS = EntityMapper.mapDoorwaysDTO(doorways);
        constructorDTO.setDoorways(doorwaysDTOS);
        return constructorDTO;
    }

    @Override
    public boolean delete(List<Long> doorwaysIds) {
        List<Doorways> doorways = doorwaysService.getAllByIds(doorwaysIds);
        doorwaysService.deleteDoorways(doorways);
        return true;
    }

    @Override
    public ConstructorDTO update(ConstructorDTO constructorDTO) {
        Constructor constructor = constructorService.getById(constructorDTO.getId());
        List<Doorways> doorways = EntityMapper.mapDoorways(constructorDTO.getDoorways(),constructor);
        doorways = doorwaysService.updateDoorways(doorways);
        constructorDTO.setDoorways(EntityMapper.mapDoorwaysDTO(doorways));
        return constructorDTO;
    }
}
