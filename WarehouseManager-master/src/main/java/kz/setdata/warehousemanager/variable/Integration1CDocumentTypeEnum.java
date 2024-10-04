package kz.setdata.warehousemanager.variable;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum Integration1CDocumentTypeEnum {
    BUYING("buying"),
    SALE("sale"),
    MOVING("moving"),   //Перемещение товаров
    INVENTORY("inventory"),
    WRITING_OFF("writingoff");  //Списание товаров

    private final String value;
}

