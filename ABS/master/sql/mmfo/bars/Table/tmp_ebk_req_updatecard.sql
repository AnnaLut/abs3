

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_EBK_REQ_UPDATECARD.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_EBK_REQ_UPDATECARD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_EBK_REQ_UPDATECARD ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_EBK_REQ_UPDATECARD 
   (	BATCHID VARCHAR2(50), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	RNK NUMBER(38,0), 
	QUALITY NUMBER(6,2), 
	DEFAULTGROUPQUALITY NUMBER(6,2), 
	GROUP_ID NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_EBK_REQ_UPDATECARD ***
 exec bpa.alter_policies('TMP_EBK_REQ_UPDATECARD');


COMMENT ON TABLE BARS.TMP_EBK_REQ_UPDATECARD IS 'Таблицa приема рекомендаций по карточкам (мастер)';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDATECARD.BATCHID IS '';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDATECARD.KF IS '';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDATECARD.RNK IS '';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDATECARD.QUALITY IS '';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDATECARD.DEFAULTGROUPQUALITY IS '';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDATECARD.GROUP_ID IS '';




PROMPT *** Create  constraint SYS_C005722 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_EBK_REQ_UPDATECARD MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005723 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_EBK_REQ_UPDATECARD MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index INDX_TERU_U2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.INDX_TERU_U2 ON BARS.TMP_EBK_REQ_UPDATECARD (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index INDX_TERU_U1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.INDX_TERU_U1 ON BARS.TMP_EBK_REQ_UPDATECARD (GROUP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_EBK_REQ_UPDATECARD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_EBK_REQ_UPDATECARD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_EBK_REQ_UPDATECARD to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_EBK_REQ_UPDATECARD.sql =========**
PROMPT ===================================================================================== 
