

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_MONTH.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_MONTH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_MONTH'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_MONTH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_MONTH ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_MONTH 
   (	N NUMBER, 
	NAME_PLAIN VARCHAR2(10), 
	NAME_FROM VARCHAR2(10), 
	NAME_RUS VARCHAR2(10), 
	NAME_RUS_FROM VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_MONTH ***
 exec bpa.alter_policies('META_MONTH');


COMMENT ON TABLE BARS.META_MONTH IS 'ћетаописание. Ќаименовани€ мес€цев';
COMMENT ON COLUMN BARS.META_MONTH.N IS 'Ќомер мес€ца';
COMMENT ON COLUMN BARS.META_MONTH.NAME_PLAIN IS 'Ќаименование мес€ца (укр. €з Ц им.пад.)';
COMMENT ON COLUMN BARS.META_MONTH.NAME_FROM IS 'Ќаименование мес€ца (укр. €з Ц род.пад.)';
COMMENT ON COLUMN BARS.META_MONTH.NAME_RUS IS 'Ќаименование мес€ца (рус. €з Ц им.пад.)';
COMMENT ON COLUMN BARS.META_MONTH.NAME_RUS_FROM IS 'Ќаименование мес€ца (рус. €з Ц род.пад.)';




PROMPT *** Create  constraint CC_METAMONTH_N ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_MONTH ADD CONSTRAINT CC_METAMONTH_N CHECK (n between 1 and 12) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METAMONTH ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_MONTH ADD CONSTRAINT PK_METAMONTH PRIMARY KEY (N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAMONTH_NAMERUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_MONTH MODIFY (NAME_RUS CONSTRAINT CC_METAMONTH_NAMERUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAMONTH_NAMEFROM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_MONTH MODIFY (NAME_FROM CONSTRAINT CC_METAMONTH_NAMEFROM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAMONTH_NAMEPLAIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_MONTH MODIFY (NAME_PLAIN CONSTRAINT CC_METAMONTH_NAMEPLAIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAMONTH_N_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_MONTH MODIFY (N CONSTRAINT CC_METAMONTH_N_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METAMONTH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METAMONTH ON BARS.META_MONTH (N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_MONTH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_MONTH      to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_MONTH      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_MONTH      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_MONTH      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_MONTH.sql =========*** End *** ==
PROMPT ===================================================================================== 
