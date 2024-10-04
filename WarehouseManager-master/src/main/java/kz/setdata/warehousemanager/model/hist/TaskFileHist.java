package kz.setdata.warehousemanager.model.hist;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "task_file_hist")
public class TaskFileHist implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "task_id")
    private TaskHist task;

    @Column(name = "file")
    private String file;

    public TaskFileHist(TaskHist task, String file) {
        this.task = task;
        this.file = file;
    }
}
