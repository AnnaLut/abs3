

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R020.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R020 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_R020'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R020 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R020 
   (	PREM CHAR(3), 
	KL CHAR(1), 
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
	R012 CHAR(1), 
	TXT VARCHAR2(192), 
	F1819 CHAR(4), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	PR_V030 CHAR(2), 
	PR_KOR CHAR(1), 
	R050_N CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_R020 ***
 exec bpa.alter_policies('KL_R020');


COMMENT ON TABLE BARS.KL_R020 IS '';
COMMENT ON COLUMN BARS.KL_R020.K030 IS '';
COMMENT ON COLUMN BARS.KL_R020.R031 IS '';
COMMENT ON COLUMN BARS.KL_R020.S181 IS '';
COMMENT ON COLUMN BARS.KL_R020.K091 IS '';
COMMENT ON COLUMN BARS.KL_R020.R012 IS '';
COMMENT ON COLUMN BARS.KL_R020.TXT IS '';
COMMENT ON COLUMN BARS.KL_R020.F1819 IS '';
COMMENT ON COLUMN BARS.KL_R020.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_R020.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_R020.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_R020.PR_V030 IS '';
COMMENT ON COLUMN BARS.KL_R020.PR_KOR IS '';
COMMENT ON COLUMN BARS.KL_R020.R050_N IS '';
COMMENT ON COLUMN BARS.KL_R020.PREM IS '';
COMMENT ON COLUMN BARS.KL_R020.KL IS '';
COMMENT ON COLUMN BARS.KL_R020.RAZD IS '';
COMMENT ON COLUMN BARS.KL_R020.GR IS '';
COMMENT ON COLUMN BARS.KL_R020.PR IS '';
COMMENT ON COLUMN BARS.KL_R020.R020 IS '';
COMMENT ON COLUMN BARS.KL_R020.T020 IS '';
COMMENT ON COLUMN BARS.KL_R020.R050 IS '';
COMMENT ON COLUMN BARS.KL_R020.A090 IS '';



PROMPT *** Create  grants  KL_R020 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_R020         to KL_R020;
grant SELECT                                                                 on KL_R020         to START1;



PROMPT *** Create SYNONYM  to KL_R020 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_R020 FOR BARS.KL_R020;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R020.sql =========*** End *** =====
PROMPT ===================================================================================== 
