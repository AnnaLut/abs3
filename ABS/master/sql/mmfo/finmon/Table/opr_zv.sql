

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/OPR_ZV.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  table OPR_ZV ***
begin 
  execute immediate '
  CREATE TABLE FINMON.OPR_ZV 
   (	ID VARCHAR2(15), 
	BRANCH_ID VARCHAR2(15), 
	OPR_ZV_N VARCHAR2(15), 
	OPR_ZV_D DATE, 
	COMM VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.OPR_ZV IS 'ФМ. Связанные операции';
COMMENT ON COLUMN FINMON.OPR_ZV.ID IS 'Ид. основной операции';
COMMENT ON COLUMN FINMON.OPR_ZV.BRANCH_ID IS 'Ид. основной операции';
COMMENT ON COLUMN FINMON.OPR_ZV.OPR_ZV_N IS 'Идент. рее. связанной операции';
COMMENT ON COLUMN FINMON.OPR_ZV.OPR_ZV_D IS 'Дата рее. связанной операции';
COMMENT ON COLUMN FINMON.OPR_ZV.COMM IS 'Комментарий';




PROMPT *** Create  constraint NK_FMOPRZV_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_ZV MODIFY (BRANCH_ID CONSTRAINT NK_FMOPRZV_BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FMOPRZV_N ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_ZV MODIFY (OPR_ZV_N CONSTRAINT NK_FMOPRZV_N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FMOPRZV_D ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_ZV MODIFY (OPR_ZV_D CONSTRAINT NK_FMOPRZV_D NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FMOPRZVID_REF ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_ZV MODIFY (ID CONSTRAINT NK_FMOPRZVID_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPR_ZV ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on OPR_ZV          to BARS;
grant SELECT                                                                 on OPR_ZV          to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/OPR_ZV.sql =========*** End *** ====
PROMPT ===================================================================================== 
