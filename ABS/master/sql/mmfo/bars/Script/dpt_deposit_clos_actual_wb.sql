prompt Script\dpt_deposit_clos_actual_wb.sql
prompt ������������� ���� wb � dpt_deposit_clos � ������������ � ������� ��������� � dpt_deposit ��� ������ ������� � clos

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