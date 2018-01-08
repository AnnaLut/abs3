

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_D5_1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_D5_1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_D5_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_D5_1 
   (	T020 CHAR(1), 
	R020 CHAR(4), 
	R011 VARCHAR2(16), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_D5_1 ***
 exec bpa.alter_policies('KOD_D5_1');


COMMENT ON TABLE BARS.KOD_D5_1 IS '';
COMMENT ON COLUMN BARS.KOD_D5_1.T020 IS '';
COMMENT ON COLUMN BARS.KOD_D5_1.R020 IS '';
COMMENT ON COLUMN BARS.KOD_D5_1.R011 IS '';
COMMENT ON COLUMN BARS.KOD_D5_1.D_OPEN IS '';
COMMENT ON COLUMN BARS.KOD_D5_1.D_CLOSE IS '';



PROMPT *** Create  grants  KOD_D5_1 ***
grant SELECT                                                                 on KOD_D5_1        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_D5_1        to BARS_DM;
grant SELECT                                                                 on KOD_D5_1        to START1;



PROMPT *** Create SYNONYM  to KOD_D5_1 ***

  CREATE OR REPLACE PUBLIC SYNONYM KOD_D5_1 FOR BARS.KOD_D5_1;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_D5_1.sql =========*** End *** ====
PROMPT ===================================================================================== 
