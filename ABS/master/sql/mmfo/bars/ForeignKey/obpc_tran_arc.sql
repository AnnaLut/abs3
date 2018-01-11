

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRAN_ARC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBPCTRANARC_OBPCFILES2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRAN_ARC ADD CONSTRAINT FK_OBPCTRANARC_OBPCFILES2 FOREIGN KEY (ID)
	  REFERENCES BARS.OBPC_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRAN_ARC.sql =========*** En
PROMPT ===================================================================================== 
