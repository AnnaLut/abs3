

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SPR_REG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SPRREG_SPROBL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_REG ADD CONSTRAINT FK_SPRREG_SPROBL FOREIGN KEY (C_REG)
	  REFERENCES BARS.SPR_OBL (C_REG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SPR_REG.sql =========*** End *** 
PROMPT ===================================================================================== 
