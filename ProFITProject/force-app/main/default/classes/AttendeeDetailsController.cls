public with sharing class AttendeeDetailsController {
    //get upcoming events
    @AuraEnabled(cacheable=true)
    public static List<Event_Attendee__c> upcomingEvents(String attendeeId) {
        List<Event_Attendee__c> eventLists = [SELECT Id, Name, Event__c, Event__r.Location__c, Event__r.Location__r.Name, Event__r.Name, Event__r.Start_DateTime__c, Event__r.End_DateTime__c FROM Event_Attendee__c WHERE Attendee__c = :attendeeId AND Event__r.Start_DateTime__c >= today AND Event__r.Live__c = true];
        return eventLists;

    }
    //get past events
    @AuraEnabled(cacheable=true)
    public static List<Event_Attendee__c> pastEvents(String attendeeId) {
        List<Event_Attendee__c> eventLists = [ SELECT Id, Name, Event__c, Event__r.Location__c, Event__r.Location__r.Name, Event__r.Name, Event__r.Start_DateTime__c, Event__r.End_DateTime__c FROM Event_Attendee__c WHERE Attendee__c = :attendeeId AND Event__r.Start_DateTime__c < today];
        return eventLists;
    }
}
