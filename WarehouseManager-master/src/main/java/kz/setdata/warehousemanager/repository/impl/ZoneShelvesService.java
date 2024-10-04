package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.Constructor;
import kz.setdata.warehousemanager.model.Shelf;
import kz.setdata.warehousemanager.model.Zone;
import kz.setdata.warehousemanager.model.ZoneShelves;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.constructor.ShelfDTO;
import kz.setdata.warehousemanager.repository.ZoneShelvesRepository;
import kz.setdata.warehousemanager.service.mapper.EntityMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ZoneShelvesService {

    private final ZoneShelvesRepository zoneShelvesRepository;
    private final ZoneService zoneService;

    public List<ZoneShelves> getZoneShelvesByZoneId(long zoneId){
        return zoneShelvesRepository.findAllByZoneId(zoneId);
    }

    public List<ZoneShelves> getZoneShelvesByShelfId(long shelfId){
        return zoneShelvesRepository.findAllByShelfId(shelfId);
    }

    public List<String> getZoneShelvesNamesByShelfId(long shelfId){
        List<ZoneShelves> zoneShelves = zoneShelvesRepository.findAllByShelfId(shelfId);
        List<String> shelfZoneNames = new ArrayList<>();
        for (ZoneShelves zoneShelf : zoneShelves){
            shelfZoneNames.add(zoneShelf.getZone().getName());
        }
        return shelfZoneNames;
    }

    public List<ZoneShelves> getZoneShelves(Zone zone, List<ShelfDTO> shelfDTOs, Constructor constructor){
        List<ZoneShelves> zoneShelves = new ArrayList<>();
        for (Shelf shelf : EntityMapper.mapShelves(shelfDTOs, constructor)){
            zoneShelves.add(new ZoneShelves(zone,shelf));
        }
        return zoneShelves;
    }

    public List<ZoneShelves> saveZoneShelves(Shelf shelf, List<String> zoneNames){
        List<ZoneShelves> zoneShelves = new ArrayList<>();
        for (String zoneName : zoneNames){
            Zone zone = zoneService.getByName(zoneName);
            if (zone != null){
                zoneShelves.add(new ZoneShelves(zone,shelf));
            }
        }
        saveAll(zoneShelves);
        return zoneShelves;
    }

    public List<ZoneShelves> saveZoneShelves(List<Shelf> shelves, ConstructorDTO constructorDTO){
        for (Shelf shelf : shelves){
            Optional<ShelfDTO> matchingShelfDTO = constructorDTO.getShelves().stream()
                    .filter(s -> s.getRackId().equals(shelf.getRackId())).
                    findFirst();
            ShelfDTO shelfDTO = null;
            if (matchingShelfDTO.isPresent()){
                shelfDTO = matchingShelfDTO.get();
            }
            if (shelfDTO!=null
                    && shelfDTO.getZoneNames()!=null
                    && !shelfDTO.getZoneNames().isEmpty()) {
                return saveZoneShelves(shelf,shelfDTO.getZoneNames());
            }
        }
        return null;
    }

    @Transactional
    public void saveAll(List<ZoneShelves> zoneShelves){
        zoneShelvesRepository.saveAll(zoneShelves);
    }

    public void saveZoneShelvesFromDto(Zone zone, List<ShelfDTO> shelfDTOs, Constructor constructor){
        saveAll(getZoneShelves(zone,shelfDTOs,constructor));
    }

    public List<String> getZonesNamesOfShelve(long shelfId){
        List<ZoneShelves> zoneShelves = getZoneShelvesByShelfId(shelfId);
        List<String> zonesNames = new ArrayList<>();
        for (ZoneShelves zoneShelf : zoneShelves){
            zonesNames.add(zoneShelf.getZone().getName());
        }
        return zonesNames;
    }

    @Transactional
    public void delete(List<ZoneShelves> zoneShelves){
        zoneShelvesRepository.deleteAll(zoneShelves);
    }

    @Transactional
    public void delete(long constructorId){
        zoneShelvesRepository.deleteZoneShelvesByConstructorId(constructorId);
    }
}
