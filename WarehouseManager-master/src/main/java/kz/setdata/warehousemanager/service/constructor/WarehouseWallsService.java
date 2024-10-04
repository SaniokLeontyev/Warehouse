package kz.setdata.warehousemanager.service.constructor;

import kz.setdata.warehousemanager.model.Constructor;
import kz.setdata.warehousemanager.model.Walls;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.constructor.WallsDTO;
import kz.setdata.warehousemanager.service.mapper.EntityMapper;
import kz.setdata.warehousemanager.service.WarehouseCRUD;
import kz.setdata.warehousemanager.repository.impl.ConstructorService;
import kz.setdata.warehousemanager.repository.impl.WallsService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WarehouseWallsService implements WarehouseCRUD {

    private final WallsService wallsService;
    private final ConstructorService constructorService;

    @Override
    public ConstructorDTO getAll() {
        ConstructorDTO constructorDTO = new ConstructorDTO();
        List<WallsDTO> wallsDTOList = EntityMapper.mapWallsDTO(wallsService.getAll());
        constructorDTO.setWalls(wallsDTOList);
        return constructorDTO;
    }

    @Override
    public ConstructorDTO save(ConstructorDTO constructorDTO, long constructorId) {
        Constructor constructor = constructorService.getById(constructorId);
        List<Walls> walls = EntityMapper.mapWalls(EntityMapper.nullifyWallsDtoIds(constructorDTO.getWalls()), constructor);
        walls.removeIf(wall -> wallsService.checkIfPossibleAddWallByCoordinates(wall, constructorId));
        walls = wallsService.saveWalls(walls);
        List<WallsDTO> wallsDTOS = EntityMapper.mapWallsDTO(walls);
        constructorDTO.setWalls(wallsDTOS);
        return constructorDTO;
    }

    @Override
    public boolean delete(List<Long> wallsIds) {
        List<Walls> walls = wallsService.getAll(wallsIds);
        wallsService.deleteWalls(walls);
        return true;
    }

    @Override
    public ConstructorDTO update(ConstructorDTO constructorDTO) {
        Constructor constructor = constructorService.getById(constructorDTO.getId());
        List<Walls> walls = EntityMapper.mapWalls(constructorDTO.getWalls(),constructor);
        walls = wallsService.updateWalls(walls);
        constructorDTO.setWalls(EntityMapper.mapWallsDTO(walls));
        return constructorDTO;
    }
}
