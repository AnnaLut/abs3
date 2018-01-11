

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_AGENCY_ACCTYPES.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SOCAGENCYACCTYPE_SOCAGNTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_ACCTYPES ADD CONSTRAINT FK_SOCAGENCYACCTYPE_SOCAGNTYPE FOREIGN KEY (AGNTYPE)
	  REFERENCES BARS.SOCIAL_AGENCY_TYPE (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCAGENCYACCTYPE_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_ACCTYPES ADD CONSTRAINT FK_SOCAGENCYACCTYPE_PS FOREIGN KEY (ACCMASK)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_AGENCY_ACCTYPES.sql ======
PROMPT ===================================================================================== 
