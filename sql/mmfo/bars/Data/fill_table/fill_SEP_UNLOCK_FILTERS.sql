prompt Importing table SEP_UNLOCK_FILTERS...

delete from sep_unlock_filters;

begin
insert into sep_unlock_filters (IDFILTER, NAMEFILTER, SQLFILTER, COMM)
values (1, 'Функція 1', 'SELECT  v.rec,v.s FROM V_RECQUE_ARCRRP_DATA v where v.dat_a > sysdate - 360 and v.blk=%p_blk% and v.s %p_moreless% %p_sum%', 'Pозблокувати всі заблоковані по вибраному коду блокування платежі, сума яких є більшою за вказану суму');
exception when dup_val_on_index then null;
end;
/
begin
insert into sep_unlock_filters (IDFILTER, NAMEFILTER, SQLFILTER, COMM)
values (2, 'Функція 2', 'SELECT  v.rec,v.s FROM V_RECQUE_ARCRRP_DATA v where v.dat_a > sysdate - 360 and v.blk=%p_blk% and (mfob like ''8%'' or nlsb like ''25%'')', 'Pозблокувати всі заблоковані по вибраному коду блокування платежі, які є бюджетними');
exception when dup_val_on_index then null;
end;
/
begin
insert into sep_unlock_filters (IDFILTER, NAMEFILTER, SQLFILTER, COMM)
values (3, 'Функція 3', 'SELECT  v.rec,v.s FROM V_RECQUE_ARCRRP_DATA v where v.dat_a > sysdate - 360 and v.blk=%p_blk% and mfob=''%p_mfob%''', 'Pозблокувати всі заблоковані по вибраному коду блокування платежі, для яких МФО отримувача яких співпадає з вказаним МФО');
exception when dup_val_on_index then null;
end;
/
begin
insert into sep_unlock_filters (IDFILTER, NAMEFILTER, SQLFILTER, COMM)
values (4, 'Функція 4', 'SELECT  v.rec,v.s FROM V_RECQUE_ARCRRP_DATA v where v.dat_a > sysdate - 360 and v.blk=%p_blk%', 'Pозблокувати всі заблоковані по вибраному коду блокування платежі');
exception when dup_val_on_index then null;
end;
/
prompt Done.
/