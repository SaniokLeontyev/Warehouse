package kz.setdata.warehousemanager.service.constructor;

import kz.setdata.warehousemanager.model.Constructor;
import kz.setdata.warehousemanager.model.Zone;
import kz.setdata.warehousemanager.model.ZoneShelves;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.constructor.ZoneDTO;
import kz.setdata.warehousemanager.repository.impl.ZoneShelvesService;
import kz.setdata.warehousemanager.service.mapper.EntityMapper;
import kz.setdata.warehousemanager.service.WarehouseCRUD;
import kz.setdata.warehousemanager.repository.impl.ConstructorService;
import kz.setdata.warehousemanager.repository.impl.ZoneService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class WarehouseZoneService implements WarehouseCRUD {

    private final ZoneService zoneService;
    private final ConstructorService constructorService;
    private final EntityMapper entityMapper;
    private final ZoneShelvesService zoneShelvesService;

    @Override
    public ConstructorDTO getAll() {
        ConstructorDTO constructorDTO = new ConstructorDTO();
        List<ZoneDTO> zoneDTOS = entityMapper.mapZoneDTOList(zoneService.getAll());
        constructorDTO.setZones(zoneDTOS);
        return constructorDTO;
    }

    @Override
    public ConstructorDTO save(ConstructorDTO constructorDTO, long constructorId) {
        Constructor constructor = constructorService.getById(constructorId);
        List<Zone> zones = entityMapper.mapZones(constructorDTO.getZones(),constructor);
        zones.removeIf(zone -> zoneService.checkIfPossibleAddZoneByCoordinates(zone, constructorId));
        zones = zoneService.saveZones(zones);
        List<ZoneDTO> zoneDTOS = entityMapper.mapZoneDTOList(zones);
        constructorDTO.setZones(zoneDTOS);
        return constructorDTO;
    }

    @Override
    public boolean delete(List<Long> zoneIds) {
        List<Zone> zones = zoneService.getAll(zoneIds);
        List<ZoneShelves> zoneShelves = new ArrayList<>();
        for (Zone zone : zones){
            zoneShelves.addAll(zoneShelvesService.getZoneShelvesByZoneId(zone.getId()));
        }
        zoneShelvesService.delete(zoneShelves);
        zoneService.deleteZones(zones);
        return true;
    }

    @Override
    public ConstructorDTO update(ConstructorDTO constructorDTO) {
        Constructor constructor = constructorService.getById(constructorDTO.getId());
        List<Zone> zones = entityMapper.mapZones(constructorDTO.getZones(),constructor);
        zones = zoneService.updateZones(zones);
        constructorDTO.setZones(entityMapper.mapZoneDTOList(zones));
        return constructorDTO;
    }
}
