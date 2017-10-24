

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SW102_REF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SW102_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_SW102_REF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_SW102_REF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_SW102_REF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SW102_REF ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SW102_REF 
   (	SWREF NUMBER(38,0)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SW102_REF ***
 exec bpa.alter_policies('TMP_SW102_REF');


COMMENT ON TABLE BARS.TMP_SW102_REF IS '';
COMMENT ON COLUMN BARS.TMP_SW102_REF.SWREF IS '';



PROMPT *** Create  grants  TMP_SW102_REF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SW102_REF   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SW102_REF   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SW102_REF.sql =========*** End ***
PROMPT ===================================================================================== 
