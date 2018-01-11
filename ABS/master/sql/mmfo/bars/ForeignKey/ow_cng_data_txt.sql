

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_CNG_DATA_TXT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OWCNGDATATXT_OWCNGTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_DATA_TXT ADD CONSTRAINT FK_OWCNGDATATXT_OWCNGTYPES FOREIGN KEY (NBS_OW)
	  REFERENCES BARS.OW_CNG_TYPES (NBS_OW) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_CNG_DATA_TXT.sql =========*** 
PROMPT ===================================================================================== 
