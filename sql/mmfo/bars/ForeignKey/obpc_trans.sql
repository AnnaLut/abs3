

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRANS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBPCTRANS_OBPCBOF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS ADD CONSTRAINT FK_OBPCTRANS_OBPCBOF FOREIGN KEY (BOF)
	  REFERENCES BARS.OBPC_BOF (BOF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANS_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS ADD CONSTRAINT FK_OBPCTRANS_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRANS.sql =========*** End *
PROMPT ===================================================================================== 
