package kz.setdata.warehousemanager.repository;

import kz.setdata.warehousemanager.model.Constructor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
public interface ConstructorRepository extends CrudRepository<Constructor,Long> {
    Constructor findAllById(long id);

    @Transactional
    @Modifying
    @Query(value =
            "WITH deleted_task_files AS (" +
                    "    DELETE FROM task_file WHERE task_id IN (" +
                    "        SELECT t.id FROM tasks t WHERE t.constructor_id = :constructorId" +
                    "    ) RETURNING task_id" +
                    "), " +
                    "deleted_task_nomenclature AS (" +
                    "    DELETE FROM task_nomenclature WHERE item_attribute_shelf_id IN (" +
                    "        SELECT ias.id FROM item_attr_shelves ias " +
                    "        JOIN shelves s ON ias.shelf_id = s.id WHERE s.constructor_id = :constructorId" +
                    "    ) RETURNING item_attribute_shelf_id" +
                    "), " +
                    "deleted_tasks AS (" +
                    "    DELETE FROM tasks WHERE constructor_id = :constructorId RETURNING id" +
                    "), " +
                    "deleted_item_attributes AS (" +
                    "    DELETE FROM item_attributes WHERE id IN (" +
                    "        SELECT ias.item_attr_id FROM item_attr_shelves ias " +
                    "        JOIN shelves s ON ias.shelf_id = s.id WHERE s.constructor_id = :constructorId" +
                    "    ) RETURNING id" +
                    "), " +
                    "deleted_item_attr_shelves AS (" +
                    "    DELETE FROM item_attr_shelves WHERE shelf_id IN (" +
                    "        SELECT s.id FROM shelves s WHERE s.constructor_id = :constructorId" +
                    "    ) RETURNING shelf_id" +
                    "), " +
                    "deleted_shelves AS (" +
                    "    DELETE FROM shelves WHERE constructor_id = :constructorId RETURNING id" +
                    "), " +
                    "deleted_zone_shelves AS (" +
                    "    DELETE FROM zone_shelves WHERE zone_id IN (" +
                    "        SELECT z.id FROM zones z WHERE z.constructor_id = :constructorId" +
                    "    ) RETURNING zone_id" +
                    "), " +
                    "deleted_windows AS (" +
                    "    DELETE FROM windows WHERE constructor_id = :constructorId RETURNING id" +
                    "), " +
                    "deleted_walls AS (" +
                    "    DELETE FROM walls WHERE constructor_id = :constructorId RETURNING id" +
                    "), " +
                    "deleted_doorways AS (" +
                    "    DELETE FROM doorways WHERE constructor_id = :constructorId RETURNING id" +
                    "), " +
                    "deleted_zones AS (" +
                    "    DELETE FROM zones WHERE constructor_id = :constructorId RETURNING id" +
                    ") " +
                    "DELETE FROM constructor WHERE id = :constructorId",
            nativeQuery = true
    )
    void deleteConstructor(Long constructorId);

}
