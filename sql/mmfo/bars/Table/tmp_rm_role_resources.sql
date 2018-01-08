

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_RM_ROLE_RESOURCES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_RM_ROLE_RESOURCES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_RM_ROLE_RESOURCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_RM_ROLE_RESOURCES 
   (	A NUMBER, 
	B VARCHAR2(500), 
	C VARCHAR2(500), 
	D VARCHAR2(500), 
	E NUMBER, 
	F VARCHAR2(500), 
	G VARCHAR2(500), 
	H VARCHAR2(500), 
	J VARCHAR2(500), 
	K VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_RM_ROLE_RESOURCES ***
 exec bpa.alter_policies('TMP_RM_ROLE_RESOURCES');


COMMENT ON TABLE BARS.TMP_RM_ROLE_RESOURCES IS '';
COMMENT ON COLUMN BARS.TMP_RM_ROLE_RESOURCES.A IS '';
COMMENT ON COLUMN BARS.TMP_RM_ROLE_RESOURCES.B IS '';
COMMENT ON COLUMN BARS.TMP_RM_ROLE_RESOURCES.C IS '';
COMMENT ON COLUMN BARS.TMP_RM_ROLE_RESOURCES.D IS '';
COMMENT ON COLUMN BARS.TMP_RM_ROLE_RESOURCES.E IS '';
COMMENT ON COLUMN BARS.TMP_RM_ROLE_RESOURCES.F IS '';
COMMENT ON COLUMN BARS.TMP_RM_ROLE_RESOURCES.G IS '';
COMMENT ON COLUMN BARS.TMP_RM_ROLE_RESOURCES.H IS '';
COMMENT ON COLUMN BARS.TMP_RM_ROLE_RESOURCES.J IS '';
COMMENT ON COLUMN BARS.TMP_RM_ROLE_RESOURCES.K IS '';



PROMPT *** Create  grants  TMP_RM_ROLE_RESOURCES ***
grant SELECT                                                                 on TMP_RM_ROLE_RESOURCES to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_RM_ROLE_RESOURCES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_RM_ROLE_RESOURCES.sql =========***
PROMPT ===================================================================================== 
