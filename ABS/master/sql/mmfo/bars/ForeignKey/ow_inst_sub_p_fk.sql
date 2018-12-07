

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_INST_SUB_P.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint OW_INST_SUB_P_FK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_INST_SUB_P ADD CONSTRAINT OW_INST_SUB_P_FK FOREIGN KEY (CHAIN_IDT, IDP)
      REFERENCES BARS.OW_INST_PORTIONS (CHAIN_IDT, SEQ_NUMBER) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_INST_SUB_P.sql =========*** En
PROMPT ===================================================================================== 

