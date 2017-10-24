

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_DEAL_FIELD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_DEAL_FIELD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_DEAL_FIELD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_DEAL_FIELD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_DEAL_FIELD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_DEAL_FIELD ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_DEAL_FIELD 
   (	TAG VARCHAR2(10), 
	NAME VARCHAR2(70), 
	REF_TAB_ID NUMBER(38,0), 
	REF_COL_NM VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_DEAL_FIELD ***
 exec bpa.alter_policies('DPU_DEAL_FIELD');


COMMENT ON TABLE BARS.DPU_DEAL_FIELD IS 'Довідник дод. параметрів депозитів ЮО';
COMMENT ON COLUMN BARS.DPU_DEAL_FIELD.REF_COL_NM IS 'Ключове поле з довідника допустимих значень дод. параметру (якщо NULL то значення з META_COLUMNS.SHOWRETVAL)';
COMMENT ON COLUMN BARS.DPU_DEAL_FIELD.REF_TAB_ID IS 'Ыдентифыкатор довідника допустимих значень дод. параметру в БМД АБС';
COMMENT ON COLUMN BARS.DPU_DEAL_FIELD.TAG IS 'Код дод. параметру';
COMMENT ON COLUMN BARS.DPU_DEAL_FIELD.NAME IS 'Назва дод. параметру';




PROMPT *** Create  constraint PK_DPUDEALFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_FIELD ADD CONSTRAINT PK_DPUDEALFIELD PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




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




PROMPT *** Create  constraint CC_DPUDEALFIELD_REFCOLNM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_FIELD ADD CONSTRAINT CC_DPUDEALFIELD_REFCOLNM CHECK ( nvl2( REF_TAB_ID, 1, 0 ) >= nvl2( REF_COL_NM, 1, 0 ) ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALFIELD_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_FIELD MODIFY (TAG CONSTRAINT CC_DPUDEALFIELD_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALFIELD_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_FIELD MODIFY (NAME CONSTRAINT CC_DPUDEALFIELD_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUDEALFIELD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUDEALFIELD ON BARS.DPU_DEAL_FIELD (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_DEAL_FIELD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEAL_FIELD  to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEAL_FIELD  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_DEAL_FIELD  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEAL_FIELD  to DPT_ADMIN;
grant SELECT                                                                 on DPU_DEAL_FIELD  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_DEAL_FIELD.sql =========*** End **
PROMPT ===================================================================================== 
