

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_E2_2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_E2_2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_E2_2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_E2_2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_E2_2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_E2_2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_E2_2 
   (	P70 CHAR(2), 
	TXT VARCHAR2(128), 
	DATA_O DATE, 
	DATA_C DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_E2_2 ***
 exec bpa.alter_policies('KOD_E2_2');


COMMENT ON TABLE BARS.KOD_E2_2 IS 'Классификатор НБУ (KOD_E2_2 - код товарної групи) ';
COMMENT ON COLUMN BARS.KOD_E2_2.P70 IS '';
COMMENT ON COLUMN BARS.KOD_E2_2.TXT IS '';
COMMENT ON COLUMN BARS.KOD_E2_2.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_E2_2.DATA_C IS '';



PROMPT *** Create  grants  KOD_E2_2 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_E2_2        to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_E2_2        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_E2_2        to BARS_DM;
grant SELECT                                                                 on KOD_E2_2        to PYOD001;
grant SELECT                                                                 on KOD_E2_2        to RPBN002;
grant SELECT                                                                 on KOD_E2_2        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOD_E2_2        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_E2_2.sql =========*** End *** ====
PROMPT ===================================================================================== 
