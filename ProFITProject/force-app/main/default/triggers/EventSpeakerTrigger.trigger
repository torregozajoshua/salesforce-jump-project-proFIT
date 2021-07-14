trigger EventSpeakerTrigger on Event_Speaker__c (before insert, before update) {
    LogHandler.doubleBooking(Trigger.new);
}