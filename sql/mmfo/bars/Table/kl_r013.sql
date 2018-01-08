

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R013.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R013 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_R013'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R013'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R013'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R013 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R013 
   (	PREM VARCHAR2(3), 
	R020 VARCHAR2(4), 
	R020R013 VARCHAR2(4), 
	R013 VARCHAR2(1), 
	TXT VARCHAR2(254), 
	REM VARCHAR2(2), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	R015 VARCHAR2(1), 
	NOTE VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_R013 ***
 exec bpa.alter_policies('KL_R013');


COMMENT ON TABLE BARS.KL_R013 IS '';
COMMENT ON COLUMN BARS.KL_R013.PREM IS '';
COMMENT ON COLUMN BARS.KL_R013.R020 IS '';
COMMENT ON COLUMN BARS.KL_R013.R020R013 IS '';
COMMENT ON COLUMN BARS.KL_R013.R013 IS '';
COMMENT ON COLUMN BARS.KL_R013.TXT IS '';
COMMENT ON COLUMN BARS.KL_R013.REM IS '';
COMMENT ON COLUMN BARS.KL_R013.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_R013.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_R013.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_R013.R015 IS '';
COMMENT ON COLUMN BARS.KL_R013.NOTE IS '';



PROMPT *** Create  grants  KL_R013 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_R013         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_R013         to KL_R013;
grant SELECT                                                                 on KL_R013         to START1;



PROMPT *** Create SYNONYM  to KL_R013 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_R013 FOR BARS.KL_R013;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R013.sql =========*** End *** =====
PROMPT ===================================================================================== 
