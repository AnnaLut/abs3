

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S031.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S031 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S031'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S031'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S031'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S031 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S031 
   (	S033 VARCHAR2(1), 
	S032 VARCHAR2(1), 
	S031 VARCHAR2(2), 
	S030 VARCHAR2(1), 
	TXT VARCHAR2(216), 
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




PROMPT *** ALTER_POLICIES to KL_S031 ***
 exec bpa.alter_policies('KL_S031');


COMMENT ON TABLE BARS.KL_S031 IS '';
COMMENT ON COLUMN BARS.KL_S031.S033 IS '';
COMMENT ON COLUMN BARS.KL_S031.S032 IS '';
COMMENT ON COLUMN BARS.KL_S031.S031 IS '';
COMMENT ON COLUMN BARS.KL_S031.S030 IS '';
COMMENT ON COLUMN BARS.KL_S031.TXT IS '';
COMMENT ON COLUMN BARS.KL_S031.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_S031.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_S031.D_MODE IS '';



PROMPT *** Create  grants  KL_S031 ***
grant SELECT                                                                 on KL_S031         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_S031         to BARS_DM;
grant SELECT                                                                 on KL_S031         to UPLD;



PROMPT *** Create SYNONYM  to KL_S031 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_S031 FOR BARS.KL_S031;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S031.sql =========*** End *** =====
PROMPT ===================================================================================== 
