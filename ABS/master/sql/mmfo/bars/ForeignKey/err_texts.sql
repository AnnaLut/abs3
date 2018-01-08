

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ERR_TEXTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ERRTEXTS_ERRLANGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_TEXTS ADD CONSTRAINT FK_ERRTEXTS_ERRLANGS FOREIGN KEY (ERRLNG_CODE)
	  REFERENCES BARS.ERR_LANGS (ERRLNG_CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ERRTEXTS_ERRCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_TEXTS ADD CONSTRAINT FK_ERRTEXTS_ERRCODES FOREIGN KEY (ERRMOD_CODE, ERR_CODE)
	  REFERENCES BARS.ERR_CODES (ERRMOD_CODE, ERR_CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ERR_TEXTS.sql =========*** End **
PROMPT ===================================================================================== 
