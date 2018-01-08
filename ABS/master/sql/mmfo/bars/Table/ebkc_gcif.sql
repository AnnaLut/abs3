

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_GCIF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_GCIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_GCIF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''EBKC_GCIF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_GCIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_GCIF 
   (	KF VARCHAR2(6), 
	RNK NUMBER(38,0), 
	GCIF VARCHAR2(30), 
	CUST_TYPE VARCHAR2(1), 
	INSERT_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_GCIF ***
 exec bpa.alter_policies('EBKC_GCIF');


COMMENT ON TABLE BARS.EBKC_GCIF IS 'Таблица идентификатора мастер-карточки для ЮО, ФОП на уровне банка';
COMMENT ON COLUMN BARS.EBKC_GCIF.KF IS '';
COMMENT ON COLUMN BARS.EBKC_GCIF.RNK IS '';
COMMENT ON COLUMN BARS.EBKC_GCIF.GCIF IS '';
COMMENT ON COLUMN BARS.EBKC_GCIF.CUST_TYPE IS '';
COMMENT ON COLUMN BARS.EBKC_GCIF.INSERT_DATE IS '';




PROMPT *** Create  constraint SYS_C0032171 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_GCIF MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032172 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_GCIF MODIFY (RNK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032173 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_GCIF MODIFY (GCIF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_EBKCGCIF_GCIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_EBKCGCIF_GCIF ON BARS.EBKC_GCIF (KF, GCIF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_EBKCGCIF_RNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_EBKCGCIF_RNK ON BARS.EBKC_GCIF (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_GCIF ***
grant SELECT                                                                 on EBKC_GCIF       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_GCIF       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_GCIF       to BARS_DM;
grant SELECT                                                                 on EBKC_GCIF       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_GCIF.sql =========*** End *** ===
PROMPT ===================================================================================== 
