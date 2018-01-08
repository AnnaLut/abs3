

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CBIREP_QUERIES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CBIREPQS_STAFF_USERID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES ADD CONSTRAINT FK_CBIREPQS_STAFF_USERID FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CBIREPQS_REPORTS_REPID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES ADD CONSTRAINT FK_CBIREPQS_REPORTS_REPID FOREIGN KEY (REP_ID)
	  REFERENCES BARS.REPORTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CBIREPQS_CBIREPQSTATS_STSID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES ADD CONSTRAINT FK_CBIREPQS_CBIREPQSTATS_STSID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.CBIREP_QUERY_STATUSES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CBIREP_QUERIES.sql =========*** E
PROMPT ===================================================================================== 
