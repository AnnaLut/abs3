exec bc.home;

begin
  bpa.alter_policy_info('CUST_PTKC', 'FILIAL' , 'M', 'M', 'M', 'M');
  bpa.alter_policy_info('CUST_PTKC', 'WHOLE',  null, null, null, null);
  commit;
exception when others then null;   
end;
/

begin
    execute immediate 'DROP TABLE BARS.CUST_PTKC CASCADE CONSTRAINTS';
exception
    when others then null;
end;
/    

Prompt Table CUST_PTKC;
begin
  execute immediate 
    'create table BARS.CUST_PTKC
(
  RNK     NUMBER,
  OKPO    VARCHAR2(10 BYTE),
  NMK     VARCHAR2(70 BYTE),
  COMM    VARCHAR2(100 BYTE),
  KF      VARCHAR2(6)      DEFAULT sys_context(''bars_context'',''user_mfo'')
)';
exception 
  when others then
    if (sqlcode = -955) then null;
    else raise;
    end if;
end;
/


COMMENT ON TABLE BARS.CUST_PTKC IS 'Перелік клієнтів з якими існують договора на обслуговування ПТКС';

COMMENT ON COLUMN BARS.CUST_PTKC.RNK IS 'РНК контрагента';

COMMENT ON COLUMN BARS.CUST_PTKC.OKPO IS 'ІНН код';

COMMENT ON COLUMN BARS.CUST_PTKC.NMK IS 'Найменування контрагента';

COMMENT ON COLUMN BARS.CUST_PTKC.COMM IS 'Коментар';


begin
    execute immediate 'DROP PUBLIC SYNONYM CUST_PTKC';
exception
    when others then null;
end;
/    

create public synonym CUST_PTKC for bars.CUST_PTKC;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.CUST_PTKC TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.CUST_PTKC TO RPBN002;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.CUST_PTKC TO WR_ALL_RIGHTS;

GRANT SELECT, FLASHBACK ON BARS.CUST_PTKC TO WR_REFREAD;

BEGIN
   bpa.alter_policies('CUST_PTKC');
END;
/
         
exec bc.home;
 
