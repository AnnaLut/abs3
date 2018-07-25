

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_HOME_TYPE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_HOME_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADR_HOME_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_HOME_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_HOME_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_HOME_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_HOME_TYPE 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(300 CHAR), 
	VALUE VARCHAR2(300 CHAR),
	name_eng varchar2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


begin
    execute immediate 'alter table ADR_HOME_TYPE
add name_eng varchar2(50)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


PROMPT *** ALTER_POLICIES to ADR_HOME_TYPE ***
 exec bpa.alter_policies('ADR_HOME_TYPE');


COMMENT ON TABLE BARS.ADR_HOME_TYPE IS 'Типы жилых помещений';
COMMENT ON COLUMN BARS.ADR_HOME_TYPE.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.ADR_HOME_TYPE.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.ADR_HOME_TYPE.VALUE IS 'Значение';




PROMPT *** Create  constraint PK_CUSTADRHOMETYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_HOME_TYPE ADD CONSTRAINT PK_CUSTADRHOMETYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTADRHOMETYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTADRHOMETYPE ON BARS.ADR_HOME_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADR_HOME_TYPE ***
grant SELECT                                                                 on ADR_HOME_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ADR_HOME_TYPE to BARS_DM;
grant SELECT                                                                 on ADR_HOME_TYPE to CUST001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ADR_HOME_TYPE to WR_ALL_RIGHTS;
grant SELECT                                                                 on ADR_HOME_TYPE to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_HOME_TYPE.sql =========*** End
PROMPT ===================================================================================== 
