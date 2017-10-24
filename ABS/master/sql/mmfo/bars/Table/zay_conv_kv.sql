

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_CONV_KV.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_CONV_KV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_CONV_KV'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_CONV_KV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_CONV_KV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_CONV_KV ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_CONV_KV 
   (	KV1 NUMBER(3,0), 
	KV2 NUMBER(3,0), 
	KV_BASE NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_CONV_KV ***
 exec bpa.alter_policies('ZAY_CONV_KV');


COMMENT ON TABLE BARS.ZAY_CONV_KV IS 'Базовые валюты для пар валют при конверсии';
COMMENT ON COLUMN BARS.ZAY_CONV_KV.KV1 IS 'Вал-1';
COMMENT ON COLUMN BARS.ZAY_CONV_KV.KV2 IS 'Вал-2';
COMMENT ON COLUMN BARS.ZAY_CONV_KV.KV_BASE IS 'Вал базовая';




PROMPT *** Create  constraint PK_ZAYCONVKV ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_CONV_KV ADD CONSTRAINT PK_ZAYCONVKV PRIMARY KEY (KV1, KV2)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYCONVKV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYCONVKV ON BARS.ZAY_CONV_KV (KV1, KV2) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_CONV_KV ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_CONV_KV     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_CONV_KV     to BARS_DM;
grant FLASHBACK,SELECT                                                       on ZAY_CONV_KV     to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_CONV_KV     to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_CONV_KV.sql =========*** End *** =
PROMPT ===================================================================================== 
