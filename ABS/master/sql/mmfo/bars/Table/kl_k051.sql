

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K051.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K051 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K051'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K051'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K051'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K051 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K051 
   (	K050 CHAR(8), 
	K051 CHAR(2), 
	K052 CHAR(1), 
	TXT VARCHAR2(96), 
	TXT27 VARCHAR2(54), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K052_OLD CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K051 ***
 exec bpa.alter_policies('KL_K051');


COMMENT ON TABLE BARS.KL_K051 IS '';
COMMENT ON COLUMN BARS.KL_K051.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K051.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_K051.K052_OLD IS '';
COMMENT ON COLUMN BARS.KL_K051.K050 IS '';
COMMENT ON COLUMN BARS.KL_K051.K051 IS '';
COMMENT ON COLUMN BARS.KL_K051.K052 IS '';
COMMENT ON COLUMN BARS.KL_K051.TXT IS '';
COMMENT ON COLUMN BARS.KL_K051.TXT27 IS '';
COMMENT ON COLUMN BARS.KL_K051.D_OPEN IS '';



PROMPT *** Create  grants  KL_K051 ***
grant SELECT                                                                 on KL_K051         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_K051         to BARS_DM;
grant SELECT                                                                 on KL_K051         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_K051         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KL_K051 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_K051 FOR BARS.KL_K051;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K051.sql =========*** End *** =====
PROMPT ===================================================================================== 
