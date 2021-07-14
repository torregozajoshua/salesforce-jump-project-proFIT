@IsTest
public with sharing class EventAttendeeTriggerHandler_TEST {

    public static void setupData(){        
        Event_Organizer__c  org = new Event_Organizer__c (
            Name = 'Joshua Torregoza',
            Phone__c = '09982242911',
            Email__c = 'torregozajoshua@gmail.com'
        );
        insert org;
        
        Event__c event = new Event__c(
            Name = 'Joshuas Birthday',
            Event_Organizer__c  = org.Id,
            Event_Type__c = 'Virtual',
            Max_Seats__c  = 199,
            Live__c = true,
            Start_DateTime__c = System.now(),
            End_DateTime__c  = System.now().addDays(3)
        );
        insert event;
        Attendee__c att = new Attendee__c(
            Name = 'Test Attendee 99',
            Email__c = 'test_attendeee@gmail.com',
            Phone__c = '09278772049'
        );
        insert att;
        
        Event_Attendee__c evtAtt = new Event_Attendee__c(Event__c = event.Id, Attendee__c = att.Id);
        insert evtAtt;
    }
    
    @isTest
    static void sendEmailTest(){
        Test.startTest();
        List <Event_Attendee__c> evtAtt = [Select Id, Name, Attendee__c, Event__c from Event_Attendee__c];
        EventAttendeeTriggerHandler.sendConfirmationEmail(evtAtt);
        Test.stopTest();
    }
}
