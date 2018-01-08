

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R012.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R012 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R012 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R012 
   (	R012 CHAR(1), 
	TXT VARCHAR2(96), 
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




PROMPT *** ALTER_POLICIES to KL_R012 ***
 exec bpa.alter_policies('KL_R012');


COMMENT ON TABLE BARS.KL_R012 IS '';
COMMENT ON COLUMN BARS.KL_R012.R012 IS '';
COMMENT ON COLUMN BARS.KL_R012.TXT IS '';
COMMENT ON COLUMN BARS.KL_R012.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_R012.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_R012.D_MODE IS '';



PROMPT *** Create  grants  KL_R012 ***
grant SELECT                                                                 on KL_R012         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_R012         to BARS_DM;
grant SELECT                                                                 on KL_R012         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R012.sql =========*** End *** =====
PROMPT ===================================================================================== 
