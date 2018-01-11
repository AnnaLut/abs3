

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SALDO_HOLIDAY.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SALDO_HOLIDAY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SALDO_HOLIDAY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SALDO_HOLIDAY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SALDO_HOLIDAY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SALDO_HOLIDAY ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.SALDO_HOLIDAY 
   (	FDAT DATE, 
	CDAT DATE, 
	ACC NUMBER(38,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SALDO_HOLIDAY ***
 exec bpa.alter_policies('SALDO_HOLIDAY');


COMMENT ON TABLE BARS.SALDO_HOLIDAY IS 'Накопительная таблица оборотов по счетам по календарным дням';
COMMENT ON COLUMN BARS.SALDO_HOLIDAY.FDAT IS 'Банковская дата';
COMMENT ON COLUMN BARS.SALDO_HOLIDAY.CDAT IS 'Календарная дата';
COMMENT ON COLUMN BARS.SALDO_HOLIDAY.ACC IS 'Ид. счета';
COMMENT ON COLUMN BARS.SALDO_HOLIDAY.DOS IS 'Сумма дебетовых оборотов';
COMMENT ON COLUMN BARS.SALDO_HOLIDAY.KOS IS 'Сумма кредитовых оборотов';




PROMPT *** Create  constraint PK_SALDOHOLIDAY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDO_HOLIDAY ADD CONSTRAINT PK_SALDOHOLIDAY PRIMARY KEY (FDAT, CDAT, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOHOLIDAY_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDO_HOLIDAY MODIFY (FDAT CONSTRAINT CC_SALDOHOLIDAY_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOHOLIDAY_CDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDO_HOLIDAY MODIFY (CDAT CONSTRAINT CC_SALDOHOLIDAY_CDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOHOLIDAY_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDO_HOLIDAY MODIFY (ACC CONSTRAINT CC_SALDOHOLIDAY_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOHOLIDAY_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDO_HOLIDAY MODIFY (DOS CONSTRAINT CC_SALDOHOLIDAY_DOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOHOLIDAY_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDO_HOLIDAY MODIFY (KOS CONSTRAINT CC_SALDOHOLIDAY_KOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SALDOHOLIDAY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SALDOHOLIDAY ON BARS.SALDO_HOLIDAY (FDAT, CDAT, ACC) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_SALDOHOLIDAY ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_SALDOHOLIDAY ON BARS.SALDO_HOLIDAY (FDAT) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_SALHOLIDAY_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_SALHOLIDAY_ACC ON BARS.SALDO_HOLIDAY (ACC) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SALDO_HOLIDAY ***
grant SELECT                                                                 on SALDO_HOLIDAY   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDO_HOLIDAY   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALDO_HOLIDAY   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDO_HOLIDAY   to START1;
grant SELECT                                                                 on SALDO_HOLIDAY   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SALDO_HOLIDAY.sql =========*** End ***
PROMPT ===================================================================================== 
