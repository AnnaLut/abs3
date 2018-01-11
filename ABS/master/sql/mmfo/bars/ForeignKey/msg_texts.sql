

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MSG_TEXTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_MSGTEXTS_MSGCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_TEXTS ADD CONSTRAINT FK_MSGTEXTS_MSGCODES FOREIGN KEY (MSG_ID)
	  REFERENCES BARS.MSG_CODES (MSG_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MSGTEXTS_ERRLANGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_TEXTS ADD CONSTRAINT FK_MSGTEXTS_ERRLANGS FOREIGN KEY (LNG_CODE)
	  REFERENCES BARS.ERR_LANGS (ERRLNG_CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MSG_TEXTS.sql =========*** End **
PROMPT ===================================================================================== 
