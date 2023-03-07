
@IsTest
private class AccountManagerTest{
    @isTest static void testAccountManager(){
        Id recordId = getTestAccountId();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://ap5.salesforce.com/services/apexrest/Accounts/'+ recordId +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        // Call the method to test
        Account  acc = AccountManager.getAccount();
        
        // Verify results
        System.assert(acc != null);
    }
    
    private static Id getTestAccountId(){
        Account acc = new Account(Name = 'TestAcc2');
        Insert acc;
         
        Contact con = new Contact(LastName = 'TestCont2', AccountId = acc.Id);
        Insert con;
        
        return acc.Id;
    }
}
