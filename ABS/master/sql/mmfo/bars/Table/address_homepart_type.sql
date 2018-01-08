

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADDRESS_HOMEPART_TYPE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADDRESS_HOMEPART_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADDRESS_HOMEPART_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ADDRESS_HOMEPART_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADDRESS_HOMEPART_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADDRESS_HOMEPART_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADDRESS_HOMEPART_TYPE 
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




PROMPT *** ALTER_POLICIES to ADDRESS_HOMEPART_TYPE ***
 exec bpa.alter_policies('ADDRESS_HOMEPART_TYPE');


COMMENT ON TABLE BARS.ADDRESS_HOMEPART_TYPE IS 'Типы делений жилых помещений';
COMMENT ON COLUMN BARS.ADDRESS_HOMEPART_TYPE.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.ADDRESS_HOMEPART_TYPE.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.ADDRESS_HOMEPART_TYPE.VALUE IS 'Значение';




PROMPT *** Create  constraint PK_CUSTADRHOMEPARTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADDRESS_HOMEPART_TYPE ADD CONSTRAINT PK_CUSTADRHOMEPARTTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTADRHOMEPARTTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTADRHOMEPARTTYPE ON BARS.ADDRESS_HOMEPART_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADDRESS_HOMEPART_TYPE ***
grant SELECT                                                                 on ADDRESS_HOMEPART_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on ADDRESS_HOMEPART_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ADDRESS_HOMEPART_TYPE to BARS_DM;
grant SELECT                                                                 on ADDRESS_HOMEPART_TYPE to CUST001;
grant SELECT                                                                 on ADDRESS_HOMEPART_TYPE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ADDRESS_HOMEPART_TYPE to WR_ALL_RIGHTS;
grant SELECT                                                                 on ADDRESS_HOMEPART_TYPE to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADDRESS_HOMEPART_TYPE.sql =========***
PROMPT ===================================================================================== 
