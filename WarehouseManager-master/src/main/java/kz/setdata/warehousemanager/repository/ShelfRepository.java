package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.Shelf;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShelfRepository extends CrudRepository<Shelf,Long> {
    Shelf findAllById(long id);
    Shelf findAllByRackId(String rackId);
    List<Shelf> findAllByConstructorId(long constructorId);
    boolean existsAllByConstructor_IdAndCoordinateXAndCoordinateY(long constructorId, String x, String y);
    List<Shelf> findAllByIdIn(List<Long> ids);
    void deleteAllByConstructor_Id(long constructorId);
    boolean existsAllById(long id);
}
