

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K160.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K160 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K160 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K160 
   (	K160 VARCHAR2(2), 
	TXT VARCHAR2(10), 
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




PROMPT *** ALTER_POLICIES to KL_K160 ***
 exec bpa.alter_policies('KL_K160');


COMMENT ON TABLE BARS.KL_K160 IS '';
COMMENT ON COLUMN BARS.KL_K160.K160 IS '';
COMMENT ON COLUMN BARS.KL_K160.TXT IS '';
COMMENT ON COLUMN BARS.KL_K160.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K160.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K160.D_MODE IS '';



PROMPT *** Create  grants  KL_K160 ***
grant SELECT                                                                 on KL_K160         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_K160         to BARS_DM;
grant SELECT                                                                 on KL_K160         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K160.sql =========*** End *** =====
PROMPT ===================================================================================== 
