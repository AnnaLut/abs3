

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_E2_1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_E2_1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_E2_1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_E2_1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_E2_1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_E2_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_E2_1 
   (	P40 VARCHAR2(2), 
	TXT VARCHAR2(240), 
	A010 VARCHAR2(2), 
	DATA_O DATE, 
	DATA_C DATE, 
	DATA_M DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_E2_1 ***
 exec bpa.alter_policies('KOD_E2_1');


COMMENT ON TABLE BARS.KOD_E2_1 IS '';
COMMENT ON COLUMN BARS.KOD_E2_1.P40 IS '';
COMMENT ON COLUMN BARS.KOD_E2_1.TXT IS '';
COMMENT ON COLUMN BARS.KOD_E2_1.A010 IS '';
COMMENT ON COLUMN BARS.KOD_E2_1.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_E2_1.DATA_C IS '';
COMMENT ON COLUMN BARS.KOD_E2_1.DATA_M IS '';



PROMPT *** Create  grants  KOD_E2_1 ***
grant SELECT                                                                 on KOD_E2_1        to BARSREADER_ROLE;
grant SELECT                                                                 on KOD_E2_1        to BARS_DM;
grant SELECT                                                                 on KOD_E2_1        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_E2_1.sql =========*** End *** ====
PROMPT ===================================================================================== 
