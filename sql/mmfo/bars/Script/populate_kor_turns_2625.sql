begin
    for k in (select kf from mv_kf)
    loop
        bc.subst_mfo(k.kf);
		
		ddraps(bankdate, 1);
		commit;

        bars.nbur_prepare_turns_2625 (k.kf, bankdate);
        commit;
    end loop;
end;
/