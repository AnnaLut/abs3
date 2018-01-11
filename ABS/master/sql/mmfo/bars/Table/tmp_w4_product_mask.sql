

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_W4_PRODUCT_MASK.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_W4_PRODUCT_MASK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_W4_PRODUCT_MASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_W4_PRODUCT_MASK 
   (	CODE VARCHAR2(32), 
	NAME VARCHAR2(100), 
	GRP_CODE VARCHAR2(32), 
	KV NUMBER(3,0), 
	NBS CHAR(4), 
	OB22 CHAR(2), 
	TIP VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_W4_PRODUCT_MASK ***
 exec bpa.alter_policies('TMP_W4_PRODUCT_MASK');


COMMENT ON TABLE BARS.TMP_W4_PRODUCT_MASK IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_MASK.CODE IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_MASK.NAME IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_MASK.GRP_CODE IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_MASK.KV IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_MASK.NBS IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_MASK.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_W4_PRODUCT_MASK.TIP IS '';




PROMPT *** Create  constraint SYS_C00119202 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_PRODUCT_MASK MODIFY (CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119203 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_PRODUCT_MASK MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119204 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_PRODUCT_MASK MODIFY (GRP_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119205 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_PRODUCT_MASK MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119206 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_PRODUCT_MASK MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119207 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_PRODUCT_MASK MODIFY (OB22 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119208 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_PRODUCT_MASK MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_W4_PRODUCT_MASK ***
grant SELECT                                                                 on TMP_W4_PRODUCT_MASK to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_W4_PRODUCT_MASK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_W4_PRODUCT_MASK.sql =========*** E
PROMPT ===================================================================================== 
