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
@Table(name = "item_attributes")
public class ItemAttributes {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nomenclature;

    private String units;

    private int quantity;

    private String uuid;

    @Column(name = "condition_type")
    private String conditionType;

    @Column(name = "start_date")
    private LocalDateTime startDate;

    @Column(name = "end_date")
    private LocalDateTime endDate;


    @Override
    public int hashCode() {
        return Objects.hash(id, nomenclature, units, quantity, uuid, conditionType, startDate, endDate);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ItemAttributes that = (ItemAttributes) o;
        return quantity == that.quantity &&
                Objects.equals(id, that.id) &&
                Objects.equals(nomenclature, that.nomenclature) &&
                Objects.equals(units, that.units) &&
                Objects.equals(uuid, that.uuid) &&
                Objects.equals(conditionType, that.conditionType) &&
                Objects.equals(startDate, that.startDate) &&
                Objects.equals(endDate, that.endDate);
    }
}
