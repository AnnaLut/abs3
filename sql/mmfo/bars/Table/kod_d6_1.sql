

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_D6_1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_D6_1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_D6_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_D6_1 
   (	T020 VARCHAR2(1), 
	R020 VARCHAR2(4), 
	R011 VARCHAR2(16), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_D6_1 ***
 exec bpa.alter_policies('KOD_D6_1');


COMMENT ON TABLE BARS.KOD_D6_1 IS '';
COMMENT ON COLUMN BARS.KOD_D6_1.T020 IS '';
COMMENT ON COLUMN BARS.KOD_D6_1.R020 IS '';
COMMENT ON COLUMN BARS.KOD_D6_1.R011 IS '';
COMMENT ON COLUMN BARS.KOD_D6_1.D_OPEN IS '';
COMMENT ON COLUMN BARS.KOD_D6_1.D_CLOSE IS '';



PROMPT *** Create  grants  KOD_D6_1 ***
grant SELECT                                                                 on KOD_D6_1        to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_D6_1.sql =========*** End *** ====
PROMPT ===================================================================================== 
