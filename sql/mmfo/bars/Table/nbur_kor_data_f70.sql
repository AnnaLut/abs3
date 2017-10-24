

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_KOR_DATA_F70.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_KOR_DATA_F70 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_KOR_DATA_F70'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_KOR_DATA_F70'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_KOR_DATA_F70'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_KOR_DATA_F70 ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_KOR_DATA_F70 
   (	REPORT_DATE DATE, 
	KF NUMBER DEFAULT sys_context(''bars_context'',''user_mfo''), 
	VAR_10 NUMBER, 
	VAR_20 NUMBER(16,2), 
	VAR_63 VARCHAR2(11), 
	VAR_71 VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_KOR_DATA_F70 ***
 exec bpa.alter_policies('NBUR_KOR_DATA_F70');


COMMENT ON TABLE BARS.NBUR_KOR_DATA_F70 IS 'Довідник "Казначейство, купівля валюти (для #70)"';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F70.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F70.KF IS 'Код філії';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F70.VAR_10 IS 'Код валюти';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F70.VAR_20 IS 'Сума у валюті';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F70.VAR_63 IS 'Підстава для купівлі';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F70.VAR_71 IS 'Код операції';




PROMPT *** Create  constraint CC_KORDATAF70_DATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F70 MODIFY (REPORT_DATE CONSTRAINT CC_KORDATAF70_DATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAF70_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F70 MODIFY (KF CONSTRAINT CC_KORDATAF70_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAF70_V10_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F70 MODIFY (VAR_10 CONSTRAINT CC_KORDATAF70_V10_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KORDATAF70 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F70 ADD CONSTRAINT PK_KORDATAF70 PRIMARY KEY (REPORT_DATE, KF, VAR_10, VAR_63, VAR_71)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAF70_V63_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F70 MODIFY (VAR_63 CONSTRAINT CC_KORDATAF70_V63_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAF70_V71_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F70 MODIFY (VAR_71 CONSTRAINT CC_KORDATAF70_V71_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAF70_V20_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F70 MODIFY (VAR_20 CONSTRAINT CC_KORDATAF70_V20_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KORDATAF70 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KORDATAF70 ON BARS.NBUR_KOR_DATA_F70 (REPORT_DATE, KF, VAR_10, VAR_63, VAR_71) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_KOR_DATA_F70 ***
grant SELECT                                                                 on NBUR_KOR_DATA_F70 to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBUR_KOR_DATA_F70 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_KOR_DATA_F70 to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_KOR_DATA_F70.sql =========*** End
PROMPT ===================================================================================== 
