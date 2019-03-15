PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/tbiu_curratekomupd.sql =========*** 
PROMPT ===================================================================================== 


CREATE OR REPLACE TRIGGER tbiu_curratekomupd
 BEFORE
  INSERT OR UPDATE
 ON cur_rates$base
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    l_comm          cur_rate_kom_upd.comments%TYPE;
    l_kol_com       NUMBER DEFAULT 0;
    l_kol_off       NUMBER DEFAULT 0;
    ---- настройка списка тобо тобо для занесения курсов в витрину
    l_branch_main   cur_rates$base.branch%TYPE DEFAULT '/300465/';
BEGIN
    IF INSERTING
    THEN
        --- не предполагается в одном действии изменения оф и ком курсов
        --- и установка новіх курсов в null
        IF :new.rate_o IS NOT NULL
        THEN
            l_comm := 'Добавлен курс НБУ';
            l_kol_off := l_kol_off + 1;
        end if;    
        
        IF (:new.rate_b IS NOT NULL OR :new.rate_s IS NOT NULL)
        THEN
            l_comm := 'Добавлен коммерческий курс ';
            l_kol_com := l_kol_com + 1;
        END IF;
    ELSE
        l_comm := 'Изменен курс ';

        IF :new.rate_b != NVL (:old.rate_b, 0)
        THEN
            l_comm := l_comm || 'покупки, ';
            l_kol_com := l_kol_com + 1;
        END IF;

        IF :new.rate_s != NVL (:old.rate_s, 0)
        THEN
            l_comm := l_comm || 'продажи, ';
            l_kol_com := l_kol_com + 1;
        END IF;

        IF :new.rate_o != NVL (:old.rate_o, 0)
        THEN
            l_comm := l_comm || 'официальный, ';
            l_kol_off := l_kol_off + 1;
        END IF;
    END IF;

    IF (l_kol_off > 0 OR l_kol_com > 0)
    THEN
        INSERT INTO cur_rate_kom_upd (kv,
                                      vdate,
                                      bsum,
                                      rate_b,
                                      rate_s,
                                      branch,
                                      isp,
                                      systime,
                                      recid,
                                      rate_o,
                                      comments)
        VALUES      (:new.kv,
                     :new.vdate,
                     :new.bsum,
                     :new.rate_b,
                     :new.rate_s,
                     :new.branch,
                     gl.auid,
                     SYSDATE,
                     s_curratekomupd.NEXTVAL,
                     :new.rate_o,
                     l_comm);

        ----------------- порождено COBUMMFO-9345
        -----заполняем витрину для ШД
        BEGIN
            INSERT ALL
            ----в любом случае офф курс загружаем только для /
            WHEN l_kol_off > 0 AND :new.branch = '/'
            THEN
                INTO   bars_intgr.cur_rate_official (arcdate,
                                                     kv,
                                                     kvcode,
                                                     kvname,
                                                     kvnominal,
                                                     rate)
                VALUES (:new.vdate,
                        cukv,
                        cunom,
                        cuname,
                        nominal,
                        :new.rate_o)
            ----? добавить возможность списка бранчей
            WHEN (    l_kol_com > 0
                  AND (:new.branch = l_branch_main OR l_branch_main IS NULL))
            THEN
                INTO   bars_intgr.cur_rate_commercial (arcdate,
                                                       branch,
                                                       kv,
                                                       kvcode,
                                                       kvname,
                                                       kvnominal,
                                                       rate_b,
                                                       rate_s)
                VALUES (:new.vdate,
                        :new.branch,
                        cukv,
                        cunom,
                        cuname,
                        nominal,
                        :new.rate_b,
                        :new.rate_s)
                SELECT cur.kv cukv, cur.lcv cunom, cur.name cuname,
                       cur.nominal
                FROM   tabval$global cur
                WHERE  kv = :new.kv;

            bars.bars_audit.info ('TBIU_CRRATEKOMUPD => OK ' || SQL%ROWCOUNT);
        EXCEPTION
            WHEN OTHERS
            THEN
                bars.bars_audit.error ('TBIU_CRRATEKOMUPD => ' || SQLERRM);
                raise;
        END;
    END IF;                              ---< (l_kol_off > 0 OR l_kol_com > 0)
END tbiu_curratekomupd;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/tbiu_curratekomupd.sql =========*** 
PROMPT ===================================================================================== 


