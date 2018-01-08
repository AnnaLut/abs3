

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANB1_PS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANB1_PS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANB1_PS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANB1_PS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANB1_PS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANB1_PS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANB1_PS 
   (	ID CHAR(4), 
	NBS CHAR(4), 
	PAP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANB1_PS ***
 exec bpa.alter_policies('ANB1_PS');


COMMENT ON TABLE BARS.ANB1_PS IS 'Зв`язок управл. та фiнанс.облiку';
COMMENT ON COLUMN BARS.ANB1_PS.ID IS 'Код управл.облiку';
COMMENT ON COLUMN BARS.ANB1_PS.NBS IS 'Код фiнанс.облiку (БР)';
COMMENT ON COLUMN BARS.ANB1_PS.PAP IS 'АП фiнанс.облiку';




PROMPT *** Create  constraint XPK_ANB1_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1_PS ADD CONSTRAINT XPK_ANB1_PS PRIMARY KEY (ID, NBS, PAP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ABN1_PS_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1_PS ADD CONSTRAINT FK_ABN1_PS_NBS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FX_ANB1_PS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1_PS ADD CONSTRAINT FX_ANB1_PS_ID FOREIGN KEY (ID)
	  REFERENCES BARS.ANB1 (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009313 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1_PS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009314 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1_PS MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009315 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1_PS MODIFY (PAP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ANB1_PS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ANB1_PS ON BARS.ANB1_PS (ID, NBS, PAP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XFK_ANB1_PS_NBS_AUTO ***
begin   
 execute immediate '
  CREATE INDEX BARS.XFK_ANB1_PS_NBS_AUTO ON BARS.ANB1_PS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANB1_PS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ANB1_PS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANB1_PS         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANB1_PS         to RPBN001;
grant DELETE,INSERT,SELECT                                                   on ANB1_PS         to SALGL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ANB1_PS         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANB1_PS.sql =========*** End *** =====
PROMPT ===================================================================================== 
