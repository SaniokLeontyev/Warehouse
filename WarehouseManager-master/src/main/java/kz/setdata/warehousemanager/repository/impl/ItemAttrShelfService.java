package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.exception.CRUDOperationException;
import kz.setdata.warehousemanager.model.ItemAttrShelf;
import kz.setdata.warehousemanager.model.Shelf;
import kz.setdata.warehousemanager.model.dto.ItemAttrShelfDTO;
import kz.setdata.warehousemanager.model.dto.MoveItemAttributeDTO;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.constructor.ItemAttributesDTO;
import kz.setdata.warehousemanager.model.dto.constructor.ShelfDTO;
import kz.setdata.warehousemanager.repository.ItemAttrShelfRepository;
import kz.setdata.warehousemanager.service.mapper.EntityMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class ItemAttrShelfService {
    private final ItemAttrShelfRepository itemAttrShelfRepository;
    private final ShelfService shelfService;
    private EntityMapper entityMapper;

    @Autowired
    public void setEntityMapper(EntityMapper entityMapper) {
        this.entityMapper = entityMapper;
    }

    private ItemAttrShelfService itemAttrShelfService;

    @Autowired
    public void setItemAttrShelfService(ItemAttrShelfService itemAttrShelfService) {
        this.itemAttrShelfService = itemAttrShelfService;
    }

    private ItemAttributesService itemAttributesService;

    @Autowired
    private void setItemAttributesService(ItemAttributesService itemAttributesService) {
        this.itemAttributesService = itemAttributesService;
    }

    @Transactional
    public void delete(ItemAttrShelf itemAttrShelf){
        itemAttrShelfRepository.delete(itemAttrShelf);
    }

    @Transactional
    public void delete(List<ItemAttrShelf> itemAttrShelves){
        itemAttrShelfRepository.deleteAll(itemAttrShelves);
    }

    @Transactional
    public void saveItemAttributesShelves(List<ItemAttrShelf> itemAttrShelves){
        itemAttrShelfRepository.saveAll(itemAttrShelves);
    }

    public ItemAttrShelf getById(long id){
        return itemAttrShelfRepository.findAllById(id);
    }

    public List<ItemAttrShelf> getShelfItemAttributesByShelfIds(List<Long> shelves){
        List<Shelf> shelfList = shelfService.getShelves(shelves);
        return itemAttrShelfRepository.findAllByShelves(shelfList);
    }

    public List<ItemAttrShelf> getShelfItemAttributes(long shelfId){
        return itemAttrShelfRepository.findAllByShelvesId(shelfId);
    }

    public ItemAttrShelf findByUuid(String uuid){
        return itemAttrShelfRepository.findAllByItemAttributesUuid(uuid);
    }

    @Transactional
    public void delete(long constructorId){
        itemAttrShelfRepository.deleteItemAttributesShelvesByConstructorId(constructorId);
    }

    public List<ItemAttrShelf> getAllByIds(List<Long> ids){
        return itemAttrShelfRepository.findAllByIdIn(ids);
    }

    @Transactional
    public ItemAttrShelf save(ItemAttrShelf itemAttrShelf){
        return itemAttrShelfRepository.save(itemAttrShelf);
    }

    public List<ItemAttributesDTO> getByNamed(String name){
        List<ItemAttrShelf> itemAttrShelves = itemAttrShelfRepository.findAllByItemAttributesNomenclatureIgnoreCase(name);
        return EntityMapper.mapItemAttributesDTOList(itemAttrShelves);
    }

    @Transactional
    public List<ItemAttrShelf> saveItemAttributesShelvesList(List<ItemAttrShelf> itemAttrShelves){
        return (List<ItemAttrShelf>) itemAttrShelfRepository.saveAll(itemAttrShelves);
    }

    public List<ItemAttrShelf> saveItemAttrShelves(ConstructorDTO constructorDTO){
        List<ItemAttrShelf> itemAttrShelves = new ArrayList<>();
        for (ShelfDTO shelfDTO : constructorDTO.getShelves()) {
            if (shelfDTO.getItemAttributes()!=null && !shelfDTO.getItemAttributes().isEmpty()) {
                itemAttrShelves.addAll(entityMapper.mapItemAttributesList(shelfDTO.getItemAttributes(), shelfDTO.getRackId()));
            }
        }
        return itemAttrShelfService.saveItemAttributesShelvesList(itemAttrShelves);
    }


    public List<ItemAttrShelf> updateItemAttributes(List<ItemAttrShelf> itemAttrShelves){
        itemAttrShelves.removeIf(itemAttribute -> !itemAttrShelfRepository.existsById(itemAttribute.getId()));
        itemAttrShelfService.saveItemAttributesShelvesList(itemAttrShelves);
        return itemAttrShelves;
    }

    public ItemAttrShelfDTO moveItemAttrs(MoveItemAttributeDTO moveItemAttributeDTO){
        Shelf shelf = shelfService.getShelfById(moveItemAttributeDTO.getToShelfId());
        if (shelf!=null){
            ItemAttrShelf itemAttrShelf = getById(moveItemAttributeDTO.getId());
            itemAttrShelf.setShelves(shelf);
            return EntityMapper.mapItemAttrShelf(itemAttrShelfService.save(itemAttrShelf));
        }else {
            throw new CRUDOperationException("Shelf with this id does not exist: " + moveItemAttributeDTO.getToShelfId());
        }
    }

    @Transactional
    public void deleteItemAttributes(List<ItemAttrShelf> itemAttrShelves){
        itemAttrShelfRepository.deleteAll(itemAttrShelves);
    }

    public List<ItemAttrShelf> getByName(String name){
        return itemAttrShelfRepository.findAllByItemAttributesNomenclatureIgnoreCase(name);
    }

    public ItemAttrShelf create(ItemAttrShelfDTO itemAttrShelfDTO){
        if (itemAttributesService.checkIfItemAttributeQuantityIsHigher(
                itemAttrShelfDTO.getItemAttributeId(),
                itemAttrShelfDTO.getQuantity())){
            ItemAttrShelf itemAttrShelf = entityMapper.mapItemAttrShelfDTO(itemAttrShelfDTO);
            return itemAttrShelfService.save(itemAttrShelf);
        }
        throw new CRUDOperationException(
                String.format("Quantity of nomenclature id %s is to high",itemAttrShelfDTO.getItemAttributeId()));
    }
}
