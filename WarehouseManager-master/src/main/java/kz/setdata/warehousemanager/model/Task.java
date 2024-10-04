package kz.setdata.warehousemanager.model;

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
@Table(name = "tasks")
public class Task {

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

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "task_type", referencedColumnName = "id")
    private TaskType taskType;

    @ManyToOne
    @JoinColumn(name="constructor_id")
    private Constructor constructor;

    @ManyToOne
    @JoinColumn(name="task_status_id")
    private TaskStatus taskStatus;

    @ManyToOne
    @JoinColumn(name = "creator_id")
    private User creator;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Task task = (Task) o;
        return Objects.equals(getComments(), task.getComments()) && Objects.equals(getUuid(), task.getUuid()) && Objects.equals(getCreateDate(), task.getCreateDate()) && Objects.equals(getEditDate(), task.getEditDate()) && Objects.equals(getUser(), task.getUser()) && Objects.equals(getTaskType(), task.getTaskType()) && Objects.equals(getConstructor(), task.getConstructor()) && Objects.equals(getTaskStatus(), task.getTaskStatus()) && Objects.equals(getCreator(), task.getCreator());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getComments(), getUuid(), getCreateDate(), getEditDate(), getUser(), getTaskType(), getConstructor(), getTaskStatus(), getCreator());
    }
}
