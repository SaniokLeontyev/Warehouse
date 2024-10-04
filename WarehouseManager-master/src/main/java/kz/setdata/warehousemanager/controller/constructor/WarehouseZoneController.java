package kz.setdata.warehousemanager.controller.constructor;


import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.service.constructor.WarehouseZoneService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/warehouse/zones")
@Api(value = "Operations related to zones", tags = {"Zones"})
@RequiredArgsConstructor
public class WarehouseZoneController {

    private final WarehouseZoneService warehouseZoneService;

    @GetMapping
    public ResponseEntity<ResponseDto> getAll(){
        return ResponseEntity.ok(ResponseDto.success(warehouseZoneService.getAll()));
    }

    @PutMapping("/{constructorId}")
    public ResponseEntity<ResponseDto> save(@RequestBody ConstructorDTO constructorDTO, @PathVariable long constructorId){
        return ResponseEntity.ok(ResponseDto.success(warehouseZoneService.save(constructorDTO, constructorId)));
    }

    @PatchMapping
    public ResponseEntity<ResponseDto> update(@RequestBody ConstructorDTO constructorDTO){
        return ResponseEntity.ok(ResponseDto.success(warehouseZoneService.update(constructorDTO)));
    }

    @DeleteMapping
    public ResponseEntity<ResponseDto> delete(@RequestBody List<Long> zones){
        return ResponseEntity.ok(ResponseDto.success(warehouseZoneService.delete(zones)));
    }
}
