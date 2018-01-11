

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_JOBS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WCSJOBS_BID_BIDS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS ADD CONSTRAINT FK_WCSJOBS_BID_BIDS_ID FOREIGN KEY (BID_ID)
	  REFERENCES BARS.WCS_BIDS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSJOBS_IQID_IQS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS ADD CONSTRAINT FK_WCSJOBS_IQID_IQS_ID FOREIGN KEY (IQUERY_ID)
	  REFERENCES BARS.WCS_INFOQUERIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSJOBS_SID_JOBSTATUSES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS ADD CONSTRAINT FK_WCSJOBS_SID_JOBSTATUSES_ID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.WCS_JOB_STATUSES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSJOBS_RSSID_STATES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_JOBS ADD CONSTRAINT FK_WCSJOBS_RSSID_STATES_ID FOREIGN KEY (RS_STATE_ID)
	  REFERENCES BARS.WCS_STATES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_JOBS.sql =========*** End ***
PROMPT ===================================================================================== 
