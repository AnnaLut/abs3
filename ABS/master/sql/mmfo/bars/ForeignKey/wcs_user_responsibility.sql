

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_USER_RESPONSIBILITY.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WCSUSRRESP_SID_STAFF_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_USER_RESPONSIBILITY ADD CONSTRAINT FK_WCSUSRRESP_SID_STAFF_ID FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSUSRRESP_SRVID_WCSSRVS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_USER_RESPONSIBILITY ADD CONSTRAINT FK_WCSUSRRESP_SRVID_WCSSRVS_ID FOREIGN KEY (SRV_ID)
	  REFERENCES BARS.WCS_SERVICES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_USRRESP_SRVHRCH_SHRCH_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_USER_RESPONSIBILITY ADD CONSTRAINT FK_USRRESP_SRVHRCH_SHRCH_ID FOREIGN KEY (SRV_HIERARCHY)
	  REFERENCES BARS.WCS_SRV_HIERARCHY (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSUSRRESP_B_BRANCH_B ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_USER_RESPONSIBILITY ADD CONSTRAINT FK_WCSUSRRESP_B_BRANCH_B FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_USER_RESPONSIBILITY.sql =====
PROMPT ===================================================================================== 
