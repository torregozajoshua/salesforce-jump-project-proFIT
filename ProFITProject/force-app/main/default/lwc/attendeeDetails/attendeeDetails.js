import { LightningElement, track, wire, api } from 'lwc';
import upcomingEvents from "@salesforce/apex/AttendeeDetailsController.upcomingEvents";
import pastEvents from "@salesforce/apex/AttendeeDetailsController.pastEvents";

export default class AttendeeDetails extends LightningElement {
    @api recordId;
    @track eventCol = [
        {
            label: 'Name',
            fieldName: 'Name',
            type: 'text',
            sortable: true
        },
        {
            label: 'Location',
            fieldName: 'Location__c',
            type: 'text',
            sortable: true
        },
        {
            label: 'Start Date',
            fieldName: 'Start_DateTime__c',
            type: 'datetime',            
            sortable: true
        },
        {
            label: 'End Date',
            fieldName: 'End_DateTime__c',
            type: 'datetime',
            sortable: true
        }        
    ];

    @track pastEventsList;
    @wire (pastEvents, {attendeeId: '$recordId'}) wiredPastEvents({error,data}){
        var returnOptions =[];
        if(data){
            console.log(data);
        data.forEach(ele => {
            var loc;
            if(ele.Event__r.Location__r){
                loc = ele.Event__r.Location__r.Name;
            }else{
                loc = 'This is Virtual';
            }
          returnOptions.push(
                {                      
                    Name:ele.Event__r.Name,
                    Start_DateTime__c:ele.Event__r.Start_DateTime__c,                
                    End_DateTime__c:ele.Event__r.End_DateTime__c,
                    Location__c : loc
                }
            );  
        });
        this.pastEventsList = returnOptions;
      }
    }


    @track upcomingEventsList;
    @wire (upcomingEvents, {attendeeId: '$recordId'}) wiredUpcomingEvents({error,data}){
        var returnOptions =[];
        if(data){
            console.log(data);
        data.forEach(ele => {
            var loc;
            if(ele.Event__r.Location__r){
                loc = ele.Event__r.Location__r.Name;
            }else{
                loc = 'This is Virtual';
            }
          returnOptions.push(
                {
                    Name:ele.Event__r.Name,
                    Start_DateTime__c:ele.Event__r.Start_DateTime__c,                
                    End_DateTime__c:ele.Event__r.End_DateTime__c,
                    Location__c : loc
                }
            );  
        });
        this.upcomingEventsList = returnOptions;
      }
    }

}