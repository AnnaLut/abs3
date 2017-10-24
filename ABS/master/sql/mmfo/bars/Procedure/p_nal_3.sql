

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NAL_3.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NAL_3 ***

  CREATE OR REPLACE PROCEDURE BARS.P_NAL_3 (p_dat1 date,  p_dat2 date ) is
l_kk1 int;  -- для протокола
l_kk2 int;
/* процедура отбора данных для отчета
   Оборотна в_дом_сть по рахунках ПО - ОБ22 ( без коригуючих)
   \BRS\SBM\NAL\3,  B003PO96.QRP
   10-04-2013  qwa

*/

  MODCODE   constant varchar2(3) := 'NAL';

begin

execute immediate ('truncate table tmp_sal');
--execute immediate ('truncate table test_tmp_sal');  -- тестирование
execute immediate ('truncate table tmp_ob22nu');
--execute immediate ('truncate table ref_kor');

-- отбор  счетов 8 класса  для сальдовки (которые связаны с НУ или ведутся вручную)

for n in (select  distinct ACCN, NLS,NLSN, NMSN, NBSN,  NOB22,NP080
            from  v_ob22nu_n
          union all
          select  distinct ACCN, ' ',NLSN, NMSN, NBSN,  NOB22,NP080
           from   v_ob22nu80   )
loop
  begin
       insert into tmp_ob22nu ( ACCN, NLS,NLSN, NMSN, NBSN,  NOB22,NP080)
         values  (n.ACCN, n.nls,n.NLSN, n.NMSN, n.NBSN,      n.NOB22,n.NP080);

       exception when dup_val_on_index then
       bars_error.raise_nerror(MODCODE, 'NAL_DUPACCN',n.nls,n.nlsn,n.np080);
  end;
end loop;

--select count(*) into l_kk1 from tmp_ob22nu ;
--bars_audit.info('p_nal_3_1 = '||l_kk1);

commit;

--  обороты за период без учета корректирующих
-- (096  пойдут  другой банковской датой)
-- в отчете сложим за счет шаблона для показа всех оборотов

insert into tmp_sal
            (kv,  nbs,         nls,
             nms,
             dosq,ostqd, kosq,ostqk,ob22)
select   distinct 980 kv, nbsn  nbs,   nlsn nls,
         substr(NMSN,1,30) NMS,
         nvl(FDOS(ACCN,p_dat1,p_dat2) ,0)   DOS,
         0 dos96,
         nvl(FKOS(ACCN,p_dat1,p_dat2) ,0)    KOS,
         0 kos96,
         nob22
from     tmp_ob22nu;

--select count(*) into l_kk2 from tmp_sal ;
--bars_audit.info('p_nal_3_2 = '||l_kk2);

-- все корректирующие нашего периода по счетам

 for k in (
 select fdat, dk, a.nls,a.kv,
       decode(dk,0,sum(s),0) dos96  ,
       decode(dk,0,a.nls, 0) nlsd,
       decode(dk,1,sum(s),0) kos96,
       decode(dk,1,a.nls, 0) nlsk
   from opldok p,
        (select * from accounts  where kv=980 and substr(nls,1,1)='8')a
  where p.tt='PO3'
   and  p.acc=a.acc
   and exists
    (select 1
     from oper
     where ref=p.ref
       and vob=96
       and sos>=4
       and pdat between trunc(p_dat1,'Q') and p_dat2
       and datp between p_dat1 and p_dat2
       and vdat=p.fdat)
       group by fdat,dk,nls,kv,p.acc
       )
 loop
  update  tmp_sal
     set  ostqd=k.dos96
   where  nls=k.nlsd;
   update  tmp_sal
     set  ostqk=k.kos96
   where   nls= k.nlsk;
 end loop;

commit;

--select count(*) into l_kk2 from tmp_sal ;
--bars_audit.info('p_nal_3_3 = '||l_kk2);

end  P_NAL_3;
/
show err;

PROMPT *** Create  grants  P_NAL_3 ***
grant EXECUTE                                                                on P_NAL_3         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_NAL_3         to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NAL_3.sql =========*** End *** =
PROMPT ===================================================================================== 
