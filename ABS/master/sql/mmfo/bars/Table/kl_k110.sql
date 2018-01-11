

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K110.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K110 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K110'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K110'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K110'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K110 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K110 
   (	K110 VARCHAR2(5), 
	DK VARCHAR2(7), 
	K111 VARCHAR2(2), 
	K112 VARCHAR2(1), 
	K113 VARCHAR2(2), 
	K114 VARCHAR2(2), 
	TXT VARCHAR2(144), 
	KL_K090 VARCHAR2(110), 
	K119 VARCHAR2(1), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K113_OLD VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K110 ***
 exec bpa.alter_policies('KL_K110');


COMMENT ON TABLE BARS.KL_K110 IS '';
COMMENT ON COLUMN BARS.KL_K110.K110 IS '';
COMMENT ON COLUMN BARS.KL_K110.DK IS '';
COMMENT ON COLUMN BARS.KL_K110.K111 IS '';
COMMENT ON COLUMN BARS.KL_K110.K112 IS '';
COMMENT ON COLUMN BARS.KL_K110.K113 IS '';
COMMENT ON COLUMN BARS.KL_K110.K114 IS '';
COMMENT ON COLUMN BARS.KL_K110.TXT IS '';
COMMENT ON COLUMN BARS.KL_K110.KL_K090 IS '';
COMMENT ON COLUMN BARS.KL_K110.K119 IS '';
COMMENT ON COLUMN BARS.KL_K110.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K110.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K110.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_K110.K113_OLD IS '';



PROMPT *** Create  grants  KL_K110 ***
grant SELECT                                                                 on KL_K110         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_K110         to BARSUPL;
grant SELECT                                                                 on KL_K110         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K110         to BARS_DM;
grant SELECT                                                                 on KL_K110         to UPLD;



PROMPT *** Create SYNONYM  to KL_K110 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_K110 FOR BARS.KL_K110;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K110.sql =========*** End *** =====
PROMPT ===================================================================================== 
