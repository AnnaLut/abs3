

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_STORNO_2103.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_STORNO_2103 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_STORNO_2103 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_STORNO_2103 
   (	TT CHAR(3), 
	REF NUMBER(38,0), 
	PDAT DATE, 
	VDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_STORNO_2103 ***
 exec bpa.alter_policies('TMP_STORNO_2103');


COMMENT ON TABLE BARS.TMP_STORNO_2103 IS '';
COMMENT ON COLUMN BARS.TMP_STORNO_2103.TT IS '';
COMMENT ON COLUMN BARS.TMP_STORNO_2103.REF IS '';
COMMENT ON COLUMN BARS.TMP_STORNO_2103.PDAT IS '';
COMMENT ON COLUMN BARS.TMP_STORNO_2103.VDAT IS '';



PROMPT *** Create  grants  TMP_STORNO_2103 ***
grant SELECT                                                                 on TMP_STORNO_2103 to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_STORNO_2103 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_STORNO_2103.sql =========*** End *
PROMPT ===================================================================================== 
