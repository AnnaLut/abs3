PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_UPDATE 
   (	IDU NUMBER(38,0), 
	USERU NUMBER(38,0), 
	DATEU DATE, 
	TYPEU NUMBER(38,0), 
	VIDD NUMBER(38,0), 
	DEPOSIT_COD VARCHAR2(4), 
	TYPE_NAME VARCHAR2(50), 
	TYPE_COD VARCHAR2(4), 
	FLAG NUMBER(1,0), 
	KV NUMBER(*,0), 
	FREQ_N NUMBER(38,0), 
	FREQ_K NUMBER(38,0), 
	BSD CHAR(4), 
	BSN CHAR(4), 
	BSA CHAR(4), 
	BASEY NUMBER(38,0), 
	METR NUMBER(38,0), 
	AMR_METR NUMBER(38,0), 
	TIP_OST NUMBER(1,0), 
	ACC7 NUMBER(*,0), 
	BASEM NUMBER(38,0), 
	BR_ID NUMBER(38,0), 
	BR_ID_L NUMBER(*,0), 
	DURATION NUMBER(38,0), 
	DURATION_DAYS NUMBER(38,0), 
	NLS_K VARCHAR2(15), 
	NLSN_K VARCHAR2(14), 
	COMPROC NUMBER(1,0), 
	TERM_TYPE NUMBER(38,0), 
	ID_STOP NUMBER(*,0), 
	BR_WD NUMBER(38,0), 
	MIN_SUMM NUMBER(38,0), 
	LIMIT NUMBER(38,0), 
	MAX_LIMIT NUMBER(38,0), 
	TERM_ADD NUMBER, 
	FL_DUBL NUMBER(*,0), 
	TERM_DUBL NUMBER(38,0), 
	EXTENSION_ID NUMBER(38,0), 
	FL_2620 NUMBER(1,0), 
	COMMENTS VARCHAR2(128), 
	IDG NUMBER(38,0), 
	IDS NUMBER(38,0),
  KF  VARCHAR2(6)  default SYS_CONTEXT(''BARS_CONTEXT'',''USER_MFO'') constraint CC_DPTVIDDUPDATE_KF_NN NOT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS.DPT_VIDD_UPDATE IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.IDU IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.USERU IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.DATEU IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.TYPEU IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.VIDD IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.DEPOSIT_COD IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.TYPE_NAME IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.TYPE_COD IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.FLAG IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.KV IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.FREQ_N IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.FREQ_K IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.BSD IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.BSN IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.BSA IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.BASEY IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.METR IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.AMR_METR IS 'Метод амортизации процентов';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.TIP_OST IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.ACC7 IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.BASEM IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.BR_ID IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.BR_ID_L IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.DURATION IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.DURATION_DAYS IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.NLS_K IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.NLSN_K IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.COMPROC IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.TERM_TYPE IS 'Тип срока: 1-фикс, 0-плав, 2-диапазон';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.ID_STOP IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.BR_WD IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.MIN_SUMM IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.LIMIT IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.MAX_LIMIT IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.TERM_ADD IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.FL_DUBL IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.TERM_DUBL IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.EXTENSION_ID IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.FL_2620 IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.COMMENTS IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.IDG IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_UPDATE.IDS IS '';


PROMPT *** Create  constraint PK_DPTVIDDUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_UPDATE ADD CONSTRAINT PK_DPTVIDDUPDATE PRIMARY KEY (IDU)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  index PK_DPTVIDDUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTVIDDUPDATE ON BARS.DPT_VIDD_UPDATE (IDU) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX001_DPTVIDDUPDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX001_DPTVIDDUPDATE ON BARS.DPT_VIDD_UPDATE (VIDD, DATEU, IDU, BR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Drop constraint CC_DPTVIDDUPDATE_KF_NN ***
begin   
 execute immediate 'ALTER TABLE BARS.DPT_VIDD_UPDATE DROP CONSTRAINT CC_DPTVIDDUPDATE_KF_NN';
exception when others then
  if  sqlcode=-2443  then null; else raise; end if;
 end;
/

begin EXECUTE IMMEDIATE 'ALTER TABLE BARS.DPT_VIDD_UPDATE ADD KF VARCHAR2(6) default SYS_CONTEXT(''BARS_CONTEXT'',''USER_MFO'') ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

PROMPT *** Create  constraint CC_DPTVIDDUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_UPDATE MODIFY (KF CONSTRAINT CC_DPTVIDDUPDATE_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** ALTER_POLICIES to DPT_VIDD_UPDATE ***
 exec bpa.alter_policies('DPT_VIDD_UPDATE');


PROMPT *** Create  grants  DPT_VIDD_UPDATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_UPDATE to ABS_ADMIN;
grant SELECT                                                                 on DPT_VIDD_UPDATE to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_UPDATE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_UPDATE to DPT_ADMIN;
grant SELECT                                                                 on DPT_VIDD_UPDATE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_UPDATE to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_VIDD_UPDATE to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
