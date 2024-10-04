package kz.setdata.warehousemanager.service.mapper;

import kz.setdata.warehousemanager.exception.CRUDOperationException;
import kz.setdata.warehousemanager.model.*;
import kz.setdata.warehousemanager.model.dto.ItemAttrShelfDTO;
import kz.setdata.warehousemanager.model.dto.TaskDto;
import kz.setdata.warehousemanager.model.dto.UserDto;
import kz.setdata.warehousemanager.model.dto.constructor.*;
import kz.setdata.warehousemanager.model.dto.form.CreateItemAttributeDTO;
import kz.setdata.warehousemanager.repository.impl.*;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EntityMapper {

    private final ShelfService shelfService;
    private final WallsService wallsService;
    private final DoorwaysService doorwaysService;
    private final WindowsService windowsService;
    private final ZoneService zoneService;
    private final ZoneShelvesService zoneShelvesService;
    private final TaskNomenclatureService taskNomenclatureService;
    private final TaskFileService taskFileService;
    private final AccountService accountService;

    private ItemAttrShelfService itemAttrShelfService;
    private ItemAttributesService itemAttributesService;

    @Autowired
    private void setItemAttrShelfService(ItemAttrShelfService itemAttrShelfService) {
        this.itemAttrShelfService = itemAttrShelfService;
    }

    @Autowired
    private void setItemAttributesService(ItemAttributesService itemAttributesService) {
        this.itemAttributesService = itemAttributesService;
    }

    public ConstructorDTO buildConstructorDTO(Constructor constructor) {
        List<Walls> walls = wallsService.getWarehouseWalls(constructor.getId());
        List<Doorways> doorways = doorwaysService.getWarehouseDoorways(constructor.getId());
        List<Windows> windows = windowsService.getWarehouseWindows(constructor.getId());
        List<Zone> zones = zoneService.getWarehouseZones(constructor.getId());
        List<ZoneDTO> zoneDTOS = mapZoneDTOList(zones);
        List<ShelfDTO> shelfDTOS = mapShelfDTOList(
                shelfService.getAllByConstructorId(constructor.getId()));
        ConstructorDTO constructorDTO = EntityMapper.mapConstructorDTO(
                constructor,
                walls,
                windows,
                doorways);
        constructorDTO.setZones(zoneDTOS);
        constructorDTO.setShelves(shelfDTOS);
        return constructorDTO;
    }

    public List<ZoneDTO> mapZoneDTOList(List<Zone> zones) {
        List<ZoneDTO> zoneDTOS = new ArrayList<>();
        for (Zone zone : zones) {
            ZoneDTO zoneDTO = new ZoneDTO();
            zoneDTO.setId(zone.getId());
            zoneDTO.setDescription(zone.getDescription());
            zoneDTO.setName(zone.getName());
            zoneDTO.setDraggable(zone.isDraggable());
            zoneDTO.setFill(zone.getFill());
            zoneDTO.setHeight(zone.getHeight());
            zoneDTO.setOpacity(zone.getOpacity());
            zoneDTO.setTitle(zone.getTitle());
            zoneDTO.setWidth(zone.getWidth());
            zoneDTO.setCoordinateX(zone.getCoordinateX());
            zoneDTO.setCoordinateY(zone.getCoordinateY());
            zoneDTO.setRotation(zone.getRotation());
            zoneDTOS.add(zoneDTO);
        }
        return zoneDTOS;
    }

    public List<ShelfDTO> mapShelfDTOList(List<Shelf> shelves) {
        List<ShelfDTO> shelfDTOS = new ArrayList<>();
        for (Shelf shelf : shelves) {
            List<ItemAttrShelf> itemAttrShelves = itemAttrShelfService.getShelfItemAttributes(shelf.getId());
            List<String> shelfZoneNames = zoneShelvesService.getZoneShelvesNamesByShelfId(shelf.getId());
            shelfDTOS.add(mapShelfDTO(shelf, itemAttrShelves, shelfZoneNames));
        }
        return shelfDTOS;
    }

    public ShelfDTO mapShelfDTO(Shelf shelf, List<ItemAttrShelf> itemAttrShelves, List<String> zoneNames) {
        ShelfDTO shelfDTO = new ShelfDTO();
        shelfDTO.setId(shelf.getId());
        shelfDTO.setShelfLevel(shelf.getShelfLevel());
        shelfDTO.setCellsPerWidth(shelf.getCellsPerWidth());
        shelfDTO.setCellsPerDepth(shelf.getCellsPerDepth());

        shelfDTO.setCoordinateX(shelf.getCoordinateX());
        shelfDTO.setCoordinateY(shelf.getCoordinateY());
        shelfDTO.setFill(shelf.getFill());
        shelfDTO.setOpacity(shelf.getOpacity());
        shelfDTO.setDraggable(shelf.isDraggable());
        shelfDTO.setName(shelf.getName());
        shelfDTO.setWidth(shelf.getWidth());
        shelfDTO.setHeight(shelf.getHeight());
        shelfDTO.setRackHeight(shelf.getRackHeight());
        shelfDTO.setRackId(shelf.getRackId());
        shelfDTO.setRotation(shelf.getRotation());

        shelfDTO.setCellHeight(shelf.getCellHeight());
        shelfDTO.setCellWidth(shelf.getCellWidth());

        shelfDTO.setZoneNames(zoneShelvesService.getZonesNamesOfShelve(shelf.getId()));
        shelfDTO.setZoneNames(zoneNames);

        shelfDTO.setItemAttributes(mapItemAttributesDTOList(itemAttrShelves));
        return shelfDTO;
    }

    public static List<ItemAttributesDTO> mapItemAttributesDTOList(List<ItemAttrShelf> itemAttrShelves) {
        List<ItemAttributesDTO> itemAttributesDTOS = new ArrayList<>();
        for (ItemAttrShelf attributes : itemAttrShelves) {
            itemAttributesDTOS.add(mapItemAttributesDTO(attributes));
        }
        return itemAttributesDTOS;
    }

    public static ItemAttributesDTO mapItemAttributesDTO(ItemAttrShelf itemAttrShelf) {
        ItemAttributesDTO itemAttributesDTO = new ItemAttributesDTO();
        itemAttributesDTO.setId(itemAttrShelf.getId());
        itemAttributesDTO.setUnits(itemAttrShelf.getItemAttributes().getUnits());
        itemAttributesDTO.setNomenclature(itemAttrShelf.getItemAttributes().getNomenclature());
        itemAttributesDTO.setQuantity(itemAttrShelf.getQuantity());
        itemAttributesDTO.setConditionType(itemAttrShelf.getItemAttributes().getConditionType());
        itemAttributesDTO.setUuid(itemAttrShelf.getItemAttributes().getUuid());
        if (itemAttrShelf.getItemAttributes().getEndDate() != null) {
            itemAttributesDTO.setEndDate(itemAttrShelf.getItemAttributes().getEndDate());
        }
        if (itemAttrShelf.getItemAttributes().getStartDate() != null) {
            itemAttributesDTO.setStartDate(itemAttrShelf.getItemAttributes().getStartDate());
        }
        if (itemAttrShelf.getShelves() != null) {
            itemAttributesDTO.setShelfId(itemAttrShelf.getShelves().getId());
        }
        itemAttributesDTO.setShelfLevel(itemAttrShelf.getShelfLevel());
        itemAttributesDTO.setCellNumber(itemAttrShelf.getCellNumber());
        return itemAttributesDTO;
    }

    public static ConstructorDTO mapConstructorDTO(Constructor constructor,
                                                   List<Walls> walls,
                                                   List<Windows> windows,
                                                   List<Doorways> doorways) {
        ConstructorDTO constructorDTO = new ConstructorDTO();
        constructorDTO.setId(constructor.getId());
        constructorDTO.setWidth(constructor.getWidth());
        constructorDTO.setHeight(constructor.getHeight());
        constructorDTO.setName(constructor.getName());
        constructorDTO.setWalls(mapWallsDTO(walls));
        constructorDTO.setWindows(mapWindowsDTO(windows));
        constructorDTO.setDoorways(mapDoorwaysDTO(doorways));
        return constructorDTO;
    }

    public static List<WallsDTO> mapWallsDTO(List<Walls> walls) {
        List<WallsDTO> wallsDTOS = new ArrayList<>();
        for (Walls wall : walls) {
            WallsDTO wallsDTO = new WallsDTO();
            wallsDTO.setId(wall.getId());
            wallsDTO.setCoordinateX(wall.getCoordinateX());
            wallsDTO.setCoordinateY(wall.getCoordinateY());

            wallsDTO.setName(wall.getName());
            wallsDTO.setHeight(wall.getHeight());
            wallsDTO.setWidth(wall.getWidth());
            wallsDTO.setFill(wall.getFill());
            wallsDTO.setOpacity(wall.getOpacity());
            wallsDTO.setDraggable(wall.isDraggable());
            wallsDTO.setRotation(wall.getRotation());
            wallsDTOS.add(wallsDTO);
        }
        return wallsDTOS;
    }

    public static List<WindowsDTO> mapWindowsDTO(List<Windows> windows) {
        List<WindowsDTO> windowsDTOS = new ArrayList<>();
        for (Windows window : windows) {
            WindowsDTO windowsDTO = new WindowsDTO();
            windowsDTO.setId(window.getId());
            windowsDTO.setCoordinateX(window.getCoordinateX());
            windowsDTO.setCoordinateY(window.getCoordinateY());

            windowsDTO.setDraggable(window.isDraggable());
            windowsDTO.setFillPatternImage(window.getFillPatternImage());
            windowsDTO.setHeight(window.getHeight());
            windowsDTO.setWidth(window.getWidth());
            windowsDTO.setName(window.getName());
            windowsDTO.setOpacity(window.getOpacity());
            windowsDTO.setRotation(window.getRotation());
            windowsDTOS.add(windowsDTO);
        }
        return windowsDTOS;
    }

    public static List<DoorwaysDTO> mapDoorwaysDTO(List<Doorways> doorways) {
        List<DoorwaysDTO> doorwaysDTOS = new ArrayList<>();
        for (Doorways doorway : doorways) {
            DoorwaysDTO doorwaysDTO = new DoorwaysDTO();
            doorwaysDTO.setId(doorway.getId());
            doorwaysDTO.setCoordinateX(doorway.getCoordinateX());
            doorwaysDTO.setCoordinateY(doorway.getCoordinateY());

            doorwaysDTO.setDraggable(doorway.isDraggable());
            doorwaysDTO.setFillPatternImage(doorway.getFillPatternImage());
            doorwaysDTO.setHeight(doorway.getHeight());
            doorwaysDTO.setWidth(doorway.getWidth());
            doorwaysDTO.setName(doorway.getName());
            doorwaysDTO.setOpacity(doorway.getOpacity());
            doorwaysDTO.setRotation(doorway.getRotation());
            doorwaysDTOS.add(doorwaysDTO);
        }
        return doorwaysDTOS;
    }

    public static Constructor mapConstructor(ConstructorDTO constructorDTO) {
        Constructor constructor = new Constructor();
        constructor.setWidth(constructorDTO.getWidth());
        constructor.setHeight(constructorDTO.getHeight());
        constructor.setName(constructorDTO.getName());
        return constructor;
    }

    public List<Zone> mapZones(List<ZoneDTO> zoneDTOS, Constructor constructor) {
        List<Zone> zones = new ArrayList<>();
        for (ZoneDTO zoneDTO : zoneDTOS) {
            zones.add(mapZone(zoneDTO, constructor));
        }
        return zones;
    }

    public Zone mapZone(ZoneDTO zoneDTO, Constructor constructor) {
        Zone zone = new Zone();
        zone.setId(zoneDTO.getId());
        zone.setDescription(zoneDTO.getDescription());
        zone.setName(zoneDTO.getName());
        zone.setDraggable(zoneDTO.isDraggable());
        zone.setFill(zoneDTO.getFill());
        zone.setHeight(zoneDTO.getHeight());
        zone.setOpacity(zoneDTO.getOpacity());
        zone.setTitle(zoneDTO.getTitle());
        zone.setWidth(zoneDTO.getWidth());
        zone.setCoordinateX(zoneDTO.getCoordinateX());
        zone.setCoordinateY(zoneDTO.getCoordinateY());
        zone.setConstructor(constructor);
        zone.setRotation(zoneDTO.getRotation());
        return zone;
    }

    public Shelf mapShelf(ShelfDTO shelfDTO, Constructor constructor) {
        Shelf shelf = new Shelf();
        shelf.setFill(shelfDTO.getFill());
        shelf.setOpacity(shelfDTO.getOpacity());
        shelf.setDraggable(shelfDTO.isDraggable());
        shelf.setName(shelfDTO.getName());
        shelf.setWidth(shelfDTO.getWidth());
        shelf.setHeight(shelfDTO.getHeight());
        shelf.setShelfLevel(shelfDTO.getShelfLevel());
        shelf.setCellsPerWidth(shelfDTO.getCellsPerWidth());
        shelf.setCellsPerDepth(shelfDTO.getCellsPerDepth());
        shelf.setCoordinateX(shelfDTO.getCoordinateX());
        shelf.setCoordinateY(shelfDTO.getCoordinateY());
        shelf.setRackHeight(shelfDTO.getRackHeight());
        shelf.setRackId(shelfDTO.getRackId());
        shelf.setConstructor(constructor);
        shelf.setRotation(shelfDTO.getRotation());
        shelf.setCellHeight(shelfDTO.getCellHeight());
        shelf.setCellWidth(shelfDTO.getCellWidth());
        return shelf;
    }

    public List<ItemAttrShelf> mapItemAttributesList(List<ItemAttributesDTO> itemAttributesDTOS, String rackId) {
        List<ItemAttrShelf> itemAttributes = new ArrayList<>();
        Shelf shelf = shelfService.getShelfByRackId(rackId);
        for (ItemAttributesDTO attributesDTO : itemAttributesDTOS) {
            itemAttributes.add(mapItemAttributes(attributesDTO, shelf));
        }
        return itemAttributes;
    }

    public ItemAttrShelf mapItemAttributes(ItemAttributesDTO itemAttributesDTO, Shelf shelf) {
        ItemAttrShelf itemAttrShelf = new ItemAttrShelf();
        ItemAttributes ia = new ItemAttributes();
        itemAttrShelf.setItemAttributes(ia);
        itemAttrShelf.getItemAttributes().setUnits(itemAttributesDTO.getUnits());
        itemAttrShelf.getItemAttributes().setNomenclature(itemAttributesDTO.getNomenclature());
        itemAttrShelf.setQuantity(itemAttributesDTO.getQuantity());
        itemAttrShelf.getItemAttributes().setConditionType(itemAttributesDTO.getConditionType());
        if (itemAttributesDTO.getEndDate() != null) {
            itemAttrShelf.getItemAttributes().setEndDate(itemAttributesDTO.getEndDate());
        }
        if (itemAttributesDTO.getStartDate() != null) {
            itemAttrShelf.getItemAttributes().setStartDate(itemAttributesDTO.getStartDate());
        }
        itemAttrShelf.getItemAttributes().setUuid(itemAttributesDTO.getUuid());
        itemAttrShelf.getItemAttributes().setQuantity(itemAttributesDTO.getQuantity());
        itemAttrShelf.setShelves(shelf);
        itemAttrShelf.setShelfLevel(itemAttributesDTO.getShelfLevel());
        itemAttrShelf.setCellNumber(itemAttributesDTO.getCellNumber());
        return itemAttrShelf;
    }

    public static List<Walls> mapWalls(List<WallsDTO> wallsDTOS, Constructor constructor) {
        List<Walls> walls = new ArrayList<>();
        for (WallsDTO wallsDTO : wallsDTOS) {
            Walls wall = new Walls();
            wall.setId(wallsDTO.getId());
            wall.setCoordinateY(wallsDTO.getCoordinateY());
            wall.setCoordinateX(wallsDTO.getCoordinateX());
            wall.setFill(wallsDTO.getFill());
            wall.setOpacity(wallsDTO.getOpacity());
            wall.setDraggable(wallsDTO.isDraggable());
            wall.setName(wallsDTO.getName());
            wall.setWidth(wallsDTO.getWidth());
            wall.setHeight(wallsDTO.getHeight());
            wall.setConstructor(constructor);
            wall.setRotation(wallsDTO.getRotation());
            walls.add(wall);
        }
        return walls;
    }

    public static List<WallsDTO> nullifyWallsDtoIds(List<WallsDTO> wallsDTOS) {
        for (WallsDTO wallsDTO : wallsDTOS) {
            wallsDTO.setId(0);
        }
        return wallsDTOS;
    }

    public static List<Doorways> mapDoorways(List<DoorwaysDTO> doorwaysDTOS, Constructor constructor) {
        List<Doorways> doorways = new ArrayList<>();
        for (DoorwaysDTO doorwaysDTO : doorwaysDTOS) {
            Doorways doorway = new Doorways();
            doorway.setId(doorwaysDTO.getId());
            doorway.setCoordinateY(doorwaysDTO.getCoordinateY());
            doorway.setCoordinateX(doorwaysDTO.getCoordinateX());
            doorway.setDraggable(doorwaysDTO.isDraggable());
            doorway.setFillPatternImage(doorwaysDTO.getFillPatternImage());
            doorway.setHeight(doorwaysDTO.getHeight());
            doorway.setWidth(doorwaysDTO.getWidth());
            doorway.setName(doorwaysDTO.getName());
            doorway.setOpacity(doorwaysDTO.getOpacity());
            doorway.setConstructor(constructor);
            doorway.setRotation(doorwaysDTO.getRotation());
            doorways.add(doorway);
        }
        return doorways;
    }

    public static List<Windows> mapWindows(List<WindowsDTO> windowsDTOS, Constructor constructor) {
        List<Windows> windows = new ArrayList<>();
        for (WindowsDTO windowsDTO : windowsDTOS) {
            Windows window = new Windows();
            window.setId(windowsDTO.getId());
            window.setCoordinateY(windowsDTO.getCoordinateY());
            window.setCoordinateX(windowsDTO.getCoordinateX());
            window.setDraggable(windowsDTO.isDraggable());
            window.setFillPatternImage(windowsDTO.getFillPatternImage());
            window.setHeight(windowsDTO.getHeight());
            window.setWidth(windowsDTO.getWidth());
            window.setName(windowsDTO.getName());
            window.setOpacity(windowsDTO.getOpacity());
            window.setConstructor(constructor);
            window.setRotation(windowsDTO.getRotation());
            windows.add(window);
        }
        return windows;
    }

    public static List<Shelf> mapShelves(List<ShelfDTO> shelfDTOs, Constructor constructor) {
        List<Shelf> shelves = new ArrayList<>();
        for (ShelfDTO shelfDTO : shelfDTOs) {
            Shelf shelf = new Shelf();
            shelf.setId(shelfDTO.getId());
            shelf.setConstructor(constructor);
            shelf.setShelfLevel(shelfDTO.getShelfLevel());
            shelf.setCellsPerWidth(shelfDTO.getCellsPerWidth());
            shelf.setCellsPerDepth(shelfDTO.getCellsPerDepth());

            shelf.setCoordinateX(shelfDTO.getCoordinateX());
            shelf.setCoordinateY(shelfDTO.getCoordinateY());
            shelf.setFill(shelfDTO.getFill());
            shelf.setOpacity(shelfDTO.getOpacity());
            shelf.setDraggable(shelfDTO.isDraggable());
            shelf.setName(shelfDTO.getName());
            shelf.setWidth(shelfDTO.getWidth());
            shelf.setHeight(shelfDTO.getHeight());
            shelf.setRackHeight(shelfDTO.getRackHeight());
            shelf.setRackId(shelfDTO.getRackId());
            shelf.setRotation(shelfDTO.getRotation());
            shelf.setCellWidth(shelfDTO.getCellWidth());
            shelf.setCellHeight(shelfDTO.getCellHeight());
            shelves.add(shelf);
        }
        return shelves;
    }

    public static List<ShelfDTO> updateShelfDTOIds(List<ShelfDTO> shelfDTOS, List<Shelf> shelves) {
        for (ShelfDTO shelfDTO : shelfDTOS) {
            for (Shelf shelf : shelves) {
                if (shelfDTO.getRackId().equals(shelf.getRackId())) {
                    shelfDTO.setId(shelf.getId());
                }
            }
        }
        return shelfDTOS;
    }

    public static Constructor extractConstructor(ConstructorDTO constructorDTO) {
        Constructor constructor = new Constructor();
        constructor.setId(constructorDTO.getId());
        constructor.setHeight(constructorDTO.getHeight());
        constructor.setWidth(constructorDTO.getWidth());
        constructor.setName(constructorDTO.getName());
        return constructor;
    }

    public static List<ShelfDTO> getShelfDtosByZoneName(String zoneName, List<ShelfDTO> shelfDTOS) {
        List<ShelfDTO> zoneShelfDtos = new ArrayList<>();
        for (ShelfDTO shelfDTO : shelfDTOS) {
            if (shelfDTO.getZoneNames().contains(zoneName)) {
                zoneShelfDtos.add(shelfDTO);
            }
        }
        return zoneShelfDtos;
    }

    public TaskDto mapTaskDto(Task task, List<String> s3urls) {
        TaskDto taskDto = new TaskDto();
        taskDto.setId(task.getId());
        taskDto.setTaskType(task.getTaskType().getName());
        taskDto.setComment(task.getComments());
        taskDto.setUuid(task.getUuid());
        taskDto.setTaskStatusId(task.getTaskStatus().getId());
        Account account = accountService.getAccountByUserId(task.getUser().getId());
        taskDto.setUserDto(new UserDto(task.getUser(), account.getUsername()));
        Account manager = accountService.getAccountByUserId(task.getCreator().getId());
        taskDto.setManager(new UserDto(task.getCreator(), manager.getUsername()));
        List<TaskNomenclature> taskNomenclatures = taskNomenclatureService.getTaskNomenclature(taskDto.getId());
        List<ItemAttrShelf> itemAttrShelves = new ArrayList<>();
        for (TaskNomenclature taskNomenclature : taskNomenclatures) {
            taskNomenclature.getItemAttrShelf().setQuantity(taskNomenclature.getItemAttrShelf().getQuantity());
            itemAttrShelves.add(taskNomenclature.getItemAttrShelf());
        }
        taskDto.setItemAttributesDTO(EntityMapper.mapItemAttributesDTOList(itemAttrShelves));
        taskDto.setConstructorId(task.getConstructor().getId());
        taskDto.setCreateDate(task.getCreateDate());
        taskDto.setEditDate(task.getEditDate());
        taskDto.setFiles(s3urls);
        return taskDto;
    }

    public List<TaskDto> mapTaskDtoList(List<Task> taskList) {
        List<TaskFile> taskFiles = taskFileService.getByTaskId(taskList);
        List<TaskDto> taskDtos = new ArrayList<>();
        for (Task task : taskList) {
            List<String> s3urls = new ArrayList<>();
            for (TaskFile taskFile : taskFiles) {
                if (taskFile.getTask().getId().longValue() == task.getId().longValue()) {
                    s3urls.add(taskFile.getFile());
                }
            }
            taskDtos.add(mapTaskDto(task, s3urls));
        }
        return taskDtos;
    }

    public static ItemAttributes mapCreateItemAttributeDTO(CreateItemAttributeDTO createItemAttributeDTO) {
        ItemAttributes itemAttributes = new ItemAttributes();
        itemAttributes.setConditionType(createItemAttributeDTO.getConditionType());
        itemAttributes.setNomenclature(createItemAttributeDTO.getNomenclature());
        itemAttributes.setUnits(createItemAttributeDTO.getUnits());
        itemAttributes.setUuid(createItemAttributeDTO.getUuid());
        itemAttributes.setQuantity(createItemAttributeDTO.getQuantity());
        if (createItemAttributeDTO.getStartDate() != null) {
            itemAttributes.setStartDate(createItemAttributeDTO.getStartDate());
        }
        if (createItemAttributeDTO.getEndDate() != null) {
            itemAttributes.setEndDate(createItemAttributeDTO.getEndDate());
        }
        return itemAttributes;
    }

    public ItemAttrShelf mapItemAttrShelfDTO(ItemAttrShelfDTO itemAttrShelfDTO) {
        ItemAttrShelf itemAttrShelf = new ItemAttrShelf();
        itemAttrShelf.setCellNumber(itemAttrShelfDTO.getCellNumber());
        itemAttrShelf.setShelfLevel(itemAttrShelfDTO.getShelfLevel());
        itemAttrShelf.setQuantity(itemAttrShelfDTO.getQuantity());
        ItemAttributes ia = itemAttributesService.getById(itemAttrShelfDTO.getItemAttributeId());
        Shelf shelf = shelfService.getShelfById(itemAttrShelfDTO.getShelfId());
        itemAttrShelf.setItemAttributes(ia);
        itemAttrShelf.setShelves(shelf);
        return itemAttrShelf;
    }

    public static ItemAttrShelfDTO mapItemAttrShelf(ItemAttrShelf itemAttrShelf) {
        ItemAttrShelfDTO itemAttrShelfDTO = new ItemAttrShelfDTO();
        itemAttrShelfDTO.setShelfId(itemAttrShelf.getShelves().getId());
        itemAttrShelfDTO.setItemAttributeId(itemAttrShelf.getItemAttributes().getId());
        itemAttrShelfDTO.setShelfLevel(itemAttrShelf.getShelfLevel());
        itemAttrShelfDTO.setQuantity(itemAttrShelf.getQuantity());
        itemAttrShelfDTO.setCellNumber(itemAttrShelf.getCellNumber());
        return itemAttrShelfDTO;
    }

    public static ItemAttributesDTO mapItemAttributeDto(ItemAttrShelf itemAttrShelf){
        ItemAttributesDTO itemAttributesDTO = new ItemAttributesDTO();
        itemAttributesDTO.setId(itemAttrShelf.getId());
        itemAttributesDTO.setNomenclature(itemAttrShelf.getItemAttributes().getNomenclature());
        itemAttributesDTO.setUnits(itemAttrShelf.getItemAttributes().getUnits());
        if (itemAttrShelf.getQuantity() > 0) {
            itemAttributesDTO.setQuantity(itemAttrShelf.getQuantity());
        }else {
            throw new CRUDOperationException("Item attribute quantity cannot be > 0");
        }
        itemAttributesDTO.setCellNumber(itemAttrShelf.getCellNumber());
        itemAttributesDTO.setShelfLevel(itemAttrShelf.getShelfLevel());
        itemAttributesDTO.setConditionType(itemAttrShelf.getItemAttributes().getConditionType());
        itemAttributesDTO.setUuid(itemAttrShelf.getItemAttributes().getUuid());
        itemAttributesDTO.setShelfId(itemAttrShelf.getShelves().getId());
        if(itemAttrShelf.getItemAttributes().getStartDate() != null) {
            itemAttributesDTO.setStartDate(itemAttrShelf.getItemAttributes().getStartDate());
        }
        if(itemAttrShelf.getItemAttributes().getEndDate() != null) {
            itemAttributesDTO.setEndDate(itemAttrShelf.getItemAttributes().getEndDate());
        }
        return itemAttributesDTO;
    }
}
