package kz.setdata.warehousemanager.controller;

import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.model.dto.ItemAttrShelfDTO;
import kz.setdata.warehousemanager.model.dto.MoveItemAttributeDTO;
import kz.setdata.warehousemanager.model.dto.form.CreateItemAttributeDTO;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.repository.impl.ItemAttrShelfService;
import kz.setdata.warehousemanager.repository.impl.ItemAttributesService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/itemAttrShelf")
@RestController
@Api(value = "Operations related to nomenclature on shelf", tags = {"Item Attrs"})
public class ItemAttrShelfController {

    private final ItemAttrShelfService itemAttrShelfService;
    private final ItemAttributesService itemAttributesService;

    @PatchMapping("/move")
    public ResponseEntity<ResponseDto> update(@RequestBody MoveItemAttributeDTO moveItemAttributeDTO){
        return ResponseEntity.ok(ResponseDto.success(itemAttrShelfService.moveItemAttrs(moveItemAttributeDTO)));
    }

    @PutMapping
    public ResponseEntity<ResponseDto> create(@RequestBody CreateItemAttributeDTO createItemAttributeDTO){
        return ResponseEntity.ok(ResponseDto.success(itemAttributesService.create(createItemAttributeDTO)));
    }

    @PatchMapping("/toShelf")
    public ResponseEntity<ResponseDto> toShelf(@RequestBody ItemAttrShelfDTO itemAttrShelfDTO){
        return ResponseEntity.ok(ResponseDto.success(itemAttrShelfService.create(itemAttrShelfDTO)));
    }
}
