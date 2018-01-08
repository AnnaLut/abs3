

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OT_PIDM.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OT_PIDM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OT_PIDM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OT_PIDM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OT_PIDM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OT_PIDM ***
begin 
  execute immediate '
  CREATE TABLE BARS.OT_PIDM 
   (	ID NUMBER(38,0), 
	ID_PP NUMBER(38,0), 
	ID_SORT NUMBER(38,0), 
	NAME VARCHAR2(250), 
	KEY VARCHAR2(20), 
	COMM VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OT_PIDM ***
 exec bpa.alter_policies('OT_PIDM');


COMMENT ON TABLE BARS.OT_PIDM IS 'Справочник для названий строк в отчетах';
COMMENT ON COLUMN BARS.OT_PIDM.ID IS 'Идентификатор нпбора';
COMMENT ON COLUMN BARS.OT_PIDM.ID_PP IS 'Идентификатор записи';
COMMENT ON COLUMN BARS.OT_PIDM.ID_SORT IS 'Порядок сортировки';
COMMENT ON COLUMN BARS.OT_PIDM.NAME IS 'Наименование строки';
COMMENT ON COLUMN BARS.OT_PIDM.KEY IS 'Ключ для связывания с выборкой';
COMMENT ON COLUMN BARS.OT_PIDM.COMM IS 'Комментарий';




PROMPT *** Create  constraint PK_OTPIDM ***
begin   
 execute immediate '
  ALTER TABLE BARS.OT_PIDM ADD CONSTRAINT PK_OTPIDM PRIMARY KEY (ID, ID_PP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007834 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OT_PIDM MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007835 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OT_PIDM MODIFY (ID_PP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007836 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OT_PIDM MODIFY (ID_SORT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007837 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OT_PIDM MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTPIDM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTPIDM ON BARS.OT_PIDM (ID, ID_PP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OT_PIDM ***
grant SELECT                                                                 on OT_PIDM         to BARSREADER_ROLE;
grant SELECT                                                                 on OT_PIDM         to BARS_DM;
grant SELECT                                                                 on OT_PIDM         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OT_PIDM         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OT_PIDM.sql =========*** End *** =====
PROMPT ===================================================================================== 
