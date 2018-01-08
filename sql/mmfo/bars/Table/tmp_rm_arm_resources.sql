

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_RM_ARM_RESOURCES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_RM_ARM_RESOURCES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_RM_ARM_RESOURCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_RM_ARM_RESOURCES 
   (	A NUMBER, 
	B VARCHAR2(500), 
	C VARCHAR2(500), 
	D VARCHAR2(500), 
	E NUMBER, 
	F VARCHAR2(500), 
	G NUMBER, 
	H VARCHAR2(500), 
	I VARCHAR2(500), 
	J VARCHAR2(500), 
	K VARCHAR2(500), 
	L VARCHAR2(500), 
	M VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_RM_ARM_RESOURCES ***
 exec bpa.alter_policies('TMP_RM_ARM_RESOURCES');


COMMENT ON TABLE BARS.TMP_RM_ARM_RESOURCES IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.A IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.B IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.C IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.D IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.E IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.F IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.G IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.H IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.I IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.J IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.K IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.L IS '';
COMMENT ON COLUMN BARS.TMP_RM_ARM_RESOURCES.M IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_RM_ARM_RESOURCES.sql =========*** 
PROMPT ===================================================================================== 
