

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K018.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K018 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K018 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K018 
   (	K018 VARCHAR2(1), 
	NAME VARCHAR2(50), 
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




PROMPT *** ALTER_POLICIES to KL_K018 ***
 exec bpa.alter_policies('KL_K018');


COMMENT ON TABLE BARS.KL_K018 IS '';
COMMENT ON COLUMN BARS.KL_K018.K018 IS '';
COMMENT ON COLUMN BARS.KL_K018.NAME IS '';
COMMENT ON COLUMN BARS.KL_K018.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K018.D_CLOSE IS '';



PROMPT *** Create  grants  KL_K018 ***
grant SELECT                                                                 on KL_K018         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K018.sql =========*** End *** =====
PROMPT ===================================================================================== 
