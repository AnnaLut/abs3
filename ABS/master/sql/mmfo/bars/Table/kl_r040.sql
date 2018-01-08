

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R040.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R040 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_R040'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R040'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R040'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R040 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R040 
   (	R040 VARCHAR2(4), 
	R041 VARCHAR2(1), 
	R042 VARCHAR2(2), 
	NAME VARCHAR2(125), 
	DECL VARCHAR2(1), 
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




PROMPT *** ALTER_POLICIES to KL_R040 ***
 exec bpa.alter_policies('KL_R040');


COMMENT ON TABLE BARS.KL_R040 IS '';
COMMENT ON COLUMN BARS.KL_R040.R040 IS '';
COMMENT ON COLUMN BARS.KL_R040.R041 IS '';
COMMENT ON COLUMN BARS.KL_R040.R042 IS '';
COMMENT ON COLUMN BARS.KL_R040.NAME IS '';
COMMENT ON COLUMN BARS.KL_R040.DECL IS '';
COMMENT ON COLUMN BARS.KL_R040.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_R040.D_CLOSE IS '';



PROMPT *** Create  grants  KL_R040 ***
grant SELECT                                                                 on KL_R040         to BARS_DM;



PROMPT *** Create SYNONYM  to KL_R040 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_R040 FOR BARS.KL_R040;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R040.sql =========*** End *** =====
PROMPT ===================================================================================== 
