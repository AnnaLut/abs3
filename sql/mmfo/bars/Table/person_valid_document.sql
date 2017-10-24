

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PERSON_VALID_DOCUMENT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PERSON_VALID_DOCUMENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PERSON_VALID_DOCUMENT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PERSON_VALID_DOCUMENT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PERSON_VALID_DOCUMENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PERSON_VALID_DOCUMENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.PERSON_VALID_DOCUMENT 
   (	RNK NUMBER(38,0), 
	DOC_STATE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PERSON_VALID_DOCUMENT ***
 exec bpa.alter_policies('PERSON_VALID_DOCUMENT');


COMMENT ON TABLE BARS.PERSON_VALID_DOCUMENT IS 'Стан актуальності ідентифікуючих документів клієнтів';
COMMENT ON COLUMN BARS.PERSON_VALID_DOCUMENT.RNK IS 'Реєстраційний номер клієнта';
COMMENT ON COLUMN BARS.PERSON_VALID_DOCUMENT.DOC_STATE IS 'Стан актуальності ідентифікуючого документу';




PROMPT *** Create  constraint PK_PERSONVALIDDOCUMENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_VALID_DOCUMENT ADD CONSTRAINT PK_PERSONVALIDDOCUMENT PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERSONVALIDDOC_DOCSTATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_VALID_DOCUMENT ADD CONSTRAINT CC_PERSONVALIDDOC_DOCSTATE CHECK ( DOC_STATE in (0,1) ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERSONVALIDDOC_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_VALID_DOCUMENT MODIFY (RNK CONSTRAINT CC_PERSONVALIDDOC_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERSONVALIDDOC_DOCSTATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_VALID_DOCUMENT MODIFY (DOC_STATE CONSTRAINT CC_PERSONVALIDDOC_DOCSTATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PERSONVALIDDOCUMENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PERSONVALIDDOCUMENT ON BARS.PERSON_VALID_DOCUMENT (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PERSON_VALID_DOCUMENT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PERSON_VALID_DOCUMENT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PERSON_VALID_DOCUMENT to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on PERSON_VALID_DOCUMENT to DPT_ADMIN;
grant SELECT                                                                 on PERSON_VALID_DOCUMENT to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PERSON_VALID_DOCUMENT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PERSON_VALID_DOCUMENT.sql =========***
PROMPT ===================================================================================== 
