@IsTest
public with sharing class AttendeeEvent_TEST {
    static Id createTestNewEvent(){
        Event__c evt = new Event__c();
        evt.Name = 'Test Event';
        evt.Start_DateTime__c = datetime.newInstance(2021, 7, 20, 19, 30, 0);
        evt.End_DateTime__c = datetime.newInstance(2021, 7, 21, 19, 30, 0);
        evt.Max_Seats__c = 10;
        evt.Live__c = true;
        insert evt;
        return evt.Id;
    }
    static Id createTestOldEvent(){
        Event__c evt = new Event__c();
        evt.Name = 'Test Event';
        evt.Start_DateTime__c = datetime.newInstance(2021, 3, 21, 19, 30, 0);
        evt.End_DateTime__c = datetime.newInstance(2021, 3, 23, 19, 30, 0);
        evt.Max_Seats__c = 10;
        evt.Live__c = true;
        insert evt;
        return evt.Id;
    }
    static Id createTestAttendee(){
        Attendee__c att = new Attendee__c();
        att.Name = 'Test Attendee';
        insert att;
        return att.Id;
    }
    @isTest
    static void testUpcomingEvents(){
        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Event__c = createTestNewEvent();
        eA.Attendee__c = createTestAttendee();
        eA.Name = 'Test Event Attendee';
        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = AttendeeDetailsController.upcomingEvents(eA.Attendee__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
        System.assertEquals('Test Event Attendee', name.Name);
    }
    @isTest
    static void testPastEvents(){
        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Event__c = createTestOldEvent();
        eA.Attendee__c = createTestAttendee();
        
        eA.Name = 'Test Event Attendee';
        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = AttendeeDetailsController.pastEvents(eA.Attendee__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
        System.assertEquals('Test Event Attendee', name.Name);
    }
}
