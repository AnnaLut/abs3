

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BR_CCK_OB22.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BR_CCK_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BR_CCK_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BR_CCK_OB22 
   (	OLD_PROD VARCHAR2(6), 
	NEW_PROD VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BR_CCK_OB22 ***
 exec bpa.alter_policies('TMP_BR_CCK_OB22');


COMMENT ON TABLE BARS.TMP_BR_CCK_OB22 IS '';
COMMENT ON COLUMN BARS.TMP_BR_CCK_OB22.OLD_PROD IS '';
COMMENT ON COLUMN BARS.TMP_BR_CCK_OB22.NEW_PROD IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BR_CCK_OB22.sql =========*** End *
PROMPT ===================================================================================== 
