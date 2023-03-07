public with sharing class WarehouseCalloutService {
    
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @future(callout=true)
    public static void runWarehouseEquipmentSync(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<Product2> equipmentList = new List<Product2>();
            
            for (Object record: results) {
                Map<String, Object> recordMap = (Map<String, Object>)record;
                Product2 equipment = new Product2();
                
                equipment.Name = (String)recordMap.get('name');
                equipment.Cost__c = (Decimal)recordMap.get('cost');
                equipment.ProductCode = (String)recordMap.get('_id');
                equipment.Current_Inventory__c = (Integer)recordMap.get('quantity');
                equipment.Maintenance_Cycle__c = (Integer)recordMap.get('maintenanceperiod');
                equipment.Replacement_Part__c = (Boolean)recordMap.get('replacement');
                equipment.Lifespan_Months__c = (Integer)recordMap.get('lifespan');
                equipment.Warehouse_SKU__c = (String)recordMap.get('sku');
                
                equipmentList.add(equipment);
            }
            
            if(equipmentList.size() > 0){
                upsert equipmentList;
            }
        }
        
    }
    
    
    
}
