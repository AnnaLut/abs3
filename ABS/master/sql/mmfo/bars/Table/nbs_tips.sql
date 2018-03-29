

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_TIPS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_TIPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_TIPS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBS_TIPS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBS_TIPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_TIPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_TIPS 
   (	NBS CHAR(4), 
	TIP CHAR(3), 
	OPT NUMBER, 
	OB22 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_TIPS ***
 exec bpa.alter_policies('NBS_TIPS');


COMMENT ON TABLE  BARS.NBS_TIPS      IS 'Связь R020+OB22<->Типы счетов';
COMMENT ON COLUMN BARS.NBS_TIPS.OB22 IS 'Параметр OB22';
COMMENT ON COLUMN BARS.NBS_TIPS.NBS  IS 'Номер балансового рахунку (R020)';
COMMENT ON COLUMN BARS.NBS_TIPS.TIP  IS 'Тип рахунку';
COMMENT ON COLUMN BARS.NBS_TIPS.OPT  IS 'Необязятельность типа';




PROMPT *** Create  constraint UK_NBSTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_TIPS ADD CONSTRAINT UK_NBSTIPS UNIQUE (NBS, OB22, TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBSTIPS_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_TIPS MODIFY (NBS CONSTRAINT CC_NBSTIPS_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBSTIPS_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_TIPS MODIFY (TIP CONSTRAINT CC_NBSTIPS_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NBSTIPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBSTIPS ON BARS.NBS_TIPS (NBS, OB22, TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_TIPS ***
grant SELECT                                                                 on NBS_TIPS        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_TIPS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_TIPS        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_TIPS        to CUST001;
grant SELECT                                                                 on NBS_TIPS        to UPLD;
grant FLASHBACK,SELECT                                                       on NBS_TIPS        to WR_REFREAD;



PROMPT *** Create SYNONYM  to NBS_TIPS ***

  CREATE OR REPLACE PUBLIC SYNONYM NBS_TIPS FOR BARS.NBS_TIPS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_TIPS.sql =========*** End *** ====
PROMPT ===================================================================================== 
