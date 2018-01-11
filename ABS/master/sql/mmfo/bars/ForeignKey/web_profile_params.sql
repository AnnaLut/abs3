

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WEB_PROFILE_PARAMS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WEB_PROFILE_PARAMS_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_PROFILE_PARAMS ADD CONSTRAINT FK_WEB_PROFILE_PARAMS_TAG FOREIGN KEY (TAG)
	  REFERENCES BARS.WEB_PROFILE_TAGS (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WEB_PROFILE_PARAMS_PROFILE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_PROFILE_PARAMS ADD CONSTRAINT FK_WEB_PROFILE_PARAMS_PROFILE FOREIGN KEY (PROFILE_ID)
	  REFERENCES BARS.WEB_PROFILES (PROFILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WEB_PROFILE_PARAMS.sql =========*
PROMPT ===================================================================================== 
