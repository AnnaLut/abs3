

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_RECTYPE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_RECTYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_RECTYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_RECTYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SEC_RECTYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_RECTYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_RECTYPE 
   (	SEC_RECTYPE VARCHAR2(10), 
	SEC_TYPECOMM VARCHAR2(100), 
	SEC_ALARM VARCHAR2(1) DEFAULT ''N''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 1 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
   CACHE ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_RECTYPE ***
 exec bpa.alter_policies('SEC_RECTYPE');


COMMENT ON TABLE BARS.SEC_RECTYPE IS 'Типы сообщений журнала безопасности';
COMMENT ON COLUMN BARS.SEC_RECTYPE.SEC_RECTYPE IS 'Код типа сообщения';
COMMENT ON COLUMN BARS.SEC_RECTYPE.SEC_TYPECOMM IS 'Наименование типа сообщения';
COMMENT ON COLUMN BARS.SEC_RECTYPE.SEC_ALARM IS 'Признак отсылки уведомления';




PROMPT *** Create  constraint CC_SECRECTYPE_ALARM ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RECTYPE ADD CONSTRAINT CC_SECRECTYPE_ALARM CHECK (sec_alarm in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SECRECTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RECTYPE ADD CONSTRAINT PK_SECRECTYPE PRIMARY KEY (SEC_RECTYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECRECTYPE_RECTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RECTYPE MODIFY (SEC_RECTYPE CONSTRAINT CC_SECRECTYPE_RECTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECRECTYPE_TYPECOMM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RECTYPE MODIFY (SEC_TYPECOMM CONSTRAINT CC_SECRECTYPE_TYPECOMM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECRECTYPE_ALARM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_RECTYPE MODIFY (SEC_ALARM CONSTRAINT CC_SECRECTYPE_ALARM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SECRECTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SECRECTYPE ON BARS.SEC_RECTYPE (SEC_RECTYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEC_RECTYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_RECTYPE     to ABS_ADMIN;
grant SELECT                                                                 on SEC_RECTYPE     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEC_RECTYPE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEC_RECTYPE     to BARS_DM;
grant SELECT                                                                 on SEC_RECTYPE     to START1;
grant SELECT                                                                 on SEC_RECTYPE     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEC_RECTYPE     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SEC_RECTYPE     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_RECTYPE.sql =========*** End *** =
PROMPT ===================================================================================== 
