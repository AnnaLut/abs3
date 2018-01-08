

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TZAPROS_BAK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_TZAPROS_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TZAPROS_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_TZAPROS_BAK 
   (	REC NUMBER(38,0), 
	ISP NUMBER, 
	OTM NUMBER, 
	DAT DATE, 
	REC_O NUMBER, 
	STMP DATE, 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_TZAPROS_BAK ***
 exec bpa.alter_policies('TMP_TZAPROS_BAK');


COMMENT ON TABLE BARS.TMP_TZAPROS_BAK IS '';
COMMENT ON COLUMN BARS.TMP_TZAPROS_BAK.REC IS '';
COMMENT ON COLUMN BARS.TMP_TZAPROS_BAK.ISP IS '';
COMMENT ON COLUMN BARS.TMP_TZAPROS_BAK.OTM IS '';
COMMENT ON COLUMN BARS.TMP_TZAPROS_BAK.DAT IS '';
COMMENT ON COLUMN BARS.TMP_TZAPROS_BAK.REC_O IS '';
COMMENT ON COLUMN BARS.TMP_TZAPROS_BAK.STMP IS '';
COMMENT ON COLUMN BARS.TMP_TZAPROS_BAK.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TZAPROS_BAK.sql =========*** End *
PROMPT ===================================================================================== 
