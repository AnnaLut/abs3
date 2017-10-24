

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R030.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R030 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_R030'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R030 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R030 
   (	PR CHAR(1), 
	R030 CHAR(3), 
	K040 CHAR(3), 
	A3 CHAR(3), 
	R031 CHAR(1), 
	R032 CHAR(1), 
	R033 CHAR(1), 
	R034 CHAR(1), 
	R035 CHAR(1), 
	GR NUMBER(*,0), 
	KOD_LIT CHAR(3), 
	KOD_NUM CHAR(3), 
	TXT VARCHAR2(27), 
	NOMIN NUMBER(*,0), 
	NAIM VARCHAR2(27), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_R030 ***
 exec bpa.alter_policies('KL_R030');


COMMENT ON TABLE BARS.KL_R030 IS '';
COMMENT ON COLUMN BARS.KL_R030.PR IS '';
COMMENT ON COLUMN BARS.KL_R030.R030 IS '';
COMMENT ON COLUMN BARS.KL_R030.K040 IS '';
COMMENT ON COLUMN BARS.KL_R030.A3 IS '';
COMMENT ON COLUMN BARS.KL_R030.R031 IS '';
COMMENT ON COLUMN BARS.KL_R030.R032 IS '';
COMMENT ON COLUMN BARS.KL_R030.R033 IS '';
COMMENT ON COLUMN BARS.KL_R030.R034 IS '';
COMMENT ON COLUMN BARS.KL_R030.R035 IS '';
COMMENT ON COLUMN BARS.KL_R030.GR IS '';
COMMENT ON COLUMN BARS.KL_R030.KOD_LIT IS '';
COMMENT ON COLUMN BARS.KL_R030.KOD_NUM IS '';
COMMENT ON COLUMN BARS.KL_R030.TXT IS '';
COMMENT ON COLUMN BARS.KL_R030.NOMIN IS '';
COMMENT ON COLUMN BARS.KL_R030.NAIM IS '';
COMMENT ON COLUMN BARS.KL_R030.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_R030.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_R030.D_MODE IS '';



PROMPT *** Create  grants  KL_R030 ***
grant SELECT                                                                 on KL_R030         to BARSUPL;
grant SELECT                                                                 on KL_R030         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_R030         to BARS_SUP;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_R030         to KL_R030;
grant SELECT                                                                 on KL_R030         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R030.sql =========*** End *** =====
PROMPT ===================================================================================== 
