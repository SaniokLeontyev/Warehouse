package kz.setdata.warehousemanager.service.constructor;

import kz.setdata.warehousemanager.model.Constructor;
import kz.setdata.warehousemanager.model.Shelf;
import kz.setdata.warehousemanager.model.ZoneShelves;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.constructor.ShelfDTO;
import kz.setdata.warehousemanager.repository.impl.*;
import kz.setdata.warehousemanager.service.mapper.EntityMapper;
import kz.setdata.warehousemanager.service.WarehouseCRUD;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class WarehouseShelvesService implements WarehouseCRUD {

    private final ShelfService shelfService;

    private final ConstructorService constructorService;
    private final EntityMapper entityMapper;
    private final ZoneShelvesService zoneShelvesService;

    private ItemAttrShelfService itemAttrShelfService;

    @Autowired
    public void setItemAttrShelfService(ItemAttrShelfService itemAttrShelfService) {
        this.itemAttrShelfService = itemAttrShelfService;
    }

    @Override
    public ConstructorDTO getAll() {
        ConstructorDTO constructorDTO = new ConstructorDTO();
        List<ShelfDTO> shelfDTOS = entityMapper.mapShelfDTOList(shelfService.getAll());
        constructorDTO.setShelves(shelfDTOS);
        return constructorDTO;
    }

    @Override
    public ConstructorDTO save(ConstructorDTO constructorDTO, long constructorId) {
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

    @Override
    public boolean delete(List<Long> shelfIds) {
        List<Shelf> shelves = shelfService.getShelves(shelfIds);
        List<ZoneShelves> zoneShelves = new ArrayList<>();
        for (Shelf shelf : shelves){
            zoneShelves.addAll(zoneShelvesService.getZoneShelvesByShelfId(shelf.getId()));
        }
        zoneShelvesService.delete(zoneShelves);
        shelfService.deleteShelves(shelves);
        return true;
    }

    @Override
    public ConstructorDTO update(ConstructorDTO constructorDTO) {
        Constructor constructor = constructorService.getById(constructorDTO.getId());
        List<Shelf> shelves = EntityMapper.mapShelves(constructorDTO.getShelves(),constructor);
        shelves = shelfService.updateShelves(shelves);
        constructorDTO.setShelves(entityMapper.mapShelfDTOList(shelves));
        return constructorDTO;
    }
}
