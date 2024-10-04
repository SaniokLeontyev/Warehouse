package kz.setdata.warehousemanager.model.dto.integration1C;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class NomenclatureDTO {

    private String barcode;
    private String cod;
    private String name;
    @JsonProperty("articul")
    private String article;
    private String uuid;

}
