

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R041.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R041 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R041 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R041 
   (	R041 VARCHAR2(1), 
	NAME VARCHAR2(42), 
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




PROMPT *** ALTER_POLICIES to KL_R041 ***
 exec bpa.alter_policies('KL_R041');


COMMENT ON TABLE BARS.KL_R041 IS '';
COMMENT ON COLUMN BARS.KL_R041.R041 IS '';
COMMENT ON COLUMN BARS.KL_R041.NAME IS '';
COMMENT ON COLUMN BARS.KL_R041.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_R041.D_CLOSE IS '';



PROMPT *** Create  grants  KL_R041 ***
grant SELECT                                                                 on KL_R041         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R041.sql =========*** End *** =====
PROMPT ===================================================================================== 
