

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TEMP_FIN_BUDGET2.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TEMP_FIN_BUDGET2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TEMP_FIN_BUDGET2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TEMP_FIN_BUDGET2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TEMP_FIN_BUDGET2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TEMP_FIN_BUDGET2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TEMP_FIN_BUDGET2 
   (	NMS VARCHAR2(50), 
	S NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TEMP_FIN_BUDGET2 ***
 exec bpa.alter_policies('TEMP_FIN_BUDGET2');


COMMENT ON TABLE BARS.TEMP_FIN_BUDGET2 IS '';
COMMENT ON COLUMN BARS.TEMP_FIN_BUDGET2.NMS IS '';
COMMENT ON COLUMN BARS.TEMP_FIN_BUDGET2.S IS '';



PROMPT *** Create  grants  TEMP_FIN_BUDGET2 ***
grant SELECT                                                                 on TEMP_FIN_BUDGET2 to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TEMP_FIN_BUDGET2 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TEMP_FIN_BUDGET2 to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TEMP_FIN_BUDGET2 to START1;
grant SELECT                                                                 on TEMP_FIN_BUDGET2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TEMP_FIN_BUDGET2.sql =========*** End 
PROMPT ===================================================================================== 
