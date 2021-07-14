trigger EventAttendeeTrigger on Event_Attendee__c (before insert, before update) {
    EventAttendeeTriggerhandler.sendConfirmationEmail(Trigger.new);
}