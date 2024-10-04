package kz.setdata.warehousemanager.service.constructor;

import kz.setdata.warehousemanager.exception.InternalApplicationException;
import kz.setdata.warehousemanager.model.*;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.constructor.ItemAttributesDTO;
import kz.setdata.warehousemanager.model.dto.constructor.ShelfDTO;
import kz.setdata.warehousemanager.repository.impl.ItemAttrShelfService;
import kz.setdata.warehousemanager.service.mapper.EntityMapper;
import kz.setdata.warehousemanager.service.WarehouseCRUD;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class WarehouseItemAttributesService implements WarehouseCRUD {
    private final ItemAttrShelfService itemAttrShelfService;
    private final EntityMapper entityMapper;

    @Override
    public ConstructorDTO getAll() {
        return null;
    }

    @Override
    public ConstructorDTO save(ConstructorDTO constructorDTO, long constructorId) {
        return null;
    }

    public List<ItemAttributesDTO> saveItemAttrs(ConstructorDTO constructorDTO) {
        try {
            List<ItemAttrShelf> itemAttrShelves = itemAttrShelfService.saveItemAttrShelves(constructorDTO);
            List<ItemAttributesDTO> itemAttributesDTOS = new ArrayList<>();
            for (ItemAttrShelf itemAttrShelf : itemAttrShelves) {
                itemAttributesDTOS.add(EntityMapper.mapItemAttributeDto(itemAttrShelf));
            }
            return itemAttributesDTOS;
        }catch (Exception e){
            throw new InternalApplicationException("Exception in saveItemAttr: " + e.getMessage());
        }
    }

    @Override
    public boolean delete(List<Long> itemAttributesIds) {
        List<ItemAttrShelf> itemAttrShelves = itemAttrShelfService.getAllByIds(itemAttributesIds);
        itemAttrShelfService.deleteItemAttributes(itemAttrShelves);
        return true;
    }

    @Override
    public ConstructorDTO update(ConstructorDTO constructorDTO) {
        List<ItemAttrShelf> itemAttrShelves = new ArrayList<>();
        for (ShelfDTO shelfDTO : constructorDTO.getShelves()){
            itemAttrShelves.addAll(entityMapper.mapItemAttributesList(shelfDTO.getItemAttributes(), shelfDTO.getRackId()));
        }
        itemAttrShelfService.updateItemAttributes(itemAttrShelves);
        return constructorDTO;
    }

    public List<ItemAttributesDTO> getByShelfId(long shelfId){
        List<ItemAttrShelf> itemAttrShelves = itemAttrShelfService.getShelfItemAttributes(shelfId);
        return EntityMapper.mapItemAttributesDTOList(itemAttrShelves);
    }

    public List<ItemAttributesDTO> getByNamed(String name){
        List<ItemAttrShelf> itemAttributes = itemAttrShelfService.getByName(name);
        return EntityMapper.mapItemAttributesDTOList(itemAttributes);
    }
}
