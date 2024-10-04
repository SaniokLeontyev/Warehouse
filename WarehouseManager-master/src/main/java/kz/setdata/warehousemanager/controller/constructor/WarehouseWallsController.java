package kz.setdata.warehousemanager.controller.constructor;

import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.model.dto.constructor.ConstructorDTO;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.service.constructor.WarehouseWallsService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/warehouse/walls")
@Api(value = "Operations related to walls", tags = {"Walls"})
@RequiredArgsConstructor
public class WarehouseWallsController {

    private final WarehouseWallsService wallsService;

    @GetMapping
    public ResponseEntity<ResponseDto> getAll(){
        return ResponseEntity.ok(ResponseDto.success(wallsService.getAll()));
    }

    @PutMapping("/{constructorId}")
    public ResponseEntity<ResponseDto> save(@RequestBody ConstructorDTO constructorDTO, @PathVariable long constructorId){
        return ResponseEntity.ok(ResponseDto.success(wallsService.save(constructorDTO,constructorId)));
    }

    @PatchMapping
    public ResponseEntity<ResponseDto> update(@RequestBody ConstructorDTO constructorDTO){
        return ResponseEntity.ok(ResponseDto.success(wallsService.update(constructorDTO)));
    }

    @DeleteMapping
    public ResponseEntity<ResponseDto> delete(@RequestBody List<Long> walls){
        return ResponseEntity.ok(ResponseDto.success(wallsService.delete(walls)));
    }

}
