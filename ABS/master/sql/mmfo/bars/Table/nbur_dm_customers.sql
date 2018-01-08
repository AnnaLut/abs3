-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 12.09.2016 (17.05.2016)
-- ======================================================================================
-- create table NBUR_DM_CUSTOMERS
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        100
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table NBUR_DM_CUSTOMERS
prompt -- ======================================================

begin
  bars.bpa.alter_policy_info( 'NBUR_DM_CUSTOMERS', 'WHOLE', Null, Null, Null, Null );
end;
/

begin
  EXECUTE IMMEDIATE 'drop table BARS.NBUR_DM_CUSTOMERS PURGE';
  dbms_output.put_line('Table dropped.');
exception
  when OTHERS then
    if ( sqlcode = -00942 )
    then dbms_output.put_line( 'Table "NBUR_DM_CUSTOMERS" does not exist.' );
    else raise;
    end if;
end;
/

begin
  execute immediate q'[CREATE TABLE BARS.NBUR_DM_CUSTOMERS
( REPORT_DATE     DATE         CONSTRAINT CC_DMCUSTOMERS_REPORTDT_NN NOT NULL
, KF              VARCHAR2(6)  CONSTRAINT CC_DMCUSTOMERS_KF_NN       NOT NULL
, CUST_ID         NUMBER(38)   CONSTRAINT CC_DMCUSTOMERS_CUSTID_NN   NOT NULL
, CUST_TYPE       NUMBER(1)    CONSTRAINT CC_DMCUSTOMERS_CUSTTP_NN   NOT NULL
, CUST_CODE       VARCHAR2(14)
, CUST_NAME       VARCHAR2(38)
, CUST_ADR        VARCHAR2(70)
, OPEN_DATE       DATE         CONSTRAINT CC_DMCUSTOMERS_OPENDT_NN   NOT NULL
, CLOSE_DATE      DATE         
, BRANCH          VARCHAR2(30) CONSTRAINT CC_DMCUSTOMERS_BRANCH_NN   NOT NULL
, TAX_REG_ID      NUMBER(2)    
, TAX_DST_ID      NUMBER(2)    
, CRISK           CHAR(2)      
, CUST_PID        NUMBER(38)
, BC              NUMBER(1)
, K030            CHAR(1)      
, K040            CHAR(3)      CONSTRAINT CC_DMCUSTOMERS_K040_NN      NOT NULL
, K041            CHAR(1)
, K050            CHAR(3)
, K051            CHAR(2)
, K060            CHAR(2)
, K070            CHAR(5)
, K072            CHAR(2)
, K073            CHAR(1)
, K074            CHAR(1)
, K080            CHAR(2)
, K081            CHAR(1)
, K090            CHAR(5)
, K110            CHAR(5)
, K111            CHAR(2)
, K112            CHAR(1)
) TABLESPACE BRSBIGD
COMPRESS BASIC
NOLOGGING
STORAGE( INITIAL 128K NEXT 128K )
PCTUSED   0
PCTFREE   0
PARTITION BY LIST (KF)
( PARTITION P_300465 VALUES ('300465')
, PARTITION P_302076 VALUES ('302076')
, PARTITION P_303398 VALUES ('303398')
, PARTITION P_304665 VALUES ('304665')
, PARTITION P_305482 VALUES ('305482')
, PARTITION P_311647 VALUES ('311647')
, PARTITION P_312356 VALUES ('312356')
, PARTITION P_313957 VALUES ('313957')
, PARTITION P_315784 VALUES ('315784')
, PARTITION P_322669 VALUES ('322669')
, PARTITION P_323475 VALUES ('323475')
, PARTITION P_324805 VALUES ('324805')
, PARTITION P_325796 VALUES ('325796')
, PARTITION P_326461 VALUES ('326461')
, PARTITION P_328845 VALUES ('328845')
, PARTITION P_331467 VALUES ('331467')
, PARTITION P_333368 VALUES ('333368')
, PARTITION P_335106 VALUES ('335106')
, PARTITION P_336503 VALUES ('336503')
, PARTITION P_337568 VALUES ('337568')
, PARTITION P_338545 VALUES ('338545')
, PARTITION P_351823 VALUES ('351823')
, PARTITION P_352457 VALUES ('352457')
, PARTITION P_353553 VALUES ('353553')
, PARTITION P_354507 VALUES ('354507')
, PARTITION P_356334 VALUES ('356334') ) ]';
  
  dbms_output.put_line('Table "NBUR_DM_CUSTOMERS" created.');
  
exception
  when OTHERS then
    if ( sqlcode = -00955 )
    then dbms_output.put_line( 'Table "NBUR_DM_CUSTOMERS" already exists.' );
    else raise;
    end if;  
end;
/

prompt -- ======================================================
prompt -- Create index
prompt -- ======================================================

begin
  execute immediate q'[CREATE UNIQUE INDEX BARS.UK_DMCUSTOMERS ON BARS.NBUR_DM_CUSTOMERS ( KF, CUST_ID )
  TABLESPACE BRSBIGI
  PCTFREE 0
  LOCAL
  COMPRESS 1 ]';
  dbms_output.put_line( 'Index "BARS.UK_DMCUSTOMERS" created.' );
exception
  when OTHERS then 
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index "UK_DMCUSTOMERS" already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "KF", "CUST_ID" already indexed.');
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- table comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.NBUR_DM_CUSTOMERS             IS 'Клієнти АБС з параметрами';

COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.KF          IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.CUST_ID     IS 'Iдентифiкатор контрагента';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.CUST_TYPE   IS 'Тип клієнта (БАНК/ЮО/ФО)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.CUST_CODE   IS 'Код клієнта';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.CUST_NAME   IS 'Назва клієнта';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.CUST_ADR    IS 'Адреса клієнта';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.BRANCH      IS 'Код вiддiлення';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.CRISK       IS 'Категорія ризику';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.OPEN_DATE   IS 'Дата реєстрації клієнта в АБС';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.CLOSE_DATE  IS 'Дата закриття клієнта';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.TAX_REG_ID  IS 'Ід. регіональної податкової інспекції';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.TAX_DST_ID  IS 'Ід. районної податкової інспекції';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.CUST_PID    IS 'РНК вищестоячого клієнта (RNKP)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.BC          IS 'Ознака кліента/некліента банку';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K030        IS 'Резидентність (CODCAGENT)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K040        IS 'Код країни (COUNTRY)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K041        IS 'Група країн';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K050        IS 'Організаційно-правова форма господарювання';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K051        IS 'Коди організаційно-правових форм господарювання (SED)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K060        IS 'Код інсайдера (PRINSIDER)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K070        IS 'Інституційний сектор економіки (ISE)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K072        IS 'Сектор економіки';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K073        IS 'Сектор економіки 1-го рівня';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K074        IS 'Узагальнений сектор економіки (державний - недержавний) ';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K080        IS 'Форма власності (FS)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K081        IS 'Форма власності 1-го рівня';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K090        IS 'Галузь економiки (OE)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K110        IS 'Вид економічної діяльності (VED)';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K111        IS 'Розділ виду економічної діяльності';
COMMENT ON COLUMN BARS.NBUR_DM_CUSTOMERS.K112        IS 'Сектор виду економічної діяльності';

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================