

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUR_RATE_KOM_UPD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUR_RATE_KOM_UPD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUR_RATE_KOM_UPD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUR_RATE_KOM_UPD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUR_RATE_KOM_UPD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUR_RATE_KOM_UPD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUR_RATE_KOM_UPD 
   (	KV NUMBER(3,0), 
	VDATE DATE, 
	BSUM NUMBER(9,4), 
	RATE_B NUMBER(9,4), 
	RATE_S NUMBER(9,4), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	ISP NUMBER(9,0), 
	SYSTIME DATE DEFAULT sysdate, 
	RECID NUMBER(38,0), 
	COMMENTS VARCHAR2(250), 
	RATE_O NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUR_RATE_KOM_UPD ***
 exec bpa.alter_policies('CUR_RATE_KOM_UPD');


COMMENT ON TABLE BARS.CUR_RATE_KOM_UPD IS 'Iсторизацiя змiн ком.курсiв валют';
COMMENT ON COLUMN BARS.CUR_RATE_KOM_UPD.KV IS 'вал';
COMMENT ON COLUMN BARS.CUR_RATE_KOM_UPD.VDATE IS 'Дата установки';
COMMENT ON COLUMN BARS.CUR_RATE_KOM_UPD.BSUM IS 'Базова сума';
COMMENT ON COLUMN BARS.CUR_RATE_KOM_UPD.RATE_B IS 'Купiвля';
COMMENT ON COLUMN BARS.CUR_RATE_KOM_UPD.RATE_S IS 'Продаж';
COMMENT ON COLUMN BARS.CUR_RATE_KOM_UPD.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARS.CUR_RATE_KOM_UPD.ISP IS 'Виконавець';
COMMENT ON COLUMN BARS.CUR_RATE_KOM_UPD.SYSTIME IS 'Сист.Дата/Час';
COMMENT ON COLUMN BARS.CUR_RATE_KOM_UPD.RECID IS '№ пп';
COMMENT ON COLUMN BARS.CUR_RATE_KOM_UPD.COMMENTS IS '';
COMMENT ON COLUMN BARS.CUR_RATE_KOM_UPD.RATE_O IS 'Інформація про зміни';




PROMPT *** Create  constraint PK_CURRATEKOMUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATE_KOM_UPD ADD CONSTRAINT PK_CURRATEKOMUPD PRIMARY KEY (RECID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATEKOMUPD_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATE_KOM_UPD MODIFY (KV CONSTRAINT CC_CURRATEKOMUPD_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATEKOMUPD_VDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATE_KOM_UPD MODIFY (VDATE CONSTRAINT CC_CURRATEKOMUPD_VDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATEKOMUPD_BSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATE_KOM_UPD MODIFY (BSUM CONSTRAINT CC_CURRATEKOMUPD_BSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATEKOMUPD_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATE_KOM_UPD MODIFY (BRANCH CONSTRAINT CC_CURRATEKOMUPD_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATEKOMUPD_ISP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATE_KOM_UPD MODIFY (ISP CONSTRAINT CC_CURRATEKOMUPD_ISP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_URRATEKOMUPD_SYSTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATE_KOM_UPD MODIFY (SYSTIME CONSTRAINT CC_URRATEKOMUPD_SYSTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATEKOMUPD_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATE_KOM_UPD MODIFY (RECID CONSTRAINT CC_CURRATEKOMUPD_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CURRATEKOMUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CURRATEKOMUPD ON BARS.CUR_RATE_KOM_UPD (RECID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUR_RATE_KOM_UPD ***
grant SELECT                                                                 on CUR_RATE_KOM_UPD to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUR_RATE_KOM_UPD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUR_RATE_KOM_UPD to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUR_RATE_KOM_UPD to PYOD001;
grant SELECT                                                                 on CUR_RATE_KOM_UPD to UPLD;
grant FLASHBACK,SELECT                                                       on CUR_RATE_KOM_UPD to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUR_RATE_KOM_UPD.sql =========*** End 
PROMPT ===================================================================================== 
