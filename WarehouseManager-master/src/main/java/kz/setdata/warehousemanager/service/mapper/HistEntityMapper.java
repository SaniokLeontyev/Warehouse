package kz.setdata.warehousemanager.service.mapper;

import kz.setdata.warehousemanager.model.ItemAttrShelf;
import kz.setdata.warehousemanager.model.Task;
import kz.setdata.warehousemanager.model.TaskFile;
import kz.setdata.warehousemanager.model.TaskNomenclature;
import kz.setdata.warehousemanager.model.hist.NomenclatureHist;
import kz.setdata.warehousemanager.model.hist.TaskFileHist;
import kz.setdata.warehousemanager.model.hist.TaskHist;
import kz.setdata.warehousemanager.model.hist.TaskNomenclatureHist;
import kz.setdata.warehousemanager.model.hist.dto.NomenclatureHistDTO;
import kz.setdata.warehousemanager.model.hist.dto.TaskHistDTO;
import kz.setdata.warehousemanager.model.hist.dto.TaskNomenclatureHistDTO;
import kz.setdata.warehousemanager.repository.hist.impl.TaskFileHistService;
import kz.setdata.warehousemanager.repository.hist.impl.TaskNomenclatureHistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class HistEntityMapper {

    private TaskFileHistService taskFileHistService;

    @Autowired
    private void setTaskFileHistService(TaskFileHistService taskFileHistService) {
        this.taskFileHistService = taskFileHistService;
    }

    private TaskNomenclatureHistService taskNomenclatureHistService;

    @Autowired
    private void setTaskNomenclatureHistService(TaskNomenclatureHistService taskNomenclatureHistService) {
        this.taskNomenclatureHistService = taskNomenclatureHistService;
    }

    public static TaskHist toTaskHist(Task task) {
        TaskHist taskHist = new TaskHist();
        taskHist.setComments(task.getComments());
        taskHist.setUuid(task.getUuid());
        taskHist.setCreateDate(task.getCreateDate());
        if (task.getEditDate() != null) {
            taskHist.setEditDate(task.getEditDate());
        }
        taskHist.setUserName(task.getUser().getName());
        taskHist.setUserSurname(task.getUser().getSurname());
        taskHist.setUserPatronymic(task.getUser().getPatronymic());
        taskHist.setManagerName(task.getCreator().getName());
        taskHist.setManagerSurname(task.getCreator().getSurname());
        taskHist.setManagerPatronymic(task.getCreator().getPatronymic());
        taskHist.setTaskType(task.getTaskType().getName());
        taskHist.setTaskStatus(task.getTaskStatus().getName());
        taskHist.setConstructorName(task.getConstructor().getName());
        return taskHist;
    }

    public static NomenclatureHist toNomenclatureHist(ItemAttrShelf itemAttrShelf) {
        NomenclatureHist nomenclatureHist = new NomenclatureHist();
        nomenclatureHist.setNomenclature(itemAttrShelf.getItemAttributes().getNomenclature());
        nomenclatureHist.setUnits(itemAttrShelf.getItemAttributes().getUnits());
        nomenclatureHist.setUuid(itemAttrShelf.getItemAttributes().getUuid());
        nomenclatureHist.setConditionType(itemAttrShelf.getItemAttributes().getConditionType());
        if (itemAttrShelf.getItemAttributes().getStartDate() != null) {
            nomenclatureHist.setStartDate(itemAttrShelf.getItemAttributes().getStartDate());
        }
        if (itemAttrShelf.getItemAttributes().getEndDate() != null) {
            nomenclatureHist.setEndDate(itemAttrShelf.getItemAttributes().getEndDate());
        }
        return nomenclatureHist;
    }

    public static List<NomenclatureHist> toNomenclatureHist(List<ItemAttrShelf> itemAttrShelf) {
        List<NomenclatureHist> nomenclatureHists = new ArrayList<>();
        for (ItemAttrShelf itemAttrShelfItem : itemAttrShelf) {
            nomenclatureHists.add(toNomenclatureHist(itemAttrShelfItem));
        }
        return nomenclatureHists;
    }

    public static TaskNomenclatureHist toTaskNomenclatureHist(TaskNomenclature taskNomenclature) {
        TaskNomenclatureHist taskNomenclatureHist = new TaskNomenclatureHist();
        NomenclatureHist nomenclatureHist = toNomenclatureHist(taskNomenclature.getItemAttrShelf());
        taskNomenclatureHist.setNomenclatureHist(nomenclatureHist);
        TaskHist taskHist = toTaskHist(taskNomenclature.getTask());
        taskNomenclatureHist.setTask(taskHist);
        taskNomenclatureHist.setQuantity(taskNomenclature.getQuantity());
        return taskNomenclatureHist;
    }

    public static List<TaskNomenclatureHist> toTaskNomenclatureHist(List<TaskNomenclature> taskNomenclature) {
        List<TaskNomenclatureHist> taskNomenclatureHists = new ArrayList<>();
        for (TaskNomenclature tm : taskNomenclature) {
            taskNomenclatureHists.add(toTaskNomenclatureHist(tm));
        }
        return taskNomenclatureHists;
    }

    public static List<TaskNomenclatureHist> buildTaskNomenclatureHist(List<TaskNomenclature> taskNomenclature,
                                                                       List<NomenclatureHist> nomenclatureHists,
                                                                       TaskHist taskHist) {
        List<TaskNomenclatureHist> taskNomenclatureHists = new ArrayList<>();
        for (TaskNomenclature tm : taskNomenclature) {
            for (NomenclatureHist hist : nomenclatureHists) {
                if (tm.getItemAttrShelf().getItemAttributes().getUuid().equals(hist.getUuid())) {
                    taskNomenclatureHists.add(new TaskNomenclatureHist(taskHist,hist, tm.getQuantity()));
                }
            }
        }
        return taskNomenclatureHists;
    }

    public static List<TaskFileHist> toTaskFileHist(List<TaskFile> taskFiles, TaskHist taskHist){
        List<TaskFileHist> taskFileHists = new ArrayList<>();
        for (TaskFile taskFile : taskFiles) {
            TaskFileHist taskFileHist = new TaskFileHist();
            taskFileHist.setFile(taskFile.getFile());
            taskFileHist.setTask(taskHist);
            taskFileHists.add(taskFileHist);
        }
        return taskFileHists;
    }

    public List<TaskHistDTO> toTaskHistDTO(List<TaskHist> taskHists) {
        List<TaskHistDTO> taskHistDTOs = new ArrayList<>();
        for (TaskHist taskHist : taskHists) {
            List<TaskNomenclatureHist> taskNomenclatureHists = taskNomenclatureHistService.getByTaskId(taskHist.getId());
            List<TaskFileHist> taskFileHists = taskFileHistService.getTaskFileHistByTaskId(taskHist.getId());
            TaskHistDTO taskHistDTO = toTaskHistDTO(taskHist,taskNomenclatureHists,taskFileHists);
            taskHistDTOs.add(taskHistDTO);
        }
        return taskHistDTOs;
    }

    public static TaskHistDTO toTaskHistDTO(TaskHist taskHist,
                                            List<TaskNomenclatureHist> taskNomenclatureHists,
                                            List<TaskFileHist> taskFileHists) {
        TaskHistDTO taskHistDTO = new TaskHistDTO();
        taskHistDTO.setId(taskHist.getId());
        taskHistDTO.setUuid(taskHist.getUuid());
        taskHistDTO.setComments(taskHist.getComments());
        taskHistDTO.setTaskStatus(taskHist.getTaskStatus());
        taskHistDTO.setTaskType(taskHist.getTaskType());
        taskHistDTO.setConstructorName(taskHist.getConstructorName());
        taskHistDTO.setEditDate(taskHist.getEditDate());
        taskHistDTO.setCreateDate(taskHist.getCreateDate());
        taskHistDTO.setManagerName(taskHist.getManagerName());
        taskHistDTO.setManagerSurname(taskHist.getManagerSurname());
        taskHistDTO.setManagerPatronymic(taskHist.getManagerPatronymic());
        taskHistDTO.setUserName(taskHist.getUserName());
        taskHistDTO.setUserSurname(taskHist.getUserSurname());
        taskHistDTO.setUserPatronymic(taskHist.getUserPatronymic());

        taskHistDTO.setNomenclature(toNomenclatureHistDTO(taskNomenclatureHists));
        taskHistDTO.setFiles(taskFiles(taskFileHists));
        return taskHistDTO;
    }

    public static List<String> taskFiles(List<TaskFileHist> taskFileHists) {
        List<String> taskFiles = new ArrayList<>();
        for (TaskFileHist taskFileHist : taskFileHists) {
            taskFiles.add(taskFileHist.getFile());
        }
        return taskFiles;
    }

    public static List<TaskNomenclatureHistDTO> toNomenclatureHistDTO(List<TaskNomenclatureHist> taskNomenclatureHists){
        List<TaskNomenclatureHistDTO> taskNomenclatureHistDTOs = new ArrayList<>();
        for (TaskNomenclatureHist tm : taskNomenclatureHists) {
            taskNomenclatureHistDTOs.add(toNomenclatureHistDTO(tm));
        }
        return taskNomenclatureHistDTOs;
    }

    public static TaskNomenclatureHistDTO toNomenclatureHistDTO(TaskNomenclatureHist taskNomenclatureHist){
        TaskNomenclatureHistDTO taskNomenclatureHistDTO  = new TaskNomenclatureHistDTO();
        taskNomenclatureHistDTO.setNomenclatureHistDTO(
                toNomenclatureHistDTO(taskNomenclatureHist.getNomenclatureHist()));
        taskNomenclatureHistDTO.setQuantity(taskNomenclatureHist.getQuantity());
        return taskNomenclatureHistDTO;
    }

    public static NomenclatureHistDTO toNomenclatureHistDTO(NomenclatureHist nomenclatureHist){
        NomenclatureHistDTO nomenclatureHistDTO = new NomenclatureHistDTO();
        nomenclatureHistDTO.setId(nomenclatureHist.getId());
        nomenclatureHistDTO.setUuid(nomenclatureHist.getUuid());
        nomenclatureHistDTO.setNomenclature(nomenclatureHist.getNomenclature());
        nomenclatureHistDTO.setUnits(nomenclatureHist.getUnits());
        nomenclatureHistDTO.setConditionType(nomenclatureHist.getConditionType());
        nomenclatureHistDTO.setStartDate(nomenclatureHist.getStartDate());
        nomenclatureHistDTO.setEndDate(nomenclatureHist.getEndDate());
        return nomenclatureHistDTO;
    }
}
