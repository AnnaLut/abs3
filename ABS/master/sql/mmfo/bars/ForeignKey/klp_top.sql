

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KLP_TOP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KLPTOP_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_TOP ADD CONSTRAINT FK_KLPTOP_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPTOP_RNKP ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_TOP ADD CONSTRAINT FK_KLPTOP_RNKP FOREIGN KEY (RNKP)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KLP_TOP.sql =========*** End *** 
PROMPT ===================================================================================== 
