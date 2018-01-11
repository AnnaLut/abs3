

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_REF_FORM_STRU.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FILES_FORMSTRU ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FORM_STRU ADD CONSTRAINT FK_FILES_FORMSTRU FOREIGN KEY (FILE_ID)
	  REFERENCES BARS.NBUR_REF_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBUR_REF_FORM_STRU.sql =========*
PROMPT ===================================================================================== 
