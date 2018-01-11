

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_SALDO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_SALDO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_SALDO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S6_SALDO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''S6_SALDO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_SALDO ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_SALDO 
   (	NLS VARCHAR2(25), 
	KSS CHAR(1), 
	GROUP_U NUMBER(10,0), 
	I_VA NUMBER(5,0), 
	OSN NUMBER(3,0), 
	PS NUMBER(3,0), 
	VID NUMBER(3,0), 
	SIO NUMBER(5,0), 
	DEPART NUMBER(5,0), 
	NK VARCHAR2(80), 
	ISP_OWNER NUMBER(5,0), 
	ABON CHAR(4), 
	DOP DATE, 
	DCL DATE, 
	DAPP DATE, 
	ISH NUMBER(16,2), 
	ISH_V NUMBER(16,2), 
	LIMIT NUMBER(16,2), 
	REE_FLAG CHAR(2), 
	REE_DATE DATE, 
	NLS_ALT VARCHAR2(25), 
	TYPE NUMBER(3,0), 
	SUB_NLS VARCHAR2(25), 
	BIC NUMBER(10,0), 
	IdContract VARCHAR2(40), 
	BalS NUMBER(5,0), 
	D_MODIFY DATE, 
	VSH NUMBER(16,2), 
	VSH_V NUMBER(16,2), 
	PlanAcc NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_SALDO ***
 exec bpa.alter_policies('S6_SALDO');


COMMENT ON TABLE BARS.S6_SALDO IS '';
COMMENT ON COLUMN BARS.S6_SALDO.NLS IS '';
COMMENT ON COLUMN BARS.S6_SALDO.KSS IS '';
COMMENT ON COLUMN BARS.S6_SALDO.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_SALDO.I_VA IS '';
COMMENT ON COLUMN BARS.S6_SALDO.OSN IS '';
COMMENT ON COLUMN BARS.S6_SALDO.PS IS '';
COMMENT ON COLUMN BARS.S6_SALDO.VID IS '';
COMMENT ON COLUMN BARS.S6_SALDO.SIO IS '';
COMMENT ON COLUMN BARS.S6_SALDO.DEPART IS '';
COMMENT ON COLUMN BARS.S6_SALDO.NK IS '';
COMMENT ON COLUMN BARS.S6_SALDO.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.S6_SALDO.ABON IS '';
COMMENT ON COLUMN BARS.S6_SALDO.DOP IS '';
COMMENT ON COLUMN BARS.S6_SALDO.DCL IS '';
COMMENT ON COLUMN BARS.S6_SALDO.DAPP IS '';
COMMENT ON COLUMN BARS.S6_SALDO.ISH IS '';
COMMENT ON COLUMN BARS.S6_SALDO.ISH_V IS '';
COMMENT ON COLUMN BARS.S6_SALDO.LIMIT IS '';
COMMENT ON COLUMN BARS.S6_SALDO.REE_FLAG IS '';
COMMENT ON COLUMN BARS.S6_SALDO.REE_DATE IS '';
COMMENT ON COLUMN BARS.S6_SALDO.NLS_ALT IS '';
COMMENT ON COLUMN BARS.S6_SALDO.TYPE IS '';
COMMENT ON COLUMN BARS.S6_SALDO.SUB_NLS IS '';
COMMENT ON COLUMN BARS.S6_SALDO.BIC IS '';
COMMENT ON COLUMN BARS.S6_SALDO.IdContract IS '';
COMMENT ON COLUMN BARS.S6_SALDO.BalS IS '';
COMMENT ON COLUMN BARS.S6_SALDO.D_MODIFY IS '';
COMMENT ON COLUMN BARS.S6_SALDO.VSH IS '';
COMMENT ON COLUMN BARS.S6_SALDO.VSH_V IS '';
COMMENT ON COLUMN BARS.S6_SALDO.PlanAcc IS '';




PROMPT *** Create  constraint SYS_C007749 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (DEPART NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007750 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (ISP_OWNER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007751 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (DOP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007752 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (ISH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007753 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (ISH_V NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007754 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (LIMIT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007755 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007756 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007757 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (IdContract NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007744 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007745 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (KSS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007746 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007747 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007748 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO MODIFY (OSN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_SALDO ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_SALDO ON BARS.S6_SALDO (NLS, I_VA, GROUP_U) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_SALDO ***
grant SELECT                                                                 on S6_SALDO        to BARSREADER_ROLE;
grant SELECT                                                                 on S6_SALDO        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_SALDO        to BARS_DM;
grant SELECT                                                                 on S6_SALDO        to RPBN002;
grant SELECT                                                                 on S6_SALDO        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_SALDO.sql =========*** End *** ====
PROMPT ===================================================================================== 
