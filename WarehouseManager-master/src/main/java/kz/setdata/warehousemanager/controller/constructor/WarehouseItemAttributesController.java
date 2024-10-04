package kz.setdata.warehousemanager.controller.constructor;

import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.service.constructor.WarehouseItemAttributesService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/warehouse/itemAttributes")
@Api(value = "Operations related to item attributes", tags = {"Item Attributes"})
@RequiredArgsConstructor
public class WarehouseItemAttributesController {

    private final WarehouseItemAttributesService warehouseItemAttributesService;

    @PutMapping("/{constructorId}")
    public ResponseEntity<ResponseDto> save(@RequestBody ConstructorDTO constructorDTO, @PathVariable long constructorId){
        return ResponseEntity.ok(ResponseDto.success(warehouseItemAttributesService.saveItemAttrs(constructorDTO)));
    }

    @PatchMapping
    public ResponseEntity<ResponseDto> update(@RequestBody ConstructorDTO constructorDTO){
        return ResponseEntity.ok(ResponseDto.success(warehouseItemAttributesService.update(constructorDTO)));
    }

    @DeleteMapping
    public ResponseEntity<ResponseDto> delete(@RequestBody List<Long> itemAttributes){
        return ResponseEntity.ok(ResponseDto.success(warehouseItemAttributesService.delete(itemAttributes)));
    }

    @GetMapping("/{shelfId}")
    public ResponseEntity<ResponseDto> getByShelfId(@PathVariable long shelfId){
        return ResponseEntity.ok(ResponseDto.success(warehouseItemAttributesService.getByShelfId(shelfId)));
    }

    @GetMapping("/{name}")
    public ResponseEntity<ResponseDto> getName(@PathVariable String name){
        return ResponseEntity.ok(ResponseDto.success(warehouseItemAttributesService.getByNamed(name)));
    }
}
