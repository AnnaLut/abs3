CREATE OR REPLACE TRIGGER taiu_diler_kurs
 AFTER
  INSERT OR UPDATE
 ON diler_kurs
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    l_comm          cur_rate_kom_upd.comments%TYPE;
    l_kol_com       NUMBER DEFAULT 0;
    l_kol_off       NUMBER DEFAULT 0;
BEGIN
    ----------------- порождено COBUMMFO-9345
    -----заполняем витрину для ШД. безовсяких условий

    INSERT INTO bars_intgr.cur_rate_dealer (arcdate,
                                            kv,
                                            kvcode,
                                            kvname,
                                            kvnominal,
                                            rate_b,
                                            rate_s)
        SELECT :new.dat, cur.kv, cur.lcv, cur.name , 1, --- cur.nominal, требование заказчика
               :new.kurs_b, :new.kurs_s
        FROM   tabval$global cur
        WHERE  kv = :new.kv;
EXCEPTION
    WHEN OTHERS
    THEN
        bars.bars_audit.error ('taiu_diler_kurs  => ' || SQLERRM);
        raise;
END  ;
/

