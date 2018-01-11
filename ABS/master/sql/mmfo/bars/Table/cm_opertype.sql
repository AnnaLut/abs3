

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_OPERTYPE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_OPERTYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_OPERTYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CM_OPERTYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CM_OPERTYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_OPERTYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_OPERTYPE 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(100), 
	CLIENTTYPE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CM_OPERTYPE ***
 exec bpa.alter_policies('CM_OPERTYPE');


COMMENT ON TABLE BARS.CM_OPERTYPE IS 'OpenWay. Типы операций';
COMMENT ON COLUMN BARS.CM_OPERTYPE.ID IS 'Тип операции';
COMMENT ON COLUMN BARS.CM_OPERTYPE.NAME IS 'Наименование типа операции';
COMMENT ON COLUMN BARS.CM_OPERTYPE.CLIENTTYPE IS 'Тип клиента: 1-ЮО, 2-ФО';




PROMPT *** Create  constraint CC_CMOPERTYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_OPERTYPE ADD CONSTRAINT CC_CMOPERTYPE_NAME_NN CHECK (name is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CMOPERTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_OPERTYPE ADD CONSTRAINT PK_CMOPERTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CMOPERTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CMOPERTYPE ON BARS.CM_OPERTYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_OPERTYPE ***
grant SELECT                                                                 on CM_OPERTYPE     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_OPERTYPE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CM_OPERTYPE     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_OPERTYPE     to OW;
grant SELECT                                                                 on CM_OPERTYPE     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_OPERTYPE.sql =========*** End *** =
PROMPT ===================================================================================== 
