

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/EDS_DECL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EDS_DECL_STATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_DECL ADD CONSTRAINT FK_EDS_DECL_STATE FOREIGN KEY (STATE)
      REFERENCES BARS.EDS_CRT_LOG_STATE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/EDS_DECL.sql =========*** End ***
PROMPT ===================================================================================== 

