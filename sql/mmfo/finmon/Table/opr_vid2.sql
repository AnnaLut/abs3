

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/OPR_VID2.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table OPR_VID2 ***
begin 
  execute immediate '
  CREATE TABLE FINMON.OPR_VID2 
   (	ID VARCHAR2(15), 
	BRANCH_ID VARCHAR2(15), 
	VID VARCHAR2(4), 
	COMM VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.OPR_VID2 IS 'ФМ. Коды признаков операций подпадающих под мониторинг';
COMMENT ON COLUMN FINMON.OPR_VID2.ID IS 'Референс документа';
COMMENT ON COLUMN FINMON.OPR_VID2.BRANCH_ID IS '';
COMMENT ON COLUMN FINMON.OPR_VID2.VID IS 'Код признака операции подпадающей под мониторинг';
COMMENT ON COLUMN FINMON.OPR_VID2.COMM IS 'Комментарий';




PROMPT *** Create  constraint XPK_FMOPERVID2 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_VID2 ADD CONSTRAINT XPK_FMOPERVID2 PRIMARY KEY (ID, BRANCH_ID, VID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FMOPERVID2_REF ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_VID2 ADD CONSTRAINT FK_FMOPERVID2_REF FOREIGN KEY (ID, BRANCH_ID)
	  REFERENCES FINMON.OPER (ID, BRANCH_ID) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FMOPERVID2_K_DFM02 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_VID2 ADD CONSTRAINT R_FMOPERVID2_K_DFM02 FOREIGN KEY (VID)
	  REFERENCES FINMON.K_DFM02 (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FMOPERVID2_REF ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_VID2 MODIFY (ID CONSTRAINT NK_FMOPERVID2_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FMOPER_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_VID2 MODIFY (BRANCH_ID CONSTRAINT NK_FMOPER_BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FMOPERVID2_VID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.OPR_VID2 MODIFY (VID CONSTRAINT NK_FMOPERVID2_VID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FMOPERVID2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_FMOPERVID2 ON FINMON.OPR_VID2 (ID, BRANCH_ID, VID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPR_VID2 ***
grant SELECT                                                                 on OPR_VID2        to BARS;



PROMPT *** Create SYNONYM  to OPR_VID2 ***

  CREATE OR REPLACE PUBLIC SYNONYM OPR_VID2 FOR FINMON.OPR_VID2;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/OPR_VID2.sql =========*** End *** ==
PROMPT ===================================================================================== 
