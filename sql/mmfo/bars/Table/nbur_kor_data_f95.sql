

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_KOR_DATA_F95.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_KOR_DATA_F95 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_KOR_DATA_F95'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_KOR_DATA_F95'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_KOR_DATA_F95'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_KOR_DATA_F95 ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_KOR_DATA_F95 
   (	ID NUMBER, 
	KF NUMBER DEFAULT sys_context(''bars_context'',''user_mfo''), 
	VAR_01 VARCHAR2(135), 
	VAR_02 VARCHAR2(135), 
	VAR_03 VARCHAR2(10), 
	VAR_04 VARCHAR2(1), 
	VAR_05 DATE, 
	VAR_06 VARCHAR2(1), 
	VAR_07 NUMBER(16,0), 
	VAR_08 NUMBER(9,4), 
	VAR_09 NUMBER(9,4), 
	VAR_10 NUMBER(9,4), 
	VAR_11 NUMBER(9,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_KOR_DATA_F95 ***
 exec bpa.alter_policies('NBUR_KOR_DATA_F95');


COMMENT ON TABLE BARS.NBUR_KOR_DATA_F95 IS 'Довідник "Дані про афілійовані особи банку (для #95)"';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.ID IS 'Ідентифікатор афільованої особи';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.KF IS 'Код філії';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.VAR_01 IS 'Назва афілійованої особи';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.VAR_02 IS 'Місцезнаходження афілійованої особи';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.VAR_03 IS 'Ідентифікаційний код';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.VAR_04 IS 'Код резидентності афілійованої особи';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.VAR_05 IS 'Дата набуття статусу афілійованої особи';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.VAR_06 IS 'Відношення афілійованої особи до банку';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.VAR_07 IS 'Розмір статутного фонду афілійованої особи';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.VAR_08 IS 'Відсоток прямої участі на дату набуття статусу афілійованої особи';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.VAR_09 IS 'Відсоток опосередкованої участі на дату набуття статусу афілійованої особи';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.VAR_10 IS 'Відсоток прямої участі афілійованої особи';
COMMENT ON COLUMN BARS.NBUR_KOR_DATA_F95.VAR_11 IS 'Відсоток опосередкованої участі афілійованої особи ';




PROMPT *** Create  constraint CC_KORDATAF95_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F95 MODIFY (ID CONSTRAINT CC_KORDATAF95_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAF95_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F95 MODIFY (KF CONSTRAINT CC_KORDATAF95_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAF95_V01_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F95 MODIFY (VAR_01 CONSTRAINT CC_KORDATAF95_V01_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAF95_V05_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F95 MODIFY (VAR_05 CONSTRAINT CC_KORDATAF95_V05_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAF95_V04_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F95 ADD CONSTRAINT CC_KORDATAF95_V04_CHECK CHECK (VAR_04 is NOT NULL and VAR_04 in (''1'',''2'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORDATAF95_V06_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F95 ADD CONSTRAINT CC_KORDATAF95_V06_CHECK CHECK (VAR_06 is NOT NULL and VAR_06 in (''1'',''2'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KORDATAF95 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_DATA_F95 ADD CONSTRAINT PK_KORDATAF95 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KORDATAF95 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KORDATAF95 ON BARS.NBUR_KOR_DATA_F95 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_KOR_DATA_F95 ***
grant SELECT                                                                 on NBUR_KOR_DATA_F95 to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_KOR_DATA_F95 to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBUR_KOR_DATA_F95 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_KOR_DATA_F95 to RPBN002;
grant SELECT                                                                 on NBUR_KOR_DATA_F95 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_KOR_DATA_F95.sql =========*** End
PROMPT ===================================================================================== 
