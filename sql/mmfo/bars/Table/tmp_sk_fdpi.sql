

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SK_ASVO_FDPI.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SK_ASVO_FDPI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_SK_ASVO_FDEP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_SK_ASVO_FDEP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_SK_ASVO_FDEP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SK_ASVO_FDPI ***
begin 
  execute immediate '
CREATE GLOBAL TEMPORARY table BARS.TMP_SK_ASVO_FDPI
(
  branch   VARCHAR2(30),
  acc_card VARCHAR2(10),
  mark     VARCHAR2(1),
  datprc   DATE,
  prc      NUMBER(6,2)
)
   ON COMMIT PRESERVE ROWS
  TABLESPACE TEMP ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SK_ASVO_FDPI ***
 exec bpa.alter_policies('TMP_SK_ASVO_FDPI');



PROMPT *** Create  grants  TMP_SK_ASVO_FDPI ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SK_ASVO_FDPI to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_SK_ASVO_FDPI to BARSR;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SK_ASVO_FDPI.sql =========*** End 
PROMPT ===================================================================================== 
