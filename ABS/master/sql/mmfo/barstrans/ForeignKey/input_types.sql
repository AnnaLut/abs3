PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Barstrans/ForeignKey/INPUT_TYPES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INPUT_TYPES_MIME ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_TYPES ADD CONSTRAINT FK_INPUT_TYPES_MIME FOREIGN KEY (CONT_TYPE)
	  REFERENCES BARSTRANS.DICT_MIME_TYPES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Barstrans/ForeignKey/INPUT_TYPES.sql =========***
PROMPT ===================================================================================== 