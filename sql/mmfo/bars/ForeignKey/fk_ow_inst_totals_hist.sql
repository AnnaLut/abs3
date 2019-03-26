

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_INST_TOTALS_HIST.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OW_INST_TOTALS_HIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_INST_TOTALS_HIST ADD CONSTRAINT FK_OW_INST_TOTALS_HIST FOREIGN KEY (CHAIN_IDT)
      REFERENCES BARS.OW_INST_TOTALS (CHAIN_IDT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_INST_TOTALS_HIST.sql =========
PROMPT ===================================================================================== 
