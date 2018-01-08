

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFF$BASE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFF_STAFFTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_STAFFTIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.STAFF_TIPS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFF_STAFFTEMPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_STAFFTEMPL FOREIGN KEY (TEMPL_ID)
	  REFERENCES BARS.STAFF_TEMPLATES (TEMPL_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFF_STAFFPROFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_STAFFPROFILES FOREIGN KEY (PROFILE)
	  REFERENCES BARS.STAFF_PROFILES (PROFILE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFF_STAFFCLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_STAFFCLS FOREIGN KEY (CLSID)
	  REFERENCES BARS.STAFF_CLASS (CLSID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFF_WEB_PROFILE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_WEB_PROFILE FOREIGN KEY (WEB_PROFILE)
	  REFERENCES BARS.WEB_PROFILES (PROFILE_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFF_POLICYGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_POLICYGROUPS FOREIGN KEY (POLICY_GROUP)
	  REFERENCES BARS.POLICY_GROUPS (POLICY_GROUP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFF$BASE.sql =========*** End *
PROMPT ===================================================================================== 
