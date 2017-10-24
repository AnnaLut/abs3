

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_MONEX3.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_MONEX3 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_MONEX3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_MONEX3 
   (	OB22 CHAR(2), 
	NAME VARCHAR2(25), 
	NLST VARCHAR2(14), 
	OB22_2809 CHAR(2), 
	OB22_KOM CHAR(2), 
	KOD_NBU VARCHAR2(5), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	ID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_MONEX3 ***
 exec bpa.alter_policies('TMP_MONEX3');


COMMENT ON TABLE BARS.TMP_MONEX3 IS '';
COMMENT ON COLUMN BARS.TMP_MONEX3.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_MONEX3.NAME IS '';
COMMENT ON COLUMN BARS.TMP_MONEX3.NLST IS '';
COMMENT ON COLUMN BARS.TMP_MONEX3.OB22_2809 IS '';
COMMENT ON COLUMN BARS.TMP_MONEX3.OB22_KOM IS '';
COMMENT ON COLUMN BARS.TMP_MONEX3.KOD_NBU IS '';
COMMENT ON COLUMN BARS.TMP_MONEX3.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_MONEX3.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_MONEX3.ID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_MONEX3.sql =========*** End *** ==
PROMPT ===================================================================================== 
