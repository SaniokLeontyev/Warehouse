package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.Zone;
import kz.setdata.warehousemanager.repository.ZoneRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
public class ZoneService {

    private final ZoneRepository zoneRepository;

    public ZoneService(ZoneRepository zoneRepository) {
        this.zoneRepository = zoneRepository;
    }

    public List<Zone> getWarehouseZones(long constructorId){
        return zoneRepository.findAllByConstructor_Id(constructorId);
    }

    public Zone getByName(String zoneName){
        return zoneRepository.findAllByName(zoneName);
    }

    @Transactional
    public List<Zone> saveZones(List<Zone> zones){
        return (List<Zone>) zoneRepository.saveAll(zones);
    }

    public boolean checkIfPossibleAddZoneByCoordinates(Zone zone, long constructorId){
        return zoneRepository.existsAllByConstructor_IdAndCoordinateXAndCoordinateY(
                constructorId, zone.getCoordinateX(), zone.getCoordinateY());
    }

    public Zone getById(long id){
        return zoneRepository.findAllById(id);
    }

    public List<String> getShelfZoneNames(List<Integer> zoneIds){
        List<String> zones = new ArrayList<>();
        for (Integer zoneId : zoneIds){
            zones.add(getById(zoneId).getName());
        }
        return zones;
    }

    public List<Zone> getAll(){
        return (List<Zone>) zoneRepository.findAll();
    }

    @Transactional
    public void deleteZones(List<Zone> zones){
        zoneRepository.deleteAll(zones);
    }

    @Transactional
    public List<Zone> updateZones(List<Zone> zones){
        zones.removeIf(zone -> !zoneRepository.existsById(zone.getId()));
        saveZones(zones);
        return zones;
    }

    public List<Zone> getAll(List<Long> zoneIds){
        return zoneRepository.findAllByIdIn(zoneIds);
    }

    @Transactional
    public void delete(long constructorId){
        zoneRepository.deleteAllByConstructor_Id(constructorId);
    }
}
