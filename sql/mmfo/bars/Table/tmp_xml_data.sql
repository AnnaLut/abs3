

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_XML_DATA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_XML_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_XML_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_XML_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_XML_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_XML_DATA ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_XML_DATA 
   (	DD CLOB
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_XML_DATA ***
 exec bpa.alter_policies('TMP_XML_DATA');


COMMENT ON TABLE BARS.TMP_XML_DATA IS '';
COMMENT ON COLUMN BARS.TMP_XML_DATA.DD IS '';



PROMPT *** Create  grants  TMP_XML_DATA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_XML_DATA    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_XML_DATA    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_XML_DATA.sql =========*** End *** 
PROMPT ===================================================================================== 
