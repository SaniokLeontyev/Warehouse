package kz.setdata.warehousemanager.model.hist;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Cascade;

import javax.persistence.*;
import java.util.Objects;

@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "task_nomenclature_hist")
public class TaskNomenclatureHist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "nomenclature_id")
    private NomenclatureHist nomenclatureHist;

    @ManyToOne
    @JoinColumn(name = "task_id")
    private TaskHist task;

    @Column(name = "quantity")
    private int quantity;

    public TaskNomenclatureHist(TaskHist task, NomenclatureHist nomenclatureHist, int quantity){
        this.task = task;
        this.quantity = quantity;
        this.nomenclatureHist = nomenclatureHist;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TaskNomenclatureHist that = (TaskNomenclatureHist) o;
        return getQuantity() == that.getQuantity() && Objects.equals(getNomenclatureHist(), that.getNomenclatureHist()) && Objects.equals(getTask(), that.getTask());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getNomenclatureHist(), getTask(), getQuantity());
    }
}

