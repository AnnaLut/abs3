

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_A010.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_A010 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_A010'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_A010'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_A010'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_A010 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_A010 
   (	A010 VARCHAR2(2), 
	A011 VARCHAR2(5), 
	A012 VARCHAR2(3), 
	A013 VARCHAR2(1), 
	A014 VARCHAR2(3), 
	A015 VARCHAR2(2), 
	A017 VARCHAR2(3), 
	F_FROM VARCHAR2(3), 
	TXT VARCHAR2(96), 
	DATA_O DATE, 
	DATA_C DATE, 
	REM VARCHAR2(6), 
	FORMA VARCHAR2(35), 
	DATA_M DATE, 
	A013_1 VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_A010 ***
 exec bpa.alter_policies('KOD_A010');


COMMENT ON TABLE BARS.KOD_A010 IS '';
COMMENT ON COLUMN BARS.KOD_A010.A010 IS '';
COMMENT ON COLUMN BARS.KOD_A010.A011 IS '';
COMMENT ON COLUMN BARS.KOD_A010.A012 IS '';
COMMENT ON COLUMN BARS.KOD_A010.A013 IS '';
COMMENT ON COLUMN BARS.KOD_A010.A014 IS '';
COMMENT ON COLUMN BARS.KOD_A010.A015 IS '';
COMMENT ON COLUMN BARS.KOD_A010.A017 IS '';
COMMENT ON COLUMN BARS.KOD_A010.F_FROM IS '';
COMMENT ON COLUMN BARS.KOD_A010.TXT IS '';
COMMENT ON COLUMN BARS.KOD_A010.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_A010.DATA_C IS '';
COMMENT ON COLUMN BARS.KOD_A010.REM IS '';
COMMENT ON COLUMN BARS.KOD_A010.FORMA IS '';
COMMENT ON COLUMN BARS.KOD_A010.DATA_M IS '';
COMMENT ON COLUMN BARS.KOD_A010.A013_1 IS '';



PROMPT *** Create  grants  KOD_A010 ***
grant SELECT                                                                 on KOD_A010        to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_A010.sql =========*** End *** ====
PROMPT ===================================================================================== 
