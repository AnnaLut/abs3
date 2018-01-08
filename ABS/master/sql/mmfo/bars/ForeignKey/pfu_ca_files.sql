

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PFU_CA_FILES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TYPE_TO_FILETYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_CA_FILES ADD CONSTRAINT FK_TYPE_TO_FILETYPES FOREIGN KEY (FILE_TYPE)
	  REFERENCES BARS.PFU_FILETYPES (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PFU_CA_FILES.sql =========*** End
PROMPT ===================================================================================== 
