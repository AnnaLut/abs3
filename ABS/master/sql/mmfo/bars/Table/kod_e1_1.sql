

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_E1_1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_E1_1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_E1_1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_E1_1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_E1_1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_E1_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_E1_1 
   (	P01 CHAR(1), 
	TXT VARCHAR2(64), 
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




PROMPT *** ALTER_POLICIES to KOD_E1_1 ***
 exec bpa.alter_policies('KOD_E1_1');


COMMENT ON TABLE BARS.KOD_E1_1 IS '';
COMMENT ON COLUMN BARS.KOD_E1_1.P01 IS '';
COMMENT ON COLUMN BARS.KOD_E1_1.TXT IS '';
COMMENT ON COLUMN BARS.KOD_E1_1.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_E1_1.DATA_C IS '';



PROMPT *** Create  grants  KOD_E1_1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_E1_1        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_E1_1        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_E1_1.sql =========*** End *** ====
PROMPT ===================================================================================== 
