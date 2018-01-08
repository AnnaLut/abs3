

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_F98_LOAD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_F98_LOAD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_F98_LOAD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_F98_LOAD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_F98_LOAD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_F98_LOAD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_F98_LOAD 
   (	NP VARCHAR2(2), 
	DT DATE, 
	EK_POK VARCHAR2(5), 
	KO VARCHAR2(3), 
	MFO VARCHAR2(6), 
	NKB VARCHAR2(3), 
	KU VARCHAR2(3), 
	PRB VARCHAR2(1), 
	K030 VARCHAR2(1), 
	V_SANK VARCHAR2(1), 
	KO_1 VARCHAR2(3), 
	R1_1 VARCHAR2(100), 
	R2_1 VARCHAR2(100), 
	K020 VARCHAR2(10), 
	DATAPOD DATE, 
	NOMPOD VARCHAR2(16), 
	DJERPOD VARCHAR2(20), 
	NAKAZ VARCHAR2(20), 
	DATANAK DATE, 
	NOMNAK VARCHAR2(16), 
	DATPODSK DATE, 
	NOMPODSK VARCHAR2(16), 
	DJERPODS VARCHAR2(20), 
	DATNAKSK DATE, 
	NOMNAKSK VARCHAR2(50), 
	SANKSIA1 VARCHAR2(5), 
	SRSANK11 DATE, 
	SRSANK12 DATE, 
	R4 VARCHAR2(100), 
	R030 VARCHAR2(3), 
	T071 NUMBER(16,0), 
	K040 VARCHAR2(3), 
	BANKIN VARCHAR2(200), 
	ADRIN VARCHAR2(200), 
	DATA_M DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_F98_LOAD ***
 exec bpa.alter_policies('CIM_F98_LOAD');


COMMENT ON TABLE BARS.CIM_F98_LOAD IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.NP IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.DT IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.EK_POK IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.KO IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.MFO IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.NKB IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.KU IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.PRB IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.K030 IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.V_SANK IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.KO_1 IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.R1_1 IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.R2_1 IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.K020 IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.DATAPOD IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.NOMPOD IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.DJERPOD IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.NAKAZ IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.DATANAK IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.NOMNAK IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.DATPODSK IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.NOMPODSK IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.DJERPODS IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.DATNAKSK IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.NOMNAKSK IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.SANKSIA1 IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.SRSANK11 IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.SRSANK12 IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.R4 IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.R030 IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.T071 IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.K040 IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.BANKIN IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.ADRIN IS '';
COMMENT ON COLUMN BARS.CIM_F98_LOAD.DATA_M IS '';



PROMPT *** Create  grants  CIM_F98_LOAD ***
grant SELECT                                                                 on CIM_F98_LOAD    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F98_LOAD    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_F98_LOAD    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F98_LOAD    to CIM_ROLE;
grant SELECT                                                                 on CIM_F98_LOAD    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_F98_LOAD.sql =========*** End *** 
PROMPT ===================================================================================== 
