

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z150.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z150 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z150 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z150 
   (	Z150 VARCHAR2(2), 
	TXT VARCHAR2(81), 
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




PROMPT *** ALTER_POLICIES to KL_Z150 ***
 exec bpa.alter_policies('KL_Z150');


COMMENT ON TABLE BARS.KL_Z150 IS '';
COMMENT ON COLUMN BARS.KL_Z150.Z150 IS '';
COMMENT ON COLUMN BARS.KL_Z150.TXT IS '';
COMMENT ON COLUMN BARS.KL_Z150.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z150.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_Z150.D_MODE IS '';



PROMPT *** Create  grants  KL_Z150 ***
grant SELECT                                                                 on KL_Z150         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_Z150         to BARS_DM;
grant SELECT                                                                 on KL_Z150         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z150.sql =========*** End *** =====
PROMPT ===================================================================================== 
