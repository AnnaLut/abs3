

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/EDS_DPT_DATA.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EDS_DPT_DATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_DPT_DATA ADD CONSTRAINT FK_EDS_DPT_DATA FOREIGN KEY (REQ_ID)
      REFERENCES BARS.EDS_DECL (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/EDS_DPT_DATA.sql =========*** End
PROMPT ===================================================================================== 

