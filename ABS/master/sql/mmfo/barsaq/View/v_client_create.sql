CREATE OR REPLACE FORCE VIEW BARSAQ.V_CLIENT_CREATE
(
   RNK,
   NAME,
   CUST_CODE,
   BANK_ID,
   CREATE_DATE
)
AS
   SELECT    cc.RNK
          || (SELECT r.ru
                FROM bars.mv_kf m, bars.kf_ru r
               WHERE r.kf = m.kf AND cc.bank_id = m.kf)
             AS rnk,
          cc.NAME,
          cc.CUST_CODE,
          cc.BANK_ID,
          cc.CREATE_DATE
     FROM bank.v_create_client@ibank.ua cc;

comment on table BARSAQ.V_CLIENT_CREATE is 'Дати реєстрації клієнтів ЮО у CORP2';
comment on column BARSAQ.V_CLIENT_CREATE.RNK is 'РНК клієнта';
comment on column BARSAQ.V_CLIENT_CREATE.NAME is 'Назва клієнта';
comment on column BARSAQ.V_CLIENT_CREATE.CUST_CODE is 'ОКПО клієнта';
comment on column BARSAQ.V_CLIENT_CREATE.BANK_ID is 'МФО клієнта';
comment on column BARSAQ.V_CLIENT_CREATE.CREATE_DATE is 'Дата реєстрації клієнта';

GRANT SELECT ON BARSAQ.V_CLIENT_CREATE TO BARS;
