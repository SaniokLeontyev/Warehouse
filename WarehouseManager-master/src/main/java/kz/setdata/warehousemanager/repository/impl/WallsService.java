package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.Walls;
import kz.setdata.warehousemanager.repository.WallsRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class WallsService {
    private final WallsRepository wallsRepository;

    public WallsService(WallsRepository wallsRepository) {
        this.wallsRepository = wallsRepository;
    }

    public List<Walls> getWarehouseWalls(long constructorId){
        return wallsRepository.findAllByConstructor_Id(constructorId);
    }

    public List<Walls> getAll(){
        return (List<Walls>) wallsRepository.findAll();
    }

    @Transactional
    public List<Walls> saveWalls(List<Walls> walls){
        return (List<Walls>) wallsRepository.saveAll(walls);
    }

    public boolean checkIfPossibleAddWallByCoordinates(Walls walls, long constructorId){
        return wallsRepository.existsAllByConstructor_IdAndCoordinateXAndCoordinateY(
                constructorId, walls.getCoordinateX(), walls.getCoordinateY());
    }

    public List<Walls> updateWalls(List<Walls> walls){
        walls.removeIf(wall -> !wallsRepository.existsById(wall.getId()));
        saveWalls(walls);
        return walls;
    }

    @Transactional
    public void deleteWalls(List<Walls> walls){
        wallsRepository.deleteAll(walls);
    }

    public List<Walls> getAll(List<Long> wallsId){
        return wallsRepository.findAllByIdIn(wallsId);
    }

    @Transactional
    public void delete(long constructorId){
        wallsRepository.deleteAllByConstructor_Id(constructorId);
    }
}
