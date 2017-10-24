

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_CURRENCY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_CURRENCY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_CURRENCY'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_CURRENCY ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_CURRENCY 
   (	I_VA NUMBER(5,0), 
	N_VA VARCHAR2(40), 
	C_VA CHAR(3), 
	K_VA CHAR(1), 
	T_VA NUMBER(3,0), 
	S_VA NUMBER(3,0), 
	TRANSR VARCHAR2(25), 
	TRANSRV VARCHAR2(25), 
	CHARGE_ROUND VARCHAR2(25), 
	CHARGE_ROUNDV VARCHAR2(25), 
	kMult NUMBER(10,0), 
	WorkCurr NUMBER(3,0), 
	CHARGE_ROUND_OB VARCHAR2(25), 
	CHARGE_ROUNDV_OB VARCHAR2(25)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_CURRENCY ***
 exec bpa.alter_policies('S6_CURRENCY');


COMMENT ON TABLE BARS.S6_CURRENCY IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.I_VA IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.N_VA IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.C_VA IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.K_VA IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.T_VA IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.S_VA IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.TRANSR IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.TRANSRV IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.CHARGE_ROUND IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.CHARGE_ROUNDV IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.kMult IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.WorkCurr IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.CHARGE_ROUND_OB IS '';
COMMENT ON COLUMN BARS.S6_CURRENCY.CHARGE_ROUNDV_OB IS '';




PROMPT *** Create  constraint SYS_C0097429 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_CURRENCY MODIFY (WorkCurr NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097428 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_CURRENCY MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_CURRENCY ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_CURRENCY ON BARS.S6_CURRENCY (I_VA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_CURRENCY.sql =========*** End *** =
PROMPT ===================================================================================== 
