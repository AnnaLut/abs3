

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRAN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBPC_TRAN_FILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRAN ADD CONSTRAINT FK_OBPC_TRAN_FILES FOREIGN KEY (ID)
	  REFERENCES BARS.OBPC_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_TRAN.sql =========*** End **
PROMPT ===================================================================================== 
