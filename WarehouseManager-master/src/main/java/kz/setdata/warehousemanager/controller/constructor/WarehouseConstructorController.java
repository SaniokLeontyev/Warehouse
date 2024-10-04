package kz.setdata.warehousemanager.controller.constructor;

import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.service.constructor.WarehouseConstructorService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/warehouse")
@Api(value = "Operations related to constructor", tags = {"Constructor"})
public class WarehouseConstructorController {
    private final WarehouseConstructorService warehouseConstructorService;

    @GetMapping
    public ResponseEntity<ResponseDto> getWarehouses(){
        return ResponseEntity.ok(ResponseDto.success(warehouseConstructorService.getAllWarehouses()));
    }

    @GetMapping("/{warehouseId}")
    public ResponseEntity<ResponseDto> getWarehouseById(@PathVariable long warehouseId){
        return ResponseEntity.ok(ResponseDto.success(warehouseConstructorService.getWarehouseById(warehouseId)));
    }

    @PutMapping
    public ResponseEntity<ResponseDto> saveWarehouse(@RequestBody ConstructorDTO constructorDTO){
        return ResponseEntity.ok( ResponseDto.success(warehouseConstructorService.saveWarehouse(constructorDTO)));
    }

    @PutMapping("/constructor")
    public ResponseEntity<ResponseDto> saveWarehouseConstructor(@RequestBody ConstructorDTO constructorDTO){
        return ResponseEntity.ok(ResponseDto.success(warehouseConstructorService.saveWarehouseConstructor(constructorDTO)));
    }

    @DeleteMapping("/{warehouseId}")
    public ResponseEntity<ResponseDto> deleteWarehouse(@PathVariable long warehouseId){
        return ResponseEntity.ok(ResponseDto.success(warehouseConstructorService.delete(warehouseId)));
    }

}