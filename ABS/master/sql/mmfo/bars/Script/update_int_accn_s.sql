begin
    for i in (select t.kf from mv_kf t) loop
        bars_context.go(i.kf);

        update int_accn t
        set    t.s = 0
        where  (t.acc, t.id) in (select dd.accs, vd.tipd - 1
                                 from   cc_add dd
                                 join   cc_deal d on dd.nd = d.nd and dd.adds = 0
                                 join   cc_vidd vd on vd.vidd = d.vidd
                                 where  (mbk.check_if_deal_belong_to_mbdk(d.vidd) = 'Y' or
                                         mbk.check_if_deal_belong_to_crsour(d.vidd) = 'Y') and
                                        d.sos <> 15);
    end loop;

    commit;

    bars_context.home();
end;
/
