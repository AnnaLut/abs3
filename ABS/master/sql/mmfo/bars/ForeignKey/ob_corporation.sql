

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OB_CORPORATION.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OB_CORPO_REFERENCE_OB_CORPO ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION ADD CONSTRAINT FK_OB_CORPO_REFERENCE_OB_CORPO FOREIGN KEY (PARENT_ID)
	  REFERENCES BARS.OB_CORPORATION (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OB_CORPORATION.sql =========*** E
PROMPT ===================================================================================== 
