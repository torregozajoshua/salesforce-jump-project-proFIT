public class EventAttendeeTriggerhandler {
    
    public static void sendConfirmationEmail(List<Event_Attendee__c> newRecordList ) {        
        Set<Id> attendeeSet = new Set<Id>();
        Set<Id> eventSet = new Set<Id>();
        
        for(Event_Attendee__c evtAttendee : newRecordList){
            attendeeSet.add(evtAttendee.Attendee__c);
            eventSet.add(evtAttendee.Event__c);
        }
        
        Map<Id,Attendee__c> attendeeMap = new Map<Id,Attendee__c>([Select Id, Name, Email__c From Attendee__c WHERE  Id IN : attendeeSet]);
        
        Map<Id, Event__c > eventMap = new Map<Id, Event__c > ( [Select Id, Name, Start_DateTime__c, Event_Organizer__c, Event_Organizer__r.Name, Location__c , Location__r.Name, Location__r.City__c, Location__r.State__c, Location__r.Country__c, Location__r.Street__c FROM Event__c  WHERE ID IN: eventSet]);
        
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        for(Event_Attendee__c evtAttendee : newRecordList){
            Attendee__c att = attendeeMap.get(evtAttendee.Attendee__c);
            Event__c evt = eventMap.get(evtAttendee.Event__c);
              
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            mail.setSubject('Pass for the '+evt.Name);
            List<String> toAddress = new List<String>();
            toAddress.add(att.Email__c);
            mail.setToAddresses( toAddress );
            mail.setSenderDisplayName(evt.Event_Organizer__r.Name);
            
            String location = 'https://www.google.com/maps/place/'+evt.Location__r.Street__c+' '+evt.Location__r.City__c+' '
                +evt.Location__r.State__c+' '+
                evt.Location__r.Country__c;

            String hrefForLocation = '<a href="'+location+'"'+'target="_blank">Here</a>';
            String emailBody = 'Dear '+ att.Name + ',<br/><br/>'+
                'Thank you for registering for '+evt.Name+' which will be organized on '+
                evt.Start_DateTime__c+' and will be held in '+evt.Location__r.Name
                +'.<br/>We are excited to have you,'+ 
                'see you in the event. <br/><br/>'+
                'Find the Google Map Location for the Event '+hrefForLocation+'.<br/><br/><br/>'+
                'Thanks,<br/>'+evt.Event_Organizer__r.Name;
            
            mail.setHtmlBody(emailBody);
            emailList.add(mail);
            
        }
        
        try{
            List<Messaging.SendEmailResult> results =  Messaging.sendEmail(emailList, false); 
            for(Messaging.SendEmailResult email : results){
                System.debug(email.isSuccess());
                if(!email.isSuccess()){
                    List<Messaging.SendEmailError> errors = email.getErrors();
                  
                }
            }  
        }catch(Exception ex){
            System.debug(ex.getMessage());
        }
    }
}