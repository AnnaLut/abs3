

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/STO_SHCEDULES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure STO_SHCEDULES ***

  CREATE OR REPLACE PROCEDURE BARS.STO_SHCEDULES IS
  BEGIN
    bars_audit.info('BARS.STO_SHCEDULES start');
    for rec in (select kf from mv_kf)
      loop
        bc.go(rec.kf);
        FOR k IN (SELECT sd.idd p_stoid,
                         tt,
                         TRUNC(SYSDATE) p_stodat0,
                         sd.dat1 p_stodat1,
                         sd.dat2 p_stodat2,
                         2 p_stofreq,
                         -1 p_stowend,
                         status_date
                    FROM sto_det sd, sto_lst sl
                   WHERE sl.idg = 12
                     AND sd.ids = sl.ids) LOOP
          sto_all.generate_stoschedules_reg(k.p_stoid,
                                            k.p_stodat0,
                                            k.p_stodat1,
                                            k.p_stodat2,
                                            k.p_stofreq,
                                            k.p_stowend,
                                            k.tt,
                                            k.status_date);
        END LOOP;
      end loop;
      bars_audit.info('BARS.STO_SHCEDULES end');
  END sto_shcedules;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/STO_SHCEDULES.sql =========*** End
PROMPT ===================================================================================== 
