

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/RS_TMP_REPORT_ATTR.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_RS_TMP_REPORT_ATTR_SID ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_REPORT_ATTR ADD CONSTRAINT FK_RS_TMP_REPORT_ATTR_SID FOREIGN KEY (SESSION_ID)
	  REFERENCES BARS.RS_TMP_SESSION_DATA (SESSION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RS_TMP_REPORT_ATTR_ATTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_REPORT_ATTR ADD CONSTRAINT FK_RS_TMP_REPORT_ATTR_ATTR FOREIGN KEY (ATTR_NAME)
	  REFERENCES BARS.ZAPROS_ATTR (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/RS_TMP_REPORT_ATTR.sql =========*
PROMPT ===================================================================================== 
