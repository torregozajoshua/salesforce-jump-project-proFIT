@IsTest
public with sharing class EventRestService_TEST {
    static Id createEventTestRecord(){
        Event__c evt = new Event__c();
        evt.Name = 'Test Record';
        evt.Start_DateTime__c = datetime.newInstance(2021, 6, 26, 11, 00, 0);
        evt.End_DateTime__c = datetime.newInstance(2021, 6, 27, 12, 00, 0);
        evt.Event_Type__c ='Virtual';
        evt.Live__c = true;
        evt.Status__c = 'Created';
        evt.Max_Seats__c = 3;
        insert evt;
        return evt.Id;
    }
    @IsTest
    static void doGetTest(){
        Test.startTest();
            Id EventId =  createEventTestRecord();
            RestRequest req = new RestRequest();
            req.requestURI = 'convergellc29--profitsbox.my.salesforce.com/services/apexrest/api/Event__c/'+EventId;
            req.httpMethod = 'GET';
            RestContext.request = req;
            Event__c evt = EventRestService.doGetEvt();           
        Test.stopTest();
        System.assertEquals(EventId, evt.Id);
    }
}
