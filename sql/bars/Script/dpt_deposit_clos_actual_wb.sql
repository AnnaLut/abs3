prompt Script\dpt_deposit_clos_actual_wb.sql
prompt Актуализируем поле wb в dpt_deposit_clos в соответствии с текущим значением в dpt_deposit или первой записью в clos

begin bars.tuda; end;
/
update dpt_deposit_clos dc
set wb = coalesce((select wb from dpt_deposit d where d.deposit_id = dc.deposit_id),
                    (select wb from
                    (SELECT deposit_id, wb
                                       FROM (SELECT cw.*,
                                                    ROW_NUMBER ()
                                                       OVER (PARTITION BY deposit_id ORDER BY idupd ASC)
                                                       rn
                                               FROM dpt_deposit_clos cw)
                                      WHERE rn = 1) T
                    where T.deposit_id = dc.deposit_id), dc.wb
);
/
commit;
/

begin bars.suda; end;
/