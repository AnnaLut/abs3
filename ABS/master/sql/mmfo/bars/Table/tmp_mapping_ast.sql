

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_MAPPING_AST.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_MAPPING_AST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_MAPPING_AST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_MAPPING_AST 
   (	BRANCH VARCHAR2(30 CHAR), 
	BARS_LOGIN VARCHAR2(30 CHAR), 
	AD_LOGIN VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_MAPPING_AST ***
 exec bpa.alter_policies('TMP_MAPPING_AST');


COMMENT ON TABLE BARS.TMP_MAPPING_AST IS '';
COMMENT ON COLUMN BARS.TMP_MAPPING_AST.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_MAPPING_AST.BARS_LOGIN IS '';
COMMENT ON COLUMN BARS.TMP_MAPPING_AST.AD_LOGIN IS '';



PROMPT *** Create  grants  TMP_MAPPING_AST ***
grant SELECT                                                                 on TMP_MAPPING_AST to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_MAPPING_AST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_MAPPING_AST.sql =========*** End *
PROMPT ===================================================================================== 
