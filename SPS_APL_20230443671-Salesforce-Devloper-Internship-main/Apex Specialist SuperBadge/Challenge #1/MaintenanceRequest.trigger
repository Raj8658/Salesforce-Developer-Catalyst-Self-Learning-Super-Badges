trigger MaintenanceRequest on Case (before update, after update) {
    
    Map<Id,Case> validCaseMap = new Map<Id,Case>();
    
    if(Trigger.isUpdate  && Trigger.isAfter){       
        for(Case caseHere: Trigger.new){
            if (caseHere.IsClosed && (caseHere.Type.equals('Repair') || caseHere.Type.equals('Routine Maintenance'))){
                validCaseMap.put(caseHere.Id, caseHere);
            }
        }
        
        if(!validCaseMap.values().isEmpty()){
        	MaintenanceRequestHelper.createNewRequest(validCaseMap);    
        }        
    }
    
}
