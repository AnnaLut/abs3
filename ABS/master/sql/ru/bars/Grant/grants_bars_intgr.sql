prompt bars/Grant/grants_bars_intgr.sql
prompt ������ ��������� ���������� bars ������������ bars_intgr
prompt ������� �� ����, ��� select any table with admin option ��� ����

grant execute on bars.fio to bars_intgr with grant option;
grant execute on bars.f_ourmfo_g to bars_intgr with grant option;
grant execute on bars.getbrat to bars_intgr with grant option;
grant execute on bars.bars_audit to bars_intgr;
grant execute on bars.bars_login to bars_intgr;
grant execute on bars.bars_context to bars_intgr;
grant execute on bars.number_list to bars_intgr;
grant execute on bars.varchar2_list to bars_intgr;
grant execute on bars.acrn to bars_intgr;
grant execute on bars.gl to bars_intgr;
grant execute on bars.xrm_dyn_dict to bars_intgr with grant option;