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
@Table(name = "walls")
public class Walls {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "coordinate_x")
    private String coordinateX;

    @Column(name = "coordinate_y")
    private String coordinateY;

    private String fill;
    private double opacity;
    private boolean draggable;
    private String name;
    private double width;
    private double height;
    private int rotation;

    @ManyToOne
    @JoinColumn(name = "constructor_id")
    private Constructor constructor;
}
