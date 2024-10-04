package kz.setdata.warehousemanager.variable;

import lombok.experimental.UtilityClass;

import java.util.UUID;

@UtilityClass
public final class Util {

    public String generateUUID(){
        return UUID.randomUUID().toString();
    }
}
