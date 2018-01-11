

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_XAFILES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OWXAFILES_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XAFILES ADD CONSTRAINT FK_OWXAFILES_STAFF FOREIGN KEY (UNFORM_USER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWXAFILES_OWCRVREQUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XAFILES ADD CONSTRAINT FK_OWXAFILES_OWCRVREQUEST FOREIGN KEY (FILE_TYPE)
	  REFERENCES BARS.OW_CRV_REQUEST (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_XAFILES.sql =========*** End *
PROMPT ===================================================================================== 
