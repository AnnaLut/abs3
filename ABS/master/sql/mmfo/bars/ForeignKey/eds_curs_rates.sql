PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/EDS_CURS_RATES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EDS_CURS_RATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_CURS_RATES ADD CONSTRAINT FK_EDS_CURS_RATES FOREIGN KEY (REQ_ID)
      REFERENCES BARS.EDS_DECL (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/EDS_CURS_RATES.sql =========*** E
PROMPT ===================================================================================== 

