

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_SALDO_VIEW.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_SALDO_VIEW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_SALDO_VIEW ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_SALDO_VIEW 
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
	ISH NUMBER(20,2), 
	ISH_V NUMBER(20,2), 
	LIMIT NUMBER(20,2), 
	REE_FLAG CHAR(2), 
	REE_DATE DATE, 
	NLS_ALT VARCHAR2(25), 
	TYPE NUMBER(3,0), 
	SUB_NLS VARCHAR2(25), 
	BIC NUMBER(10,0), 
	IdContract VARCHAR2(40), 
	BalS NUMBER(5,0), 
	D_MODIFY DATE, 
	VSH NUMBER(20,2), 
	VSH_V NUMBER(20,2), 
	PlanAcc NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_SALDO_VIEW ***
 exec bpa.alter_policies('S6_SALDO_VIEW');


COMMENT ON TABLE BARS.S6_SALDO_VIEW IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.D_MODIFY IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.VSH IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.VSH_V IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.PlanAcc IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.NLS IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.KSS IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.I_VA IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.OSN IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.PS IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.VID IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.SIO IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.DEPART IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.NK IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.ABON IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.DOP IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.DCL IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.DAPP IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.ISH IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.ISH_V IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.LIMIT IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.REE_FLAG IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.REE_DATE IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.NLS_ALT IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.TYPE IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.SUB_NLS IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.BIC IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.IdContract IS '';
COMMENT ON COLUMN BARS.S6_SALDO_VIEW.BalS IS '';




PROMPT *** Create  constraint SYS_C005023 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO_VIEW MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005024 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO_VIEW MODIFY (KSS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005033 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO_VIEW MODIFY (IdContract NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005032 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO_VIEW MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005031 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO_VIEW MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005030 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO_VIEW MODIFY (DOP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005029 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO_VIEW MODIFY (ISP_OWNER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005028 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO_VIEW MODIFY (DEPART NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005027 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO_VIEW MODIFY (OSN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005026 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO_VIEW MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005025 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SALDO_VIEW MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_SALDO_VIEW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_SALDO_VIEW   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_SALDO_VIEW   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_SALDO_VIEW   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_SALDO_VIEW.sql =========*** End ***
PROMPT ===================================================================================== 
