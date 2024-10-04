package kz.setdata.warehousemanager.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "zone_shelves")
public class ZoneShelves {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @JoinColumn(name = "zone_id")
    private Zone zone;

    @ManyToOne
    @JoinColumn(name = "shelf_id")
    private Shelf shelf;

    public ZoneShelves(Zone zone, Shelf shelf){
        this.zone = zone;
        this.shelf = shelf;
    }

}
