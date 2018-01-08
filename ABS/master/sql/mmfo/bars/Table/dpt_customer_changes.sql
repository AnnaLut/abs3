

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_CUSTOMER_CHANGES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_CUSTOMER_CHANGES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_CUSTOMER_CHANGES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_CUSTOMER_CHANGES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_CUSTOMER_CHANGES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_CUSTOMER_CHANGES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_CUSTOMER_CHANGES 
   (	RNK NUMBER(38,0), 
	TAG VARCHAR2(10), 
	VAL VARCHAR2(200), 
	VAL_OLD VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_CUSTOMER_CHANGES ***
 exec bpa.alter_policies('DPT_CUSTOMER_CHANGES');


COMMENT ON TABLE BARS.DPT_CUSTOMER_CHANGES IS 'Зміни в реквізитах клієнта (для друку заяви)';
COMMENT ON COLUMN BARS.DPT_CUSTOMER_CHANGES.RNK IS 'РНК клієнта';
COMMENT ON COLUMN BARS.DPT_CUSTOMER_CHANGES.TAG IS 'Код реквізиту';
COMMENT ON COLUMN BARS.DPT_CUSTOMER_CHANGES.VAL IS 'Нове значення реквізиту';
COMMENT ON COLUMN BARS.DPT_CUSTOMER_CHANGES.VAL_OLD IS 'Старе значення реквізиту';




PROMPT *** Create  constraint PK_DPTCUSTOMERCHANGES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_CUSTOMER_CHANGES ADD CONSTRAINT PK_DPTCUSTOMERCHANGES PRIMARY KEY (RNK, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPTCUSTOMERCHANGES_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_CUSTOMER_CHANGES MODIFY (RNK CONSTRAINT DPTCUSTOMERCHANGES_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPTCUSTOMERCHANGES_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_CUSTOMER_CHANGES MODIFY (TAG CONSTRAINT DPTCUSTOMERCHANGES_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPTCUSTOMERCHANGES_VAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_CUSTOMER_CHANGES MODIFY (VAL CONSTRAINT DPTCUSTOMERCHANGES_VAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTCUSTOMERCHANGES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTCUSTOMERCHANGES ON BARS.DPT_CUSTOMER_CHANGES (RNK, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_CUSTOMER_CHANGES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_CUSTOMER_CHANGES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_CUSTOMER_CHANGES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_CUSTOMER_CHANGES to DPT_ADMIN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_CUSTOMER_CHANGES.sql =========*** 
PROMPT ===================================================================================== 
