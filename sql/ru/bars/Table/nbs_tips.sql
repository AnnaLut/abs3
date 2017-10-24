

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_TIPS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_TIPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_TIPS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBS_TIPS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
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
	OPT NUMBER
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


COMMENT ON TABLE BARS.NBS_TIPS IS 'Связь НБС<->Типы счетов';
COMMENT ON COLUMN BARS.NBS_TIPS.NBS IS 'НБС';
COMMENT ON COLUMN BARS.NBS_TIPS.TIP IS 'Тип счета';
COMMENT ON COLUMN BARS.NBS_TIPS.OPT IS '';




PROMPT *** Create  constraint FK_NBSTIPS_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_TIPS ADD CONSTRAINT FK_NBSTIPS_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBSTIPS_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_TIPS ADD CONSTRAINT FK_NBSTIPS_NBS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NBSTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_TIPS ADD CONSTRAINT PK_NBSTIPS PRIMARY KEY (NBS, TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
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




PROMPT *** Create  constraint CC_NBSTIPS_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_TIPS MODIFY (NBS CONSTRAINT CC_NBSTIPS_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBSTIPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBSTIPS ON BARS.NBS_TIPS (NBS, TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_TIPS ***
grant SELECT                                                                 on NBS_TIPS        to BARSDWH_ACCESS_USER;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_TIPS        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_TIPS        to CUST001;
grant FLASHBACK,SELECT                                                       on NBS_TIPS        to WR_REFREAD;



PROMPT *** Create SYNONYM  to NBS_TIPS ***

  CREATE OR REPLACE PUBLIC SYNONYM NBS_TIPS FOR BARS.NBS_TIPS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_TIPS.sql =========*** End *** ====
PROMPT ===================================================================================== 
