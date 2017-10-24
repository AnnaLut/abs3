

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_W4_ACC_ARC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_W4_ACC_ARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_W4_ACC_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_W4_ACC_ARC 
   (	ND NUMBER(22,0), 
	ACC_PK NUMBER(22,0), 
	ACC_OVR NUMBER(22,0), 
	ACC_9129 NUMBER(22,0), 
	ACC_3570 NUMBER(22,0), 
	ACC_2208 NUMBER(22,0), 
	ACC_2627 NUMBER(22,0), 
	ACC_2207 NUMBER(22,0), 
	ACC_3579 NUMBER(22,0), 
	ACC_2209 NUMBER(22,0), 
	CARD_CODE VARCHAR2(32), 
	ACC_2625X NUMBER(22,0), 
	ACC_2627X NUMBER(22,0), 
	ACC_2625D NUMBER(22,0), 
	ACC_2628 NUMBER(22,0), 
	ACC_2203 NUMBER(22,0), 
	FIN NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	DAT_CLOSE DATE, 
	PASS_DATE DATE, 
	PASS_STATE NUMBER(10,0), 
	KOL_SP NUMBER, 
	S250 VARCHAR2(1), 
	GRP NUMBER(*,0), 
	NOT_USE_REZ23 DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_W4_ACC_ARC ***
 exec bpa.alter_policies('TMP_W4_ACC_ARC');


COMMENT ON TABLE BARS.TMP_W4_ACC_ARC IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ND IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_PK IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_OVR IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_9129 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_3570 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_2208 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_2627 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_2207 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_3579 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_2209 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.CARD_CODE IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_2625X IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_2627X IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_2625D IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_2628 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.ACC_2203 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.FIN IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.FIN23 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.OBS23 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.KAT23 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.K23 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.DAT_END IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.DAT_CLOSE IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.PASS_DATE IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.PASS_STATE IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.KOL_SP IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.S250 IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.GRP IS '';
COMMENT ON COLUMN BARS.TMP_W4_ACC_ARC.NOT_USE_REZ23 IS '';




PROMPT *** Create  constraint PK_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_ACC_ARC ADD CONSTRAINT PK_TMP_W4_ACC_ARC PRIMARY KEY (ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003197059 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_ACC_ARC MODIFY (CARD_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003197058 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_ACC_ARC MODIFY (ACC_PK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003197057 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_ACC_ARC MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK7_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK7_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_3579) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK8_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK8_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_2209) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK9_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK9_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_2625X) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_PK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK10_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK10_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_2627X) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK11_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK11_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_2625D) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK12_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK12_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_2203) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK1_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK1_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_OVR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_9129) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK3_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK3_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_3570) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK4_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK4_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_2208) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK5_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK5_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_2627) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK6_TMP_W4_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK6_TMP_W4_ACC_ARC ON BARS.TMP_W4_ACC_ARC (ACC_2207) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_W4_ACC_ARC.sql =========*** End **
PROMPT ===================================================================================== 
