CREATE OR REPLACE FORCE VIEW BARS.V_T00_STATS AS
     SELECT rn  RNX,
            DECODE (rn, 1, report_date, NULL) report_date,
            DECODE (rn, 1, kf, NULL) report_kf,
            DECODE (rn, 1, acc, NULL) acc,
            DECODE (rn, 1, nls, NULL) nls,
            DECODE (rn, 1, ostf, NULL) ostf,
            DECODE (rn, 1, dos, NULL) dos,
            DECODE (rn, 1, kos, NULL) kos,
            desc_in,
            s_in,
            id_db,
            desc_db,
            s_db,
            id_kr,
            desc_kr,
            s_kr
       FROM (
       select ROW_NUMBER () OVER ( PARTITION BY NVL (t.report_date, t_in.fdat), NVL (t.kf, t_in.kf), NVL (t.acc, t_in.acc) ORDER BY NVL (t.n, t_in.n)) rn,                   
              t.kf     ,
              t.report_date,
              t.acc,
              t.nls,
              t.ostf,
              t.dos,
              t.kos,
              t.id_db,
              t.desc_db,
              t.s_db,
              t.id_kr,
              t.desc_kr,
              t.s_kr,
              t_in.n,
              t_in.stat_id_desc desc_in,
              t_in.amount s_in              
       from (WITH t_db AS (SELECT ROW_NUMBER () OVER (PARTITION BY kf, stat_type ORDER BY stat_type_id) n, t.* FROM v_t00_stats_plain t WHERE stat_type = 'DB'),
                  t_kr AS (SELECT ROW_NUMBER () OVER (PARTITION BY kf, stat_type ORDER BY stat_type_id) n, t.* FROM v_t00_stats_plain t WHERE stat_type = 'KR')
                  --t_in AS (SELECT ROW_NUMBER () OVER (PARTITION BY kf            ORDER BY stat_id_desc) n, t.* FROM v_t00_stats_plain t WHERE stat_type LIKE 'OST_%')
             SELECT /*ROW_NUMBER () OVER ( PARTITION BY NVL (t_db.fdat, t_in.fdat), NVL (t_db.kf, t_in.kf), NVL (t_db.acc, t_in.acc) ORDER BY NVL (t_db.n, t_in.n)) rn,
                    NVL (t_db.fdat, t_in.fdat) fdat,
                    NVL (t_db.kf, t_in.kf) kf,
                    NVL (t_db.acc, t_in.acc) acc,
                    NVL (t_db.nls, t_in.nls) nls,
                    NVL (t_db.ostf, t_in.ostf) ostf,
                    NVL (t_db.dos, t_in.dos) dos,
                    NVL (t_db.kos, t_in.kos) kos,
                    t_in.n,
                    t_in.stat_id_desc desc_in,
                    t_in.amount s_in,
                    */
                    nvl(t_db.n ,t_kr.n)  n,
                    nvl(t_db.kf,t_kr.kf) kf,
                    nvl(t_db.acc, t_kr.acc) acc,
                    nvl(t_db.nls, t_kr.nls) nls,
                    nvl(t_db.ostf, t_kr.ostf) ostf,
                    nvl(t_db.dos, t_kr.dos) dos,
                    nvl(t_db.kos, t_kr.kos) kos,
                    t_db.report_date  report_date,
                    t_db.id id_db,
                    t_db.stat_id_desc desc_db,
                    t_db.amount s_db,
                    t_kr.id id_kr,
                    t_kr.stat_id_desc desc_kr,
                    t_kr.amount s_kr
               FROM t_db
                    FULL OUTER JOIN t_kr
                       ON t_db.n = t_kr.n AND t_db.kf = t_kr.kf
             ) t          
          FULL OUTER JOIN (SELECT ROW_NUMBER () OVER (PARTITION BY kf            ORDER BY stat_id_desc) n, t.* FROM v_t00_stats_plain t WHERE stat_type LIKE 'OST_%') t_in
                ON t.n = t_in.n AND t.kf = t_in.kf
                       )
   ORDER BY kf, rn;


GRANT SELECT ON BARS.V_T00_STATS TO BARS_ACCESS_DEFROLE;


comment on table  V_T00_STATS is 'Статистика по составляющим остатка и оборотов транзитов РУ';

comment on column V_T00_STATS.RNX          is 'Последовательный №'; 
comment on column V_T00_STATS.report_date  is 'Отчетная банковская дата'; 
comment on column V_T00_STATS.report_kf    is 'МФО'; 
comment on column V_T00_STATS.acc          is 'асс счета'; 
comment on column V_T00_STATS.nls          is 'Лицевой счет'; 
comment on column V_T00_STATS.ostf         is 'Входящий остаток';
comment on column V_T00_STATS.dos          is 'Обороты дб.';
comment on column V_T00_STATS.kos          is 'Обороты кр.';
comment on column V_T00_STATS.desc_in      is 'Наименование статистики по входящему остатку';
comment on column V_T00_STATS.s_in         is 'Сумма по статистике входящего остатка';
comment on column V_T00_STATS.id_db        is 'ид. в таблице статистик для деб. оборотов (t00_stats.id)';
comment on column V_T00_STATS.desc_db      is 'Описание статистики по дб. оборотам';
comment on column V_T00_STATS.s_db         is 'Сумма по статистике деб. оборотов';
comment on column V_T00_STATS.id_kr        is 'ид. в таблице статистик для кр. оборотов (t00_stats.id)';
comment on column V_T00_STATS.desc_kr      is 'Описание статистики по кр. оборотам';
comment on column V_T00_STATS.s_kr         is 'Сумма по статистике кр. оборотов';
