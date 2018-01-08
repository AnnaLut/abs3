

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NMK_OUTPUT3.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NMK_OUTPUT3 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NMK_OUTPUT3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NMK_OUTPUT3 
   (	OUTPUT_LINE VARCHAR2(1500)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NMK_OUTPUT3 ***
 exec bpa.alter_policies('TMP_NMK_OUTPUT3');


COMMENT ON TABLE BARS.TMP_NMK_OUTPUT3 IS '';
COMMENT ON COLUMN BARS.TMP_NMK_OUTPUT3.OUTPUT_LINE IS '';



PROMPT *** Create  grants  TMP_NMK_OUTPUT3 ***
grant SELECT                                                                 on TMP_NMK_OUTPUT3 to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_NMK_OUTPUT3 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NMK_OUTPUT3.sql =========*** End *
PROMPT ===================================================================================== 
