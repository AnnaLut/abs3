begin
    for k in (select kf from mv_kf)
    loop
        bc.subst_mfo(k.kf);
        
        ddraps(dat_next_u(bankdate, -1));
        commit;

        bars.nbur_prepare_turns (k.kf, dat_next_u(bankdate, -1));
        commit;
    end loop;
end;
/

