public class MaintenanceRequestHelper {
    
    public static void createNewRequest(Map<Id, Case> validCaseMap){
        List<Case> newCases = new List<Case>();
        Map<Id, Integer> productMaintenanceCycleMap = new Map<Id, Integer>();
        Map<Id, Integer> workPartMaintenanceCycleMap = new Map<Id, Integer>();
        
		for (Product2 productHere : [select Id, Maintenance_Cycle__c from Product2]) {
            if (productHere.Maintenance_Cycle__c != null) {
                productMaintenanceCycleMap.put(productHere.Id, Integer.valueOf(productHere.Maintenance_Cycle__c));               
            }
        }
        
        for (Work_Part__c workPart : [select Id, Equipment__c, Maintenance_Request__c from Work_Part__c where Maintenance_Request__c in :validCaseMap.keySet()]) {
            if (workPart.Equipment__c != null) {
                if(!workPartMaintenanceCycleMap.containsKey(workPart.Maintenance_Request__c)){
                    workPartMaintenanceCycleMap.put(workPart.Maintenance_Request__c, productMaintenanceCycleMap.get(workPart.Equipment__c));   
                }
                else if(productMaintenanceCycleMap.get(workPart.Equipment__c) < workPartMaintenanceCycleMap.get(workPart.Maintenance_Request__c)){
                    workPartMaintenanceCycleMap.put(workPart.Maintenance_Request__c, productMaintenanceCycleMap.get(workPart.Equipment__c));  
                }             
            }
        }
        
        for(Case caseHere: validCaseMap.values()){
            Case newCase = new Case();
            newCase.Vehicle__c = caseHere.Vehicle__c;
            newCase.Equipment__c = caseHere.Equipment__c;
            newCase.Type = 'Routine Maintenance';
            newCase.Subject = String.isBlank(caseHere.Subject) ? 'Routine Maintenance Request' : caseHere.Subject + ' New';
            newCase.Date_Reported__c = Date.today();
            newCase.Date_Due__c = workPartMaintenanceCycleMap.containsKey(caseHere.Product__c) ? Date.today().addDays(workPartMaintenanceCycleMap.get(caseHere.Product__c)) : Date.today();
            newCase.Status = 'New';
            newCase.Product__c = caseHere.Product__c;
            newCase.AccountId = caseHere.AccountId;
            newCase.ContactId = caseHere.ContactId;
            newCase.AssetId = caseHere.AssetId;
            newCase.Origin = caseHere.Origin;
            newCase.Reason = caseHere.Reason;
          	
            newCases.add(newCase);
        }
        
        if(newCases.size() > 0){
            insert newCases;
        }
    }

}
