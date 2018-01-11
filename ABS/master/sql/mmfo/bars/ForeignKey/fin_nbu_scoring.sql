

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FIN_NBU_SCORING.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FINNBUSCOR_MAXS_STYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_NBU_SCORING ADD CONSTRAINT FK_FINNBUSCOR_MAXS_STYPES_ID FOREIGN KEY (MAX_SIGN)
	  REFERENCES BARS.FIN_OBU_SIGN_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FINNBUSCOR_MINS_STYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_NBU_SCORING ADD CONSTRAINT FK_FINNBUSCOR_MINS_STYPES_ID FOREIGN KEY (MIN_SIGN)
	  REFERENCES BARS.FIN_OBU_SIGN_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FIN_NBU_SCORING.sql =========*** 
PROMPT ===================================================================================== 
