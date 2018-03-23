begin
  bpa.alter_policy_info('LOCPAY_FEE_LOG', 'FILIAL', 'M', 'M', 'M', 'M');
  bpa.alter_policy_info('LOCPAY_FEE_LOG', 'WHOLE',  null, null, null, null);
  commit;
exception when others then null;   
end;
/



begin
execute immediate '
CREATE TABLE BARS.LOCPAY_FEE_LOG
(
  REF     NUMBER(38),
  S       NUMBER(24),
  NLSTR   VARCHAR2(15 BYTE),
  dat    DATE,
  kf     varchar2(6) default sys_context(''bars_context'',''user_mfo''),
  constraint pk_LOCPAYFEELOG primary key (REF)
) tablespace brsmdld';
exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/

exec bpa.alter_policies('LOCPAY_FEE_LOG');


grant select, insert, delete on LOCPAY_FEE_LOG to BARS_ACCESS_DEFROLE;