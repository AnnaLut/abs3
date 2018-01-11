

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K050.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K050 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K050'', ''CENTER'' , null, ''E'', ''E'', ''E'');
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
   (	K050 CHAR(3), 
	K051 CHAR(2), 
	K052 CHAR(1), 
	TXT VARCHAR2(96), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K050_OLD VARCHAR2(12), 
	K051_OLD CHAR(2), 
	K052_OLD CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
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
grant SELECT                                                                 on KL_K050         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_K050         to BARSUPL;
grant SELECT                                                                 on KL_K050         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K050         to KL_K050;
grant SELECT                                                                 on KL_K050         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K050.sql =========*** End *** =====
PROMPT ===================================================================================== 
