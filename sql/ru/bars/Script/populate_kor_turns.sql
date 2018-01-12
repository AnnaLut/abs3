begin
    for k in (select kf from mv_kf)
    loop
        bc.subst_mfo(k.kf);

        bars.nbur_prepare_turns (k.kf, to_date('18122017','ddmmyyyy'));
        commit;
    end loop;
end;
/