

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_EBK_DUP_CLIENT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_EBK_DUP_CLIENT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_EBK_DUP_CLIENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_EBK_DUP_CLIENT 
   (	KF VARCHAR2(6), 
	RNK NUMBER(38,0), 
	DUP_KF VARCHAR2(6), 
	DUP_RNK NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_EBK_DUP_CLIENT ***
 exec bpa.alter_policies('TMP_EBK_DUP_CLIENT');


COMMENT ON TABLE BARS.TMP_EBK_DUP_CLIENT IS 'Таблица перестановок дублирующих друг-друга карточек';
COMMENT ON COLUMN BARS.TMP_EBK_DUP_CLIENT.KF IS '';
COMMENT ON COLUMN BARS.TMP_EBK_DUP_CLIENT.RNK IS '';
COMMENT ON COLUMN BARS.TMP_EBK_DUP_CLIENT.DUP_KF IS '';
COMMENT ON COLUMN BARS.TMP_EBK_DUP_CLIENT.DUP_RNK IS '';




PROMPT *** Create  constraint SYS_C008135 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_EBK_DUP_CLIENT MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008136 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_EBK_DUP_CLIENT MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index TMP_EBK_DUP_CLIENT_N1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.TMP_EBK_DUP_CLIENT_N1 ON BARS.TMP_EBK_DUP_CLIENT (RNK, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_EBK_DUP_CLIENT ***
grant SELECT                                                                 on TMP_EBK_DUP_CLIENT to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_EBK_DUP_CLIENT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_EBK_DUP_CLIENT to BARS_DM;
grant SELECT                                                                 on TMP_EBK_DUP_CLIENT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_EBK_DUP_CLIENT.sql =========*** En
PROMPT ===================================================================================== 
