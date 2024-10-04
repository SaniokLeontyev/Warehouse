package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.ItemAttributes;
import kz.setdata.warehousemanager.model.Shelf;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface ItemAttributesRepository extends CrudRepository<ItemAttributes,Long> {
    List<ItemAttributes> findAllByUuidIsIn(List<String> uuids);
    ItemAttributes findAllById(long id);
    List<ItemAttributes> findAllByNomenclatureLikeIgnoreCase(String name);
    List<ItemAttributes> findAllByIdIn(List<Long> ids);
    ItemAttributes findByUuid(String uuid);
    @Transactional
    @Modifying
    @Query("DELETE FROM ItemAttributes ia WHERE ia.id IN (SELECT s.id FROM Shelf s WHERE s.constructor.id = :id)")
    void deleteItemAttributesByConstructorId(Long id);
}
