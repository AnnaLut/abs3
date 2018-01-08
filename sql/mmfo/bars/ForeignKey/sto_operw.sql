

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_OPERW.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STOOPERW_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_OPERW ADD CONSTRAINT FK_STOOPERW_TAG FOREIGN KEY (TAG)
	  REFERENCES BARS.OP_FIELD (TAG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STOOPERW_IDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_OPERW ADD CONSTRAINT FK_STOOPERW_IDD FOREIGN KEY (IDD)
	  REFERENCES BARS.STO_DET (IDD) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_OPERW.sql =========*** End **
PROMPT ===================================================================================== 
