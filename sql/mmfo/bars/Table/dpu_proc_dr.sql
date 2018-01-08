

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_PROC_DR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_PROC_DR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_PROC_DR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_PROC_DR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_PROC_DR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_PROC_DR ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_PROC_DR 
   (	VIDD NUMBER(38,0), 
	NBS CHAR(4), 
	KV NUMBER(3,0), 
	OB22_7 CHAR(2), 
	OB22_7_SH CHAR(2), 
	NLS7 VARCHAR2(15), 
	NLS7_SH VARCHAR2(15), 
	BRANCH VARCHAR2(30), 
	NAM_VIDD VARCHAR2(200), 
	NBS_7 CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_PROC_DR ***
 exec bpa.alter_policies('DPU_PROC_DR');


COMMENT ON TABLE BARS.DPU_PROC_DR IS 'Связь видов вкладов и счетов расходов';
COMMENT ON COLUMN BARS.DPU_PROC_DR.VIDD IS 'Код вида вклада';
COMMENT ON COLUMN BARS.DPU_PROC_DR.NBS IS 'Номер балансового счета для основного счета вида вклада';
COMMENT ON COLUMN BARS.DPU_PROC_DR.KV IS 'Валюта вклада';
COMMENT ON COLUMN BARS.DPU_PROC_DR.OB22_7 IS 'ОВ22 для счета 7-класса процентных расходов для нач. %%';
COMMENT ON COLUMN BARS.DPU_PROC_DR.OB22_7_SH IS 'ОВ22 для счета 7-класса, в случае досрочного возврата вклада';
COMMENT ON COLUMN BARS.DPU_PROC_DR.NLS7 IS 'Номер счета 7-класса';
COMMENT ON COLUMN BARS.DPU_PROC_DR.NLS7_SH IS 'Номер счета 7-класса, случае досрочного возврата вклада';
COMMENT ON COLUMN BARS.DPU_PROC_DR.BRANCH IS 'Код подразделения банка';
COMMENT ON COLUMN BARS.DPU_PROC_DR.NAM_VIDD IS 'Наименование вклада';
COMMENT ON COLUMN BARS.DPU_PROC_DR.NBS_7 IS 'Номер бал. счета 7 класса';




PROMPT *** Create  constraint DPU_PROC_DR_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_PROC_DR ADD CONSTRAINT DPU_PROC_DR_PK PRIMARY KEY (VIDD, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index DPU_PROC_DR_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.DPU_PROC_DR_PK ON BARS.DPU_PROC_DR (VIDD, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_PROC_DR ***
grant SELECT                                                                 on DPU_PROC_DR     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_PROC_DR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_PROC_DR     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_PROC_DR     to START1;
grant SELECT                                                                 on DPU_PROC_DR     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_PROC_DR     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_PROC_DR.sql =========*** End *** =
PROMPT ===================================================================================== 
