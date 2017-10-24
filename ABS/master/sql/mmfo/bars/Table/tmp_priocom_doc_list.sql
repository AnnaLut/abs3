

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PRIOCOM_DOC_LIST.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PRIOCOM_DOC_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_PRIOCOM_DOC_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_PRIOCOM_DOC_LIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_PRIOCOM_DOC_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PRIOCOM_DOC_LIST ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_PRIOCOM_DOC_LIST 
   (	DOCID NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PRIOCOM_DOC_LIST ***
 exec bpa.alter_policies('TMP_PRIOCOM_DOC_LIST');


COMMENT ON TABLE BARS.TMP_PRIOCOM_DOC_LIST IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_DOC_LIST.DOCID IS '';



PROMPT *** Create  grants  TMP_PRIOCOM_DOC_LIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PRIOCOM_DOC_LIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_PRIOCOM_DOC_LIST to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PRIOCOM_DOC_LIST to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PRIOCOM_DOC_LIST.sql =========*** 
PROMPT ===================================================================================== 
