package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.Doorways;
import kz.setdata.warehousemanager.model.Windows;
import kz.setdata.warehousemanager.repository.DoorwaysRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class DoorwaysService {

    private final DoorwaysRepository doorwaysRepository;

    public DoorwaysService(DoorwaysRepository doorwaysRepository) {
        this.doorwaysRepository = doorwaysRepository;
    }

    public List<Doorways> getWarehouseDoorways(long constructorId){
        return doorwaysRepository.findAllByConstructor_Id(constructorId);
    }

    @Transactional
    public List<Doorways> saveDoorways(List<Doorways> doorways){
        return (List<Doorways>) doorwaysRepository.saveAll(doorways);
    }

    public boolean checkIfPossibleAddDoorwayByCoordinates(Doorways doorways, long constructorId){
        return doorwaysRepository.existsAllByConstructor_IdAndCoordinateXAndCoordinateY(
                constructorId, doorways.getCoordinateX(), doorways.getCoordinateY());
    }

    public List<Doorways> getAll(){
        return (List<Doorways>) doorwaysRepository.findAll();
    }

    @Transactional
    public void deleteDoorways(List<Doorways> doorways){
        doorwaysRepository.deleteAll(doorways);
    }

    @Transactional
    public List<Doorways> updateDoorways(List<Doorways> doorways){
        doorways.removeIf(doorway -> !doorwaysRepository.existsById(doorway.getId()));
        saveDoorways(doorways);
        return doorways;
    }

    public List<Doorways> getAllByIds(List<Long> ids){
        return doorwaysRepository.findAllByIdIn(ids);
    }

    @Transactional
    public void delete(long constructorId){
        doorwaysRepository.deleteAllByConstructor_Id(constructorId);
    }
}
