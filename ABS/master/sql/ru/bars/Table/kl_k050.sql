

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K050.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K050 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K050'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K050'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K050 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K050 
   (	K050 VARCHAR2(3), 
	K051 VARCHAR2(2), 
	K052 VARCHAR2(1), 
	TXT VARCHAR2(96), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K050_OLD VARCHAR2(12), 
	K051_OLD VARCHAR2(2), 
	K052_OLD VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K050 ***
 exec bpa.alter_policies('KL_K050');


COMMENT ON TABLE BARS.KL_K050 IS '';
COMMENT ON COLUMN BARS.KL_K050.K050 IS '';
COMMENT ON COLUMN BARS.KL_K050.K051 IS '';
COMMENT ON COLUMN BARS.KL_K050.K052 IS '';
COMMENT ON COLUMN BARS.KL_K050.TXT IS '';
COMMENT ON COLUMN BARS.KL_K050.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K050.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K050.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_K050.K050_OLD IS '';
COMMENT ON COLUMN BARS.KL_K050.K051_OLD IS '';
COMMENT ON COLUMN BARS.KL_K050.K052_OLD IS '';



PROMPT *** Create  grants  KL_K050 ***
grant SELECT                                                                 on KL_K050         to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K050.sql =========*** End *** =====
PROMPT ===================================================================================== 
