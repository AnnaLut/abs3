prompt reset object idupd - сбрасываем idupd на максимальный
begin
    for rec in (select kf from bars.mv_kf)
    loop
        bars_intgr.xrm_import.reset_object_idupd(p_object_name => 'CLIENTFO2', p_kf => rec.kf);
		bars_intgr.xrm_import.reset_object_idupd(p_object_name => 'CLIENT_ADDRESS', p_kf => rec.kf);
		bars_intgr.xrm_import.reset_object_idupd(p_object_name => 'ACCOUNTS', p_kf => rec.kf);
        bars_intgr.xrm_import.reset_object_idupd(p_object_name => 'BPK2', p_kf => rec.kf);
        bars_intgr.xrm_import.reset_object_idupd(p_object_name => 'DEPOSITS2', p_kf => rec.kf);
        bars_intgr.xrm_import.reset_object_idupd(p_object_name => 'ACCOUNTS_CASH', p_kf => rec.kf);
    end loop;
	commit;
end;
/