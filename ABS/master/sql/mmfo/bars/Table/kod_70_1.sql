

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_70_1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_70_1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_70_1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_70_1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_70_1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_70_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_70_1 
   (	P01 VARCHAR2(1), 
	P40 VARCHAR2(2), 
	P40_TXT VARCHAR2(2), 
	TXT VARCHAR2(54), 
	TXT14 VARCHAR2(14), 
	DATA_O DATE, 
	DATA_C DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_70_1 ***
 exec bpa.alter_policies('KOD_70_1');


COMMENT ON TABLE BARS.KOD_70_1 IS '';
COMMENT ON COLUMN BARS.KOD_70_1.P01 IS '';
COMMENT ON COLUMN BARS.KOD_70_1.P40 IS '';
COMMENT ON COLUMN BARS.KOD_70_1.P40_TXT IS '';
COMMENT ON COLUMN BARS.KOD_70_1.TXT IS '';
COMMENT ON COLUMN BARS.KOD_70_1.TXT14 IS '';
COMMENT ON COLUMN BARS.KOD_70_1.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_70_1.DATA_C IS '';



PROMPT *** Create  grants  KOD_70_1 ***
grant SELECT                                                                 on KOD_70_1        to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on KOD_70_1        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_70_1        to BARS_DM;
grant SELECT                                                                 on KOD_70_1        to UPLD;
grant FLASHBACK,SELECT                                                       on KOD_70_1        to WR_REFREAD;



PROMPT *** Create SYNONYM  to KOD_70_1 ***

  CREATE OR REPLACE PUBLIC SYNONYM KOD_70_1 FOR BARS.KOD_70_1;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_70_1.sql =========*** End *** ====
PROMPT ===================================================================================== 
