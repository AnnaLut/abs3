begin
  bpa.alter_policy_info('FINMON_PEP_CUSTOMERS', 'WHOLE', null, null, null, null); 
  bpa.alter_policy_info('FINMON_PEP_CUSTOMERS', 'FILIAL', null, null, null, null);
end;
/
    /*
    «RNK клієнта», 
    «ПІБ/Назва клієнта», 
    «№ в переліку», 
    «Дозвіл» (див. п.4), 
    «Рівень ризику», 
    «Критерії ризику» (показувати встановлення критеріїв ризику з кодами (Id) 2, 3, 62-65), 
    «Дата перевірки», 
    «RNK пов’язаної особи», 
    «ПІБ/Назва пов’язаної особи», 
    «№ в переліку (пов’язаної особи)», 
    «Коментар» (приймає значення «клієнт» або «пов’язана» залежно від збігу). 
    */
begin 
execute immediate 'CREATE TABLE BARS.FINMON_PEP_CUSTOMERS
                    ( ID            number,            
                      RNK           number,
                      NMK           varchar2(150),
                      PERMIT        number(1),
                      CRISK         VARCHAR2(50),
                      CUST_RISK     VARCHAR2(50),
                      CHECK_DATE    DATE DEFAULT TRUNC(SYSDATE),
                      RNK_REEL      number,
                      NMK_REEL      varchar2(150),
                      NUM_REEL      int,
                      COMMENTS      varchar2(200)) TABLESPACE BRSBIGD';
exception when others then if (sqlcode = -955) then null; else raise; end if; 
end;
/

COMMENT ON TABLE FINMON_PEP_CUSTOMERS IS 'ФМ. Збіг ПЕП КЛІЄНТИ';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.ID         IS 'Унікальний код';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.RNK        IS 'Реєстраційний номер клієнта в БД';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.NMK        IS 'Найменування клієнта в БД';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.PERMIT     IS 'Найменування клієнта в БД';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.CRISK      IS 'Категорія ризику клієнта на дату перевірки';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.CUST_RISK  IS 'Критерії ризику клієнта на дату перевірки';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.CHECK_DATE IS 'Дата перевірки';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.RNK_REEL   IS 'RNK пов''язаної особи';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.NMK_REEL   IS 'ПІБ/Назва пов''язаної особи';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.NUM_REEL   IS '№ пов''яз. особи в (пов’язаної особи)';
COMMENT ON COLUMN FINMON_PEP_CUSTOMERS.COMMENTS   IS 'Коментар';

/
GRANT SELECT,INSERT,UPDATE,DELETE ON FINMON_PEP_CUSTOMERS TO BARS_ACCESS_DEFROLE;
/  

