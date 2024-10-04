package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.Shelf;
import kz.setdata.warehousemanager.model.Windows;
import kz.setdata.warehousemanager.model.Zone;
import kz.setdata.warehousemanager.repository.ShelfRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class ShelfService {

    private final ShelfRepository shelfRepository;

    public ShelfService(ShelfRepository shelfRepository) {
        this.shelfRepository = shelfRepository;
    }

    @Transactional
    public List<Shelf> saveShelves(List<Shelf> shelves){
        return (List<Shelf>) shelfRepository.saveAll(shelves);
    }

    public Shelf getShelfById(long id){
        return shelfRepository.findAllById(id);
    }

    public Shelf getShelfByRackId(String rackId){
        return shelfRepository.findAllByRackId(rackId);
    }

    public List<Shelf> getAllByConstructorId(long constructorId){
        return shelfRepository.findAllByConstructorId(constructorId);
    }

    public boolean checkIfPossibleAddShelfByCoordinates(Shelf shelf, long constructorId){
        return shelfRepository.existsAllByConstructor_IdAndCoordinateXAndCoordinateY(
                constructorId, shelf.getCoordinateX(), shelf.getCoordinateY());
    }

    public boolean checkIfPossibleAddWindowByCoordinates(Windows windows, long constructorId){
        return shelfRepository.existsAllByConstructor_IdAndCoordinateXAndCoordinateY(
                constructorId, windows.getCoordinateX(), windows.getCoordinateY());
    }

    public List<Shelf> getAll(){
        return (List<Shelf>) shelfRepository.findAll();
    }

    @Transactional
    public void deleteShelves(List<Shelf> shelves){
        shelfRepository.deleteAll(shelves);
    }

    @Transactional
    public List<Shelf> updateShelves(List<Shelf> shelves){
        shelves.removeIf(shelf -> !shelfRepository.existsById(shelf.getId()));
        saveShelves(shelves);
        return shelves;
    }

    public List<Shelf> getShelves(List<Long> shelfIds){
        return shelfRepository.findAllByIdIn(shelfIds);
    }

    @Transactional
    public void delete(long constructorId){
        shelfRepository.deleteAllByConstructor_Id(constructorId);
    }

    public boolean existsById(long id){
        return shelfRepository.existsById(id);
    }
}
