

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SALDOA.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SALDOA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SALDOA ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SALDOA 
   (	ACC NUMBER(*,0), 
	FDAT DATE, 
	PDAT DATE, 
	OSTF NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	TRCN NUMBER(10,0), 
	OSTQ NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SALDOA ***
 exec bpa.alter_policies('TMP_SALDOA');


COMMENT ON TABLE BARS.TMP_SALDOA IS '';
COMMENT ON COLUMN BARS.TMP_SALDOA.ACC IS '';
COMMENT ON COLUMN BARS.TMP_SALDOA.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_SALDOA.PDAT IS '';
COMMENT ON COLUMN BARS.TMP_SALDOA.OSTF IS '';
COMMENT ON COLUMN BARS.TMP_SALDOA.DOS IS '';
COMMENT ON COLUMN BARS.TMP_SALDOA.KOS IS '';
COMMENT ON COLUMN BARS.TMP_SALDOA.TRCN IS '';
COMMENT ON COLUMN BARS.TMP_SALDOA.OSTQ IS '';
COMMENT ON COLUMN BARS.TMP_SALDOA.DOSQ IS '';
COMMENT ON COLUMN BARS.TMP_SALDOA.KOSQ IS '';
COMMENT ON COLUMN BARS.TMP_SALDOA.KF IS '';



PROMPT *** Create  grants  TMP_SALDOA ***
grant SELECT                                                                 on TMP_SALDOA      to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_SALDOA      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SALDOA.sql =========*** End *** ==
PROMPT ===================================================================================== 
