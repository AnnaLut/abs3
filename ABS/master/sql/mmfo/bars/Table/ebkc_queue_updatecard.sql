

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_QUEUE_UPDATECARD.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_QUEUE_UPDATECARD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_QUEUE_UPDATECARD'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''EBKC_QUEUE_UPDATECARD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_QUEUE_UPDATECARD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_QUEUE_UPDATECARD ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_QUEUE_UPDATECARD 
   (	RNK NUMBER(38,0), 
	STATUS NUMBER(1,0) DEFAULT 0, 
	INSERT_DATE DATE DEFAULT trunc(sysdate), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	CUST_TYPE VARCHAR2(1), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_QUEUE_UPDATECARD ***
 exec bpa.alter_policies('EBKC_QUEUE_UPDATECARD');


COMMENT ON TABLE BARS.EBKC_QUEUE_UPDATECARD IS 'Черга клієнтів (ЮО, ФОП) для формування пакету оновлень';
COMMENT ON COLUMN BARS.EBKC_QUEUE_UPDATECARD.RNK IS '';
COMMENT ON COLUMN BARS.EBKC_QUEUE_UPDATECARD.STATUS IS '';
COMMENT ON COLUMN BARS.EBKC_QUEUE_UPDATECARD.INSERT_DATE IS '';
COMMENT ON COLUMN BARS.EBKC_QUEUE_UPDATECARD.BRANCH IS '';
COMMENT ON COLUMN BARS.EBKC_QUEUE_UPDATECARD.CUST_TYPE IS 'Тип клієнта: L - юрособа, P - ФОП';
COMMENT ON COLUMN BARS.EBKC_QUEUE_UPDATECARD.KF IS '';




PROMPT *** Create  constraint CHK_EBK_QUPDCARD_LP ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_QUEUE_UPDATECARD ADD CONSTRAINT CHK_EBK_QUPDCARD_LP CHECK (cust_type in (''L'', ''P'')) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint EBKC_Q_UPDCARD_CT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_QUEUE_UPDATECARD ADD CONSTRAINT EBKC_Q_UPDCARD_CT_NN CHECK (cust_type is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EBKCQUEUEUPDATECARD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_QUEUE_UPDATECARD MODIFY (KF CONSTRAINT CC_EBKCQUEUEUPDATECARD_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index U1_EBKC_QUPDCARD ***
begin   
 execute immediate '
  CREATE INDEX BARS.U1_EBKC_QUPDCARD ON BARS.EBKC_QUEUE_UPDATECARD (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_EBKCQUEUEUPDATECARD ***
begin   
 execute immediate '
  CREATE INDEX BARS.UK_EBKCQUEUEUPDATECARD ON BARS.EBKC_QUEUE_UPDATECARD (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_QUEUE_UPDATECARD ***
grant SELECT                                                                 on EBKC_QUEUE_UPDATECARD to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_QUEUE_UPDATECARD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_QUEUE_UPDATECARD to BARS_DM;
grant SELECT                                                                 on EBKC_QUEUE_UPDATECARD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_QUEUE_UPDATECARD.sql =========***
PROMPT ===================================================================================== 
