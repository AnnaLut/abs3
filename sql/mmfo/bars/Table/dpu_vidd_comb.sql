

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_VIDD_COMB.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_VIDD_COMB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_VIDD_COMB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_VIDD_COMB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_VIDD_COMB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_VIDD_COMB ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_VIDD_COMB 
   (	MAIN_VIDD NUMBER(38,0), 
	DMND_VIDD NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_VIDD_COMB ***
 exec bpa.alter_policies('DPU_VIDD_COMB');


COMMENT ON TABLE BARS.DPU_VIDD_COMB IS 'Комбинированные виды деп.договоров ЮЛ';
COMMENT ON COLUMN BARS.DPU_VIDD_COMB.MAIN_VIDD IS 'Вид основного договора';
COMMENT ON COLUMN BARS.DPU_VIDD_COMB.DMND_VIDD IS 'Вид связанного договора';




PROMPT *** Create  constraint PK_DPUVIDDCOMB ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_COMB ADD CONSTRAINT PK_DPUVIDDCOMB PRIMARY KEY (MAIN_VIDD, DMND_VIDD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDDCOMB_DPUVIDD_MAIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_COMB ADD CONSTRAINT FK_DPUVIDDCOMB_DPUVIDD_MAIN FOREIGN KEY (MAIN_VIDD)
	  REFERENCES BARS.DPU_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDDCOMB_DPUVIDD_DMND ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_COMB ADD CONSTRAINT FK_DPUVIDDCOMB_DPUVIDD_DMND FOREIGN KEY (DMND_VIDD)
	  REFERENCES BARS.DPU_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDCOMB_MAINVIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_COMB MODIFY (MAIN_VIDD CONSTRAINT CC_DPUVIDDCOMB_MAINVIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDCOMB_DMNDVIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_COMB MODIFY (DMND_VIDD CONSTRAINT CC_DPUVIDDCOMB_DMNDVIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUVIDDCOMB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUVIDDCOMB ON BARS.DPU_VIDD_COMB (MAIN_VIDD, DMND_VIDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_VIDD_COMB ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_VIDD_COMB   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_VIDD_COMB   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_VIDD_COMB   to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_VIDD_COMB   to DPT_ADMIN;
grant SELECT                                                                 on DPU_VIDD_COMB   to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_VIDD_COMB   to WR_ALL_RIGHTS;
grant SELECT                                                                 on DPU_VIDD_COMB   to WR_DEPOSIT_U;



PROMPT *** Create SYNONYM  to DPU_VIDD_COMB ***

  CREATE OR REPLACE PUBLIC SYNONYM DPU_VIDD_COMB FOR BARS.DPU_VIDD_COMB;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_VIDD_COMB.sql =========*** End ***
PROMPT ===================================================================================== 
