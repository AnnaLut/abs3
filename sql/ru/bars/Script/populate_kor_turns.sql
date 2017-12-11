begin
    for k in (select kf from mv_kf)
    loop
        bc.subst_mfo(k.kf);
		
		ddraps(bankdate);
		commit;

        bars.nbur_prepare_turns (k.kf, bankdate);
        commit;
    end loop;
end;
/