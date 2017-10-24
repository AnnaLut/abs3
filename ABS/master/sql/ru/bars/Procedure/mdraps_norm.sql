

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MDRAPS_NORM.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MDRAPS_NORM ***

  CREATE OR REPLACE PROCEDURE BARS.MDRAPS_NORM (dat_ DATE) IS
-- Нормалізація вішалок на дату перехода
-- місячних драпсів
dat1_ DATE :=TRUNC(dat_,'MM');
BEGIN
for x IN (
select a.acc,a.nls,a.kv,b.fdat,b.ostq+b.dosq-b.kosq delta
  from agg_monbals b,accounts a
 where b.ostq<>b.kosq-b.dosq
and a.acc=b.acc
and a.tip IN ( 'VE0','VE1')
and b.fdat=dat1_
)
LOOP
IF x.delta<0 THEN
   UPDATE agg_monbals SET dosq=dosq-x.delta WHERE acc=x.acc AND fdat=x.fdat;
ELSE
   UPDATE agg_monbals SET kosq=kosq+x.delta WHERE acc=x.acc AND fdat=x.fdat;
END IF;
deb.trace(1,x.nls||x.kv,x.delta);
END LOOP;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MDRAPS_NORM.sql =========*** End *
PROMPT ===================================================================================== 
