package kz.setdata.warehousemanager.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Objects;

@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "task_nomenclature")
public class TaskNomenclature {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "item_attribute_shelf_id")
    private ItemAttrShelf itemAttrShelf;

    @ManyToOne
    @JoinColumn(name = "task_id")
    private Task task;

    @Column(name = "quantity")
    private int quantity;

    public TaskNomenclature(Task task, ItemAttrShelf itemAttrShelf, int quantity){
        this.task = task;
        this.quantity = quantity;
        this.itemAttrShelf = itemAttrShelf;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TaskNomenclature that = (TaskNomenclature) o;
        return getQuantity() == that.getQuantity() && Objects.equals(getItemAttrShelf(), that.getItemAttrShelf()) && Objects.equals(getTask(), that.getTask());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getItemAttrShelf(), getTask(), getQuantity());
    }
}
