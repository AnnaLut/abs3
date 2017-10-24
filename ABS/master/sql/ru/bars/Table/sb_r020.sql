

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_R020.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_R020 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_R020'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_R020 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_R020 
   (	KL CHAR(1), 
	RAZD CHAR(2), 
	GR CHAR(3), 
	PR CHAR(1), 
	R020 CHAR(4), 
	T020 CHAR(1), 
	R050 CHAR(2), 
	A090 CHAR(1), 
	K030 CHAR(1), 
	R031 CHAR(1), 
	S181 CHAR(1), 
	K091 CHAR(1), 
	F_11 CHAR(1), 
	F_17 CHAR(1), 
	F_21 CHAR(1), 
	F_22 CHAR(1), 
	F_27 CHAR(1), 
	F_28 CHAR(1), 
	F_33 CHAR(1), 
	F_37 CHAR(1), 
	F_40 CHAR(1), 
	F_41 CHAR(1), 
	F_42 CHAR(1), 
	F_50 CHAR(1), 
	F_56 CHAR(1), 
	F_67 CHAR(1), 
	F_75 CHAR(1), 
	F_81 CHAR(1), 
	F_82 CHAR(1), 
	TXT VARCHAR2(192), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_R020 ***
 exec bpa.alter_policies('SB_R020');


COMMENT ON TABLE BARS.SB_R020 IS '';
COMMENT ON COLUMN BARS.SB_R020.KL IS '';
COMMENT ON COLUMN BARS.SB_R020.RAZD IS '';
COMMENT ON COLUMN BARS.SB_R020.GR IS '';
COMMENT ON COLUMN BARS.SB_R020.PR IS '';
COMMENT ON COLUMN BARS.SB_R020.R020 IS '';
COMMENT ON COLUMN BARS.SB_R020.T020 IS '';
COMMENT ON COLUMN BARS.SB_R020.R050 IS '';
COMMENT ON COLUMN BARS.SB_R020.A090 IS '';
COMMENT ON COLUMN BARS.SB_R020.K030 IS '';
COMMENT ON COLUMN BARS.SB_R020.R031 IS '';
COMMENT ON COLUMN BARS.SB_R020.S181 IS '';
COMMENT ON COLUMN BARS.SB_R020.K091 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_11 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_17 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_21 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_22 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_27 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_28 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_33 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_37 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_40 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_41 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_42 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_50 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_56 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_67 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_75 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_81 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_82 IS '';
COMMENT ON COLUMN BARS.SB_R020.TXT IS '';
COMMENT ON COLUMN BARS.SB_R020.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_R020.D_CLOSE IS '';



PROMPT *** Create  grants  SB_R020 ***
grant SELECT                                                                 on SB_R020         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_R020         to SB_R020;
grant SELECT                                                                 on SB_R020         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_R020.sql =========*** End *** =====
PROMPT ===================================================================================== 
