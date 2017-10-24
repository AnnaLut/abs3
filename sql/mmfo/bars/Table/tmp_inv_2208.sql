

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INV_2208.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INV_2208 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_INV_2208'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''TMP_INV_2208'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''TMP_INV_2208'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INV_2208 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_INV_2208 
   (	ACC NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INV_2208 ***
 exec bpa.alter_policies('TMP_INV_2208');


COMMENT ON TABLE BARS.TMP_INV_2208 IS '';
COMMENT ON COLUMN BARS.TMP_INV_2208.ACC IS '';



PROMPT *** Create  grants  TMP_INV_2208 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INV_2208    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_INV_2208    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INV_2208    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INV_2208.sql =========*** End *** 
PROMPT ===================================================================================== 
