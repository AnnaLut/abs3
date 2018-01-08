

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_PRODUCT_MASK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_PRODUCT_MASK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_PRODUCT_MASK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''W4_PRODUCT_MASK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''W4_PRODUCT_MASK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_PRODUCT_MASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_PRODUCT_MASK 
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
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_PRODUCT_MASK ***
 exec bpa.alter_policies('W4_PRODUCT_MASK');


COMMENT ON TABLE BARS.W4_PRODUCT_MASK IS 'W4. Маски для новых продуктов';
COMMENT ON COLUMN BARS.W4_PRODUCT_MASK.CODE IS '';
COMMENT ON COLUMN BARS.W4_PRODUCT_MASK.NAME IS '';
COMMENT ON COLUMN BARS.W4_PRODUCT_MASK.GRP_CODE IS '';
COMMENT ON COLUMN BARS.W4_PRODUCT_MASK.KV IS '';
COMMENT ON COLUMN BARS.W4_PRODUCT_MASK.NBS IS '';
COMMENT ON COLUMN BARS.W4_PRODUCT_MASK.OB22 IS '';
COMMENT ON COLUMN BARS.W4_PRODUCT_MASK.TIP IS '';




PROMPT *** Create  constraint CC_W4PRODUCTMASK_GRPCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_MASK MODIFY (GRP_CODE CONSTRAINT CC_W4PRODUCTMASK_GRPCODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCTMASK_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_MASK MODIFY (NAME CONSTRAINT CC_W4PRODUCTMASK_NAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCTMASK_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_MASK MODIFY (CODE CONSTRAINT CC_W4PRODUCTMASK_CODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCTMASK_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_MASK MODIFY (KV CONSTRAINT CC_W4PRODUCTMASK_KV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCTMASK_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_MASK MODIFY (NBS CONSTRAINT CC_W4PRODUCTMASK_NBS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCTMASK_OB22_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_MASK MODIFY (OB22 CONSTRAINT CC_W4PRODUCTMASK_OB22_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCTMASK_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_MASK MODIFY (TIP CONSTRAINT CC_W4PRODUCTMASK_TIP_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_PRODUCT_MASK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_PRODUCT_MASK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_PRODUCT_MASK to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_PRODUCT_MASK to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_PRODUCT_MASK.sql =========*** End *
PROMPT ===================================================================================== 
