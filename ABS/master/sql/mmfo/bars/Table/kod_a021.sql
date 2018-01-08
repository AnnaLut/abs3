

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_A021.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_A021 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_A021'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_A021'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_A021'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_A021 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_A021 
   (	A021 DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_A021 ***
 exec bpa.alter_policies('KOD_A021');


COMMENT ON TABLE BARS.KOD_A021 IS '';
COMMENT ON COLUMN BARS.KOD_A021.A021 IS '';



PROMPT *** Create  grants  KOD_A021 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_A021        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_A021        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_A021        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_A021.sql =========*** End *** ====
PROMPT ===================================================================================== 
