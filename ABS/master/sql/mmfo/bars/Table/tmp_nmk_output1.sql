

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NMK_OUTPUT1.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NMK_OUTPUT1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NMK_OUTPUT1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NMK_OUTPUT1 
   (	OUTPUT_LINE VARCHAR2(1500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NMK_OUTPUT1 ***
 exec bpa.alter_policies('TMP_NMK_OUTPUT1');


COMMENT ON TABLE BARS.TMP_NMK_OUTPUT1 IS '';
COMMENT ON COLUMN BARS.TMP_NMK_OUTPUT1.OUTPUT_LINE IS '';



PROMPT *** Create  grants  TMP_NMK_OUTPUT1 ***
grant SELECT                                                                 on TMP_NMK_OUTPUT1 to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NMK_OUTPUT1.sql =========*** End *
PROMPT ===================================================================================== 
