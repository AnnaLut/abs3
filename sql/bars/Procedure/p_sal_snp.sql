

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SAL_SNP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SAL_SNP ***

  CREATE OR REPLACE PROCEDURE BARS.P_SAL_SNP 
  ( mode_   int ,
    p_dat1  date,
    p_dat2  date,
    branch_ varchar2,  -- p_p3
    p_p0    varchar2 default null,  -- Б_Р "з"
    p_p1    varchar2 default null,  -- Б_Р "по"
    p_p2    varchar2 default null,  -- вал
    p_p4    varchar2 default null,  -- OB22
    p_p7    varchar2 default null  -- вкл 8 клас
  ) IS

/*
02-07-2015  nvv - переход на новие Драпс (в драпсах відсутні записи з залишком і оборотами 0)

13-03-2012  qwa - для накопления месячных снимков использую параметр
                  выборочного накопления (если данные есть -
                  не перенакапливаем)
07-02-2012 serg - оптимизация по параметру mode_=11
                  Требуется:
                  etalon/package/bars_accm_snap.pkb (body) version 1.17 03.02.2012
                  etalon/table/tmp_sal_acc.sql
                  etalon/table/tmp_accm_snap_first.sql
                  etalon/table/tmp_accm_snap_last.sql
                  patchz93.sql
                  Идея: берем снимок из accm_snap_balances на дату начала периода
                        и снимок из accm_snap_balances на дату окончания периода
                        обороты суммируем по saldoa, saldob
                        используем групповой или точечный алгоритм работы с saldoa/saldob
                        в зависимости от кол-ва обрабатываемых счетов
                        порог задается параметром ACTHRESH (default 5000);
                        снимки на начало и конец периода сбрасываются во врменные таблицы
                        после чего дополняются счетами не работавшими на концах периода(но работавшими внутри)
03-02-2012 qwa - новый параметр 111 - для отчета 11 - сальдовка за период не больше
                 месяца, через v_gl и saldoa
26-01-2012 qwa - новый параметр 11 - для отчета 11 - сальдовка за любой период
                 по accm_snap_balances
                 добавлены новые параметры,
06-01-2011 qwa-102-1000 уточнила выборку
               добавила проверку на наличие ненулевых полей остатков-оборотов
               контроль дат открытия пока оставлю, были когда-то проблемы с отбором
               в прошлых периодах
23.08.2011 Qwa-102-1000 принудительно формируем accm_agg_monbals на дату p_dat1
12.01.2011 Qwa-102-1000 Не отбирались  счета открытые после даты формирования
           и по которым  были корр (096)
24.03.2010 Qwa-102-1000 Была ошибка в вычислении эквивалента
           с корректирующими

23.03.2010 Qwa-102-1000 Убрала проверку на закрытые счета
               так как исн по закрытым не копится
22.03.2010 Qwa-102-1000
 Вернула счета 8625 ( у них балансовый 2625)

19.03.2010 Qwa-102-1000
 Убрала 8 класс, исправила исх остатки с учетом кориг след месяца

18.03.2010 Qwa-102
  1. Параметр  102 - сальдовка 1000 за период (любой, но ограничим годом)
     с корректирующими
     причем 2620,2628,2630,2635,2638  выводим только итоги (за счет шаблона)
*/

   p constant varchar2(30) := 'P_SAL_SNP';
   dat1_  date := p_dat1;
   dat2_  date := p_dat2;
   caldt_ID_1 accm_calendar.caldt_ID%type;
   caldt_ID_2 accm_calendar.caldt_ID%type;
   nn_  number;
   l_dd number;
   MODCODE   constant varchar2(3) := 'REP';
   l_cnt    number; -- кол-во чего-либо
   -- порог кол-ва счетов:
   -- если не больше этого значения, используем точечный алгоритм доступа
   -- иначе - используем групповой алгоритм доступа
   l_acc_threshold  number;
   --
   l_flag   integer;  -- 0/1

   dat_max date;
begin

    dat1_  := to_date  ('01.'||to_char(p_dat1,'mm.yyyy'),'dd.mm.yyyy');
    dat2_  := to_date  ('01.'||to_char(p_dat2,'mm.yyyy'),'dd.mm.yyyy');

/* страховочная синхронизация */

  --if length(BRANCH_)=8  then
     -- страховочная синхронизация месячная

  if    mode_=102 then
         bars_accm_sync.sync_AGG('MONBAL', dat1_,1);
   elsif mode_=11 then

      l_dd:=to_date(p_dat2,'dd-mm-yyyy') -  to_date(p_dat1,'dd-mm-yyyy') ;

      if l_dd>31
        then  bars_error.raise_nerror(MODCODE, '38');
      end if;
     -- if nvl(p_p7,'0')='1' then  -- только если 8 класс делаем синхронизацию
/*
    Bars_accm_sync.sync_snap_period(
                  p_objname    => 'BALANCE',
                  p_startdate  => p_dat1,
                  p_finishdate => p_dat2,
                  p_snapmode   => 1);  --  1-условная синхронизация, 0-безусловная
*/
     -- end if;
   end if;
  --end if;
  commit;

if mode_=11 then
  --
  logger.trace('%s: начало работы по параметру mode=11', p);
  --
  EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_SAL';
  begin
    select bankdt_id
      into caldt_ID_1
      from accm_calendar
     where caldt_DATE =p_dat1 ;
  exception when no_data_found then
    return;  -- здесь нормальное сообщение
  end;
  --
  logger.trace('%s: p_dat1=%s, caldt_id_1=%s', p, to_char(p_dat1, 'dd.mm.yyyy'), to_char(caldt_id_1));
  --
  begin
    select bankdt_id
      into caldt_ID_2
      from accm_calendar
     where caldt_DATE=p_dat2 ;
  exception when no_data_found then
    return;  -- здесь нормальное сообщение
  end;
  --
  logger.trace('%s: p_dat2=%s, caldt_id_2=%s', p, to_char(p_dat2, 'dd.mm.yyyy'), to_char(caldt_id_2));
  --
  if l_acc_threshold is null
  then
        begin
            select to_number(val)
              into l_acc_threshold
              from params
             where par='ACTHRESH';
            --
            logger.trace('%s: ACTHRESH параметр = %s', p, to_char(l_acc_threshold));
            --
        exception when no_data_found then
            l_acc_threshold := 5000;
            --
            logger.trace('%s: ACTHRESH параметр не найден, умолч. значение = %s', p, to_char(l_acc_threshold));
            --
        end;
  end if;
  --
  logger.trace('%s: наполняем множество счетов в tmp_sal_acc', p);
  --
    insert
      into tmp_sal_acc(acc, kv, nbs, nls, nms, ob22, branch, daos, dazs, dappq, dapp)
    select acc, kv, nbs, nls, substr(nms,1,35), ob22, branch, daos, dazs, dappq, dapp
      from accounts
     where substr (nbs, 1, 1) <> decode (p_p7, '1', 'A', '8')
           and kv = decode (p_p2, '%', kv, substr (p_p2, 1, 3))
           and branch like
                  decode (branch_,
                          '%', branch,
                          trim (branch_ || '%'))
           and branch like
                  sys_context ('bars_context', 'user_branch_mask')
           and to_number (nbs) >=
                  decode (p_p0,
                          '%', to_number (nbs),
                          to_number (substr (p_p0, 1, 4)))
           and to_number (nbs) <=
                  decode (p_p1,
                          '%', to_number (nbs),
                          to_number (substr (p_p1, 1, 4)))
           and nvl (ob22, '00') in
                  (substr (
                      decode (p_p4, '%', nvl (ob22, '00'), p_p4),
                      1,
                      2),
                   substr (p_p4, 4, 2),
                   substr (p_p4, 7, 2),
                   substr (p_p4, 10, 2),
                   substr (p_p4, 13, 2),
                   substr (p_p4, 16, 2),
                   substr (p_p4, 19, 2),
                   substr (p_p4, 22, 2),
                   substr (p_p4, 25, 2));
  --
  l_cnt := sql%rowcount;
  --
  logger.trace('%s: кол-во счетов в tmp_sal_acc %s', p, to_char(l_cnt));
  --
  /*
  -- отладка
  begin
  select 1
    into l_flag
    from tmp_sal_acc
   where nls='20679301124142'
     and kv=980;
  exception
    when no_data_found then
        l_flag := 0;
  end;
  --
  logger.trace('%s: счет 20679301124142(980) отобран(0/1): %s', p, to_char(l_flag));
  */

if   (--p_dat1 =gl.bd and
        p_dat2 = gl.bd)  then     --accounts

    select max(fdat) into dat_max from fdat;

		insert
				into tmp_sal (kv,
							 nbs,
							 nls,
							 nms,
							 ostqd,
							 ostqk,
							 dosq,
							 kosq,
							 ostiqd,
							 ostiqk,
							 ob22,
							 branch)
		select kv, nbs, nls, substr(nms,1,35) nms,
					  case when ostq < 0 then -ostq else 0 end as ostqd,
					  case when ostq > 0 then ostq else 0 end as ostqk,
					  dosq,
					  kosq,
					  case when ostiq < 0 then -ostiq else 0 end as ostiqd,
					  case when ostiq > 0 then ostiq else 0 end as ostiqk,
					  ob22,
			   branch
		from (
		select kv, nbs, nls, nms, ost, ob22, dos, kos,
			   case when kv = 980 then ost else gl.p_icurval(kv,ost,p_dat1) end ostq,
			   case when kv = 980 then dos else gl.p_icurval(kv,dos,p_dat1) end dosq,
			   case when kv = 980 then kos else gl.p_icurval(kv,kos,p_dat1) end kosq,
			   case when kv = 980 then ost-dos+kos else gl.p_icurval(kv,ost-dos+kos,p_dat1) end ostiq,
			   /*case when kv = 980 then ost else gl.p_icurval(kv,ost,p_dat1) end -
			   case when kv = 980 then dos else gl.p_icurval(kv,dos,p_dat1) end +
			   case when kv = 980 then kos else gl.p_icurval(kv,kos,p_dat1) end ostiq,		*/
			   branch
		from (
		select a.nls, a.kv, a.nbs, a.ob22, a.nms, a.branch,
			   a.ostc+nvl(sdos,0)-nvl(skos,0) as ost,
			   nvl(s.dos,0) dos,
			   nvl(s.kos,0) kos--,
			  -- a.ostc+nvl(sdos,0)-nvl(skos,0)-nvl(s.dos,0)+nvl(s.kos,0) as ostc
		from tmp_sal_acc t, accounts a,
				(select acc,
					   sum(dos) sdos,
					   sum(kos) skos,
					   sum(case when fdat between p_dat1 and p_dat2  then dos else 0 end) dos,
					   sum(case when fdat between p_dat1 and p_dat2  then kos else 0 end) kos
				 from saldoa so
				where fdat between p_dat1 and dat_max
				 group by acc )  s
		where a.acc = s.acc(+)
		  and a.acc = t.acc
		  and (a.dazs is null or a.dazs >= p_dat1)
		)
        )
        where dosq<>0 or kosq<>0 or ostq<>0 or ostiq<>0;

else
  if l_cnt > l_acc_threshold
  then
      --
      logger.trace('%s: сбрасываем снимок баланса(всю партицию) на начало периода в таблицу tmp_accm_snap_first', p);
      --
      insert
        into tmp_accm_snap_first(acc, rnk, ost, ostq, dos, dosq, kos, kosq)
      select acc, rnk, ost, ostq, dos, dosq, kos, kosq
        from accm_snap_balances
       where caldt_id = caldt_id_1;
      --
      logger.trace('%s: сброшено %s счетов', p, to_char(sql%rowcount));
      --
      logger.trace('%s: сбрасываем снимок баланса(всю партицию) на конец периода в таблицу tmp_accm_snap_last', p);
      --
      insert
        into tmp_accm_snap_last(acc, rnk, ost, ostq, dos, dosq, kos, kosq)
      select acc, rnk, ost, ostq, dos, dosq, kos, kosq
        from accm_snap_balances
       where caldt_id = caldt_id_2;
      --
      logger.trace('%s: сброшено %s счетов', p, to_char(sql%rowcount));
      --
  else
      --
      logger.trace('%s: сбрасываем снимок баланса(отдельные счета) на начало периода в таблицу tmp_accm_snap_first', p);
      --
      insert
        into tmp_accm_snap_first(acc, rnk, ost, ostq, dos, dosq, kos, kosq)
      select s.acc, s.rnk, s.ost, s.ostq, s.dos, s.dosq, s.kos, s.kosq
        from accm_snap_balances s, tmp_sal_acc t
       where s.caldt_id = caldt_id_1
         and s.acc = t.acc;
      --
      logger.trace('%s: сброшено %s счетов', p, to_char(sql%rowcount));
      --
      logger.trace('%s: сбрасываем снимок баланса(отдельные счета) на конец периода в таблицу tmp_accm_snap_last', p);
      --
      insert
        into tmp_accm_snap_last(acc, rnk, ost, ostq, dos, dosq, kos, kosq)
      select s.acc, s.rnk, s.ost, s.ostq, s.dos, s.dosq, s.kos, s.kosq
        from accm_snap_balances s, tmp_sal_acc t
       where s.caldt_id = caldt_id_2
         and s.acc = t.acc;
      --
      logger.trace('%s: сброшено %s счетов', p, to_char(sql%rowcount));
      --
  end if;
  --
  logger.trace('%s: дополняем снимок баланса на начало периода счетами, открытыми внутри периода', p);
  --
  insert
    into tmp_accm_snap_first(acc, rnk, ost, ostq, dos, dosq, kos, kosq)
  select acc, null, 0, 0, 0, 0, 0, 0
    from tmp_sal_acc
   where p_dat1 not between daos and nvl(dazs, to_date('01.01.4000','dd.mm.yyyy'))
     and (p_dat1, p_dat2+0.999994)
         overlaps
         (daos, nvl(dazs, to_date('01.01.4000','dd.mm.yyyy'))+0.999994);
  --
  logger.trace('%s: дополнено %s счетов', p, to_char(sql%rowcount));
  --
  logger.trace('%s: дополняем снимок баланса на конец периода счетами, закрытыми внутри периода', p);
  --
  insert
    into tmp_accm_snap_last(acc, rnk, ost, ostq, dos, dosq, kos, kosq)
  select acc, null, 0, 0, 0, 0, 0, 0
    from tmp_sal_acc
   where p_dat2 not between daos and nvl(dazs, to_date('01.01.4000','dd.mm.yyyy'))
     and (p_dat1, p_dat2+0.999994)
         overlaps
         (daos, nvl(dazs, to_date('01.01.4000','dd.mm.yyyy'))+0.999994);
  --
  logger.trace('%s: дополнено %s счетов', p, to_char(sql%rowcount));
  --
  if l_cnt > l_acc_threshold
  then
      --
      logger.trace('%s: используем алгоритм групповой обработки', p);
      --
      insert
        into tmp_sal (kv,
                     nbs,
                     nls,
                     nms,
                     ostqd,
                     ostqk,
                     dosq,
                     kosq,
                     ostiqd,
                     ostiqk,
                     ob22,
                     branch)
       select kv,
              nbs,
              nls,
              nms,
              case when ostq < 0 then -ostq else 0 end as ostqd,
              case when ostq > 0 then ostq else 0 end as ostqk,
              dosq,
              kosq,
              case when ostiq < 0 then -ostiq else 0 end as ostiqd,
              case when ostiq > 0 then ostiq else 0 end as ostiqk,
              ob22,
              branch
         from (select a.kv,
                      a.nbs,
                      a.nls,
                      substr (a.nms, 1, 35) as nms,
                      s1.ostq + s1.dosq - s1.kosq as ostq,
                      s2.ostq as ostiq,
                      nvl(case when a.kv=980 then sa.dos else sb.dosq end, 0) as dosq,
                      nvl(case when a.kv=980 then sa.kos else sb.kosq end, 0) as kosq,
                      nvl (a.ob22, '00') as ob22,
                      a.branch
                 from tmp_accm_snap_first s1,
                      tmp_accm_snap_last  s2,
                      (  select acc, sum (dos) as dos, sum (kos) as kos
                           from saldoa
                          where fdat between p_dat1 and p_dat2
                       group by acc) sa,
                      (  select acc, sum (dos) as dosq, sum (kos) as kosq
                           from saldob
                          where fdat between p_dat1 and p_dat2
                       group by acc) sb,
                      tmp_sal_acc a
                where     a.acc = s1.acc(+)
                      and a.acc = s2.acc(+)
                      and a.acc = sa.acc(+)
                      and a.acc = sb.acc(+)
                )
                where dosq<>0 or kosq<>0 or ostq<>0 or ostiq<>0
      ;
  else
      --
      logger.trace('%s: используем алгоритм точечной обработки', p);
      --
      insert
        into tmp_sal (kv,
                     nbs,
                     nls,
                     nms,
                     ostqd,
                     ostqk,
                     dosq,
                     kosq,
                     ostiqd,
                     ostiqk,
                     ob22,
                     branch)
       select kv,
              nbs,
              nls,
              nms,
              case when ostq < 0 then -ostq else 0 end as ostqd,
              case when ostq > 0 then ostq else 0 end as ostqk,
              dosq,
              kosq,
              case when ostiq < 0 then -ostiq else 0 end as ostiqd,
              case when ostiq > 0 then ostiq else 0 end as ostiqk,
              ob22,
              branch
         from (select a.kv,
                      a.nbs,
                      a.nls,
                      substr (a.nms, 1, 35) as nms,
                      s1.ostq + s1.dosq - s1.kosq as ostq,
                      s2.ostq as ostiq,
                      nvl(case when a.kv=980 then
                           (select sum(dos) from saldoa where acc=a.acc and fdat between p_dat1 and p_dat2 group by acc)
                      else (select sum(dos) from saldob where acc=a.acc and fdat between p_dat1 and p_dat2 group by acc)
                      end, 0) as dosq,
                      nvl(case when a.kv=980 then
                           (select sum(kos) from saldoa where acc=a.acc and fdat between p_dat1 and p_dat2 group by acc)
                      else (select sum(kos) from saldob where acc=a.acc and fdat between p_dat1 and p_dat2 group by acc)
                      end, 0) as kosq,
                      nvl (a.ob22, '00') as ob22,
                      a.branch
                 from tmp_accm_snap_first s1,
                      tmp_accm_snap_last  s2,
                      tmp_sal_acc a
                where     a.acc = s1.acc(+)
                      and a.acc = s2.acc(+)
                )
                where dosq<>0 or kosq<>0 or ostq<>0 or ostiq<>0
      ;
  end if;
  --
  logger.trace('%s: отобрано в таблицу tmp_sal счетов %s', p, to_char(sql%rowcount));
  --
  logger.trace('%s: окончание работы по параметру mode=11', p);
  --
end if;  --- accounts

elsif mode_ = 102 then  /* сальдовка  за период, с корр 096*/
  EXECUTE IMMEDIATE 'TRUNCATE TABLE CCK_AN_TMP';
  begin
  -- bars_audit.info( 'p_sal_snp=p_dat1='||p_dat1||'p_dat2='||p_dat2);
     select caldt_ID
      into caldt_ID_1
      from accm_calendar
     where caldt_DATE=dat1_ ;
     exception when no_data_found then return;  -- здесь нормальное сообщение
  end;
  begin
  select caldt_ID
      into caldt_ID_2
      from accm_calendar
     where caldt_DATE=dat2_ ;
     exception when no_data_found then return;  -- здесь нормальное сообщение
  end;
 insert into CCK_AN_TMP
             (branch,nbs,kv,name,name1,nls,n1,n2,n3,n4,n5,zalq,zal,rezq)
 select a.branch,
         a.nbs,
         a.kv,
         nvl(a.ob22,'00') ob22,
         substr(a.nms,1,35) nms,
         a.nls,
         y.ost,y.ostq,y.dos,y.dosq,y.kos,y.kosq,y.osti,y.ostiq
 from accounts a,--specparam_int s,  OB22 переїхало в accounts
      (select m.acc,
         sum(m.ost) ost,  sum(m.ostq) ostq,
         sum(m.dos) dos,  sum(m.dosq) dosq,
         sum(m.kos) kos,  sum(m.kosq) kosq,
         sum(m.osti) osti,sum(m.ostiq)  ostiq
       from
       (select acc,
         (decode(caldt_id, caldt_ID_1, ost+dos-kos-cudos+cukos, 0)) ost,
         (decode(caldt_id, caldt_ID_1, ostq+dosq-kosq-cudosq+cukosq, 0)) ostq,
         (decode(caldt_id, caldt_ID_2, ost -crdos +crkos, 0))  osti,
         (decode(caldt_id, caldt_ID_2, ostq-crdosq+crkosq, 0)) ostiq,
         (dos + crdos- cudos)  dos ,
         (dosq+ crdosq-cudosq) dosq ,
         (kos+  crkos -cukos)  kos ,
         (kosq+ crkosq-cukosq) kosq
       from accm_agg_monbals
       where  caldt_id  between caldt_ID_1 and caldt_ID_2
       and (dos<>0 or dosq<>0 or kos<>0 or kosq<>0 or crdos<>0 or crdosq<>0 or crkos<>0 or crkosq<>0
          or cudos<>0 or cudosq<>0 or cukos<>0 or cukosq<>0 or ost<>0 or ostq<>0 )
       ) m
      group by m.acc) y
  where  a.acc=y.acc
    and  a.nbs not like '8%'
    and  ( a.dazs is null or a.dazs > p_dat1)
    and  (a.daos<=p_dat2
          or (a.daos>p_dat2  and (y.ost<>0 or y.osti<>0  -- открыты позже,но были корр.в предыд-й месяц
                                or y.dos<>0 or y.kos<>0)
               ))
    and  a.branch like BRANCH_||'%'
    and  a.branch like sys_context('bars_context','user_branch')||'%'
    --and  a.acc=s.acc(+)
	;
end if;
commit;
Return;
end p_sal_snp;
/
show err;

PROMPT *** Create  grants  P_SAL_SNP ***
grant EXECUTE                                                                on P_SAL_SNP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_SAL_SNP       to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SAL_SNP.sql =========*** End ***
PROMPT ===================================================================================== 
