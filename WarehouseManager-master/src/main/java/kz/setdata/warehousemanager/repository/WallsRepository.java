package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.Walls;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WallsRepository extends CrudRepository<Walls,Long> {
    List<Walls> findAllByConstructor_Id(long constructorId);
    boolean existsAllByConstructor_IdAndCoordinateXAndCoordinateY(long constructorId,String x, String y);
    boolean existsById(long id);
    List<Walls> findAllByIdIn(List<Long> wallsId);
    void deleteAllByConstructor_Id(long constructorId);
}
