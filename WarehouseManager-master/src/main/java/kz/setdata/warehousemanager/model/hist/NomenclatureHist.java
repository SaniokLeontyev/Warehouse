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
@Table(name = "nomenclature_hist")
public class NomenclatureHist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nomenclature;

    private String units;

    private String uuid;

    @Column(name = "condition_type")
    private String conditionType;

    @Column(name = "start_date")
    private LocalDateTime startDate;

    @Column(name = "end_date")
    private LocalDateTime endDate;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        NomenclatureHist that = (NomenclatureHist) o;
        return Objects.equals(getNomenclature(), that.getNomenclature()) && Objects.equals(getUnits(), that.getUnits()) && Objects.equals(getUuid(), that.getUuid()) && Objects.equals(getConditionType(), that.getConditionType()) && Objects.equals(getStartDate(), that.getStartDate()) && Objects.equals(getEndDate(), that.getEndDate());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getNomenclature(), getUnits(), getUuid(), getConditionType(), getStartDate(), getEndDate());
    }
}

