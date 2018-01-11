

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_PARTNERS_ALL.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PARTNERS_TID_PARTTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNERS_ALL ADD CONSTRAINT FK_PARTNERS_TID_PARTTS_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_PARTNER_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PARTNERS_B_BRANCH_BRH ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNERS_ALL ADD CONSTRAINT FK_PARTNERS_B_BRANCH_BRH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_IDMATHER ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNERS_ALL ADD CONSTRAINT FK_IDMATHER FOREIGN KEY (ID_MATHER)
	  REFERENCES BARS.WCS_PARTNERS_ALL (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_PARTNERS_ALL.sql =========***
PROMPT ===================================================================================== 
