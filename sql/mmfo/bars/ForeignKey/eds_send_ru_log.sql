

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/EDS_SEND_RU_LOG.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EDS_SEND_RU_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_SEND_RU_LOG ADD CONSTRAINT FK_EDS_SEND_RU_LOG FOREIGN KEY (REQ_ID)
      REFERENCES BARS.EDS_DECL (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/EDS_SEND_RU_LOG.sql =========*** 
PROMPT ===================================================================================== 

