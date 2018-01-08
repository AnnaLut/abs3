

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K019.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K019 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K019 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K019 
   (	K019 VARCHAR2(1), 
	TXT VARCHAR2(75), 
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




PROMPT *** ALTER_POLICIES to KL_K019 ***
 exec bpa.alter_policies('KL_K019');


COMMENT ON TABLE BARS.KL_K019 IS '';
COMMENT ON COLUMN BARS.KL_K019.K019 IS '';
COMMENT ON COLUMN BARS.KL_K019.TXT IS '';
COMMENT ON COLUMN BARS.KL_K019.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K019.D_CLOSE IS '';



PROMPT *** Create  grants  KL_K019 ***
grant SELECT                                                                 on KL_K019         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K019.sql =========*** End *** =====
PROMPT ===================================================================================== 
