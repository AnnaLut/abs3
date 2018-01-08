

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R011.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R011 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_R011'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R011'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R011'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R011 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R011 
   (	PREM VARCHAR2(3), 
	R020 VARCHAR2(4), 
	R020R011 VARCHAR2(4), 
	R011 VARCHAR2(1), 
	S181 VARCHAR2(1), 
	S190 VARCHAR2(1), 
	TXT VARCHAR2(192), 
	REM VARCHAR2(2), 
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




PROMPT *** ALTER_POLICIES to KL_R011 ***
 exec bpa.alter_policies('KL_R011');


COMMENT ON TABLE BARS.KL_R011 IS '';
COMMENT ON COLUMN BARS.KL_R011.PREM IS '';
COMMENT ON COLUMN BARS.KL_R011.R020 IS '';
COMMENT ON COLUMN BARS.KL_R011.R020R011 IS '';
COMMENT ON COLUMN BARS.KL_R011.R011 IS '';
COMMENT ON COLUMN BARS.KL_R011.S181 IS '';
COMMENT ON COLUMN BARS.KL_R011.S190 IS '';
COMMENT ON COLUMN BARS.KL_R011.TXT IS '';
COMMENT ON COLUMN BARS.KL_R011.REM IS '';
COMMENT ON COLUMN BARS.KL_R011.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_R011.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_R011.D_MODE IS '';



PROMPT *** Create  grants  KL_R011 ***
grant SELECT                                                                 on KL_R011         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_R011         to BARS_DM;
grant SELECT                                                                 on KL_R011         to START1;



PROMPT *** Create SYNONYM  to KL_R011 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_R011 FOR BARS.KL_R011;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R011.sql =========*** End *** =====
PROMPT ===================================================================================== 
