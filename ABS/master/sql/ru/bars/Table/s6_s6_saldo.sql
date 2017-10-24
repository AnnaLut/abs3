

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_SALDO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_SALDO ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_SALDO ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_SALDO 
   (	NLS VARCHAR2(25), 
	KSS VARCHAR2(1), 
	GROUP_U NUMBER(11,0), 
	I_VA NUMBER(11,0), 
	OSN NUMBER(11,0), 
	PS NUMBER(11,0), 
	VID NUMBER(11,0), 
	SIO NUMBER(11,0), 
	DEPART NUMBER(11,0), 
	NK VARCHAR2(80), 
	ISP_OWNER NUMBER(11,0), 
	ABON VARCHAR2(4), 
	DOP DATE, 
	DCL DATE, 
	DAPP DATE, 
	ISH NUMBER(18,2), 
	ISH_V NUMBER(18,2), 
	LIMIT NUMBER(18,2), 
	REE_FLAG VARCHAR2(2), 
	REE_DATE DATE, 
	NLS_ALT VARCHAR2(25), 
	TYPE NUMBER(11,0), 
	SUB_NLS VARCHAR2(25), 
	BIC NUMBER(11,0), 
	IDCONTRACT VARCHAR2(40), 
	BALS NUMBER(11,0), 
	D_MODIFY DATE, 
	VSH NUMBER(18,2), 
	VSH_V NUMBER(18,2), 
	PLANACC NUMBER(11,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_SALDO ***
 exec bpa.alter_policies('S6_S6_SALDO');


COMMENT ON TABLE BARS.S6_S6_SALDO IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.NLS IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.KSS IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.I_VA IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.OSN IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.PS IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.VID IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.SIO IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.DEPART IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.NK IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.ABON IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.DOP IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.DCL IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.DAPP IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.ISH IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.ISH_V IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.LIMIT IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.REE_FLAG IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.REE_DATE IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.NLS_ALT IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.TYPE IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.SUB_NLS IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.BIC IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.IDCONTRACT IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.BALS IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.D_MODIFY IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.VSH IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.VSH_V IS '';
COMMENT ON COLUMN BARS.S6_S6_SALDO.PLANACC IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_SALDO.sql =========*** End *** =
PROMPT ===================================================================================== 
