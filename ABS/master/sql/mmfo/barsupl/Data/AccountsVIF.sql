prompt Особливо важливі файли - Аналітичні рахунки - версія 1.1
declare
l_clob clob := q'[
select 
       kf,
       rnk,
       kv,
       nls,
       case when case when TO_DATE(:param1, 'dd/mm/yyyy') >= dapp then ostc else bars.fost(acc, TO_DATE(:param1, 'dd/mm/yyyy')) end >=0 then 1 else 2 end ozn_zal,
       abs(case when TO_DATE(:param1, 'dd/mm/yyyy') >= dapp then ostc else bars.fost(acc,TO_DATE(:param1, 'dd/mm/yyyy')) end) ostc,
       daos,
       dapp,
       dazs,
       nms
   from bars.accounts
]';
begin
    update upl_sql
    set sql_text = l_clob,
        vers = '1.1'
    where sql_id = 95;
    commit;
end;
/