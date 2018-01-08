

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_EBK_REQ_UPDCARD_ATTR.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_EBK_REQ_UPDCARD_ATTR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_EBK_REQ_UPDCARD_ATTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_EBK_REQ_UPDCARD_ATTR 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	RNK NUMBER(38,0), 
	QUALITY VARCHAR2(5), 
	NAME VARCHAR2(100), 
	VALUE VARCHAR2(4000), 
	RECOMMENDVALUE VARCHAR2(4000), 
	DESCR VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_EBK_REQ_UPDCARD_ATTR ***
 exec bpa.alter_policies('TMP_EBK_REQ_UPDCARD_ATTR');


COMMENT ON TABLE BARS.TMP_EBK_REQ_UPDCARD_ATTR IS 'Таблицa приема рекомендаций по карточкам (детаил)';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDCARD_ATTR.KF IS '';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDCARD_ATTR.RNK IS '';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDCARD_ATTR.QUALITY IS '';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDCARD_ATTR.NAME IS '';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDCARD_ATTR.VALUE IS '';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDCARD_ATTR.RECOMMENDVALUE IS '';
COMMENT ON COLUMN BARS.TMP_EBK_REQ_UPDCARD_ATTR.DESCR IS '';




PROMPT *** Create  constraint SYS_C007496 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_EBK_REQ_UPDCARD_ATTR MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007497 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_EBK_REQ_UPDCARD_ATTR MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index INDX_TERUA_U2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.INDX_TERUA_U2 ON BARS.TMP_EBK_REQ_UPDCARD_ATTR (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_EBK_REQ_UPDCARD_ATTR ***
grant SELECT                                                                 on TMP_EBK_REQ_UPDCARD_ATTR to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_EBK_REQ_UPDCARD_ATTR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_EBK_REQ_UPDCARD_ATTR to BARS_DM;
grant SELECT                                                                 on TMP_EBK_REQ_UPDCARD_ATTR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_EBK_REQ_UPDCARD_ATTR.sql =========
PROMPT ===================================================================================== 
