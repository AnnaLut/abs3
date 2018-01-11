

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R042.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R042 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R042 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R042 
   (	R042 VARCHAR2(2), 
	R041 VARCHAR2(1), 
	NAME VARCHAR2(70), 
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




PROMPT *** ALTER_POLICIES to KL_R042 ***
 exec bpa.alter_policies('KL_R042');


COMMENT ON TABLE BARS.KL_R042 IS '';
COMMENT ON COLUMN BARS.KL_R042.R042 IS '';
COMMENT ON COLUMN BARS.KL_R042.R041 IS '';
COMMENT ON COLUMN BARS.KL_R042.NAME IS '';
COMMENT ON COLUMN BARS.KL_R042.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_R042.D_CLOSE IS '';



PROMPT *** Create  grants  KL_R042 ***
grant SELECT                                                                 on KL_R042         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_R042         to BARS_DM;
grant SELECT                                                                 on KL_R042         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R042.sql =========*** End *** =====
PROMPT ===================================================================================== 
