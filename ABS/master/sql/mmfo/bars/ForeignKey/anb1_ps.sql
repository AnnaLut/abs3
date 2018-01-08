

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ANB1_PS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ABN1_PS_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1_PS ADD CONSTRAINT FK_ABN1_PS_NBS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FX_ANB1_PS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1_PS ADD CONSTRAINT FX_ANB1_PS_ID FOREIGN KEY (ID)
	  REFERENCES BARS.ANB1 (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ANB1_PS.sql =========*** End *** 
PROMPT ===================================================================================== 
