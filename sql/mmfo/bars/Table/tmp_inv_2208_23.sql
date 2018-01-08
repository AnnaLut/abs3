

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INV_2208_23.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INV_2208_23 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_INV_2208_23'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''TMP_INV_2208_23'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''TMP_INV_2208_23'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INV_2208_23 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_INV_2208_23 
   (	ACC NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INV_2208_23 ***
 exec bpa.alter_policies('TMP_INV_2208_23');


COMMENT ON TABLE BARS.TMP_INV_2208_23 IS '';
COMMENT ON COLUMN BARS.TMP_INV_2208_23.ACC IS '';



PROMPT *** Create  grants  TMP_INV_2208_23 ***
grant SELECT                                                                 on TMP_INV_2208_23 to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_INV_2208_23 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INV_2208_23.sql =========*** End *
PROMPT ===================================================================================== 
