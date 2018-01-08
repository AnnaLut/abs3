-- ======================================================================================
-- Module : DPU
-- Author : BAA
-- Date   : 20.09.2016
-- ===================================== <Comments> =====================================
-- create table DPU_VIDD
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table DPU_VIDD
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'DPU_VIDD', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'DPU_VIDD', 'FILIAL', NULL,  'E',  'E',  'E' );
end;
/


declare
  e_col_not_exists       exception;
  pragma exception_init( e_col_not_exists,-00904 );
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
  e_dup_col_nm           exception;
  pragma exception_init( e_dup_col_nm, -00957 );
begin
  execute immediate q'[CREATE TABLE BARS.DPU_VIDD
( VIDD           NUMBER(38)              CONSTRAINT CC_DPUVIDD_VIDD_NN NOT NULL
, NAME           VARCHAR2(50)            CONSTRAINT CC_DPUVIDD_NAME_NN NOT NULL
, KV             NUMBER(3)               CONSTRAINT CC_DPUVIDD_KV_NN NOT NULL
, SROK           NUMBER(7,2)
, BSD            CHAR(4)                 CONSTRAINT CC_DPUVIDD_BSD_NN NOT NULL
, BSN            CHAR(4)                 CONSTRAINT CC_DPUVIDD_BSN_NN NOT NULL
, BASEY          INTEGER       DEFAULT 0 CONSTRAINT CC_DPUVIDD_BASEY_NN NOT NULL
, METR           INTEGER                 CONSTRAINT CC_DPUVIDD_METR_NN NOT NULL
, BR_ID          NUMBER(38)
, FREQ_N         NUMBER(3)     DEFAULT 1 CONSTRAINT CC_DPUVIDD_FREQN_NN NOT NULL
, FREQ_V         NUMBER(3)               CONSTRAINT CC_DPUVIDD_FREQV_NN NOT NULL
, ACC7           NUMBER(38)
, TT             CHAR(3)                 CONSTRAINT CC_DPUVIDD_TT_NN NOT NULL
, COMPROC        NUMBER(1)     DEFAULT 0 CONSTRAINT CC_DPUVIDD_COMPROC_NN NOT NULL
, ID_STOP        NUMBER(38)              CONSTRAINT CC_DPUVIDD_IDSTOP_NN NOT NULL
, MIN_SUMM       NUMBER(24)
, LIMIT          NUMBER(24)
, PENYA          NUMBER(24)
, SHABLON        VARCHAR2(35)
, COMMENTS       VARCHAR2(128)
, FLAG           NUMBER(1)     DEFAULT 0 CONSTRAINT CC_DPUVIDD_FLAG_NN         NOT NULL
, FL_ADD         NUMBER(1)     DEFAULT 0 CONSTRAINT CC_DPUVIDD_FLADD_NN        NOT NULL
, FL_EXTEND      NUMBER(1)     DEFAULT 0 CONSTRAINT CC_DPUVIDD_FLEXTEND_NN     NOT NULL
, TIP_OST        NUMBER(1)     DEFAULT 1 CONSTRAINT CC_DPUVIDD_TIPOST_NN       NOT NULL
, DPU_TYPE       NUMBER(1)     DEFAULT 1 CONSTRAINT CC_DPUVIDD_S181_NN         NOT NULL
, FL_AUTOEXTEND  NUMBER(1)     DEFAULT 0 CONSTRAINT CC_DPUVIDD_FLAUTOEXTEND_NN NOT NULL
, DPU_CODE       CHAR(4)
, MAX_SUMM       NUMBER(24)
, TYPE_ID        NUMBER(38)    DEFAULT 0 CONSTRAINT CC_DPUVIDD_TYPEID_NN NOT NULL
, TERM_TYPE      NUMBER(1)     DEFAULT 1 CONSTRAINT CC_DPUVIDD_TERMTYPE_NN NOT NULL
, TERM_MIN       NUMBER(6,4)             constraint CC_DPUVIDD_TERMMIN_NN NOT NULL
, TERM_MAX       NUMBER(6,4)             constraint CC_DPUVIDD_TERMMAX_NN NOT NULL
, TERM_ADD       NUMBER(6,4)
, IRVK           NUMBER(1)     DEFAULT 1 CONSTRAINT CC_DPUVIDD_IRVK_NN         NOT NULL
, EXN_MTH_ID     NUMBER(38)
, constraint PK_DPUVIDD            PRIMARY KEY (VIDD) USING INDEX TABLESPACE BRSSMLI
, constraint FK_DPUVIDD_DPUTYPES   FOREIGN KEY (TYPE_ID) REFERENCES BARS.DPU_TYPES (TYPE_ID)
, constraint FK_DPUVIDD_DPTSTOP    FOREIGN KEY (ID_STOP) REFERENCES BARS.DPT_STOP (ID)
, constraint CC_DPUVIDD_COMPROC      check ( COMPROC in (0,1) )
, constraint CC_DPUVIDD_COMPROC_FREQ check ( COMPROC = decode(FREQ_V,5,COMPROC,0) )
, constraint CC_DPUVIDD_FLADD        check ( FL_ADD in (0,1) )
, constraint CC_DPUVIDD_FLAG         check ( FLAG in (0,1) )
, constraint CC_DPUVIDD_FLAUTOEXTEND check ( FL_AUTOEXTEND in (0,1) )
, constraint CC_DPUVIDD_FLEXTEND     check ( FL_EXTEND in (0,1,2) )
, constraint CC_DPUVIDD_IRVK         check ( IRVK in (0,1 ))
, constraint CC_DPUVIDD_TERMTYPE     check ( TERM_TYPE in (1,2) )
, constraint CC_DPUVIDD_TIPOST       check ( TIP_OST in (0,1) )
, constraint CC_DPUVIDD_TERMMIN      check ( TERM_MIN > 0 )
, constraint CC_DPUVIDD_SHABLON_EXST check ( FLAG = nvl2(SHABLON,FLAG,0) )
) tablespace BRSSMLD]';

  dbms_output.put_line( 'Table "DPU_VIDD" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "DPU_VIDD" already exists.' );
end;
/

begin
  bpa.alter_policies('DPU_VIDD');
end;
/

commit;

prompt -- ======================================================
prompt -- indexes
prompt -- ======================================================

begin
  execute immediate 'CREATE INDEX BARS.IDX_DPUVIDD_TYPEID_KV ON BARS.DPU_VIDD ( TYPE_ID, KV ) TABLESPACE BRSSMLI'; 
  dbms_output.put_line('index IDX_DPUVIDD_TYPEID_KV created.');
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then 
        dbms_output.put_line('Index IDX_DPUVIDD_TYPEID_KV already exists in the table.');
      when (sqlcode = -01408)
      then 
        dbms_output.put_line('Columns TYPE_ID and KV already indexed.');
      else 
        raise;
    end case;
end;
/

prompt -- ======================================================
prompt -- Constraints
prompt -- ======================================================

begin
  execute immediate q'[ALTER TABLE DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_BRATES FOREIGN KEY (BR_ID) REFERENCES BRATES (BR_ID)]';
  dbms_output.put_line('Constraint FK_DPUVIDD_BRATES created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table BARS.BRATES does not exist.');
      else dbms_output.put_line( SubStr(sqlerrm, instr(sqlerrm,'ORA-')+11) );
    end case;
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_DOCSCHEME FOREIGN KEY (SHABLON) REFERENCES BARS.DOC_SCHEME (ID)]';
  dbms_output.put_line('Constraint FK_DPUVIDD_DOCSCHEME created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table BARS.DOC_SCHEME does not exist.');
      else dbms_output.put_line( SubStr(sqlerrm, instr(sqlerrm,'ORA-')+11) );
    end case;
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_FREQ_FREQN FOREIGN KEY (FREQ_N) REFERENCES BARS.FREQ (FREQ)]';
  dbms_output.put_line('Constraint FK_DPUVIDD_FREQ_FREQN created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table BARS.FREQ does not exist.');
      else dbms_output.put_line( SubStr(sqlerrm, instr(sqlerrm,'ORA-')+11) );
    end case;
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_FREQ_FREQV FOREIGN KEY (FREQ_V) REFERENCES BARS.FREQ (FREQ)]';
  dbms_output.put_line('Constraint FK_DPUVIDD_FREQ_FREQV created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table BARS.FREQ does not exist.');
      else dbms_output.put_line( SubStr(sqlerrm, instr(sqlerrm,'ORA-')+11) );
    end case;
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_INTMETR FOREIGN KEY (METR) REFERENCES BARS.INT_METR (METR)]';
  dbms_output.put_line('Constraint FK_DPUVIDD_INTMETR created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table BARS.INT_METR does not exist.');
      else dbms_output.put_line( SubStr(sqlerrm, instr(sqlerrm,'ORA-')+11) );
    end case;
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_PS_BSD FOREIGN KEY (BSD) REFERENCES BARS.PS (NBS)]';
  dbms_output.put_line('Constraint FK_DPUVIDD_PS_BSD created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table BARS.PS does not exist.');
      else dbms_output.put_line( SubStr(sqlerrm, instr(sqlerrm,'ORA-')+11) );
    end case;
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_PS_BSN FOREIGN KEY (BSN) REFERENCES BARS.PS (NBS)]';
  dbms_output.put_line('Constraint FK_DPUVIDD_PS_BSN created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table BARS.PS does not exist.');
      else dbms_output.put_line( SubStr(sqlerrm, instr(sqlerrm,'ORA-')+11) );
    end case;
end;
/

begin
  execute immediate q'[ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_TABVAL FOREIGN KEY (KV) REFERENCES BARS.TABVAL$GLOBAL (KV)]';
  dbms_output.put_line('Constraint FK_DPUVIDD_TABVAL created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table BARS.TABVAL$GLOBAL does not exist.');
      else dbms_output.put_line( SubStr(sqlerrm, instr(sqlerrm,'ORA-')+11) );
    end case;
end;
/

begin
  execute immediate q'[ALTER TABLE DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_TTS FOREIGN KEY (TT) REFERENCES BARS.TTS (TT)]';
  dbms_output.put_line('Constraint FK_DPUVIDD_TTS created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table BARS.TTS does not exist.');
      else dbms_output.put_line( SubStr(sqlerrm, instr(sqlerrm,'ORA-')+11) );
    end case;
end;
/

begin
  execute immediate q'[alter table DPU_VIDD add constraint FK_DPUVIDD_DPTVIDDEXTYPES foreign key ( EXN_MTH_ID ) references DPT_VIDD_EXTYPES ( ID )]';
  dbms_output.put_line('Constraint FK_DPUVIDD_DPTVIDDEXTYPES created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table BARS.DPT_VIDD_EXTYPES does not exist.');
      else dbms_output.put_line( SubStr(sqlerrm, instr(sqlerrm,'ORA-')+11) );
    end case;
end;
/

prompt -- ======================================================
prompt -- comments
prompt -- ======================================================

SET FEEDBACK ON

COMMENT ON TABLE  DPU_VIDD               IS 'Виды вкладов для ЮЛ';

COMMENT ON COLUMN DPU_VIDD.VIDD          IS 'Вид вклада';
COMMENT ON COLUMN DPU_VIDD.NAME          IS 'Название вклада';
COMMENT ON COLUMN DPU_VIDD.KV            IS 'Код валюты';
COMMENT ON COLUMN DPU_VIDD.BSD           IS 'Бал.счет депозита';
COMMENT ON COLUMN DPU_VIDD.BSN           IS 'Бал.счет начисл.%%';
COMMENT ON COLUMN DPU_VIDD.BASEY         IS '###Код базы начисления %%';
COMMENT ON COLUMN DPU_VIDD.METR          IS 'Код метода начичления %%';
COMMENT ON COLUMN DPU_VIDD.BR_ID         IS 'Код базовой %% ставки';
COMMENT ON COLUMN DPU_VIDD.FREQ_N        IS 'Периодичность начисления %%';
COMMENT ON COLUMN DPU_VIDD.FREQ_V        IS 'Периодичность выплаты %% (Frequency of interest payment)';
COMMENT ON COLUMN DPU_VIDD.ACC7          IS '###Внутр.номер счета расходов';
COMMENT ON COLUMN DPU_VIDD.TT            IS 'Код операции по начислению %%';
COMMENT ON COLUMN DPU_VIDD.COMPROC       IS 'Флаг капитализации %% (Allowed compound interest)';
COMMENT ON COLUMN DPU_VIDD.ID_STOP       IS 'Код штрафа за досрочное расторжение договора';
COMMENT ON COLUMN DPU_VIDD.MIN_SUMM      IS 'Миним.сумма депозита';
COMMENT ON COLUMN DPU_VIDD.LIMIT         IS 'Миним.сумма пополнения депозита';
COMMENT ON COLUMN DPU_VIDD.PENYA         IS 'Пеня за несвоевременный возврат депозита';
COMMENT ON COLUMN DPU_VIDD.SHABLON       IS 'Шаблон договора';
COMMENT ON COLUMN DPU_VIDD.COMMENTS      IS 'Комментарий';
COMMENT ON COLUMN DPU_VIDD.FLAG          IS 'Флаг активности вида депозита';
COMMENT ON COLUMN DPU_VIDD.FL_ADD        IS 'Флаг пополнения депозита';
COMMENT ON COLUMN DPU_VIDD.FL_EXTEND     IS 'Флаг депозитной линии';
COMMENT ON COLUMN DPU_VIDD.TIP_OST       IS 'Тип начисления';
COMMENT ON COLUMN BARS.DPU_VIDD.DPU_TYPE IS 'Тип депозита: 0-до востреб, 1-краткоср., 2-долгоср.';
COMMENT ON COLUMN DPU_VIDD.FL_AUTOEXTEND IS 'Признак автомат.переоформления договора';
COMMENT ON COLUMN DPU_VIDD.DPU_CODE      IS 'Символьный код вида договора';
COMMENT ON COLUMN DPU_VIDD.MAX_SUMM      IS 'Макс.сумма депозита';
COMMENT ON COLUMN DPU_VIDD.TYPE_ID       IS 'Числ.код типа договора';
COMMENT ON COLUMN DPU_VIDD.TERM_TYPE     IS 'Тип терміну депозиту (1 - фікований, 2 - діапазон)';
COMMENT ON COLUMN DPU_VIDD.TERM_MIN      IS 'Мінімальний термін дії депозиту';
COMMENT ON COLUMN DPU_VIDD.TERM_MAX      IS 'Максимальний термін дії депозиту';
COMMENT ON COLUMN DPU_VIDD.TERM_ADD      IS 'Термін протягом якого дозволено поповнення депозиту';
COMMENT ON COLUMN DPU_VIDD.IRVK          IS '1 - Irrevocable (terminable) / 0 - Revocable (on demand)';
COMMENT ON COLUMN DPU_VIDD.EXN_MTH_ID    IS 'Ідентифікатор методу автопролонгації депозиту';

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
