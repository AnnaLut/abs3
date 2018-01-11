

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_TMP_VOLAP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_TMP_VOLAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_TMP_VOLAP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_TMP_VOLAP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SW_TMP_VOLAP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_TMP_VOLAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_TMP_VOLAP 
   (	RU_CHAR VARCHAR2(1), 
	SW_CHAR VARCHAR2(3), 
	CHRSET VARCHAR2(5)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_TMP_VOLAP ***
 exec bpa.alter_policies('SW_TMP_VOLAP');


COMMENT ON TABLE BARS.SW_TMP_VOLAP IS '';
COMMENT ON COLUMN BARS.SW_TMP_VOLAP.RU_CHAR IS '';
COMMENT ON COLUMN BARS.SW_TMP_VOLAP.SW_CHAR IS '';
COMMENT ON COLUMN BARS.SW_TMP_VOLAP.CHRSET IS '';



PROMPT *** Create  grants  SW_TMP_VOLAP ***
grant SELECT                                                                 on SW_TMP_VOLAP    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_TMP_VOLAP    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_TMP_VOLAP    to START1;
grant SELECT                                                                 on SW_TMP_VOLAP    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_TMP_VOLAP.sql =========*** End *** 
PROMPT ===================================================================================== 
