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
@Table(name = "windows")
public class Windows {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "coordinate_x")
    private String coordinateX;

    @Column(name = "coordinate_y")
    private String coordinateY;

    private boolean draggable;
    @Column(name = "fill_pattern_image")
    private String fillPatternImage;
    private int height;
    private int width;
    private String name;
    private double opacity;
    private int rotation;

    @ManyToOne
    @JoinColumn(name = "constructor_id")
    private Constructor constructor;
}
