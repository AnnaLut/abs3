

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K040.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K040 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K040'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K040'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K040'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K040 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K040 
   (	K040 VARCHAR2(3), 
	R030 VARCHAR2(3), 
	K041 VARCHAR2(1), 
	K042 VARCHAR2(1), 
	K043 VARCHAR2(1), 
	R031 VARCHAR2(1), 
	A2 VARCHAR2(2), 
	KOD_LIT VARCHAR2(3), 
	TXT VARCHAR2(51), 
	TXT_ENG VARCHAR2(48), 
	TXT27 VARCHAR2(27), 
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




PROMPT *** ALTER_POLICIES to KL_K040 ***
 exec bpa.alter_policies('KL_K040');


COMMENT ON TABLE BARS.KL_K040 IS '';
COMMENT ON COLUMN BARS.KL_K040.K040 IS '';
COMMENT ON COLUMN BARS.KL_K040.R030 IS '';
COMMENT ON COLUMN BARS.KL_K040.K041 IS '';
COMMENT ON COLUMN BARS.KL_K040.K042 IS '';
COMMENT ON COLUMN BARS.KL_K040.K043 IS '';
COMMENT ON COLUMN BARS.KL_K040.R031 IS '';
COMMENT ON COLUMN BARS.KL_K040.A2 IS '';
COMMENT ON COLUMN BARS.KL_K040.KOD_LIT IS '';
COMMENT ON COLUMN BARS.KL_K040.TXT IS '';
COMMENT ON COLUMN BARS.KL_K040.TXT_ENG IS '';
COMMENT ON COLUMN BARS.KL_K040.TXT27 IS '';
COMMENT ON COLUMN BARS.KL_K040.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K040.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K040.D_MODE IS '';



PROMPT *** Create  grants  KL_K040 ***
grant FLASHBACK,SELECT,UPDATE                                                on KL_K040         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K040         to BARS_DM;
grant SELECT,UPDATE                                                          on KL_K040         to START1;
grant FLASHBACK,SELECT                                                       on KL_K040         to WR_REFREAD;



PROMPT *** Create SYNONYM  to KL_K040 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_K040 FOR BARS.KL_K040;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K040.sql =========*** End *** =====
PROMPT ===================================================================================== 
