

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_W4_PRODUCT_DOC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_W4_PRODUCT_DOC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_W4_PRODUCT_DOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_W4_PRODUCT_DOC 
   (	GRP_CODE VARCHAR2(32), 
	DOC_ID VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_W4_PRODUCT_DOC ***
 exec bpa.alter_policies('TMP_W4_PRODUCT_DOC');


COMMENT ON TABLE BARS.TMP_W4_PRODUCT_DOC IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_DOC.GRP_CODE IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_DOC.DOC_ID IS '';




PROMPT *** Create  constraint SYS_C00119198 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_PRODUCT_DOC MODIFY (GRP_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119199 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_PRODUCT_DOC MODIFY (DOC_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_W4_PRODUCT_DOC ***
grant SELECT                                                                 on TMP_W4_PRODUCT_DOC to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_W4_PRODUCT_DOC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_W4_PRODUCT_DOC.sql =========*** En
PROMPT ===================================================================================== 
