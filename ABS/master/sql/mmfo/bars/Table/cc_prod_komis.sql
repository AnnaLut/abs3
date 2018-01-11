

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_PROD_KOMIS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_PROD_KOMIS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_PROD_KOMIS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_PROD_KOMIS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_PROD_KOMIS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_PROD_KOMIS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_PROD_KOMIS 
   (	PROD VARCHAR2(100), 
	KOMIS CHAR(6), 
	COM VARCHAR2(255), 
	PDV NUMBER, 
	TARIF NUMBER, 
	NBS_OB22 VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_PROD_KOMIS ***
 exec bpa.alter_policies('CC_PROD_KOMIS');


COMMENT ON TABLE BARS.CC_PROD_KOMIS IS '';
COMMENT ON COLUMN BARS.CC_PROD_KOMIS.PROD IS 'Код кредитного продукта';
COMMENT ON COLUMN BARS.CC_PROD_KOMIS.KOMIS IS 'Код разовой комиссии';
COMMENT ON COLUMN BARS.CC_PROD_KOMIS.COM IS 'Комментарий';
COMMENT ON COLUMN BARS.CC_PROD_KOMIS.PDV IS '';
COMMENT ON COLUMN BARS.CC_PROD_KOMIS.TARIF IS '';
COMMENT ON COLUMN BARS.CC_PROD_KOMIS.NBS_OB22 IS '';




PROMPT *** Create  constraint CC_PROD_KOMIS_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROD_KOMIS ADD CONSTRAINT CC_PROD_KOMIS_PK PRIMARY KEY (PROD, KOMIS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_PROD_KOMIS_P ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROD_KOMIS MODIFY (PROD CONSTRAINT NK_CC_PROD_KOMIS_P NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_PROD_KOMIS_K ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROD_KOMIS MODIFY (KOMIS CONSTRAINT NK_CC_PROD_KOMIS_K NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_PROD_KOMIS_NBS_OB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PROD_KOMIS MODIFY (NBS_OB22 CONSTRAINT NK_CC_PROD_KOMIS_NBS_OB22 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CC_PROD_KOMIS_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_PROD_KOMIS_PK ON BARS.CC_PROD_KOMIS (PROD, KOMIS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_PROD_KOMIS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_PROD_KOMIS   to ABS_ADMIN;
grant SELECT                                                                 on CC_PROD_KOMIS   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_PROD_KOMIS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_PROD_KOMIS   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_PROD_KOMIS   to RCC_DEAL;
grant SELECT                                                                 on CC_PROD_KOMIS   to UPLD;
grant FLASHBACK,SELECT                                                       on CC_PROD_KOMIS   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_PROD_KOMIS.sql =========*** End ***
PROMPT ===================================================================================== 
