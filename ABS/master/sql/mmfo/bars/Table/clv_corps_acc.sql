

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLV_CORPS_ACC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLV_CORPS_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLV_CORPS_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CLV_CORPS_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLV_CORPS_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLV_CORPS_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLV_CORPS_ACC 
   (	RNK NUMBER(38,0), 
	ID NUMBER(38,0), 
	MFO VARCHAR2(6), 
	NLS VARCHAR2(14), 
	KV NUMBER(3,0), 
	COMMENTS VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLV_CORPS_ACC ***
 exec bpa.alter_policies('CLV_CORPS_ACC');


COMMENT ON TABLE BARS.CLV_CORPS_ACC IS '';
COMMENT ON COLUMN BARS.CLV_CORPS_ACC.RNK IS '';
COMMENT ON COLUMN BARS.CLV_CORPS_ACC.ID IS '';
COMMENT ON COLUMN BARS.CLV_CORPS_ACC.MFO IS '';
COMMENT ON COLUMN BARS.CLV_CORPS_ACC.NLS IS '';
COMMENT ON COLUMN BARS.CLV_CORPS_ACC.KV IS '';
COMMENT ON COLUMN BARS.CLV_CORPS_ACC.COMMENTS IS '';




PROMPT *** Create  constraint CC_CLVCORPSACC_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CORPS_ACC MODIFY (RNK CONSTRAINT CC_CLVCORPSACC_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCORPSACC_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CORPS_ACC MODIFY (ID CONSTRAINT CC_CLVCORPSACC_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCORPSACC_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CORPS_ACC MODIFY (MFO CONSTRAINT CC_CLVCORPSACC_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCORPSACC_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CORPS_ACC MODIFY (NLS CONSTRAINT CC_CLVCORPSACC_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CLVCORPSACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CORPS_ACC ADD CONSTRAINT PK_CLVCORPSACC PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLVCORPSACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CLVCORPSACC ON BARS.CLV_CORPS_ACC (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLV_CORPS_ACC ***
grant SELECT                                                                 on CLV_CORPS_ACC   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CLV_CORPS_ACC   to BARS_DM;
grant SELECT                                                                 on CLV_CORPS_ACC   to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLV_CORPS_ACC.sql =========*** End ***
PROMPT ===================================================================================== 
