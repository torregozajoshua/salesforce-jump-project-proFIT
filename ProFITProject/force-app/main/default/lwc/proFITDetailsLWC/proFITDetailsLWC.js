import { LightningElement, api, track, wire } from "lwc";
import getSpeakers from "@salesforce/apex/ProFITDetailsController.getSpeakers";
import getLocationDetails from "@salesforce/apex/ProFITDetailsController.getLocationDetails";
import getAttendees from "@salesforce/apex/ProFITDetailsController.getAttendees";

const columns = [
  {
    label: "Name",
    fieldName: "Name",
    cellAttributes: {
      iconName: "standard:user",
      iconPosition: "left"
    }
  },
  { label: "Email", fieldName: "Email", type: "email" },
  { label: "Phone", fieldName: "Phone", type: "phone" },
  { label: "Company Name", fieldName: "CompanyName" }
];

const columnsAtt = [
  {
    label: "Name",
    fieldName: "Name",
    cellAttributes: {
      iconName: "standard:user",
      iconPosition: "left"
    }
  },
  { label: "Email", fieldName: "Email", type: "email" },
  { label: "Company Name", fieldName: "CompanyName" },
  {
    label: "Location",
    fieldName: "Location",
    cellAttributes: {
      iconName: "utility:location",
      iconPosition: "left"
    }
  }
];

export default class ProFITDetailsLWC extends LightningElement {
  @api recordId;
  @api speaker;
  @track speakerList;
  @track eventRec;
  @track attendeesList;
  errors;
  columnsList = columns;
  columnAtt = columnsAtt;

 
  handleSpeakerActive() {
    getSpeakers({
      eventId: this.recordId
    })
      .then((result) => {
        result.forEach((speaker) => {
            speaker.Name = speaker.Speaker__r.Name;
            speaker.Email = speaker.Speaker__r.Email__c;
            speaker.Phone = speaker.Speaker__r.Phone__c;
            speaker.CompanyName = speaker.Speaker__r.Company__c;
        });
        this.speakerList = result;
        this.errors = undefined;
      })
      .catch((err) => {
        this.errors = err;
        this.speakerList = undefined;
      });
  }

  handleLocationDetails() {
    getLocationDetails({
      eventId: this.recordId
    })
      .then((result) => {
        if (result.Location__c) {
          this.eventRec = result;
        } else {
          this.eventRec = undefined;
        }
        this.errors = undefined;
      })
      .catch((err) => {
        this.errors = err;
        this.speakerList = undefined;
      });
  }

  handleEventAttendee() {
    getAttendees({
      eventId: this.recordId
    })
    .then((result) => {
        result.forEach((att) => {
          att.Name = att.Attendee__r.Name;
          att.Email = att.Attendee__r.Email__c;
          att.CompanyName = att.Attendee__r.Company_Name__c;
          if (att.Attendee__r.Address__c) {
            att.Location = att.Attendee__r.Address__r.Name;
          } else {
            att.Location = "Preferred Not to Say";
          }
        });

        console.log(" result ", result);
        this.attendeesList = result;
        console.log(" attendeesList ", this.attendeesList);
        this.errors = undefined;
      })
      .catch((err) => {
        this.errors = err;
        this.speakerList = undefined;
      });
  }
}