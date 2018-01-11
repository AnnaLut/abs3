

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_REF_SEL_TRANS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REFSELTRANS_REFFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_SEL_TRANS ADD CONSTRAINT FK_REFSELTRANS_REFFILES FOREIGN KEY (FILE_ID)
	  REFERENCES BARS.NBUR_REF_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_REF_SEL_TRANS.sql =========*
PROMPT ===================================================================================== 
