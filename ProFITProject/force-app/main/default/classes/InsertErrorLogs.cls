public class InsertErrorLogs {
    public static void setErrorLog(String logDetails, DateTime  logDateTime, String processName){
        Error_Log__c errLog = new Error_Log__c();

        errLog.Log_Details__c = logDetails;
        errLog.Log_DateTime__c = logDateTime;
        errLog.Process_Name__c = processName;
           
        insert errLog;
    }
}