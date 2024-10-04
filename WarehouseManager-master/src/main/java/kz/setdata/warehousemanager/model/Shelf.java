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
@Table(name = "shelves")
public class Shelf {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "shelf_level")
    private int shelfLevel;

    @Column(name = "cells_per_width")
    private int cellsPerWidth;

    @Column(name = "cells_per_depth")
    private int cellsPerDepth;

    @Column(name = "coordinate_x")
    private String coordinateX;
    @Column(name = "coordinate_y")
    private String coordinateY;
    private String fill;
    private int opacity;
    private boolean draggable;
    private String name;
    private double width;
    private double height;
    private int rotation;

    @Column(name = "cell_height")
    private double cellHeight;
    @Column(name = "cell_width")
    private double cellWidth;

    @Column(name = "rack_height")
    private int rackHeight;

    @Column(name = "rack_id", unique = true)
    private String rackId;

    @ManyToOne
    @JoinColumn(name = "constructor_id")
    private Constructor constructor;

}

