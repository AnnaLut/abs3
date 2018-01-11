

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_DEAL_FIELD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUDEALFIELD_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_FIELD ADD CONSTRAINT FK_DPUDEALFIELD_METATABLES FOREIGN KEY (REF_TAB_ID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALFIELD_METACOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_FIELD ADD CONSTRAINT FK_DPUDEALFIELD_METACOLUMNS FOREIGN KEY (REF_TAB_ID, REF_COL_NM)
	  REFERENCES BARS.META_COLUMNS (TABID, COLNAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_DEAL_FIELD.sql =========*** E
PROMPT ===================================================================================== 
