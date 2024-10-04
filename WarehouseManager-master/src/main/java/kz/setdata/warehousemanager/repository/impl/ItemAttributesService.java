package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.ItemAttributes;
import kz.setdata.warehousemanager.model.dto.form.CreateItemAttributeDTO;
import kz.setdata.warehousemanager.repository.ItemAttributesRepository;
import kz.setdata.warehousemanager.service.mapper.EntityMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ItemAttributesService {

    private final ItemAttributesRepository itemAttributesRepository;

    public ItemAttributes getById(long id) {
        return itemAttributesRepository.findAllById(id);
    }

    public ItemAttributes create(CreateItemAttributeDTO createItemAttributeDTO) {
        ItemAttributes itemAttributes = EntityMapper.mapCreateItemAttributeDTO(createItemAttributeDTO);
        return itemAttributesRepository.save(itemAttributes);
    }

    @Transactional
    public void delete(long constructorId) {
        itemAttributesRepository.deleteItemAttributesByConstructorId(constructorId);
    }

    @Transactional
    public void delete(List<ItemAttributes> itemAttributes) {
        itemAttributesRepository.deleteAll(itemAttributes);
    }

    @Transactional
    public void delete(ItemAttributes itemAttributes) {
        itemAttributesRepository.delete(itemAttributes);
    }

    @Transactional
    public ItemAttributes save(ItemAttributes itemAttributes) {
        return itemAttributesRepository.save(itemAttributes);
    }

    public boolean checkIfItemAttributeQuantityIsHigher(long itemAttributeId, int quantityOnShelf) {
        ItemAttributes itemAttributes = itemAttributesRepository.findAllById(itemAttributeId);
        return itemAttributes.getQuantity() >= quantityOnShelf;
    }
}
