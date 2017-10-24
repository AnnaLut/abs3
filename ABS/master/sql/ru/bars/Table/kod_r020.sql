

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_R020.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_R020 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_R020'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_R020 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_R020 
   (	A010 CHAR(2), 
	POLE CHAR(4), 
	PREM CHAR(3), 
	R020 CHAR(4), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_R020 ***
 exec bpa.alter_policies('KOD_R020');


COMMENT ON TABLE BARS.KOD_R020 IS '';
COMMENT ON COLUMN BARS.KOD_R020.A010 IS '';
COMMENT ON COLUMN BARS.KOD_R020.POLE IS '';
COMMENT ON COLUMN BARS.KOD_R020.PREM IS '';
COMMENT ON COLUMN BARS.KOD_R020.R020 IS '';
COMMENT ON COLUMN BARS.KOD_R020.D_OPEN IS '';
COMMENT ON COLUMN BARS.KOD_R020.D_CLOSE IS '';



PROMPT *** Create  grants  KOD_R020 ***
grant SELECT                                                                 on KOD_R020        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_R020        to KOD_R020;
grant SELECT                                                                 on KOD_R020        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_R020.sql =========*** End *** ====
PROMPT ===================================================================================== 
