

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_KOR_DATA_FD3.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_KOR_DATA_FD3 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_KOR_DATA_FD3'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_KOR_DATA_FD3'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_KOR_DATA_FD3'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_KOR_DATA_FD3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_KOR_DATA_FD3 
   (	REPORT_DATE DATE, 
	KF NUMBER DEFAULT sys_context(''bars_context'',''user_mfo''), 
	VAR_10 NUMBER, 
	VAR_20 NUMBER(16,2), 
	VAR_40 VARCHAR2(2), 
	VAR_42 VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_KOR_DATA_FD3 ***
 exec bpa.alter_policies('NBUR_KOR_DATA_FD3');


COMMENT ON TABLE BARS.NBUR_KOR_DATA_FD3 IS 'Довідник "Казначейство, купівля валюти (для #70)"';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_FD3.VAR_42 IS 'Код операції';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_FD3.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_FD3.KF IS 'Код філії';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_FD3.VAR_10 IS 'Код валюти';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_FD3.VAR_20 IS 'Сума у валюті';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_FD3.VAR_40 IS 'Код мети продажу';




PROMPT *** Create  constraint PK_KORDATAFD3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_FD3 ADD CONSTRAINT PK_KORDATAFD3 PRIMARY KEY (REPORT_DATE, KF, VAR_10, VAR_40, VAR_42)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAFD3_DATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_FD3 MODIFY (REPORT_DATE CONSTRAINT CC_KORDATAFD3_DATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAFD3_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_FD3 MODIFY (KF CONSTRAINT CC_KORDATAFD3_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAFD3_V10_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_FD3 MODIFY (VAR_10 CONSTRAINT CC_KORDATAFD3_V10_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAFD3_V20_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_FD3 MODIFY (VAR_20 CONSTRAINT CC_KORDATAFD3_V20_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAFD3_V40_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_FD3 MODIFY (VAR_40 CONSTRAINT CC_KORDATAFD3_V40_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KORDATAFD3 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KORDATAFD3 ON BARS.NBUR_KOR_DATA_FD3 (REPORT_DATE, KF, VAR_10, VAR_40, VAR_42) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_KOR_DATA_FD3 ***
grant SELECT                                                                 on NBUR_KOR_DATA_FD3 to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_KOR_DATA_FD3 to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBUR_KOR_DATA_FD3 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_KOR_DATA_FD3 to RPBN002;
grant SELECT                                                                 on NBUR_KOR_DATA_FD3 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_KOR_DATA_FD3.sql =========*** End
PROMPT ===================================================================================== 
