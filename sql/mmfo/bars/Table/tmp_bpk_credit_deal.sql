

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BPK_CREDIT_DEAL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BPK_CREDIT_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BPK_CREDIT_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BPK_CREDIT_DEAL 
   (	CARD_ND NUMBER(24,0), 
	DEAL_ND NUMBER(24,0), 
	DEAL_SUM NUMBER(24,0), 
	DEAL_KV NUMBER(3,0), 
	DEAL_RNK NUMBER(24,0), 
	OPEN_DT DATE, 
	MATUR_DT DATE, 
	CLOSE_DT DATE, 
	ACC_9129 NUMBER(24,0), 
	ACC_OVR NUMBER(24,0), 
	ACC_2208 NUMBER(24,0), 
	ACC_2207 NUMBER(24,0), 
	ACC_2209 NUMBER(24,0), 
	PC_TYPE VARCHAR2(3), 
	CREATE_DT DATE, 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BPK_CREDIT_DEAL ***
 exec bpa.alter_policies('TMP_BPK_CREDIT_DEAL');


COMMENT ON TABLE BARS.TMP_BPK_CREDIT_DEAL IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.CARD_ND IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.DEAL_ND IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.DEAL_SUM IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.DEAL_KV IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.DEAL_RNK IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.OPEN_DT IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.MATUR_DT IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.CLOSE_DT IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.ACC_9129 IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.ACC_OVR IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.ACC_2208 IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.ACC_2207 IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.ACC_2209 IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.PC_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.CREATE_DT IS '';
COMMENT ON COLUMN BARS.TMP_BPK_CREDIT_DEAL.KF IS '';



PROMPT *** Create  grants  TMP_BPK_CREDIT_DEAL ***
grant SELECT                                                                 on TMP_BPK_CREDIT_DEAL to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_BPK_CREDIT_DEAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BPK_CREDIT_DEAL.sql =========*** E
PROMPT ===================================================================================== 
