

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/POLICY_MNEMONICS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PLCMNEMONICS_PLCTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_MNEMONICS ADD CONSTRAINT FK_PLCMNEMONICS_PLCTYPES FOREIGN KEY (POLICY_TYPE)
	  REFERENCES BARS.POLICY_TYPES (POLICY_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/POLICY_MNEMONICS.sql =========***
PROMPT ===================================================================================== 
