

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/OPR_VID3.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table OPR_VID3 ***
begin 
  execute immediate '
  CREATE TABLE FINMON.OPR_VID3 
   (	ID VARCHAR2(15), 
	BRANCH_ID VARCHAR2(15), 
	VID VARCHAR2(3), 
	COMM VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.OPR_VID3 IS 'ФМ. Коды признаков операций подпадающих под мониторинг';
COMMENT ON COLUMN FINMON.OPR_VID3.ID IS 'Референс документа';
COMMENT ON COLUMN FINMON.OPR_VID3.BRANCH_ID IS '';
COMMENT ON COLUMN FINMON.OPR_VID3.VID IS 'Код признака операции подпадающей под мониторинг';
COMMENT ON COLUMN FINMON.OPR_VID3.COMM IS 'Комментарий';




PROMPT *** Create  constraint XPK_FMOPERVID3 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_VID3 ADD CONSTRAINT XPK_FMOPERVID3 PRIMARY KEY (ID, BRANCH_ID, VID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FMOPERVID3_REF ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_VID3 MODIFY (ID CONSTRAINT NK_FMOPERVID3_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FMOPERVID3_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_VID3 MODIFY (BRANCH_ID CONSTRAINT NK_FMOPERVID3_BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FMOPERVID3_VID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_VID3 MODIFY (VID CONSTRAINT NK_FMOPERVID3_VID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FMOPERVID3 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_FMOPERVID3 ON FINMON.OPR_VID3 (ID, BRANCH_ID, VID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPR_VID3 ***
grant SELECT                                                                 on OPR_VID3        to BARS;
grant SELECT                                                                 on OPR_VID3        to BARSREADER_ROLE;



PROMPT *** Create SYNONYM  to OPR_VID3 ***

  CREATE OR REPLACE PUBLIC SYNONYM OPR_VID3 FOR FINMON.OPR_VID3;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/OPR_VID3.sql =========*** End *** ==
PROMPT ===================================================================================== 
