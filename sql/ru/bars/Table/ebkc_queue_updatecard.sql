

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_QUEUE_UPDATECARD.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_QUEUE_UPDATECARD ***


BEGIN 
        execute immediate  
          'begin  
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
	CUST_TYPE VARCHAR2(1)
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


COMMENT ON TABLE BARS.EBKC_QUEUE_UPDATECARD IS '����� �볺��� (��, ���) ��� ���������� ������ ��������';
COMMENT ON COLUMN BARS.EBKC_QUEUE_UPDATECARD.RNK IS '';
COMMENT ON COLUMN BARS.EBKC_QUEUE_UPDATECARD.STATUS IS '';
COMMENT ON COLUMN BARS.EBKC_QUEUE_UPDATECARD.INSERT_DATE IS '';
COMMENT ON COLUMN BARS.EBKC_QUEUE_UPDATECARD.BRANCH IS '';
COMMENT ON COLUMN BARS.EBKC_QUEUE_UPDATECARD.CUST_TYPE IS '��� �볺���: L - �������, P - ���';




PROMPT *** Create  constraint EBKC_Q_UPDCARD_CT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_QUEUE_UPDATECARD ADD CONSTRAINT EBKC_Q_UPDCARD_CT_NN CHECK (cust_type is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_EBK_QUPDCARD_LP ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_QUEUE_UPDATECARD ADD CONSTRAINT CHK_EBK_QUPDCARD_LP CHECK (cust_type in (''L'', ''P'')) ENABLE';
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



PROMPT *** Create  grants  EBKC_QUEUE_UPDATECARD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_QUEUE_UPDATECARD to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_QUEUE_UPDATECARD.sql =========***
PROMPT ===================================================================================== 
