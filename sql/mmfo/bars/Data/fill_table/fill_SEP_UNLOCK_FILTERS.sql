prompt Importing table SEP_UNLOCK_FILTERS...

delete from sep_unlock_filters;

begin
insert into sep_unlock_filters (IDFILTER, NAMEFILTER, SQLFILTER, COMM)
values (1, '������� 1', 'SELECT  v.rec,v.s FROM V_RECQUE_ARCRRP_DATA v where v.dat_a > sysdate - 360 and v.blk=%p_blk% and v.s %p_moreless% %p_sum%', 'P����������� �� ���������� �� ��������� ���� ���������� ������, ���� ���� � ������ �� ������� ����');
exception when dup_val_on_index then null;
end;
/
begin
insert into sep_unlock_filters (IDFILTER, NAMEFILTER, SQLFILTER, COMM)
values (2, '������� 2', 'SELECT  v.rec,v.s FROM V_RECQUE_ARCRRP_DATA v where v.dat_a > sysdate - 360 and v.blk=%p_blk% and (mfob like ''8%'' or nlsb like ''25%'')', 'P����������� �� ���������� �� ��������� ���� ���������� ������, �� � ����������');
exception when dup_val_on_index then null;
end;
/
begin
insert into sep_unlock_filters (IDFILTER, NAMEFILTER, SQLFILTER, COMM)
values (3, '������� 3', 'SELECT  v.rec,v.s FROM V_RECQUE_ARCRRP_DATA v where v.dat_a > sysdate - 360 and v.blk=%p_blk% and mfob=''%p_mfob%''', 'P����������� �� ���������� �� ��������� ���� ���������� ������, ��� ���� ��� ���������� ���� ������� � �������� ���');
exception when dup_val_on_index then null;
end;
/
begin
insert into sep_unlock_filters (IDFILTER, NAMEFILTER, SQLFILTER, COMM)
values (4, '������� 4', 'SELECT  v.rec,v.s FROM V_RECQUE_ARCRRP_DATA v where v.dat_a > sysdate - 360 and v.blk=%p_blk%', 'P����������� �� ���������� �� ��������� ���� ���������� ������');
exception when dup_val_on_index then null;
end;
/
prompt Done.
/