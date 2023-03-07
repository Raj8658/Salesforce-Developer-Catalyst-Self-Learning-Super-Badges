public class WarehouseSyncSchedule implements Schedulable{
  // implement scheduled code here
    public void execute(System.SchedulableContext context){
        WarehouseCalloutService.runWarehouseEquipmentSync();
    }
}
