

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SPECPARAM_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SPECPARAMUPD_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_UPDATE ADD CONSTRAINT FK_SPECPARAMUPD_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPECPARAMUPD_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_UPDATE ADD CONSTRAINT FK_SPECPARAMUPD_STAFF FOREIGN KEY (USER_NAME)
	  REFERENCES BARS.STAFF$BASE (LOGNAME) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SPECPARAM_UPDATE.sql =========***
PROMPT ===================================================================================== 
