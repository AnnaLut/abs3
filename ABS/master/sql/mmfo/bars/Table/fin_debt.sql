

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_DEBT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_DEBT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_DEBT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_DEBT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_DEBT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_DEBT ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_DEBT 
   (	NBS_N CHAR(6), 
	NBS_P CHAR(6), 
	NBS_K CHAR(6), 
	MOD_ABS NUMBER(*,0), 
	COMM VARCHAR2(100),
	TERM_DAY NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_DEBT ***
 exec bpa.alter_policies('FIN_DEBT');

declare
  v_num integer;
begin
  select count(1) into v_num 
    from user_tab_columns 
    where table_name = 'FIN_DEBT'
      and column_name = 'TERM_DAY';
  if v_num = 0 then
    execute immediate 'ALTER TABLE FIN_DEBT ADD TERM_DAY NUMBER';
  end if;
end;
/

COMMENT ON COLUMN FIN_DEBT.TERM_DAY
IS 'номер дня – кінцевий день кожного місяця для погашення';


COMMENT ON TABLE BARS.FIN_DEBT IS 'Довідник рахунків дебіторської заборгованості';
COMMENT ON COLUMN BARS.FIN_DEBT.NBS_N IS 'Бал/ob22 дебіторської заборгованості';
COMMENT ON COLUMN BARS.FIN_DEBT.NBS_P IS 'Бал/ob22 простроченої дебіторської заборгованості';
COMMENT ON COLUMN BARS.FIN_DEBT.NBS_K IS 'Бал/ob22 Кред.заборгованості';
COMMENT ON COLUMN BARS.FIN_DEBT.MOD_ABS IS 'Признак~відсутності~в мод.АБС=1';
COMMENT ON COLUMN BARS.FIN_DEBT.COMM IS '';
COMMENT ON COLUMN BARS.FIN_DEBT.TERM_DAY IS 'номер дня – кінцевий день кожного місяця для погашення';



PROMPT *** Create  constraint UK_FINDEBT_NBSP ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_DEBT ADD CONSTRAINT UK_FINDEBT_NBSP UNIQUE (NBS_P)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FINDEB ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_DEBT ADD CONSTRAINT PK_FINDEB PRIMARY KEY (NBS_N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_FINDEBT_NBSP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_FINDEBT_NBSP ON BARS.FIN_DEBT (NBS_P) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINDEB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINDEB ON BARS.FIN_DEBT (NBS_N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_DEBT ***
grant SELECT                                                                 on FIN_DEBT        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_DEBT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_DEBT        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_DEBT        to START1;
grant SELECT                                                                 on FIN_DEBT        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_DEBT.sql =========*** End *** ====
PROMPT ===================================================================================== 
