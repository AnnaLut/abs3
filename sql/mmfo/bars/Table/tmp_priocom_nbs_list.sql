

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PRIOCOM_NBS_LIST.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PRIOCOM_NBS_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_PRIOCOM_NBS_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_PRIOCOM_NBS_LIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_PRIOCOM_NBS_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PRIOCOM_NBS_LIST ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_PRIOCOM_NBS_LIST 
   (	NBS VARCHAR2(4)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PRIOCOM_NBS_LIST ***
 exec bpa.alter_policies('TMP_PRIOCOM_NBS_LIST');


COMMENT ON TABLE BARS.TMP_PRIOCOM_NBS_LIST IS '';
COMMENT ON COLUMN BARS.TMP_PRIOCOM_NBS_LIST.NBS IS '';



PROMPT *** Create  grants  TMP_PRIOCOM_NBS_LIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PRIOCOM_NBS_LIST to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PRIOCOM_NBS_LIST to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PRIOCOM_NBS_LIST.sql =========*** 
PROMPT ===================================================================================== 
