

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MY_LKL_RRP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MY_LKL_RRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MY_LKL_RRP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MY_LKL_RRP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MY_LKL_RRP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MY_LKL_RRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.MY_LKL_RRP 
   (	MFO VARCHAR2(12), 
	DAT DATE, 
	OSTF NUMBER(24,0), 
	LIM NUMBER(24,0), 
	LNO NUMBER(24,0), 
	KN NUMBER(*,0), 
	BN NUMBER(*,0), 
	DAT_R DATE, 
	RN NUMBER(*,0), 
	IDR CHAR(8), 
	DR_DATE DATE, 
	PCN NUMBER, 
	PFN NUMBER, 
	PQN NUMBER, 
	PRN NUMBER, 
	SSP_DATE DATE, 
	SSP_SN NUMBER, 
	SSP_PN NUMBER, 
	TROUBLE CHAR(1), 
	KV NUMBER(*,0), 
	BLK NUMBER(*,0), 
	BN_SSP NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MY_LKL_RRP ***
 exec bpa.alter_policies('MY_LKL_RRP');


COMMENT ON TABLE BARS.MY_LKL_RRP IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.MFO IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.DAT IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.OSTF IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.LIM IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.LNO IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.KN IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.BN IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.DAT_R IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.RN IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.IDR IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.DR_DATE IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.PCN IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.PFN IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.PQN IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.PRN IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.SSP_DATE IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.SSP_SN IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.SSP_PN IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.TROUBLE IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.KV IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.BLK IS '';
COMMENT ON COLUMN BARS.MY_LKL_RRP.BN_SSP IS '';




PROMPT *** Create  constraint SYS_C005073 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MY_LKL_RRP MODIFY (BLK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005074 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MY_LKL_RRP MODIFY (BN_SSP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MY_LKL_RRP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MY_LKL_RRP      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MY_LKL_RRP      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MY_LKL_RRP.sql =========*** End *** ==
PROMPT ===================================================================================== 
