public class AnimalLocator {
	public class cls_animal {
		public Integer id;	
		public String name;	
		public String eats;	
		public String says;	
	}    
public class JSONOutput{
	public cls_animal animal;

   	//public JSONOutput parse(String json){
	//return (JSONOutput) System.JSON.deserialize(json, JSONOutput.class);
	//}
}
    
    public static String getAnimalNameById (Integer id) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        //request.setHeader('id', String.valueof(id)); -- cannot be used in this challenge :)
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug('response: ' + response.getBody());
        //Map<String,Object> map_results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
        jsonOutput results = (jsonOutput) JSON.deserialize(response.getBody(), jsonOutput.class);
        //Object results = (Object) map_results.get('animal');
		system.debug('results= ' + results.animal.name);
        return(results.animal.name);
    }

}
