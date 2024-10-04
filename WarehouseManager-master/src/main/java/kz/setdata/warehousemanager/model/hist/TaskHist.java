package kz.setdata.warehousemanager.model.hist;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "task_hist")
public class TaskHist {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "TEXT")
    private String comments;

    @Column(name = "uuid", unique = true)
    private String uuid;

    @Column(name = "create_date")
    private LocalDateTime createDate;

    @Column(name = "edit_date")
    private LocalDateTime editDate;

    @Column(name = "user_name")
    private String userName;
    @Column(name = "user_surname")
    private String userSurname;
    @Column(name = "user_patronymic")
    private String userPatronymic;

    @Column(name = "manager_name")
    private String managerName;
    @Column(name = "manager_surname")
    private String managerSurname;
    @Column(name = "manager_patronymic")
    private String managerPatronymic;

    @Column(name = "task_type")
    private String taskType;

    @Column(name="constructor_name")
    private String constructorName;

    @Column(name = "task_status")
    private String taskStatus;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TaskHist taskHist = (TaskHist) o;
        return Objects.equals(getComments(), taskHist.getComments()) && Objects.equals(getUuid(), taskHist.getUuid()) && Objects.equals(getCreateDate(), taskHist.getCreateDate()) && Objects.equals(getEditDate(), taskHist.getEditDate()) && Objects.equals(getUserName(), taskHist.getUserName()) && Objects.equals(getUserSurname(), taskHist.getUserSurname()) && Objects.equals(getUserPatronymic(), taskHist.getUserPatronymic()) && Objects.equals(getManagerName(), taskHist.getManagerName()) && Objects.equals(getManagerSurname(), taskHist.getManagerSurname()) && Objects.equals(getManagerPatronymic(), taskHist.getManagerPatronymic()) && Objects.equals(getTaskType(), taskHist.getTaskType()) && Objects.equals(getConstructorName(), taskHist.getConstructorName()) && Objects.equals(getTaskStatus(), taskHist.getTaskStatus());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getComments(), getUuid(), getCreateDate(), getEditDate(), getUserName(), getUserSurname(), getUserPatronymic(), getManagerName(), getManagerSurname(), getManagerPatronymic(), getTaskType(), getConstructorName(), getTaskStatus());
    }
}