

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K114.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K114 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K114 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K114 
   (	K114 VARCHAR2(2), 
	TXT VARCHAR2(192), 
	TXT1 VARCHAR2(128), 
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




PROMPT *** ALTER_POLICIES to KL_K114 ***
 exec bpa.alter_policies('KL_K114');


COMMENT ON TABLE BARS.KL_K114 IS '';
COMMENT ON COLUMN BARS.KL_K114.K114 IS '';
COMMENT ON COLUMN BARS.KL_K114.TXT IS '';
COMMENT ON COLUMN BARS.KL_K114.TXT1 IS '';
COMMENT ON COLUMN BARS.KL_K114.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K114.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K114.D_MODE IS '';



PROMPT *** Create  grants  KL_K114 ***
grant SELECT                                                                 on KL_K114         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_K114         to BARS_DM;
grant SELECT                                                                 on KL_K114         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K114.sql =========*** End *** =====
PROMPT ===================================================================================== 
