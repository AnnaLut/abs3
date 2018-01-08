

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_AGENCY_DPTTYPES.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SOCAGNDPTYPE_SOCIALDPTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_DPTTYPES ADD CONSTRAINT FK_SOCAGNDPTYPE_SOCIALDPTTYPES FOREIGN KEY (DPTTYPE)
	  REFERENCES BARS.SOCIAL_DPT_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCAGNDPTYPE_SOCAGNTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_DPTTYPES ADD CONSTRAINT FK_SOCAGNDPTYPE_SOCAGNTYPE FOREIGN KEY (AGNTYPE)
	  REFERENCES BARS.SOCIAL_AGENCY_TYPE (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_AGENCY_DPTTYPES.sql ======
PROMPT ===================================================================================== 
