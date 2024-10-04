package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.ItemAttrShelf;
import kz.setdata.warehousemanager.model.Shelf;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface ItemAttrShelfRepository extends CrudRepository<ItemAttrShelf, Long> {
    List<ItemAttrShelf> findAllByShelvesId(long shelfId);
    ItemAttrShelf findAllById(long id);
    List<ItemAttrShelf> findAllByItemAttributesNomenclatureIgnoreCase(String name);
    List<ItemAttrShelf> findAllByIdIn(List<Long> ids);
    ItemAttrShelf findAllByItemAttributesUuid(String uuid);
    @Transactional
    @Modifying
    @Query("DELETE FROM ItemAttrShelf ias WHERE ias.shelves.id IN (SELECT s.id FROM Shelf s WHERE s.constructor.id = :id)")
    void deleteItemAttributesShelvesByConstructorId(Long id);

    @Query("SELECT i FROM ItemAttrShelf i WHERE i.shelves in :shelves")
    List<ItemAttrShelf> findAllByShelves(List<Shelf> shelves);
}
