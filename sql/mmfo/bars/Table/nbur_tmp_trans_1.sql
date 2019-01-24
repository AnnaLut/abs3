

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_TRANS_1.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_TMP_TRANS_1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_TMP_TRANS_1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_TMP_TRANS_1 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.NBUR_TMP_TRANS_1 
   (	REPORT_DATE DATE, 
	KF VARCHAR2(6), 
	REF NUMBER(38,0), 
	TT VARCHAR2(3), 
	RNK NUMBER(38,0), 
	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	KV NUMBER(3,0), 
	P10 VARCHAR2(3), 
	P20 VARCHAR2(16), 
	P31 VARCHAR2(10), 
	P32 VARCHAR2(100), 
	P40 VARCHAR2(2), 
	P51 VARCHAR2(50), 
	P52 VARCHAR2(10), 
	P53 VARCHAR2(135), 
	P54 VARCHAR2(2), 
	P55 VARCHAR2(1), 
	P62 VARCHAR2(1), 
	REFD NUMBER, 
	D1#2D VARCHAR2(2), 
	D1#E2 VARCHAR2(2), 
	D6#E2 VARCHAR2(3), 
	D7#E2 VARCHAR2(10), 
	D8#E2 VARCHAR2(70), 
	DA#E2 VARCHAR2(70), 
	KOD_G VARCHAR2(16), 
	NB VARCHAR2(70), 
	NAZN VARCHAR2(70), 
	NMK VARCHAR2(70), 
	BAL_UAH NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_TMP_TRANS_1 ***
 exec bpa.alter_policies('NBUR_TMP_TRANS_1');


COMMENT ON TABLE BARS.NBUR_TMP_TRANS_1 IS 'Тимчасова таблиця для переліку бал.рахунків';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.REPORT_DATE IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.KF IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.REF IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.TT IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.RNK IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.ACC IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.NLS IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.KV IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.P10 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.P20 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.P31 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.P32 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.P40 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.P51 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.P52 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.P53 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.P54 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.P55 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.P62 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.REFD IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.D1#E2 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.D6#E2 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.D7#E2 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.D8#E2 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.DA#E2 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.KOD_G IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.NB IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.NAZN IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.NMK IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.BAL_UAH IS '';


begin
    execute immediate 'alter table BARS.NBUR_TMP_TRANS_1 add (D1#2D  varchar2(2))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.NBUR_TMP_TRANS_1.D1#2D IS '';


PROMPT *** Create  constraint SYS_C00139918 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_TMP_TRANS_1 MODIFY (REPORT_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139919 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_TMP_TRANS_1 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139920 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_TMP_TRANS_1 MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139921 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_TMP_TRANS_1 MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139922 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_TMP_TRANS_1 MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139923 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_TMP_TRANS_1 MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139924 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_TMP_TRANS_1 MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139925 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_TMP_TRANS_1 MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_TMP_TRANS_1 ***
grant SELECT                                                                 on NBUR_TMP_TRANS_1 to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_TMP_TRANS_1 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_TRANS_1.sql =========*** End 
PROMPT ===================================================================================== 
