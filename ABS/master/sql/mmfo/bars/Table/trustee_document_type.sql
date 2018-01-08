

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TRUSTEE_DOCUMENT_TYPE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TRUSTEE_DOCUMENT_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TRUSTEE_DOCUMENT_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TRUSTEE_DOCUMENT_TYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TRUSTEE_DOCUMENT_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TRUSTEE_DOCUMENT_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TRUSTEE_DOCUMENT_TYPE 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(100), 
	NAME_R VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TRUSTEE_DOCUMENT_TYPE ***
 exec bpa.alter_policies('TRUSTEE_DOCUMENT_TYPE');


COMMENT ON TABLE BARS.TRUSTEE_DOCUMENT_TYPE IS 'Типы документов, на основании которых ФЛ имеет право доверенного лица';
COMMENT ON COLUMN BARS.TRUSTEE_DOCUMENT_TYPE.ID IS 'Идентификатор типа документа';
COMMENT ON COLUMN BARS.TRUSTEE_DOCUMENT_TYPE.NAME IS 'Наименование типа документа';
COMMENT ON COLUMN BARS.TRUSTEE_DOCUMENT_TYPE.NAME_R IS 'Наименование типа документа в родительном падеже';




PROMPT *** Create  constraint PK_TRUSTEEDOCTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.TRUSTEE_DOCUMENT_TYPE ADD CONSTRAINT PK_TRUSTEEDOCTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TRUSTEEDOCTYPE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TRUSTEE_DOCUMENT_TYPE MODIFY (ID CONSTRAINT CC_TRUSTEEDOCTYPE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TRUSTEEDOCTYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TRUSTEE_DOCUMENT_TYPE MODIFY (NAME CONSTRAINT CC_TRUSTEEDOCTYPE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TRUSTEEDOCTYPE_NAMER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TRUSTEE_DOCUMENT_TYPE MODIFY (NAME_R CONSTRAINT CC_TRUSTEEDOCTYPE_NAMER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRUSTEEDOCTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TRUSTEEDOCTYPE ON BARS.TRUSTEE_DOCUMENT_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TRUSTEE_DOCUMENT_TYPE ***
grant SELECT                                                                 on TRUSTEE_DOCUMENT_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TRUSTEE_DOCUMENT_TYPE to BARS_DM;
grant SELECT                                                                 on TRUSTEE_DOCUMENT_TYPE to CUST001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TRUSTEE_DOCUMENT_TYPE to WR_ALL_RIGHTS;
grant SELECT                                                                 on TRUSTEE_DOCUMENT_TYPE to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TRUSTEE_DOCUMENT_TYPE.sql =========***
PROMPT ===================================================================================== 
