

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OVR_LIM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OVRLIM_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_LIM ADD CONSTRAINT FK_OVRLIM_ND FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OVRLIM_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_LIM ADD CONSTRAINT FK_OVRLIM_ACC FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OVR_LIM.sql =========*** End *** 
PROMPT ===================================================================================== 
