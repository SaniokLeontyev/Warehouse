package kz.setdata.warehousemanager.controller.integration1C;

import io.swagger.annotations.Api;
import kz.setdata.warehousemanager.model.dto.general.ResponseDto;
import kz.setdata.warehousemanager.model.dto.integration1C.NomenclatureDTO;
import kz.setdata.warehousemanager.service.integration1C.Integration1CService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/1c")
@RestController
@Api(value = "Operations related to 1c", tags = {"1C"})
public class Integration1CController {

    private final Integration1CService integration1CService;

    @GetMapping("/nomenclatures")
    public ResponseEntity<ResponseDto> getNomenclatures(@RequestParam(name = "uuid",required = false) String uuid,
                                                        @RequestParam(name = "name",required = false) String name){
        List<NomenclatureDTO> nomenclatureDTOList = integration1CService.getNomenclatures();
        if (uuid != null){
            return ResponseEntity.ok(ResponseDto.success(integration1CService.getNomenclatureByUUID(uuid)));
        }else if (name != null){
            return ResponseEntity.ok(ResponseDto.success(integration1CService.getNomenclatureByName(nomenclatureDTOList,name)));
        }
        return ResponseEntity.ok(ResponseDto.success(integration1CService.getNomenclatures()));
    }

    @GetMapping("/warehouses")
    public ResponseEntity<ResponseDto> getWarehouses(){
        return ResponseEntity.ok(ResponseDto.success(integration1CService.getWarehouses()));
    }

    @GetMapping("/measures")
    public ResponseEntity<ResponseDto> getMeasures(){
        return ResponseEntity.ok(ResponseDto.success(integration1CService.getMeasures()));
    }

    @GetMapping("/documents/buying/{dateFrom}/{dateTo}")
    public ResponseEntity<ResponseDto> getDocumentsBuying(@PathVariable String dateFrom, @PathVariable String dateTo){
        return ResponseEntity.ok(ResponseDto.success(integration1CService.getBuyingDocuments(dateFrom,dateTo)));
    }

    @GetMapping("/documents/sale/{dateFrom}/{dateTo}")
    public ResponseEntity<ResponseDto> getDocumentsSale(@PathVariable String dateFrom, @PathVariable String dateTo){
        return ResponseEntity.ok(ResponseDto.success(integration1CService.getSaleDocuments(dateFrom,dateTo)));
    }

    @GetMapping("/documents/moving/{dateFrom}/{dateTo}")
    public ResponseEntity<ResponseDto> getMovingDocuments(@PathVariable String dateFrom, @PathVariable String dateTo){
        return ResponseEntity.ok(ResponseDto.success(integration1CService.getMovingDocuments(dateFrom,dateTo)));
    }

    @GetMapping("/documents/inventory/{dateFrom}/{dateTo}")
    public ResponseEntity<ResponseDto> getInventoryDocuments(@PathVariable String dateFrom, @PathVariable String dateTo){
        return ResponseEntity.ok(ResponseDto.success(integration1CService.getInventoryDocuments(dateFrom,dateTo)));
    }

    @GetMapping("/documents/writingOf/{dateFrom}/{dateTo}")
    public ResponseEntity<ResponseDto> getWritingOfDocuments(@PathVariable String dateFrom, @PathVariable String dateTo){
        return ResponseEntity.ok(ResponseDto.success(integration1CService.getWritingOfDocuments(dateFrom,dateTo)));
    }

}
