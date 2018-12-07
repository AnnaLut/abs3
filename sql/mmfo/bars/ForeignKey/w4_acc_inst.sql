PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/W4_ACC_INST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_W4_ACC_INST_CH_IDT ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_INST ADD CONSTRAINT FK_W4_ACC_INST_CH_IDT FOREIGN KEY (CHAIN_IDT)
	  REFERENCES BARS.OW_INST_TOTALS (CHAIN_IDT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint FK_W4_ACC_INST_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_INST ADD CONSTRAINT FK_W4_ACC_INST_ND FOREIGN KEY (ND)
      REFERENCES BARS.W4_ACC (ND) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/W4_ACC_INST.sql =========*** End 
PROMPT ===================================================================================== 