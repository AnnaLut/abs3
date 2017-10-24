create or replace procedure cck_sber(tip_     in Varchar2,
                                     vid_     in varchar2,
                                     p_branch in varchar2  default sys_context('bars_context','mfo')) is

  -- tip ������� 2 �� 3 ��

  /*
  01.04.2015 nov  ���������� ������ ������������ �������� �� ���������� ������� ����������� �������� ����� �� ������� ����������� ����� � 2207 ��� �������� ���� ��������� %
                           �������� ��� ��������� ����
                         VID=1 -  ���� ��������� ����������� �� ��� . ������ �������� �� ��� ���������� �� ����� ��� �� ����� ������� ���� ��������� ��������� �� �� ���� �� ����� �������� ������� �� ���������� �� ���
                         VID=4 -(�� S38)  ���� ��������� ����������� �� ��� ���������   ����� ������ ��� ����� ������������ ������ ����� ���� �������� � ���.
                        VID=5  - ������������  ������ � �������� �� ��������� �� ��������� ������ ��  (��� ��������� ���� 25 �� �������� ������������ �� 31 �������� ������)
  
  
  24.04.2014 DAV ����� �������� ������� �� � ��� ������������ � ������� ��������� STA CCK.CC_ASPN_DOG  ������������� �� ���������
                 ��� ������ ��������� � ������� ���� ��������� ���� �������� �� �������� ��� �� �������� ������� ������ ������ ��
                 ��������� ���������� ����.
  
  
  !!!! sos !!!!
  18.07.2013 Sta ��������� �������� ��������� �� ���������.
                 ���������� ��� ��
                 �������� �������.
                 �� ���� �� ��� ���� !
  */

  l_dat1 date; -- ����.���. ����
  l_dat2 date; -- ����-����.���. ����

  l_Acr_dat date; -- ���� �� ��� ��������� �������
  l_ostc_sn accounts.ostc%type; -- ������� ���  SN
  l_acc_sn  accounts.acc%type; -- SN

  l_max number; -- l_max > 0  - max ��������� ����� ��� �������� �� ��������� (�� ���) - ������������ � ����� ��������
  -- l_max = Null - �� �������
begin
 
  
  l_dat1 := dat_next_u(gl.bdate, -1); -- ������� ��� ����
  l_dat2 := dat_next_u(gl.bdate, -2); -- ����-������� ��� ����

  -- ������� �� ���������� ��� ���� ��������� % ����� ������������ �� ��� (�� 01.04.2015 - ����� �� ������������)
  if vid_ = '1' then
  
    for k in (
              
              -- STA
              --- ���������� ������ ������ �� ��������� ����
              -- ������� �������� �� ��������� ����������� �����.
              -- ������� ��������� ������� ����������� ����� �� ��������� ���� ����� ���������� ��� ��������� ����������� �����
              -- (���� �� �� ������ �� ��������� ���� ����� ��� ��������� ��������� �����)
              -- ��� �������� � ������� ������ ��� ��������� "�� ������� ����" �� ����� ��������� ����� ������� ���� ������� �� �����. (3 �������)
              -- ��� �������� � ������� ������ ��� ��������� "�� ������� �����" ����� �������� ����� ����������� ��������� �� ������� �����, (2 �������)
              -- � ����� � ������ ������� ���� ������� ������� �� ��������� �� �� ����������� ����� � ������� ���� ��������� �������� ���� ������.
              -- ��� ����� ��������� ������������ � ����� ��������� �� ����� (1 �������)
              
              select d.ND,
                      d.rnk,
                      d.CC_ID,
                      c.OKPO,
                      c.nmk,
                      substr(t.txt, 2, 1) as DP,
                      d.vidd,
                      d.sdate,
                      i.basem,
                      i.basey,
                      a.kv,
                      (select max(l.fdat)
                         from cc_lim l
                        where l.nd = d.nd
                          and fdat > l_dat2
                          and l.fdat <= l_dat1
                          and l.sumo > 0) pl_dat
                from cc_deal  d,
                      accounts    a, -- saldo a,
                      customer c,
                      int_accn i,
                      nd_acc   n,
                      nd_txt   t,
                      cc_add   da
               where (tip_ <= 2 and vidd in (1, 2, 3) or
                     tip_ = 3 and vidd in (11, 12, 13))
                 AND d.sos > 0
                 AND d.sos < 14
                 AND d.nd = n.nd
                 and n.acc = a.acc
                 and a.tip = 'LIM'
                 AND d.rnk = c.rnk
                 and da.nd = d.nd
                 AND i.acc = a.acc
                 and i.id = 0
                 and d.nd = t.nd
                 and t.tag = 'FLAGS'
                    -- ����������� ����������� ���������
                 and (nvl(to_number(cck_app.get_nd_txt(d.ND, 'FREQP'),
                                    '99999999999D99',
                                    'NLS_NUMERIC_CHARACTERS = ''. '''),
                          da.freq) != 400 or d.wdate < gl.bdate)
                    -- ������ ��������� �� ����
                 and exists
               (select 1
                        from cc_lim l
                       where l.nd = d.nd
                         and fdat > l_dat2
                         and l.fdat <= l_dat1
                         and l.sumo > 0)
                    -- ���� ������� ��������� ������
                 and nvl(nvl(to_date(cck_app.get_nd_txt(d.ND, 'DATSN'),
                                     'dd/mm/yyyy'),
                             i.apl_dat),
                         d.sdate) <= cck_app.correctDate2(980, gl.bd - 1, 0)) loop
      -- ����� (������� ) ��������
      If k.vidd = 11 and k.basem = 1 and k.basey = 2 then
        begin
          -- �� ������ �� STA
          l_max     := null;
          l_ostc_sn := null;
          l_acc_sn  := null;
        
          -- ���� �� ���� �������� % ?
          select nvl(MAX(i.acr_dat), k.pl_dat - 1), max(i.acra)
            into l_Acr_dat, l_acc_sn
            from int_accn i, accounts a, nd_acc n
           where n.nd = k.nd
             and n.acc = a.acc
             and i.acc = a.acc
             and i.id = 0
             and a.tip = 'SS '
             and a.dazs is null
             and a.kv = k.kv;
          -- ���� �� ������� �� �� ���.% ?
          select abs(a.ostc)
            into l_ostc_sn
            from accounts a
           where a.acc = l_acc_sn
             and ostc < 0
             and ostc = ostb
             and a.tip = 'SN '
             and a.kv = k.kv;
          -- ���� ��� ������� ��-������, �� �.�. ����� ��� ���� >= ����� �� ��� , �.�. �������� �������� �� ����� ����� �� ���
        
          If k.pl_DAT <= l_Acr_dat then
            l_max := greatest(l_ostc_sn -
                              cck.FINT(k.ND, k.pl_DAT, l_Acr_dat),
                              0);
          else
            l_max := trunc(l_ostc_sn);
          End if;
        
          cck.CC_ASPN_DOG(k.nd, k.cc_id, k.okpo, k.nmk, -3, l_max);
        
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            goto NexRec;
        end;
      
      elsif k.DP = 0 then
        -- �� ������� ���� (����� % ��������� �� ���������� ����)
        cck.CC_ASPN_DOG(k.nd, k.cc_id, k.okpo, k.nmk, -3, null);
      else
        -- �� ������� �����
        cck.CC_ASPN_DOG(k.nd, k.cc_id, k.okpo, k.nmk, -2, null);
      end if;
    
      <<NexRec>>
      null;
    
    end loop;
  
    Return;
  end if;

  -- ������� �� ���������� ��� ���� ��������� %  ������������ �� ��� ��������� (�������� )
  if vid_ = '4' then
  
    for k in (select d.ND,
                     d.rnk,
                     d.CC_ID,
                     c.OKPO,
                     c.nmk,
                     substr(t.txt, 2, 1) as DP,
                     d.vidd,
                     d.sdate,
                     i.basem,
                     i.basey,
                     a.kv,
                     (select max(l.fdat)
                        from cc_lim l
                       where l.nd = d.nd
                         and fdat > l_dat2
                         and l.fdat <= l_dat1
                         and l.sumo > 0) pl_dat
                from cc_deal  d,
                     accounts    a, -- saldo a,
                     customer c,
                     int_accn i,
                     nd_acc   n,
                     nd_txt   t,
                     cc_add   da
               where (tip_ <= 2 and vidd in (1, 2, 3) or
                     tip_ = 3 and vidd in (11, 12, 13))
                 AND d.sos > 0
                 AND d.sos < 14
                 AND d.nd = n.nd
                 and n.acc = a.acc
                 and a.tip = 'LIM'
                 AND d.rnk = c.rnk
                 and da.nd = d.nd
                 and nvl(to_number(cck_app.get_nd_txt(d.ND, 'FREQP'),
                                   '99999999999D99',
                                   'NLS_NUMERIC_CHARACTERS = ''. '''),
                         da.freq) != 400
                 AND i.acc = a.acc
                 and i.id = 0
                 and d.nd = t.nd
                 and t.tag = 'FLAGS'
                 AND
                    -- ���������� ���� ��������� ���� ���������   -- �������� ���������� �������� ����  (����� ������� �� ������������� � ��������� ���� (���� ��� ���������� ������ ������� �� ����� -1 �����) - ��� � ����� ��������� ���� ��)
                     (cck_app.correctDate2(980,
                                           (case
                                             when cck_app.valid_date(cck_app.Pay_Day_SN_to_ND(d.nd) ||
                                                                     to_char(gl.bd, '/mm/yyyy')) <= gl.bd then
                                              cck_app.valid_date(cck_app.Pay_Day_SN_to_ND(d.nd) ||
                                                                 to_char(gl.bd, '/mm/yyyy'))
                                             else
                                              cck_app.valid_date(cck_app.Pay_Day_SN_to_ND(d.nd) ||
                                                                 to_char(add_months(gl.bd, -1), '/mm/yyyy'))
                                           end),
                                           /*nvl( to_number(    CCK_APP.GET_ND_TXT(d.nd,'DAYNP'),'99999999999D99', 'NLS_NUMERIC_CHARACTERS = ''. ''' ),
                                             to_number(NVL(GetGlobalOption('CC_DAYNP'),'1'),'99999999999D99', 'NLS_NUMERIC_CHARACTERS = ''. ''' )
                                           ) -- ��������� ������������ ��������/����������� 0/1 �����/������ �� ��������� ������
                                           */
                                           -- ������ ������ ������
                                           1) =
                     cck_app.correctDate2(980, gl.bd - 1, 0) -- ��������� ��������� ����
                     or /* cck_app.correctDate2(980,d.wdate,nvl( CCK_APP.GET_ND_TXT(d.nd,'DAYNP'),NVL(GetGlobalOption('CC_DAYNP'),'1')))=cck_app.correctDate2(980,gl.bd-1,nvl( CCK_APP.GET_ND_TXT(d.nd,'DAYNP'),NVL(GetGlobalOption('CC_DAYNP'),'1'))) */
                     -- ������ ������ ������
                     cck_app.correctDate2(980, d.wdate, 1) =
                     cck_app.correctDate2(980, gl.bd - 1, 1))
                    --  ���� ������� ��������� ������
                 and nvl(nvl(to_date(cck_app.get_nd_txt(d.ND, 'DATSN'),
                                     'dd/mm/yyyy'),
                             i.apl_dat),
                         d.sdate) <= cck_app.correctDate2(980, gl.bd - 1, 0)) loop
      -- ����� (������� ) ��������
      If k.vidd = 11 and k.basem = 1 and k.basey = 2 then
        begin
          -- �� ������ �� STA
          l_max     := null;
          l_ostc_sn := null;
          l_acc_sn  := null;
        
          -- ���� �� ���� �������� % ?
          select nvl(MAX(i.acr_dat), k.pl_dat - 1), max(i.acra)
            into l_Acr_dat, l_acc_sn
            from int_accn i, accounts a, nd_acc n
           where n.nd = k.nd
             and n.acc = a.acc
             and i.acc = a.acc
             and i.id = 0
             and a.tip = 'SS '
             and a.dazs is null
             and a.kv = k.kv;
          -- ���� �� ������� �� �� ���.% ?
          select abs(a.ostc)
            into l_ostc_sn
            from accounts a
           where a.acc = l_acc_sn
             and ostc < 0
             and ostc = ostb
             and a.tip = 'SN '
             and a.kv = k.kv;
          -- ���� ��� ������� ��-������, �� �.�. ����� ��� ���� >= ����� �� ��� , �.�. �������� �������� �� ����� ����� �� ���
        
          If k.pl_DAT <= l_Acr_dat then
            l_max := greatest(l_ostc_sn -
                              cck.FINT(k.ND, k.pl_DAT, l_Acr_dat),
                              0);
          else
            l_max := l_ostc_sn;
          End if;
          bars_audit.info('CCK_SBER 0 in ND = '||k.nd);
          cck.CC_ASPN_DOG(k.nd, k.cc_id, k.okpo, k.nmk, -3, l_max);
        
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            goto NexRec;
        end;
      
      elsif k.DP = 0 then
        -- �� ������� ���� (����� % ��������� �� ���������� ����)
        bars_audit.info('CCK_SBER 1 in ND = '||k.nd);
        cck.CC_ASPN_DOG(k.nd, k.cc_id, k.okpo, k.nmk, -3, null);
      else
        -- �� ������� �����
        bars_audit.info('CCK_SBER 2 in ND = '||k.nd);
        cck.CC_ASPN_DOG(k.nd, k.cc_id, k.okpo, k.nmk, -2, null);
      end if;
    
      <<NexRec>>
      null;
    
    end loop;
  
    Return;
  end if;

  -- ������������  ������ � �������� �� ��������� �� ��������� ������ ��  (��� ��������� ���� 25 �� �������� ������������ �� 31 �������� ������)
  if vid_ = 5 then
    for k in (select d.ND, d.CC_ID, c.OKPO, c.nmk, substr(t.txt, 2, 1) as DP
                from cc_deal  d,
                     accounts a,
                     customer c,
                     int_accn i,
                     nd_acc   n,
                     nd_txt   t,
                     cc_add   da
               where (tip_ <= 2 and vidd in (1, 2, 3) or
                     tip_ = 3 and vidd in (11, 12, 13))
                 AND d.sos > 0
                 AND d.sos < 14
                 AND d.nd = n.nd
                 and n.acc = a.acc
                 and a.tip = 'LIM'
                 AND d.rnk = c.rnk
                 and da.nd = d.nd
                 and nvl(to_number(cck_app.get_nd_txt(d.ND, 'FREQP'),
                                   '99999999999D99',
                                   'NLS_NUMERIC_CHARACTERS = ''. '''),
                         da.freq) != 400
                 AND i.acc = a.acc
                 and i.id = 0
                 and d.nd = t.nd
                 and t.tag = 'FLAGS'
                 AND to_char(gl.bd, 'yyyymmdd') >
                     to_char(cck.CorrectDate(980, gl.bd - 1, gl.bd - 2),
                             'yyyymm') ||
                     nvl((select lpad(txt, 2, '0')
                           from nd_txt
                          where nd = d.nd
                            and tag = 'DAYSN'),
                         to_char(lpad(i.s, 2, '0')))) loop
      if k.DP = 0 then
        cck.CC_ASPN_DOG(k.nd, k.cc_id, k.okpo, k.nmk, -3, null);
      else
        cck.CC_ASPN_DOG(k.nd, k.cc_id, k.okpo, k.nmk, -2, null);
      end if;
    end loop;
  end if;

  --
  /*
  �������� ����������� ���������� ���
  1   �� ������� (0 - �� ��������� ����  1 - ��������� )
  � - ���� ����  , min_dat - ��� ���� ����  max_dat �� ����
  
  select case when a.m=0 then case when :x between a.n1 and a.n2 then 1 else 0 end
                         else case when :x<=a.n2 or :x>=a.n1 then 1 else 0 end end as res
    from (select to_number(to_char(:min_dat,'dd')) as n1, to_number(to_char(:max_dat,'dd')) as n2,
          case when to_char(:min_dat,'mmyyyy')=to_char(:max_dat,'mmyyyy') then 0 else 1 end as m from dual) a
  
  2. �� ��������
  
  5 in
  (
  select to_char(:min_dat+level,'dd') num from dual
  connect by :min_dat+level <= :max_dat)
  
  
  */
  ---

end CCK_SBER;
/
