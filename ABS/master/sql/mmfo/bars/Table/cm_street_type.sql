

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_STREET_TYPE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_STREET_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_STREET_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CM_STREET_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CM_STREET_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_STREET_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_STREET_TYPE 
   (	ID NUMBER(10,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CM_STREET_TYPE ***
 exec bpa.alter_policies('CM_STREET_TYPE');


COMMENT ON TABLE BARS.CM_STREET_TYPE IS 'CardMake. Довідник кодів типів вулиць';
COMMENT ON COLUMN BARS.CM_STREET_TYPE.ID IS 'Код';
COMMENT ON COLUMN BARS.CM_STREET_TYPE.NAME IS 'Назва';




PROMPT *** Create  constraint PK_CMSTREETTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_STREET_TYPE ADD CONSTRAINT PK_CMSTREETTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CMSTREETTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CMSTREETTYPE ON BARS.CM_STREET_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_STREET_TYPE ***
grant SELECT                                                                 on CM_STREET_TYPE  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_STREET_TYPE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CM_STREET_TYPE  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_STREET_TYPE  to OW;
grant SELECT                                                                 on CM_STREET_TYPE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_STREET_TYPE.sql =========*** End **
PROMPT ===================================================================================== 
