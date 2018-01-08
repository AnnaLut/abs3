

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F71_KONS_TEMP.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F71_KONS_TEMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F71_KONS_TEMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F71_KONS_TEMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F71_KONS_TEMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F71_KONS_TEMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_F71_KONS_TEMP 
   (	OKPO VARCHAR2(10), 
	P040 NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F71_KONS_TEMP ***
 exec bpa.alter_policies('OTCN_F71_KONS_TEMP');


COMMENT ON TABLE BARS.OTCN_F71_KONS_TEMP IS '';
COMMENT ON COLUMN BARS.OTCN_F71_KONS_TEMP.OKPO IS '';
COMMENT ON COLUMN BARS.OTCN_F71_KONS_TEMP.P040 IS '';



PROMPT *** Create  grants  OTCN_F71_KONS_TEMP ***
grant SELECT                                                                 on OTCN_F71_KONS_TEMP to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_KONS_TEMP to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_KONS_TEMP to START1;
grant SELECT                                                                 on OTCN_F71_KONS_TEMP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F71_KONS_TEMP.sql =========*** En
PROMPT ===================================================================================== 
