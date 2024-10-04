package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.exception.CRUDOperationException;
import kz.setdata.warehousemanager.exception.InternalApplicationException;
import kz.setdata.warehousemanager.model.ItemAttrShelf;
import kz.setdata.warehousemanager.model.Task;
import kz.setdata.warehousemanager.model.TaskNomenclature;
import kz.setdata.warehousemanager.model.dto.TaskNomenclatureDTO;
import kz.setdata.warehousemanager.model.excel.TaskExcel;
import kz.setdata.warehousemanager.repository.TaskNomenclatureRepository;
import kz.setdata.warehousemanager.service.TaskExcelService;
import kz.setdata.warehousemanager.service.mapper.ExcelEntityMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class TaskNomenclatureService {
    private final TaskNomenclatureRepository taskNomenclatureRepository;
    private ItemAttrShelfService itemAttrShelfService;
    private final TaskExcelService taskExcelService;

    @Autowired
    public void setItemAttrShelfService(ItemAttrShelfService itemAttrShelfService) {
        this.itemAttrShelfService = itemAttrShelfService;
    }

    public List<TaskNomenclature> getTaskNomenclature(long taskId){
        return taskNomenclatureRepository.findAllByTaskId(taskId);
    }

    @Transactional
    public void save(List<TaskNomenclature> taskNomenclatures){
        taskNomenclatureRepository.saveAll(taskNomenclatures);
    }

    public List<TaskNomenclature> build(Task task, Map<ItemAttrShelf,Integer> itemAttrShelfIntegerMap){
        List<TaskNomenclature> taskNomenclatures = new ArrayList<>();
        for (Map.Entry<ItemAttrShelf, Integer> itemAttrShelfIntegerEntry : itemAttrShelfIntegerMap.entrySet()){
            taskNomenclatures.add(new TaskNomenclature(task,itemAttrShelfIntegerEntry.getKey(),itemAttrShelfIntegerEntry.getValue()));
        }
        return taskNomenclatures;
    }

    public Map<ItemAttrShelf,Integer> buildTaskNomenclature(List<TaskNomenclatureDTO> nomenclatureDTOS){
        Map<ItemAttrShelf,Integer> itemAttrShelfIntegerMap = new HashMap<>();
        for (TaskNomenclatureDTO taskNomenclatureDTO : nomenclatureDTOS){
            ItemAttrShelf ia = itemAttrShelfService.getById(taskNomenclatureDTO.getItemAttrShelfId());
            int itemAttrsDifference = ia.getQuantity() - taskNomenclatureDTO.getQuantity();
            if (taskNomenclatureDTO.getQuantity() <= ia.getQuantity()) {
                    ia.setQuantity(itemAttrsDifference);
                    itemAttrShelfIntegerMap.put(
                            ia,
                            taskNomenclatureDTO.getQuantity());
            }else {
                throw new CRUDOperationException(String.format("Quantity of nomenclature id %s is to high",ia.getId()));
            }
        }
        return itemAttrShelfIntegerMap;
    }

    public Map<ItemAttrShelf,Integer> buildTaskNomenclatureNoMinus(List<TaskNomenclatureDTO> nomenclatureDTOS){
        Map<ItemAttrShelf,Integer> itemAttrShelfIntegerMap = new HashMap<>();
        for (TaskNomenclatureDTO taskNomenclatureDTO : nomenclatureDTOS){
            ItemAttrShelf ia = itemAttrShelfService.getById(taskNomenclatureDTO.getItemAttrShelfId());
            if (taskNomenclatureDTO.getQuantity() <= ia.getQuantity()) {
                ia.setQuantity(taskNomenclatureDTO.getQuantity());
                itemAttrShelfIntegerMap.put(
                        ia,
                        taskNomenclatureDTO.getQuantity());
            }else {
                throw new CRUDOperationException(String.format("Quantity of nomenclature id %s is to high",ia.getId()));
            }
        }
        return itemAttrShelfIntegerMap;
    }

    public Map<ItemAttrShelf,Integer> buildTaskNomenclatureWithShelf(List<Long> shelfIds){
        List<ItemAttrShelf> itemAttrShelves = itemAttrShelfService.getShelfItemAttributesByShelfIds(shelfIds);
        Map<ItemAttrShelf,Integer> itemAttributesMap = new HashMap<>();
        for (ItemAttrShelf itemAttrShelf : itemAttrShelves){
            itemAttributesMap.put(
                    itemAttrShelfService.findByUuid(itemAttrShelf.getItemAttributes().getUuid()),
                    itemAttrShelf.getQuantity());
        }
        return itemAttributesMap;
    }

    public void deleteNomenclatureFromTask(long taskId, long itemAttributeId){
        TaskNomenclature taskNomenclature = taskNomenclatureRepository.findAllByTaskIdAndItemAttrShelfId(taskId,itemAttributeId);
        taskNomenclatureRepository.delete(taskNomenclature);
    }

    @Transactional
    public void delete(TaskNomenclature taskNomenclature){
        taskNomenclatureRepository.delete(taskNomenclature);
    }

    @Transactional
    public void delete(List<TaskNomenclature> taskNomenclatures){
        taskNomenclatureRepository.deleteAll(taskNomenclatures);
    }

    @Transactional
    public TaskNomenclature save(TaskNomenclature taskNomenclature){
        return taskNomenclatureRepository.save(taskNomenclature);
    }

    @Transactional
    public void deleteByTasks(List<Task> tasks){
        List<TaskNomenclature> taskNomenclatures = taskNomenclatureRepository.findAllByTaskIn(tasks);
        taskNomenclatureRepository.deleteAll(taskNomenclatures);
    }

    public List<TaskNomenclature> getAllByItemAttributes(List<ItemAttrShelf> itemAttrShelves){
        return taskNomenclatureRepository.findAllByItemAttrShelfIn(itemAttrShelves);
    }

    @Transactional
    public void delete(long constructorId){
        taskNomenclatureRepository.deleteTaskNomenclatureByConstructorId(constructorId);
    }

    public void excelTask(List<TaskExcel> taskExcels, HttpServletResponse response){
        if (!taskExcels.isEmpty()){
            try {
                taskExcelService.exportToExcel(response,taskExcels);
            } catch (IOException e) {
                throw new InternalApplicationException("Error creating excel file");
            }
        }
        throw new CRUDOperationException("TaskExcels is empty");
    }

}
