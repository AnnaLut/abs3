create or replace procedure P_BAL_SNP
( p_id    number    -- ����� (������)
, p_DAT   date      -- ����
, Param0  varchar2  -- Param0= ����� (%-��_)
, Param1  varchar2  -- Param1='����������_� (%-��_)
, Param2  varchar2  -- Param2='����������_�� (%-��_)
) is
/*
  23.08.2017 BAA 
  19.07.2012 Sta �i���� ����������� = 1 ��� ����� ����i�
  17-06-2011 Sta ��� � ���� - 61 ������ � �� �� 61 �����
  22-01-2010 Sta ��� �� �� �����. �� � ����
                 ����� p_Id (��� ����) = p_Id+100 (� ����)
  l_id1 = -1 then
     -- ������ ���+��22
     -- kodz=2354(131), ������ + ��22  ������i� i ������i� � ���-���i������i
     -- kodz=2744(266), ������ ������i� i ������i� � ���-��� ( ����_� ��22    )

  l_id1 = -3 then
     -- ������ + ��22  ������i� i ������i� � ���i���i
     -- kodz=2450(132)

  l_id1 = -2 then
     -- ������ ���+BRANCH substr(substr(a.branch,1,15),-4)
     -- kodz=  51(244) ������ ������i� i ������i� � ���-���i������i  (�i����-2)
     -- kodz=2745(267) ������ ������i� i ������i� � ���-��� ( ����_� ����-2)
  l_id1 = 0 then
     -- ������ ���
     -- kodz=15 (����� 31) ������ ������i� i ������i� � ���-���i������i
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
     -- ������ ���+��22
     -- kodz=2354(131), ������ + ��22  ������i� i ������i� � ���-���i������i
     -- kodz=2744(266), ������ ������i� i ������i� � ���-��� ( ����_� ��22    )
     l_Sql := 'insert into tmp_bal (NBS,DOS,KOS,OSTD,OSTK)
     select a.nbs|| '' ''||a.OB22, sum( b.dosq ) DOS, sum( b.kosq ) KOS ,
            sum(decode( sign(b.ostq),-1, -b.ostq, 0 )) OSTD,
            sum(decode( sign(b.ostq), 1,  b.ostq, 0 )) OSTK
       from snap_balances b
       join accounts a
         on ( b.acc = a.acc )
     where b.FDAT  = :l_DAT1 ' || l_Sql1 || l_Sql2 || '
       and a.nbs not like ''8%''
       and (b.dosq>0 or b.kosq>0 or b.ostq<>0)
       and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
     group by a.nbs|| '' ''||a.OB22 ' ;

  ElsIF l_id1 = -1 and l_id2 = 1 
  then -- ���� �� �������
    
    NULL;

  ElsIF l_id1 = -3 and l_id2 = 0 then
     -- ������ + ��22  ������i� i ������i� � ���i���i
     -- kodz=2450(132)

     l_Sql := 'insert into tmp_bal (KV,NBS,DOS,KOS,OSTD,OSTK)
     select a.KV, a.nbs|| '' ''||a.OB22, sum( b.dos ) DOS, sum( b.kos ) KOS ,
             sum(decode( sign(b.ost),-1, -b.ost, 0 )) OSTD,
             sum(decode( sign(b.ost), 1,  b.ost, 0 )) OSTK
      from snap_balances b
      join accounts a
        on ( b.acc = a.acc )
     where b.FDAT  = :l_DAT1 ' || l_Sql1 || l_Sql2 || '
       and a.nbs not like ''8%''
       and ( b.dos>0 or b.kos>0 or b.ost<>0 )
       and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
     group by a.KV, a.nbs|| '' ''||a.OB22 ' ;

  ElsIF l_id1 = -3 and l_id2 = 1 
  then -- ���� �� �������
    
    NULL;

  elsif l_id1 = -2 and l_id2 = 0 then

     -- ������ ���+BRANCH substr(substr(a.branch,1,15),-4)
     -- kodz=  51(244) ������ ������i� i ������i� � ���-���i������i  (�i����-2)
     -- kodz=2745(267) ������ ������i� i ������i� � ���-��� ( ����_� ����-2)
     l_Sql := 'insert into tmp_bal (NBS,DOS,KOS,OSTD,OSTK)
     select a.nbs|| ''/''||substr(substr(a.branch,1,15),-4),
            sum( b.dosq ) DOS, sum( b.kosq ) KOS ,
            sum(decode( sign(b.ostq),-1, -b.ostq, 0 )) OSTD,
            sum(decode( sign(b.ostq), 1,  b.ostq, 0 )) OSTK
      from snap_balances b
      join accounts a
        on ( b.acc = a.acc )
     where b.FDAT  = :l_DAT1 ' || l_Sql1 || l_Sql2 || '
       and a.nbs not like ''8%''
       and ( b.dosq>0 or b.kosq>0 or b.ostq<>0 )
       and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
     group by a.nbs|| ''/''||substr(substr(a.branch,1,15),-4) ' ;

  ElsIF l_id1 = -2 and l_id2 = 1 
  then -- ���� �� �������
    
    NULL; 

  elsif l_id1 =  0 and l_id2 = 0 
  then -- kodz=15 (����� 31) ������ ������i� i ������i� � ���-���i������i
    
    -- moved to function RPT_UTL.GET_BALANCES
    l_Sql := 'insert into tmp_bal ( NBS,DOS,KOS,OSTD,OSTK )
    select a.nbs, sum( b.dosq ) DOS, sum( b.kosq ) KOS ,
           sum(decode( sign(b.ostq),-1, -b.ostq, 0 )) OSTD,
           sum(decode( sign(b.ostq), 1,  b.ostq, 0 )) OSTK
      from SNAP_BALANCES b
      join ACCOUNTS a
        on ( b.acc = a.acc )
     where b.FDAT  = :l_DAT1 ' || l_Sql1 || l_Sql2 || '
       and a.nbs not like ''8%''
       and ( b.dosq>0 or b.kosq>0 or b.ostq<>0 )
       and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
     group by a.nbs';

  ElsIF l_id1 = 0 and l_id2 = 1
  then -- kodz=61 (����� 61) ��� �� ����� ��� � ����
     
     l_Sql := 'insert into tmp_bal (NBS,DOS,KOS,OSTD,OSTK)
     select a.nbs, sum( b.dosq ) DOS, sum( b.kosq ) KOS ,
            sum(decode( sign(b.ostq),-1, -b.ostq, 0 )) OSTD,
            sum(decode( sign(b.ostq), 1,  b.ostq, 0 )) OSTK
       from ( select acc, dosq-cudosq+crdosq DOSQ,
                     kosq-cukosq+crkosq KOSQ,
                     ostq-crdosq+crkosq OSTQ
                from AGG_MONBALS
               where FDAT  = :l_DAT1
            ) b
          , accounts a
      where b.acc = a.acc ' || l_Sql1 || l_Sql2 || '
        and a.nbs not like ''8%''
        and ( b.dosq > 0 or b.kosq > 0 or b.ostq <> 0 )
        and a.BRANCH like sys_context(''bars_context'',''user_branch_mask'')
      group by a.nbs';
    
  end if;

  execute immediate l_Sql using l_DAT1 ;

  -- ���������� ������������
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
        -- �������� ������
        begin
          select substr(name,1,90) into l_sK from ps where nbs= l_K||'   ';
        exception when NO_DATA_FOUND THEN l_sK := to_char(l_K);
        end;
        -- ���������-������
        if l_K = 9  
        then l_sB1 :='�������������� ���i�'; l_b1:=9;
        else l_sB1 :='���������� ���i�'    ; l_b1:=7;
        end if;
     end if;

     If l_R<>to_number(substr(p.nbs3,1,2)) 
     then
        l_R:=to_number(substr(p.nbs3,1,2));
        -- �������� �������
        begin
          select substr(name,1,90) into l_sR from ps where nbs= l_R||'  ';
        exception
          when NO_DATA_FOUND THEN l_sR := to_char(l_R);
        end;
     end if;

     If l_G <> to_number(p.nbs3)
     then
        l_G := to_number(p.nbs3);
        -- �������� ������
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
