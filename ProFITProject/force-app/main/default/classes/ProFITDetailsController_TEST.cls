@IsTest
public with sharing class ProFITDetailsController_TEST {

    static Id createTestEvent(){
        Event__c evt = new Event__c();
        evt.Name = 'Test Event';
        evt.Start_DateTime__c = datetime.newInstance(2021, 12, 21, 12, 0, 0);
        evt.End_DateTime__c = datetime.newInstance(2021, 12, 22, 12, 0, 0);
        evt.Max_Seats__c = 10;
        evt.Live__c = true;
        insert evt;
        return evt.Id;
    }
    static Id createTestSpeaker(){
        Speaker__c spk = new Speaker__c();
        spk.Name = 'Test Spek';
        insert spk;
        return spk.Id;
    }
    static Id createTestAttendee(){
        Attendee__c att = new Attendee__c();
        att.Name = 'Test Attendee';
        insert att;
        return att.Id;
    }
    @IsTest
    static void testSpeaker(){
        
        Test.startTest();
        String recId;
        Event_Speaker__c eS = new Event_Speaker__c();
        eS.Event__c = createTestEvent();
        eS.Speaker__c = createTestSpeaker();
        eS.Name = 'Test Name';
        Event_Speaker__c name;
        String str = '';
        insert eS;
        List<Event_Speaker__c> retrievedSpeaker = ProFITDetailsController.getSpeakers(eS.Event__c);
        //Event_Speaker__c acquiredSpeaker = [SELECT Id,Name FROM Event_Speaker__c];
        name = retrievedSpeaker.get(0);
        Test.stopTest();
        System.assertEquals('Test Name',name.Name);
    }
    @IsTest
    static void testLocation(){
        Test.startTest();
        String recId = createTestEvent();
        Event__c evts = ProFITDetailsController.getLocationDetails(recId);
        Test.stopTest();
        System.assertEquals('Test Event',evts.Name);
    }
    @IsTest
    static void testAttendee(){
        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Attendee__c = createTestAttendee();
        eA.Event__c = createTestEvent();
        eA.Name = 'Test EA';
        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = ProFITDetailsController.getAttendees(eA.Event__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
        System.assertEquals('Test EA', name.Name);
    }
}
