

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_K021.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_K021 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_K021 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_K021 
   (	K021 VARCHAR2(1), 
	TXT VARCHAR2(249), 
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




PROMPT *** ALTER_POLICIES to KOD_K021 ***
 exec bpa.alter_policies('KOD_K021');


COMMENT ON TABLE BARS.KOD_K021 IS '';
COMMENT ON COLUMN BARS.KOD_K021.K021 IS '';
COMMENT ON COLUMN BARS.KOD_K021.TXT IS '';
COMMENT ON COLUMN BARS.KOD_K021.D_OPEN IS '';
COMMENT ON COLUMN BARS.KOD_K021.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KOD_K021.D_MODE IS '';



PROMPT *** Create  grants  KOD_K021 ***
grant SELECT                                                                 on KOD_K021        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_K021.sql =========*** End *** ====
PROMPT ===================================================================================== 
