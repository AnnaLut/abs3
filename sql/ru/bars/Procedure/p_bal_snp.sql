CREATE OR REPLACE procedure BARS.P_BAL_SNP
( p_id    number    -- режим (разрез)
, p_DAT   date      -- дата
, Param0  varchar2  -- Param0= Бранч (%-вс_)
, Param1  varchar2  -- Param1='БалРахунок_з (%-вс_)
, Param2  varchar2  -- Param2='БалРахунок_по (%-вс_)
) is
/*
  25/04/2018 Virko
  29/11/2017 Virko
  23.08.2017 BAA
  19.07.2012 Sta Рiвень користувача = 1 для синхр снапiв
  17-06-2011 Sta Бал з корр - 61 запрос и он же 61 отчет
  22-01-2010 Sta Все то же самое. но з корр
                 Парам p_Id (без корр) = p_Id+100 (з корр)
  l_id1 = -1 then
     -- разрез БАЛ+ОБ22
     -- kodz=2354(131), БАЛАНС + ОБ22  оборотiв i залишкiв в ГРН-еквiвалентi
     -- kodz=2744(266), БАЛАНС оборотiв i залишкiв в ГРН-екв ( розр_з ОБ22    )

  l_id1 = -3 then
     -- Баланс + ОБ22  оборотiв i залишкiв в Номiналi
     -- kodz=2450(132)

  l_id1 = -2 then
     -- разрез БАЛ+BRANCH substr(substr(a.branch,1,15),-4)
     -- kodz=  51(244) БАЛАНС оборотiв i залишкiв в ГРН-еквiвалентi  (рiвень-2)
     -- kodz=2745(267) БАЛАНС оборотiв i залишкiв в ГРН-екв ( розр_з ТВБВ-2)
  l_id1 = 0 then
     -- разрез БАЛ
     -- kodz=15 (отчет 31) БАЛАНС оборотiв i залишкiв в ГРН-еквiвалентi
*/
  l_id1  number := p_id;
  l_id2  number := 0 ;
  l_DAT1 date   := p_DAT;
  l_DAT2 date   := p_DAT;
  ---
  l_b1   number(38);
  l_k    integer;
  l_r    integer;
  l_g    integer;
  l_sk   varchar2(90);
  l_sr   varchar2(90);
  l_sg   varchar2(90);
  l_sb1  varchar2(40);
  ---
  l_Sql   varchar2(3000) := '';
  l_Sql1  varchar2(2000) := '';
  l_Sql2  varchar2(2000) := '';
begin

  If ( p_id > 90 )
  then
     l_id1  := p_id -100;
     l_id2  := 1;
     l_DAT1 := to_date('01.'||to_char(p_DAT,'MM.YYYY'),'DD.MM.YYYY');
     begin
       select Nvl(max(fdat),p_DAT)
         into l_DAT2
         from fdat
        where to_char(fdat,'yyyymm')=to_char(p_DAT ,'yyyymm');
     exception
       when NO_DATA_FOUND THEN null;
     end;

  end if;

  execute immediate 'truncate table TMP_BAL';

  If length(Param1)>0 and Param1 <>'%'
  then
    l_Sql1 := ' and a.nbs >= '''|| Param1 ||'''';
  end if;

  If length(Param2)>0 and Param2 <>'%'
  then
    l_Sql2 := ' and a.nbs <= '''|| Param2 ||'''';
  end if;

  If l_id1 = -2 then
     If length(Param0)>0 and Param0 <>'%' then
        l_Sql1 := ' and a.branch like '''|| Param0 || '%''';
     end if;
  end if;

  If l_id1 = -3 then
     If length(Param0)>0 and Param0 <>'%' then
        l_Sql1 := ' and a.kv = '|| Param0 ;
     end if;
  end if;

  IF l_id1 = -1 and l_id2 = 0
  then
     -- разрез БАЛ+ОБ22
     -- kodz=2354(131), БАЛАНС + ОБ22  оборотiв i залишкiв в ГРН-еквiвалентi
     -- kodz=2744(266), БАЛАНС оборотiв i залишкiв в ГРН-екв ( розр_з ОБ22    )
     l_Sql := 'insert into tmp_bal (NBS,DOS,KOS,OSTD,OSTK)
      select nbs, sum(dos), sum(kos), sum(ostd), sum(ostk)
      from (
         select a.nbs|| '' ''||a.OB22 nbs,
                sum( b.dosq ) DOS, sum( b.kosq ) KOS ,
                sum(decode( sign(b.ostq),-1, -b.ostq, 0 )) OSTD,
                sum(decode( sign(b.ostq), 1,  b.ostq, 0 )) OSTK
           from snap_balances b
           join accounts a
             on ( b.acc = a.acc )
         where b.FDAT  = :l_DAT1 ' || l_Sql1 || l_Sql2 || '
           and a.nbs not like ''8%''
           and (b.dosq>0 or b.kosq>0 or b.ostq<>0)
           and nvl(a.dat_alt, :l_DAT1 - 1) <> :l_DAT1
           and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
         group by a.nbs|| '' ''||a.OB22
            union all
         select substr(b.acc_num, 1, 4)|| '' ''||b.acc_OB22,
                sum( b.dosq_repd ) DOS, sum( b.kosq_repd ) KOS ,
                sum(decode( sign(b.ostq_rep),-1, -b.ostq_rep, 0 )) OSTD,
                sum(decode( sign(b.ostq_rep), 1,  b.ostq_rep, 0 )) OSTK
           from nbur_kor_balances b
           join accounts a
             on ( b.acc_id = a.acc )
         where b.report_date  = :l_DAT1 ' || l_Sql1 || l_Sql2 || '
           and a.nbs not like ''8%''
           and (b.dosq_repd>0 or b.kosq_repd>0 or b.ostq_rep<>0)
           and nvl(a.dat_alt, :l_DAT1 - 1) = :l_DAT1
           and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
         group by substr(b.acc_num, 1, 4)|| '' ''||b.acc_OB22 )
      group by nbs ';

  ElsIF l_id1 = -1 and l_id2 = 1
  then -- пока не сделано

    NULL;

  ElsIF l_id1 = -3 and l_id2 = 0 then
     -- Баланс + ОБ22  оборотiв i залишкiв в Номiналi
     -- kodz=2450(132)

     l_Sql := 'insert into tmp_bal (KV,NBS,DOS,KOS,OSTD,OSTK)
      select kv, nbs, sum(dos), sum(kos), sum(ostd), sum(ostk)
      from (
         select a.KV, a.nbs|| '' ''||a.OB22 nbs,
                 sum( b.dos ) DOS, sum( b.kos ) KOS ,
                 sum(decode( sign(b.ost),-1, -b.ost, 0 )) OSTD,
                 sum(decode( sign(b.ost), 1,  b.ost, 0 )) OSTK
          from snap_balances b
          join accounts a
            on ( b.acc = a.acc )
         where b.FDAT  = :l_DAT1 ' || l_Sql1 || l_Sql2 || '
           and a.nbs not like ''8%''
           and ( b.dos>0 or b.kos>0 or b.ost<>0 )
           and nvl(a.dat_alt, :l_DAT1 - 1) <> :l_DAT1
           and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
         group by a.KV, a.nbs|| '' ''||a.OB22
            union all
         select a.kv, substr(b.acc_num, 1, 4)|| '' ''||b.acc_OB22,
                sum( b.dos_repd ) DOS, sum( b.kos_repd ) KOS ,
                sum(decode( sign(b.ost_rep),-1, -b.ost_rep, 0 )) OSTD,
                sum(decode( sign(b.ost_rep), 1,  b.ost_rep, 0 )) OSTK
           from nbur_kor_balances b
           join accounts a
             on ( b.acc_id = a.acc )
         where b.report_date  = :l_DAT1 ' || l_Sql1 || l_Sql2 || '
           and a.nbs not like ''8%''
           and (b.dos_repd>0 or b.kos_repd>0 or b.ost_rep<>0)
           and nvl(a.dat_alt, :l_DAT1 - 1) = :l_DAT1
           and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
         group by a.kv, substr(b.acc_num, 1, 4)|| '' ''||b.acc_OB22 )
      group by kv, nbs ';

  ElsIF l_id1 = -3 and l_id2 = 1
  then -- пока не сделано

    NULL;

  elsif l_id1 = -2 and l_id2 = 0 then

     -- разрез БАЛ+BRANCH substr(substr(a.branch,1,15),-4)
     -- kodz=  51(244) БАЛАНС оборотiв i залишкiв в ГРН-еквiвалентi  (рiвень-2)
     -- kodz=2745(267) БАЛАНС оборотiв i залишкiв в ГРН-екв ( розр_з ТВБВ-2)
     l_Sql := 'insert into tmp_bal (NBS,DOS,KOS,OSTD,OSTK)
      select nbs, sum(dos), sum(kos), sum(ostd), sum(ostk)
      from (
         select a.nbs|| ''/''||substr(substr(a.branch,1,15),-4) nbs,
                sum( b.dosq ) DOS, sum( b.kosq ) KOS ,
                sum(decode( sign(b.ostq),-1, -b.ostq, 0 )) OSTD,
                sum(decode( sign(b.ostq), 1,  b.ostq, 0 )) OSTK
          from snap_balances b
          join accounts a
            on ( b.acc = a.acc )
         where b.FDAT  = :l_DAT1 ' || l_Sql1 || l_Sql2 || '
           and a.nbs not like ''8%''
           and ( b.dosq>0 or b.kosq>0 or b.ostq<>0 )
           and nvl(a.dat_alt, :l_DAT1 - 1) <> :l_DAT1
           and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
         group by a.nbs|| ''/''||substr(substr(a.branch,1,15),-4)
            union all
         select substr(b.acc_num, 1, 4)|| ''/''||substr(substr(a.branch,1,15),-4),
                sum( b.dosq_repd ) DOS, sum( b.kosq_repd ) KOS ,
                sum(decode( sign(b.ostq_rep),-1, -b.ostq_rep, 0 )) OSTD,
                sum(decode( sign(b.ostq_rep), 1,  b.ostq_rep, 0 )) OSTK
           from nbur_kor_balances b
           join accounts a
             on ( b.acc_id = a.acc )
         where b.report_date  = :l_DAT1 ' || l_Sql1 || l_Sql2 || '
           and a.nbs not like ''8%''
           and (b.dosq_repd>0 or b.kosq_repd>0 or b.ostq_rep<>0)
           and nvl(a.dat_alt, :l_DAT1 - 1) = :l_DAT1
           and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
         group by substr(b.acc_num, 1, 4)|| ''/''||substr(substr(a.branch,1,15),-4) )
      group by nbs ';

  ElsIF l_id1 = -2 and l_id2 = 1
  then -- пока не сделано

    NULL;

  elsif l_id1 =  0 and l_id2 = 0
  then -- kodz=15 (отчет 31) БАЛАНС оборотiв i залишкiв в ГРН-еквiвалентi

    -- moved to function RPT_UTL.GET_BALANCES
    l_Sql := 'insert into tmp_bal ( NBS,DOS,KOS,OSTD,OSTK )
      select nbs, sum(dos), sum(kos), sum(ostd), sum(ostk)
      from (
          select a.nbs,
               sum(b.dosq) DOS, sum(b.kosq) KOS ,
               sum(decode( sign(b.ostq),-1, -b.ostq, 0 )) OSTD,
               sum(decode( sign(b.ostq), 1,  b.ostq, 0 )) OSTK
          from SNAP_BALANCES b
          join ACCOUNTS a
            on ( b.acc = a.acc )
         where b.FDAT  = :l_DAT1 ' || l_Sql1 || l_Sql2 || '
           and a.nbs not like ''8%''
           and ( b.dosq>0 or b.kosq>0 or b.ostq<>0 )
           and nvl(a.dat_alt, :l_DAT1 - 1) <> :l_DAT1
           and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
         group by a.nbs
            union all
         select substr(b.acc_num, 1, 4),
                sum( b.dosq_repd ) DOS, sum( b.kosq_repd ) KOS ,
                sum(decode( sign(b.ostq_rep),-1, -b.ostq_rep, 0 )) OSTD,
                sum(decode( sign(b.ostq_rep), 1,  b.ostq_rep, 0 )) OSTK
           from nbur_kor_balances b
           join accounts a
             on ( b.acc_id = a.acc )
         where b.report_date  = :l_DAT1 ' || l_Sql1 || l_Sql2 || '
           and a.nbs not like ''8%''
           and (b.dosq_repd>0 or b.kosq_repd>0 or b.ostq_rep<>0)
           and nvl(a.dat_alt, :l_DAT1 - 1) = :l_DAT1
           and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
         group by substr(b.acc_num, 1, 4))
      group by nbs ';

  ElsIF l_id1 = 0 and l_id2 = 1
  then -- kodz=61 (отчет 61) БАЛ на конец мес з корр

     l_Sql := 'insert into tmp_bal (NBS,DOS,KOS,OSTD,OSTK)
      select nbs, sum(dos), sum(kos), sum(ostd), sum(ostk)
      from (
          select a.nbs,
               sum(b.dosq-b.cudosq+b.crdosq ) DOS,
               sum(b.kosq-b.cukosq+b.crkosq ) KOS ,
               sum(decode( sign(b.ostq-b.crdosq+b.crkosq),-1, -(b.ostq-b.crdosq+b.crkosq), 0 )) OSTD,  
               sum(decode( sign(b.ostq-b.crdosq+b.crkosq), 1,  b.ostq-b.crdosq+b.crkosq, 0 )) OSTK
          from agg_monbals b, accounts a
          where   b.fdat  = :l_DAT1
             and b.acc = a.acc ' || l_Sql1 || l_Sql2 || '
             and a.nbs not like ''8%'' '||
           (case  when to_char(p_DAT, 'mmyyyy') = '122017' 
                  then ' and a.dat_alt is null '
                  else ''
            end) || 
            'and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
          group by a.nbs';
       
      if to_char(p_DAT, 'mmyyyy') = '122017' then 
         l_Sql := l_Sql || ' union all
          select substr(d.acc_num, 1, 4) nbs,
                   sum((case when d.acc_type = ''OLD'' then d.dosq_repm-b.cudosq else b.dosq-d.dosq_repd+b.crdosq end)) DOS,
                   sum((case when d.acc_type = ''OLD'' then d.kosq_repm-b.cukosq else b.kosq-d.kosq_repd+b.crkosq end)) KOS ,
                   sum((case when d.acc_type = ''OLD'' then 0 else decode( sign(b.ostq-b.crdosq+b.crkosq),-1, -(b.ostq-b.crdosq+b.crkosq), 0 ) end)) OSTD,
                   sum((case when d.acc_type = ''OLD'' then 0 else decode( sign(b.ostq-b.crdosq+b.crkosq), 1,  b.ostq-b.crdosq+b.crkosq, 0 ) end)) OSTK
            from AGG_MONBALS b, nbur_kor_balances d, accounts a
            where   b.fdat  = :l_DAT1
                and b.acc = a.acc ' || l_Sql1 || l_Sql2 || '
                and d.report_date = to_date(''18122017'', ''ddmmyyyy'') 
                and b.acc = d.acc_id
                and a.nbs not like ''8%''
                and a.dat_alt = to_date(''18122017'', ''ddmmyyyy'') 
                and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'') 
            group by substr(d.acc_num, 1, 4) ';
      end if;
      
      l_Sql := l_Sql || ') group by nbs ';
  end if;

  if l_id1 = 0 and l_id2 = 1 then
     if to_char(p_DAT, 'mmyyyy') = '122017' then
        execute immediate l_Sql using l_DAT1, l_DAT1;
     else
        execute immediate l_Sql using l_DAT1;
     end if;
  else
     execute immediate l_Sql using l_DAT1, l_DAT1, l_DAT1, l_DAT1, l_DAT1, l_DAT1 ;
  end if;

  -- заполнение наименований
  l_k  := 0;
  l_r  := 0;
  l_g  := 0;
  l_sk := ' ';
  l_sr := ' ';
  l_sg := ' ';

  FOR p in ( select distinct substr(nbs,1,3) nbs3 from tmp_bal order by 1 )
  loop

     If l_K<>to_number(substr(p.nbs3,1,1))
     then
        l_K:=to_number(substr(p.nbs3,1,1));
        -- название класса
        begin
          select substr(name,1,90) into l_sK from ps where nbs= l_K||'   ';
        exception when NO_DATA_FOUND THEN l_sK := to_char(l_K);
        end;
        -- внебаланс-баланс
        if l_K = 9
        then l_sB1 :='Позабалансовий облiк'; l_b1:=9;
        else l_sB1 :='Балансовий облiк'    ; l_b1:=7;
        end if;
     end if;

     If l_R<>to_number(substr(p.nbs3,1,2))
     then
        l_R:=to_number(substr(p.nbs3,1,2));
        -- название раздела
        begin
          select substr(name,1,90) into l_sR from ps where nbs= l_R||'  ';
        exception
          when NO_DATA_FOUND THEN l_sR := to_char(l_R);
        end;
     end if;

     If l_G <> to_number(p.nbs3)
     then
        l_G := to_number(p.nbs3);
        -- название группы
        begin
          select substr(name,1,90) into l_sG from ps where nbs= l_G||' ';
        exception
          when NO_DATA_FOUND THEN l_sG := p.nbs3;
        end;
     end if;

     update tmp_bal
        set id  = l_id1, DAT = l_DAT2,
            B1  = l_b1 , SB1 = l_sb1 ,
            K   = l_K  , SK  = l_sK  ,
            R   = l_R  , SR  = l_sR  ,
            G   = l_G  , SG  = l_sG
      where nbs like p.nbs3||'%';

  end loop;

end P_BAL_SNP;
/

show err;

grant EXECUTE on P_BAL_SNP to BARS_ACCESS_DEFROLE;
