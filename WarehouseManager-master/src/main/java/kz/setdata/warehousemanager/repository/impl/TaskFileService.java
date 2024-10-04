package kz.setdata.warehousemanager.repository.impl;

import kz.setdata.warehousemanager.model.Task;
import kz.setdata.warehousemanager.model.TaskFile;
import kz.setdata.warehousemanager.repository.TaskFileRepository;
import kz.setdata.warehousemanager.service.S3Service;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class TaskFileService {
    private final TaskFileRepository taskFileRepository;
    private final S3Service s3Service;

    private TaskFileService taskFileService;

    @Autowired
    private void setTaskFileService(TaskFileService taskFileService) {
        this.taskFileService = taskFileService;
    }

    public List<TaskFile> getByTaskId(Long taskId) {
        return taskFileRepository.findByTaskId(taskId);
    }

    public List<String> getTaskS3Urls(List<TaskFile> taskFiles) {
        List<String> urls = new ArrayList<>();
        for (TaskFile taskFile : taskFiles) {
            urls.add(taskFile.getFile());
        }
        return urls;
    }

    public List<TaskFile> getByTaskId(List<Task> tasks) {
        return taskFileRepository.findAllByTaskIn(tasks);
    }

    @Transactional
    public void save(List<TaskFile> taskFiles) {
        taskFileRepository.saveAll(taskFiles);
    }

    @Transactional
    public List<String> saveTaskFilesToS3(String taskUUID, List<String> base64Files) {
        List<String> s3urls = new ArrayList<>();
        for (String base64File : base64Files) {
            String s3Url = s3Service.uploadObject("task_" + taskUUID,base64File + "_" + System.currentTimeMillis());
            s3urls.add(s3Url);
        }
        return s3urls;
    }

    public void save(Task task, List<String> base64Files) {
        List<TaskFile> taskFiles = new ArrayList<>();
        for (String base64File : base64Files) {
            taskFiles.add(new TaskFile(task,base64File));
        }
        taskFileService.save(taskFiles);
    }


    public void deleteByTaskId(Long taskId) {
        taskFileRepository.deleteTaskFile(taskId);
    }

    @Transactional
    public void delete(List<TaskFile> taskFiles) {
        taskFileRepository.deleteAll(taskFiles);
    }
}
