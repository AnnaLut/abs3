

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_I010.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_I010 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_I010 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_I010 
   (	I010 VARCHAR2(2), 
	TXT VARCHAR2(45), 
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




PROMPT *** ALTER_POLICIES to KL_I010 ***
 exec bpa.alter_policies('KL_I010');


COMMENT ON TABLE BARS.KL_I010 IS '';
COMMENT ON COLUMN BARS.KL_I010.I010 IS '';
COMMENT ON COLUMN BARS.KL_I010.TXT IS '';
COMMENT ON COLUMN BARS.KL_I010.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_I010.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_I010.D_MODE IS '';



PROMPT *** Create  grants  KL_I010 ***
grant SELECT                                                                 on KL_I010         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_I010.sql =========*** End *** =====
PROMPT ===================================================================================== 
