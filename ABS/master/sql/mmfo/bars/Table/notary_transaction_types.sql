

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTARY_TRANSACTION_TYPES.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTARY_TRANSACTION_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTARY_TRANSACTION_TYPES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NOTARY_TRANSACTION_TYPES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NOTARY_TRANSACTION_TYPES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTARY_TRANSACTION_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTARY_TRANSACTION_TYPES 
   (	TYPE_ID NUMBER(10,0), 
	TXT VARCHAR2(64 CHAR)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTARY_TRANSACTION_TYPES ***
 exec bpa.alter_policies('NOTARY_TRANSACTION_TYPES');


COMMENT ON TABLE BARS.NOTARY_TRANSACTION_TYPES IS 'Типи нотаріальних дії нотаріусів';
COMMENT ON COLUMN BARS.NOTARY_TRANSACTION_TYPES.TYPE_ID IS 'Iдентифікатор типу транзакції';
COMMENT ON COLUMN BARS.NOTARY_TRANSACTION_TYPES.TXT IS 'Назва типу транзакції';




PROMPT *** Create  constraint SYS_C006162 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_TRANSACTION_TYPES MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006163 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_TRANSACTION_TYPES MODIFY (TXT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NOTARY_TRANSACTION_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_TRANSACTION_TYPES ADD CONSTRAINT PK_NOTARY_TRANSACTION_TYPES PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NOTARY_TRANSACTION_TYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NOTARY_TRANSACTION_TYPES ON BARS.NOTARY_TRANSACTION_TYPES (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOTARY_TRANSACTION_TYPES ***
grant SELECT                                                                 on NOTARY_TRANSACTION_TYPES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NOTARY_TRANSACTION_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOTARY_TRANSACTION_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTARY_TRANSACTION_TYPES.sql =========
PROMPT ===================================================================================== 
