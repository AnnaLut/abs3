

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_E1_2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_E1_2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_E1_2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_E1_2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_E1_2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_E1_2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_E1_2 
   (	P40 CHAR(2), 
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




PROMPT *** ALTER_POLICIES to KOD_E1_2 ***
 exec bpa.alter_policies('KOD_E1_2');


COMMENT ON TABLE BARS.KOD_E1_2 IS '';
COMMENT ON COLUMN BARS.KOD_E1_2.P40 IS '';
COMMENT ON COLUMN BARS.KOD_E1_2.TXT IS '';
COMMENT ON COLUMN BARS.KOD_E1_2.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_E1_2.DATA_C IS '';



PROMPT *** Create  grants  KOD_E1_2 ***
grant SELECT                                                                 on KOD_E1_2        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_E1_2        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_E1_2        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_E1_2        to START1;
grant SELECT                                                                 on KOD_E1_2        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_E1_2.sql =========*** End *** ====
PROMPT ===================================================================================== 
