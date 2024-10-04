package kz.setdata.warehousemanager.controller.constructor;

import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.service.constructor.WarehouseShelvesService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/warehouse/shelves")
@Api(value = "Operations related to shelves", tags = {"Shelves"})
@RequiredArgsConstructor
public class WarehouseShelvesController {

    private final WarehouseShelvesService warehouseShelvesService;

    @GetMapping
    public ResponseEntity<ResponseDto> getAll(){
        return ResponseEntity.ok(ResponseDto.success(warehouseShelvesService.getAll()));
    }

    @PutMapping("/{constructorId}")
    public ResponseEntity<ResponseDto> save(@RequestBody ConstructorDTO constructorDTO, @PathVariable long constructorId){
        return ResponseEntity.ok(ResponseDto.success(warehouseShelvesService.save(constructorDTO, constructorId)));
    }

    @PatchMapping
    public ResponseEntity<ResponseDto> update(@RequestBody ConstructorDTO constructorDTO){
        return ResponseEntity.ok(ResponseDto.success(warehouseShelvesService.update(constructorDTO)));
    }

    @DeleteMapping()
    public ResponseEntity<ResponseDto> delete(@RequestBody List<Long> shelves){
        return ResponseEntity.ok(ResponseDto.success(warehouseShelvesService.delete(shelves)));
    }
}
