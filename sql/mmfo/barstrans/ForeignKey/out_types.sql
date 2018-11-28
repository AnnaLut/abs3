PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_TYPES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OUT_TYPES_MIME ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT FK_OUT_TYPES_MIME FOREIGN KEY (CONT_TYPE)
	  REFERENCES BARSTRANS.DICT_MIME_TYPES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OUT_TYPES_A_MIME ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.OUT_TYPES ADD CONSTRAINT FK_OUT_TYPES_A_MIME FOREIGN KEY (ACC_CONT_TYPE)
	  REFERENCES BARSTRANS.DICT_MIME_TYPES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Barstrans/ForeignKey/OUT_TYPES.sql =========*** E
PROMPT ===================================================================================== 