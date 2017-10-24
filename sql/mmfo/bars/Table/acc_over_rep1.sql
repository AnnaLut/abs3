

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER_REP1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER_REP1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER_REP1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_OVER_REP1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_OVER_REP1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER_REP1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER_REP1 
   (	USERID NUMBER, 
	DAT1 DATE, 
	DAT2 DATE, 
	DAT3 DATE, 
	DAT4 DATE, 
	DAYS1 NUMBER, 
	DAYS2 NUMBER, 
	DAYS3 NUMBER, 
	DAYS4 NUMBER, 
	POST1 NUMBER, 
	POST2 NUMBER, 
	POST3 NUMBER, 
	POST4 NUMBER, 
	SOB2 NUMBER, 
	SOB3 NUMBER, 
	SOBM NUMBER, 
	PR NUMBER, 
	LIM NUMBER, 
	USED NUMBER, 
	REFD NUMBER, 
	NLS1 VARCHAR2(15), 
	NLS2 VARCHAR2(15), 
	KV NUMBER, 
	TT CHAR(3), 
	SN NUMBER, 
	SQ NUMBER, 
	NAZN VARCHAR2(160), 
	K NUMBER, 
	DATD DATE, 
	ACC NUMBER, 
	RNK NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_OVER_REP1 ***
 exec bpa.alter_policies('ACC_OVER_REP1');


COMMENT ON TABLE BARS.ACC_OVER_REP1 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.USERID IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.DAT1 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.DAT2 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.DAT3 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.DAT4 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.DAYS1 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.DAYS2 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.DAYS3 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.DAYS4 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.POST1 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.POST2 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.POST3 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.POST4 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.SOB2 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.SOB3 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.SOBM IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.PR IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.LIM IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.USED IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.REFD IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.NLS1 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.NLS2 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.KV IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.TT IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.SN IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.SQ IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.NAZN IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.K IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.DATD IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.ACC IS '';
COMMENT ON COLUMN BARS.ACC_OVER_REP1.RNK IS '';



PROMPT *** Create  grants  ACC_OVER_REP1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_REP1   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_OVER_REP1   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_REP1   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER_REP1.sql =========*** End ***
PROMPT ===================================================================================== 
