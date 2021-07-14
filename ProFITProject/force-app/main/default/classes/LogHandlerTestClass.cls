@IsTest
public with sharing class LogHandlerTestClass {  
    Static Id createTestEvent(){
        Event__c evt = new Event__c();
        evt.Name = 'Test Event';
        evt.Live__c = true;
        evt.Start_DateTime__c = datetime.newInstance(2021, 6, 21, 9, 00, 0);
        evt.End_DateTime__c = datetime.newInstance(2021, 6, 22, 12, 00, 0);
        insert evt;
        return evt.Id;
    }

    Static Id createTestSpeaker(){
        Speaker__c spk = new Speaker__c();
        spk.Name = 'Joshua Torregoza';
        insert spk;
        return spk.Id;
    }

    @IsTest
    Static void checkEventEspeaker(){
    try {
        Test.startTest();

        Event_Speaker__c eS = new Event_Speaker__c();
        eS.Name = 'Test Event-Speaker';
        eS.Event__c = createTestEvent();
        eS.Speaker__c = createTestSpeaker();
        
        insert eS;
        

        Event_Speaker__c retrievedES = [Select Name from Event_Speaker__c where Name =: eS.Name];
        System.assertEquals('Test Event-Speaker',retrievedES.Name);
        
    } catch (Exception ex) {
        System.debug(ex);
        Test.stopTest();
        }        
    }
}