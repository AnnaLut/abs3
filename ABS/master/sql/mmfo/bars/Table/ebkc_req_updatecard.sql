

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_REQ_UPDATECARD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_REQ_UPDATECARD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_REQ_UPDATECARD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_REQ_UPDATECARD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_REQ_UPDATECARD ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_REQ_UPDATECARD 
   (	BATCHID VARCHAR2(50), 
	KF VARCHAR2(6), 
	RNK NUMBER(38,0), 
	QUALITY NUMBER(6,2), 
	DEFAULTGROUPQUALITY NUMBER(6,2), 
	GROUP_ID NUMBER(1,0), 
	CUST_TYPE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_REQ_UPDATECARD ***
 exec bpa.alter_policies('EBKC_REQ_UPDATECARD');


COMMENT ON TABLE BARS.EBKC_REQ_UPDATECARD IS 'Таблицa приема рекомендаций по карточкам (мастер)';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDATECARD.BATCHID IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDATECARD.KF IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDATECARD.RNK IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDATECARD.QUALITY IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDATECARD.DEFAULTGROUPQUALITY IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDATECARD.GROUP_ID IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDATECARD.CUST_TYPE IS '';




PROMPT *** Create  constraint SYS_C0032179 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_REQ_UPDATECARD MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032180 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_REQ_UPDATECARD MODIFY (RNK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_EBKC_REQ_UPDCARD ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_EBKC_REQ_UPDCARD ON BARS.EBKC_REQ_UPDATECARD (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_EBKC_REQ_UPDCARD ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_EBKC_REQ_UPDCARD ON BARS.EBKC_REQ_UPDATECARD (GROUP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_REQ_UPDATECARD ***
grant SELECT                                                                 on EBKC_REQ_UPDATECARD to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_REQ_UPDATECARD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_REQ_UPDATECARD to BARS_DM;
grant SELECT                                                                 on EBKC_REQ_UPDATECARD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_REQ_UPDATECARD.sql =========*** E
PROMPT ===================================================================================== 
