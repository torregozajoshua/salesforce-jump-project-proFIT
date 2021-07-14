public class DeleteEventBatchClass implements Database.Batchable<sObject> {
    
    //set the query
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        String query = 'Select Id, Name From Event__c Where Live__c = false AND Status__c != \'Completed\' AND End_DateTime__c < LAST_N_MONTHS:4';
        return Database.getQueryLocator(query);
    }

    //update the record
    public void execute(Database.BatchableContext batchContext, List<Event__c> eventList ){
        if(!eventList.isEmpty()){
            List<Event__c> updateEvtRecsList = new List<Event__c>();
            for(Event__c evt: eventList){
                evt.Status__c = 'Deleted';
                updateEvtRecsList.add(evt);                
            }
            update updateEvtRecsList;
        }
    }
    
    //send an email
    public void finish(Database.BatchableContext batchContext){
        String userName = UserInfo.getUserName();
        User activeUser = [Select Name,Email From User where Username = : userName limit 1];
        String userEmail = activeUser.Email;
        String userWholeName = activeUser.Name;
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setSubject('Batch Processing Completed');
        List<String> toAddress = new List<String>();
        toAddress.add(userEmail);
        mail.setToAddresses( toAddress );
        mail.setSenderDisplayName(userWholeName);
        
        mail.setHtmlBody('Event status to deleted has been processed.');
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        emails.add(mail);
        Messaging.sendEmail(emails);
    }
}