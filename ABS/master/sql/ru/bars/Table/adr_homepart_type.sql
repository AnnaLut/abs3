

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_HOMEPART_TYPE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_HOMEPART_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_HOMEPART_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_HOMEPART_TYPE 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(300 CHAR), 
	VALUE VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADR_HOMEPART_TYPE ***
 exec bpa.alter_policies('ADR_HOMEPART_TYPE');


COMMENT ON TABLE BARS.ADR_HOMEPART_TYPE IS 'Типы делений жилых помещений';
COMMENT ON COLUMN BARS.ADR_HOMEPART_TYPE.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.ADR_HOMEPART_TYPE.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.ADR_HOMEPART_TYPE.VALUE IS 'Значение';




PROMPT *** Create  constraint PK_CUSTADRHOMEPARTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_HOMEPART_TYPE ADD CONSTRAINT PK_CUSTADRHOMEPARTTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTADRHOMEPARTTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTADRHOMEPARTTYPE ON BARS.ADR_HOMEPART_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADR_HOMEPART_TYPE ***
grant SELECT                                                                 on ADR_HOMEPART_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ADR_HOMEPART_TYPE to CUST001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ADR_HOMEPART_TYPE to WR_ALL_RIGHTS;
grant SELECT                                                                 on ADR_HOMEPART_TYPE to WR_CUSTREG;



PROMPT *** Create SYNONYM  to ADR_HOMEPART_TYPE ***

  CREATE OR REPLACE SYNONYM BARS.ADDRESS_HOMEPART_TYPE FOR BARS.ADR_HOMEPART_TYPE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_HOMEPART_TYPE.sql =========*** End
PROMPT ===================================================================================== 
