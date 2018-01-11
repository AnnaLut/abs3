

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_DEAL_ATTRS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INSDLSATTRS_INSDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_ATTRS ADD CONSTRAINT FK_INSDLSATTRS_INSDEALS FOREIGN KEY (DEAL_ID, KF)
	  REFERENCES BARS.INS_DEALS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDLSATTRS_DEALTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_ATTRS ADD CONSTRAINT FK_INSDLSATTRS_DEALTAGS FOREIGN KEY (ATTR_ID)
	  REFERENCES BARS.INS_ATTRS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_DEAL_ATTRS.sql =========*** E
PROMPT ===================================================================================== 
