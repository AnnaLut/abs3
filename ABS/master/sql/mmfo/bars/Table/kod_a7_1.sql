

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_A7_1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_A7_1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_A7_1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_A7_1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_A7_1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_A7_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_A7_1 
   (	A010 VARCHAR2(2), 
	PREM VARCHAR2(3), 
	R020 VARCHAR2(4), 
	T020 VARCHAR2(1), 
	UMOVA VARCHAR2(25), 
	DATA_O DATE, 
	DATA_C DATE, 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_A7_1 ***
 exec bpa.alter_policies('KOD_A7_1');


COMMENT ON TABLE BARS.KOD_A7_1 IS '';
COMMENT ON COLUMN BARS.KOD_A7_1.A010 IS '';
COMMENT ON COLUMN BARS.KOD_A7_1.PREM IS '';
COMMENT ON COLUMN BARS.KOD_A7_1.R020 IS '';
COMMENT ON COLUMN BARS.KOD_A7_1.T020 IS '';
COMMENT ON COLUMN BARS.KOD_A7_1.UMOVA IS '';
COMMENT ON COLUMN BARS.KOD_A7_1.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_A7_1.DATA_C IS '';
COMMENT ON COLUMN BARS.KOD_A7_1.TXT IS '';



PROMPT *** Create  grants  KOD_A7_1 ***
grant SELECT                                                                 on KOD_A7_1        to BARSREADER_ROLE;
grant SELECT                                                                 on KOD_A7_1        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_A7_1        to BARS_DM;
grant SELECT                                                                 on KOD_A7_1        to START1;
grant SELECT                                                                 on KOD_A7_1        to UPLD;



PROMPT *** Create SYNONYM  to KOD_A7_1 ***

  CREATE OR REPLACE PUBLIC SYNONYM KOD_A7_1 FOR BARS.KOD_A7_1;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_A7_1.sql =========*** End *** ====
PROMPT ===================================================================================== 
