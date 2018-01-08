

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ESCR_MAP_EVENT_TO_BUILD_TYPE.sql 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint METB_BUILD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_MAP_EVENT_TO_BUILD_TYPE ADD CONSTRAINT METB_BUILD_ID FOREIGN KEY (BUILD_TYPE_ID)
	  REFERENCES BARS.ESCR_BUILD_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint METB_EVENET_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_MAP_EVENT_TO_BUILD_TYPE ADD CONSTRAINT METB_EVENET_ID FOREIGN KEY (EVENT_ID)
	  REFERENCES BARS.ESCR_EVENTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ESCR_MAP_EVENT_TO_BUILD_TYPE.sql 
PROMPT ===================================================================================== 
