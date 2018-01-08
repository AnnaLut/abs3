

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_INV_CCK_FL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_INV_CCK_FL ***

  CREATE OR REPLACE PROCEDURE BARS.P_INV_CCK_FL (p_dat date, p_frm int, p_type int default 1) is

-- ============================================================================
--                    ������������������ ���������
--                          VERSION 26.0 (19/10/2012)
-- ============================================================================
/*
 ����� ��� ������������� ��������� �������� � ������ ���� ������� �� ���.�����
 p_dat  -- �� ����
 p_frm   -- �(1)/���(0) ����������������
 p_type -- ��� ��������� ��� ������: ������������ ��-������� (1)/ ����������� (0)

*/

  l_DAT01d_ date      ;
  Di_       number    ;   -- accm_calendar.caldt_id%type
  Dy_       number    ;   -- accm_calendar.caldt_id%type

  U_REZ_     int ; -- \ ���� � ���� �� ����������� ������� �������� �� ���� (��� ���������� ���������)
  D_REZ_     date; -- /
  U_REZ1_    int ; -- \ ���� � ���� �� ������������ ������� �������� �� ����� ������ (��� ����������� ���������)
  D_REZ1_    date; -- /
  U_REZ2_    int ; -- \ ���� � ���� �� ������������ ������� �������� �� ����� ����������� ������ (��� ���������� ���������)
  D_REZ2_    date; -- /
  l_rez_id   int;
  l_rez_dat  date;
  l_rez_id2  int;
  l_rez_dat2 date;
  l_dat      date := p_dat ;
  l_err      varchar2(25);

  dTmp_  date;
  nTmp_  int;
--==================

  --gg   INV_CCK_FL%rowtype; use this variable as gg.g01  -- Serg's comment

  G01_ INV_CCK_FL.G01%type; --01 ����� ��
  G02_ INV_CCK_FL.G02%type; --02 ��� �������� (�i��i�����)
  G03_ INV_CCK_FL.G03%type; --03 ����� ����
  G04_ INV_CCK_FL.G04%type; --04 �I� ������������
  G05_ INV_CCK_FL.G05%type; --05 I������i���i���� ��� ��
  G06_ INV_CCK_FL.G06%type; --06 ���� ������� �� ������ � �����i �����
  G07_ INV_CCK_FL.G07%type; --07 ������ �������
  G08_ INV_CCK_FL.G08%type; --08 � �������� �����
  G09_ INV_CCK_FL.G09%type; --09 ���� ���������� ������� �������
  G10_ INV_CCK_FL.G10%type; --10 ������� ���� ��������� (���������)
  G11_ INV_CCK_FL.G11%type; --11 ����� ���� ��������� � ����������� ���.���������i�
  G12_ INV_CCK_FL.G12%type; --12 ������ ��������������i� �������
  G13_ INV_CCK_FL.G13%type; --13 �i��-�� ��i������� ��������������i�
  G13a_ INV_CCK_FL.G13a%type; --13a �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�
  G13b_ INV_CCK_FL.G13b%type; --13b �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�
  G13v_ INV_CCK_FL.G13v%type; --13v �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�
  G13g_ INV_CCK_FL.G13g%type; --13g �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�
  G13d_ INV_CCK_FL.G13d%type; --13d �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�
  G13e_ INV_CCK_FL.G13e%type; --13e �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�
  G13j_ INV_CCK_FL.G13j%type; --13j �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�
  G13z_ INV_CCK_FL.G13z%type; --13z �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�
  G13i_ INV_CCK_FL.G13i%type; --13i �i��-�� ��i������� ��������������i� � ����i�i ���i� ��������������i�
  G14_ INV_CCK_FL.G14%type; --14 ���� ���������� �������, �� ��� �������� �� ����� ����, ����������� ������������ ������� �� �������� ������
  G15_ INV_CCK_FL.G15%type; --15 ���� ���������� �������, �� ��� �������� �� ����� ����, ����������� ������������ ������� �� ������������ ��������
  G16_ INV_CCK_FL.G16%type; --16 ���� �������� �������������i ������i����
  G17_ INV_CCK_FL.G17%type; --17 ������ i�������� ��i��� ������i������ KL_K061
  G18_ INV_CCK_FL.G18%type; --18 �i������ ��� ������� ������� i�������� �����
  G19_ INV_CCK_FL.G19%type; --19 ����� ��, �� ����� ���i�������� ������ �� ��i��� ����
  G20_ INV_CCK_FL.G20%type; --20 ������� � ����i������� �������
  G21_ INV_CCK_FL.G21%type; --21 ���� ������� �� ��i��� ���� � �����i �������
  G22_ INV_CCK_FL.G22%type; --22 ���� ������� � ���.�����i
  G23_ INV_CCK_FL.G23%type; --23 ���� ���������������� ��������
  G24_ INV_CCK_FL.G24%type; --24 ��� ���i�� �������������i �� ���������� ��������            00000000000000000000
  G25_ INV_CCK_FL.G25%type; --25 ���� �������.�����"����� �����������
  G26_ INV_CCK_FL.G26%type; --26 ���� �������.�����"����� ���������
  G27_ INV_CCK_FL.G27%type; --27 �i��� % ������
  G27e_ INV_CCK_FL.G27e%type;  --27e ��. % ������
  G28_ INV_CCK_FL.G28%type; --28 ���������i ���������i ������������i ������ (���.���� ������� ��� ������������<180 ��i�)
  G29_ INV_CCK_FL.G29%type; --29 ���������i ���������i ������������i ������ (���.���� ������������>180 ��i�)
  G30_ INV_CCK_FL.G30%type; --30 ���������i ����������i �� 31 ��� ������ (���.���� ������� ��� ������������<180 ��i�)
  G31_ INV_CCK_FL.G31%type; --31 ���������i ����������i �� 31 ��� ������ (���.���� ������������>180 ��i�)
  G32_ INV_CCK_FL.G32%type; --32 ���������i ����������i �i� 32 �� 60 ��i� ������ (���.���� ������� ��� ������������<180 ��i�)
  G33_ INV_CCK_FL.G33%type; --33 ���������i ����������i �i� 32 �� 60 ��i� ������ (���.���� ������������>180 ��i�)
  G34_ INV_CCK_FL.G34%type; --34 ���������� ��������� ������ ����� 60 ���
  G35_ INV_CCK_FL.G35%type; --35 ���� ������������ �� ����� ���� � ������ ������ (34 ��� ����� ������������� ��� KL_S031), ���
  G36_ INV_CCK_FL.G36%type; --36 ��i��� �i��������� ����� ������������ (����)
  G37_ INV_CCK_FL.G37%type; --37 �����i��i� ��������� ������� ������������
  G38_ INV_CCK_FL.G38%type; --38 ���� �������� ������ ���.�����
  G39_ INV_CCK_FL.G39%type; --39 �������i� ������ �������� ������i�
  G40_ INV_CCK_FL.G40%type; --40 �������������� ����� �������������
  G41_ INV_CCK_FL.G41%type; --41 ��� ������������  (��.� ������i������� KL_S031)
  G42_ INV_CCK_FL.G42%type; --42 ���������� ��� �������� �������
  G43_ INV_CCK_FL.G43%type; --43 �������� ���� ������������ �� ����� ���� ��� ���������� ������, ���.
  G44_ INV_CCK_FL.G44%type; --44 ���� ������������, �� �������� �� ���������� ������� ��� �i����������� �������� ����� �� ���������� ������i��� �����
  G45_ INV_CCK_FL.G45%type; --45 ���� �������������i, �� �������� �� ���������� ������� ��� �i����������� �������� ����� �� ���������� ������i��� ���
  G46_ INV_CCK_FL.G46%type; --46 ����i�i��� ������������ �� �������� ������ (%)
  G47_ INV_CCK_FL.G47%type; --47 ������������ ���� �������, ���.
  G48_ INV_CCK_FL.G48%type; --48 �������� ���������� ���� ������� �� ���-� ��������
  G49_ INV_CCK_FL.G49%type; --49 �������� ���������� ���� ������� �� ���-� ������� ������
  G50_ INV_CCK_FL.G50%type; --50 �i�������� ����  �������� ������������ ������� �i� ���� �������������� �������
  G51_ INV_CCK_FL.G51%type; --51 �������i� ��������, ��i ����������� �����i��� ������������� ����������
  G52_ INV_CCK_FL.G52%type; --52 ���� ������������ ������� �� ������������� ����.������i���
  G53_ INV_CCK_FL.G53%type; --53 ���� �������� ������������ ������� �� ������������� ����.������i���
  G54_ INV_CCK_FL.G54%type; --54 ���������i��� �� ����i����i� �����
  G55_ INV_CCK_FL.G55%type; --55 �i����� ����������� ������� (������������ �� ��������, ������� ����i������ �����)
  G56_ INV_CCK_FL.G56%type; --56 ���� �������� ���������i� �������
  G57_ INV_CCK_FL.G57%type; --57 �� ����� 891, �� ����� ���i��������� ���� �����.�� �������.�����i� �� ��������, �� �� ������ �������i
  G58_ INV_CCK_FL.G58%type; --58 ���� �����.�� �������.�����i� �� ��������, �� �� ������ �������i
  G59_ INV_CCK_FL.G59%type; --59 �������� �������� ����� (��������� ����� � ������)
  G60_ INV_CCK_FL.G60%type; --60 ���� �������� ���������������� �������
  G61_ INV_CCK_FL.G61%type; --61 �������� ���������� ���� ������� ��� ������������ �������� ����� �� ��������������� �����'�������� (���. 3690), ���
  G62_ INV_CCK_FL.G62%type; --62 ������� ���������� ������� (1-������, 2-г����� ���������)

  G101_ INV_CCK_FL.G101%type; --101 ���� ������� ������������� �� ������ �� ������� ����, ���.
  G102_ INV_CCK_FL.G102%type; --102 ���� ������� ������������� �� ������ �� ������� ����, ���.
  G103_ INV_CCK_FL.G103%type; --103 ��� ���������� ��������
  G104_ INV_CCK_FL.G104%type; --104 ���� ����������� ������������� �� ������������ �������
  G105_ INV_CCK_FL.G105%type; --105 ���� ���������� ����� �� ������� � ��������� ����, ���.
  G106_ INV_CCK_FL.G106%type; --106 ���� ���������� �������� �� �������� � ��������� ����, ���.
  G107_ INV_CCK_FL.G107%type; --107 ������ ������������ ����� �� ����, ���.
  --G108_ INV_CCK_FL.G108%type; --108 ���� �������� ������� ����������

  acc_SS   int;
  acc_ZAL  int;
  acc_pot  int;
  l_acc_sp int;
  l_acc_ss  accounts.acc%type;
  l_acc9129 accounts.acc%type;
  l_s270    specparam.s270%type;
  l_s370    specparam.s370%type;
  l_nd      cc_deal.nd%type;
  l_r013_n  specparam.r013%type;
  l_s270_n  specparam.s270%type;
  l_s370_n  specparam.s370%type;
  l_title   varchar2(20) := 'CCK P_INV_CCK_FL:'; -- ��� �����������
  fd_       varchar2(10) := 'DD.MM.YYYY';  -- ������ ���
  l_count_s031  number;
  l_G28_    INV_CCK_FL.G28%type;
  l_G29_    INV_CCK_FL.G29%type;
  l_G30_    INV_CCK_FL.G30%type;
  l_G31_    INV_CCK_FL.G31%type;
  l_G32_    INV_CCK_FL.G32%type;
  l_G33_    INV_CCK_FL.G33%type;
  l_G34_    INV_CCK_FL.G34%type;
  l_G41_    INV_CCK_FL.G41%type;
 -- l_G47_    INV_CCK_FL.G47%type;
 -- l_G48_    INV_CCK_FL.G48%type;
 -- l_G49_    INV_CCK_FL.G49%type;
  l_time_start   varchar2(20);
  l_time_start1  varchar2(20);
  l_time_start2  varchar2(20);
  l_time_start3  varchar2(20);
  l_time_start4  varchar2(20);
  l_time_start5  varchar2(20);
  l_time_finish  varchar2(20);

  -- ���������� �� ���������� (������ B8)
  se_       number;
  ost_      number;
  s1_       number;
  s2_       number;
  s3_       number;
  sr013_    number;
  sr013_60  number;
  l_newnbs number;

  l_usedwh    char(1);        -- ������������� �������� � ���
  l_errmsg    varchar2(500);  -- ���������
  l_errcode   number;          -- ��� ����������

begin

    l_newnbs := NEWNBS.GET_STATE;
   --
   -- �������� �� ����������� ��������� ���. ���������
   -- ����������� ������ ��� ��� � ���� �������� �������� � ���
   --
   begin
      select val into l_usedwh from params$global  where par = 'CCKDWH';

      if l_usedwh = '1' then
         bars.bars_dwhcck.check_import_status(
                 p_date        => p_dat,
                 p_daymon_flag => p_type,
                 p_errmsg      => l_errmsg,
                 p_retcode     => l_errcode);

         if l_errcode <> 0 then
            raise_application_error(-20079,l_errmsg );
         end if;

      end if;
   exception when no_data_found then l_usedwh := '0';
   end;

  select to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') into l_time_start from dual;
  bars_audit.trace('%s TIME_Start: l_time_start=%s',l_title, l_time_start);
  bars_audit.trace('%s 0.����� �������������� �� ��. ��.���-��:l_dat=%s, p_frm=%s, p_type=%s',l_title, to_char(l_dat), to_char(p_frm), to_char(p_type));

 -- ���� ���������� ������������ �����:
 -- �����������
 -- Begin
 --  bars_accm_sync.sync_agg('MONBAL', to_date('29/04/2011','dd/mm/yyyy'),0);
 -- End;
 -- ����������
 -- Begin
 --  bars_accm_sync.sync_snap('BALANCE', to_date('29/04/2011','dd/mm/yyyy'), 0);
 -- End;

----------------------------------

  -- ��� ����������� ���������  ����� � �������� ���� ����������� ������ �� ����� ������
  if p_type = 1 then
    begin /*  ���� � ���� �� ������������ ������� �������� */
      select p.USERID, p.DAT  into U_REZ1_, D_REZ1_
        from REZ_PROTOCOL p
       where p.dat = l_dat
       and exists (select 1 from TMP_REZ_RISK where DAT = p.DAT and id = p.USERID);
    EXCEPTION WHEN NO_DATA_FOUND THEN
        begin
           select id, dat into U_REZ1_, D_REZ1_ from rez_form f
            where dat = l_dat and dat_form = (select max(dat_form) from rez_form where dat = f.dat);
        EXCEPTION WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20077,'�� �������� ������ �������� �� ���� '||to_char(l_dat,'dd/mm/yyyy') );
         return;
	end;
    end;

  -- ��� ���������� ���������  ����� � �������� ���� ��������� ������ �� ��������� ���� (��� ����� ������� � ���)
  elsif p_type = 0 then
    begin
         /*  ���� � ���� �� ������������ ������� �������� �� ������� �����*/
         select p.USERID, p.DAT  into U_REZ2_, D_REZ2_
           from REZ_PROTOCOL p
          where p.dat = (select max(dat) from rez_protocol where to_char(dat,'MM') = to_char(add_months(l_dat, -1),'MM'))
          and exists (select 1 from TMP_REZ_RISK where DAT = p.DAT and id = p.USERID);

	     /*  ���� � ���� �� ���������� ������� �������� */
              begin
                -- ������� ������� � ���������
 	          select p.userid, p.dat  into u_rez_, d_rez_
                    from rez_protocol p
                    where p.dat = l_dat
                      and exists (select 1 from tmp_rez_risk where dat = p.dat and id = p.userid);
              exception when no_data_found then
                 -- ���� �� ����� ������� �� tmp_rez_risk ����� ������� � ���
                  select id, dat
                    into u_rez_, d_rez_
                    from (select p.id, p.dat
                            from tmp_rez_risk p
                           where p.dat =  (select max(dat)
                                             from tmp_rez_risk
                                            where dat <= l_dat)
                          group by p.id, p.dat
                          order by p.id desc )
                   where rownum = 1;
              end;

    EXCEPTION WHEN NO_DATA_FOUND THEN
           begin
             select id, dat  into U_REZ2_, D_REZ2_
	       from rez_form f
	      where dat = (select max(dat) from  TMP_REZ_RISK where to_char(dat,'MM') = to_char(add_months(l_dat, -1),'MM'))
                and dat_form = (select max(dat_form) from rez_form where dat = f.dat);
          EXCEPTION WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR (-20077,'�� �������� ������ �������� �� ���� '||to_char(add_months( last_day(l_dat), -1),'dd/mm/yyyy') );
            return;
	   end;
    end;

  end if;

-- ������������� ���� �� ������ ������
  if p_type = 1 then
    l_dat := D_REZ1_; -- ���� ������������ �������
  end if;

 -- Id ���.����
  if p_type = 1 then
    l_DAT01d_ := add_months( (last_day(l_dat)+1), -1); --01 ����� ���������   ������
  elsif p_type = 0 then
    l_DAT01d_ := l_dat; --������� ����
  end if;

  select caldt_ID into Di_ from accm_calendar where caldt_DATE = l_DAT01d_;

  select caldt_ID into Dy_ from accm_calendar where caldt_DATE = trunc(l_dat,'Y');

   bars_audit.trace('%s 1.���� ������ l_dat=%s, ���� ������������ ������� D_REZ1_=%s, ���� ������� ������� D_REZ_=%s, D_REZ2_=%s, Di_=%s',l_title, to_char(l_dat),
                     to_char(D_REZ1_), to_char(D_REZ_), to_char(D_REZ2_), to_char(Di_));

  -- �������� ���� � pul, ���� ����� ��� ��������� ������� ������� ���� ����������� � ������
  PUL.Set_Mas_Ini( 'sFdat1', to_char(l_dat,'dd/mm/yyyy'), '���.sFdat1' );

  /*p_frm = 0 - ��� ���������������� */
  if nvl(p_frm,0) = 0  then
     begin
       select 1 into nTmp_ from INV_CCK_FL where G00 = l_dat and GT = p_type and rownum = 1;
       return;
     exception when no_data_found then null;
     end;
  end if;

   -- ������������� ����/����� �� ������� �������� ��� ���������� ���������
   select decode(p_type,1,U_REZ1_,U_REZ_) into l_rez_id from dual;
   select decode(p_type,1,D_REZ1_,D_REZ_) into l_rez_dat from dual;
   select decode(p_type,1,U_REZ1_,U_REZ2_) into l_rez_id2 from dual;
   select decode(p_type,1,D_REZ1_,D_REZ2_) into l_rez_dat2 from dual;

   bars_audit.trace('%s 1.l_rez_id=%s, l_rez_dat=%s, l_rez_id2=%s, l_rez_dat2=%s',l_title, to_char(l_rez_id), to_char(D_REZ1_), to_char(l_rez_dat),
                      to_char(l_rez_id2), to_char(l_rez_dat2));

  -- �������� ��� �� ��������� ����
  delete from INV_CCK_FL where G00 = l_dat and GT = p_type;
  delete from INV_CCK_FL_BPKK where G00 = l_dat and GT = p_type;

  --������ �� ��
for k in
     ( select d.nd,c.OKPO, d.wdate, d.obs, nvl(d.fin,c.crisk) crisk, d.cc_id, a.kv, c.NMK,
           a.acc,d.SDOG, c.PRINSIDER , d.PROD, d.branch, a.tip, c.rnk, d.kf, a.ob22, a.daos, a.ostc, a89.acc accc
      from cc_deal d, customer c, accounts a, nd_acc n, accounts a89
     where d.vidd in (11,12,13) and d.sos >= 10
       and d.rnk = c.rnk
       and d.nd  = n.nd
       and n.acc = a.acc
       and a.tip in ('SS ','SP ','SL ')
       and (a.dazs is null or a.dazs > l_dat) and a.daos <= l_dat
       and a.accc = a89.acc
       and a89.tip = 'LIM' and a89.nbs = '8999'
       and (a89.dazs is null or a89.dazs > l_dat) and a89.daos <= l_dat
       --and d.nd in ( 15195, 17930, 58046)  -- �������!!!!!!!
       UNION  -- ��������� �� ��, � ������� ��� ����, � ������ %%
       select d.nd,c.OKPO, d.wdate, d.obs, nvl(d.fin,c.crisk) crisk, d.cc_id, a.kv, c.NMK,
           a.acc,d.SDOG, c.PRINSIDER , d.PROD, d.branch, a.tip, c.rnk, d.kf, a.ob22, a.daos, a.ostc,
           ( select a8.acc from accounts a8, nd_acc n8 where a8.acc=n8.acc and n8.nd=d.nd and a8.tip='LIM') accc
      from cc_deal d, customer c, accounts a, nd_acc n
     where d.vidd in (11,12,13) and d.sos >= 10
       and d.rnk = c.rnk
       and d.nd  = n.nd
       and n.acc = a.acc
       and a.tip in ('SPN', 'SLN')
       and (a.dazs is null or a.dazs > l_dat) and a.daos <= l_dat
       and d.nd not in
                          ( select d.nd
                              from cc_deal d, accounts a, nd_acc n
                             where d.vidd in (11,12,13) and d.sos >= 10
                               and d.nd  = n.nd
                               and n.acc = a.acc
                               and a.tip in ('SS ','SP ','SL ')
                               and (a.dazs is null or a.dazs > l_dat) and a.daos <= l_dat )
       UNION  -- ��������� �� ��, � ������� ��� ����, � ������ 9129
       select d.nd,c.OKPO, d.wdate, d.obs, nvl(d.fin,c.crisk) crisk, d.cc_id, a.kv, c.NMK,
           a.acc,d.SDOG, c.PRINSIDER , d.PROD, d.branch, a.tip, c.rnk, d.kf, a.ob22, a.daos, a.ostc,
           ( select a8.acc from accounts a8, nd_acc n8 where a8.acc=n8.acc and n8.nd=d.nd and a8.tip='LIM') accc
      from cc_deal d, customer c, accounts a, nd_acc n
     where d.vidd in (11,12,13) and d.sos >= 10
       and d.rnk = c.rnk
       and d.nd  = n.nd
       and n.acc = a.acc
       and a.tip in ('CR9')
       and decode(p_type,1,SNP.fost(a.acc,di_,1,8),SNP.fost(a.acc,di_,0,8))<>0
       and (a.dazs is null or a.dazs > l_dat) and a.daos <= l_dat
       and d.nd not in
                          ( select d.nd
                              from cc_deal d, accounts a, nd_acc n
                             where d.vidd in (11,12,13) and d.sos >= 10
                               and d.nd  = n.nd
                               and n.acc = a.acc
                               and a.tip in ('SS ','SP ','SL ')
                               and (a.dazs is null or a.dazs > l_dat) and a.daos <= l_dat )
      )
----------------------
loop
   -- �������� ����������
   G01_ := null;
   G02_ := null;
   G03_ := null;
   G04_ := null;
   G05_ := null;
   G06_ := 0;
   G07_ := null;
   G08_ := null;
   G09_ := null;
   G10_ := null;
   G11_ := null;
   G12_ := null;
   G13_ := 0;
   G14_ := null;
   G15_ := null;
   G16_ := null;
   G17_ := 0;
   G18_ := null;
   G19_ := null;
   G20_ := null;
   G21_ := 0;
   G22_ := 0;
   G23_ := 0;
   G24_ := null;
   G25_ := 0;
   G26_ := 0;
   G27_ := 0;
   G27e_ := null;
   G28_ := 0;
   G29_ := 0;
   G30_ := 0;
   G31_ := 0;
   G32_ := 0;
   G33_ := 0;
   G34_ := 0;
   G35_ := 0;
   G36_ := null;
   G37_ := null;
   G38_ := null;
   G39_ := null;
   G40_ := null;
   G41_ := null;
   G42_ := null;
   G43_ := 0;
   G44_ := 0;
   G45_ := 0;
   G46_ := 0;
   G47_ := 0;
   G48_ := 0;
   G49_ := 0;
   G50_ := 0;
   G51_ := null;
   G52_ := 0;
   G53_ := 0;
   G54_ := null;
   G55_ := null;
   G56_ := null;
   G57_ := 0;
   G58_ := 0;
   --G59_ := null;  - ��������������� �� �����. �������� ��� ������ ������ ������ � ��� ������� ������� k.nd
   G60_ := null;
   G61_ := 0;
   G62_ := null;

   G101_ := 0;
   G102_ := 0;
   G103_ := null;
   G104_ := null;
   G105_ := 0;
   G106_ := 0;
   G107_ := 0;
   --G108_ := null;

   l_s270 := null;
   l_s370 := null;
   l_r013_n := null;
   l_s270_n := null;
   l_s370_n := null;

   l_nd := 0;
--   l_G47_ :=0;
--   l_G48_ :=0;
--   l_G49_ :=0;
   l_G41_ :=null;

----------------
   -- ��� ������������ ������ ��� ���������
   l_err := '��: �� � '||k.nd;

   --01 ������������ ���������
   select name into G01_ from branch where branch = '/'||k.kf||'/';

   --02 ������
   G02_ := k.kf;

   --03 ���������
   G03_ := k.branch;

   bars_audit.trace('%s 2.���.���=%s:G01_=%s,G02_=%s,G03_=%s',l_title,to_char(k.nd),to_char(G01_),to_char(G02_),to_char(G03_));

   --04 ������������ ��������
   G04_ := k.NMK;

   --05 OKPO
   G05_ := k.OKPO;

   -- ������� acc "�������", � ������ �������� ����� ������ ������������� ��������
   begin
    select min(a.acc) into acc_pot from accounts a, nd_acc na where a.tip = 'SS ' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
          and decode(p_type,1,SNP.fost(a.acc,di_,1,8),SNP.fost(a.acc,di_,0,8))<>0 and a.acc=na.acc and na.nd=k.nd;
    if acc_pot is null then
       select min(a.acc) into acc_pot from accounts a, nd_acc na where a.tip in ('SS ','SP ','SL ') and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
          and decode(p_type,1,SNP.fost(a.acc,di_,1,8),SNP.fost(a.acc,di_,0,8))<>0 and a.acc=na.acc and na.nd=k.nd;
       if acc_pot is null then
            select min(a.acc) into acc_pot from accounts a, nd_acc na where a.tip in ('SS ','SP ','SL ') and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
                and a.acc=na.acc and na.nd=k.nd and a.daos = (select min(a.daos)
	                                                        from accounts a, nd_acc na
	     		   				       where a.tip in ('SS ','SP ','SL ') and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
                                                                 and a.acc=na.acc and na.nd=k.nd) ;
            if acc_pot is null then
               select min(a.acc) into acc_pot from accounts a, nd_acc na where a.tip in ('SPN','SLN') and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
                  and decode(p_type,1,SNP.fost(a.acc,di_,1,8),SNP.fost(a.acc,di_,0,8))<>0 and a.acc=na.acc and na.nd=k.nd;
              if acc_pot is null then
                 select min(a.acc) into acc_pot from accounts a, nd_acc na where a.tip in ('SPN','SLN') and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
                   and a.acc=na.acc and na.nd=k.nd;
               if acc_pot is null then
                   select a.acc into acc_pot from accounts a, nd_acc na where a.tip in ('CR9') and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
                      and decode(p_type,1,SNP.fost(a.acc,di_,1,8),SNP.fost(a.acc,di_,0,8))<>0 and a.acc=na.acc and na.nd=k.nd;
               end if;
              end if;
            end if;
	end if;
     end if;
   end;

   --06 ����� �� �������� � ������ ��������
   G06_ := k.SDOG;

   --07 ������ ��������
   G07_ := k.KV;

   --08  � ��������
   G08_ := k.CC_ID;

   bars_audit.trace('%s 3.���.���=%s:acc_pot=%s,G04_=%s,G05_=%s,G06_=%s,G07_=%s,G08_=%s',
                      l_title,to_char(k.nd),to_char(acc_pot),to_char(G04_),to_char(G05_),to_char(G06_),to_char(G07_),to_char(G08_));

   --09 ���� ����������� ������ ������� (� �������� �� - ���� ������)
   --   !!! �� ����� ��� ������ �������� �� saldoa, ��� ��� ����� ������� - ���� ����� �� �����
   select to_char(wdate,fd_) into G09_ from cc_add where nd = k.nd;

   --10 ����������� ���� ��������� (��������������)';
   begin
    select to_char(mdate,fd_) into G10_ from cc_prol where nd = k.ND and npp = 0;
   exception when no_data_found then null;
   end;

   --11 ����������� ���� ��������� � ������ ��������� �����������' - ���� ����������� �� ���� - �����;
   begin
     select mdate into dTmp_ from cc_prol where npp = ( select max(npp)
                                                          from cc_prol
							 where fdat <= l_dat and npp>0
							   and nd = k.nd
							   and mdate is not null
							  group by nd) and nd = k.nd and rownum = 1;
   exception when no_data_found then dTmp_ := null;
   end;

   if G10_ =  to_char(dTmp_,fd_) or G10_ > to_char(dTmp_,fd_) then  G11_ := null;
   else G11_ := to_char(dTmp_,fd_);
   end if;

   bars_audit.trace('%s 4.���.���=%s:G09_=%s,G10_=%s,G11_=%s',
                      l_title,to_char(k.nd),to_char(G09_),to_char(G10_),to_char(G11_));

   -- 12,13 - ������ �� ����������������
   -- cck_restr - ������� ������� ������ ���������������� ���������� �� ����
   select count(*) into G13_ from cck_restr where nd = k.nd and fdat <= l_dat;

   -- ���� ���������������� �� ���� - ������� "���" (2), ����� - "������������������" (1)
   select decode(G13_,0, '2', '1') into G12_ from dual;

   -- cck_restr - ������� ������� ����������� �� ����� ����
   -- 1 ��������������_� � ������_ ������ �������� ����� (SS) �� �����.�����_�(SN ����) - ��_�� ���� �������
   -- 2 ��������������_� � ������_ ������ �������� ����� (SS)
   -- 3 ��������������_� � ������_ ������ �����.�����_�(SN ����)
   -- 4 ��_������� ���� �������
   -- 5 ��_������� ���� �������
   -- 6 ��_������� �_�������� ������
   -- 7 ��_������� �_����� ���� (���������_�)
   -- 8 ��_����� ��� ��� ��_�� ������� ����_���_�
   -- 9 ��_�� ������ �����'������
   -- 10 ���_���������� �������
   -- 11 ��_�� ���� ������������ � ���������� � ������������ ������ ��������������� �_������ ��_�
   -- 12 ��_�� �������� ������������ ��� ��������� �  ������������ ������ ��������������� �_������ ��_�
   -- 13 ��������������_� ����������� �������������_
   -- 14 �������������� �� ���������� ������ ������������
    -----------------------------------
   /*
   13� ��_�� ���� ������� �� ������� (� ��������� �_����� �������� �� ���_������ ����_�)
   13� ���������_� �������
   13� ��_�� ����_�� ��������� �������
   13� ��_�� ������ �����������
   13� ���_���������� �������
   13� ��_�� ���� ������������ � ���������� � ������������ ������ ��������������� �_������ ��_�
   13� ��������������_� ����������� �������������_
   13� ��_�� �������� ������������ ��� ��������� �  ������������ ������ ��������������� �_������ ��_�
   13i �������������� �� ���������� ������ ������������
   */

   select  sum(decode(vid_restr, 1, 1, 0)),  sum(decode(vid_restr, 7, 1, 0)),  sum(decode(vid_restr, 8, 1, 0)),
           sum(decode(vid_restr, 9, 1, 0)), sum(decode(vid_restr, 10, 1, 0)), sum(decode(vid_restr, 11, 1, 0)),
          sum(decode(vid_restr, 13, 1, 0)), sum(decode(vid_restr, 12, 1, 0)), sum(decode(vid_restr, 14, 1, 0))
     into   G13a_, G13b_, G13v_,
            G13g_, G13d_, G13e_,
            G13j_, G13z_, G13i_
     from cck_restr
    where nd = k.nd and fdat <= l_dat;

 /*  select count(*) into G13a_
     from cck_restr
    where nd = k.nd and fdat <= l_dat and vid_restr = 1;

   select count(*) into G13b_
     from cck_restr
    where nd = k.nd and fdat <= l_dat and vid_restr = 7;

   select count(*) into G13v_
     from cck_restr
    where nd = k.nd and fdat <= l_dat and vid_restr = 8;

   select count(*) into G13g_
     from cck_restr
    where nd = k.nd and fdat <= l_dat and vid_restr = 9;

   select count(*) into G13d_
     from cck_restr
    where nd = k.nd and fdat <= l_dat and vid_restr = 10;

   select count(*) into G13e_
     from cck_restr
    where nd = k.nd and fdat <= l_dat and vid_restr = 11;

   select count(*) into G13j_
     from cck_restr
    where nd = k.nd and fdat <= l_dat and vid_restr = 13;

   select count(*) into G13z_
     from cck_restr
    where nd = k.nd and fdat <= l_dat and vid_restr = 12;

   select count(*) into G13i_
     from cck_restr
    where nd = k.nd and fdat <= l_dat and vid_restr = 14;     */

     bars_audit.trace('%s 5.���.���=%s:G12_=%s,G13_=%s', l_title,to_char(k.nd),G12_,to_char(G13_));

   --14 ���� ���������� �������, �� ��� �������� �� ����� ����, ����������� ������������ ������� �� �������� ������
   -- ���� �� ���.���������, ���� ����� - ��� ��������� ���������� ���������� ������� ����� ��������
   begin
     select decode(k.tip, 'SP ', to_char(to_date(substr(f_get_nd_txt(k.ND, 'DATSP', l_dat),1,10),fd_),fd_),null)
       into G14_
       from dual
      where k.tip = 'SP ' and decode(p_type, 1, SNP.fost(k.acc,DI_,1,7), SNP.fost(k.acc,DI_,0,7))<>0;
    if G14_ is null then
      begin
        select  decode(k.tip,'SP ',to_char(max(fdat),fd_),null)
          into G14_
          from saldoa
         where ostf = 0 and fdat <= l_dat and dos > 0
           and acc in (select n.acc from nd_acc n, accounts a
                        where a.acc = n.acc and n.nd = k.ND and a.tip = 'SP ')
           and decode(p_type, 1, SNP.fost(k.acc,DI_,1,7), SNP.fost(k.acc,DI_,0,7))<>0;
      if G14_ is null then
          begin  -- ��������� ��� �������� ��������
            select  decode(k.tip,'SP ',to_char(min(fdat),fd_),null)
              into G14_
              from saldoa
             where ostf <> 0 and fdat <= l_dat and dos = 0 and kos = 0
               and acc in (select n.acc from nd_acc n, accounts a
                            where a.acc = n.acc and n.nd = k.ND and a.tip = 'SP ')
               and decode(p_type, 1, SNP.fost(k.acc,DI_,1,7), SNP.fost(k.acc,DI_,0,7))<>0;
          EXCEPTION WHEN NO_DATA_FOUND THEN G14_ := null;
          end;
      end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN G14_ := null;
      end;
    end if;
   exception when no_data_found then G14_ := null;
   end;

   if to_date(G14_,fd_) > nvl(to_date(G11_,fd_),to_date(G10_,fd_)) then  G14_ := nvl(G11_,G10_); end if;

   --15 ���� ���������� �������, �� ��� �������� �� ����� ����, ����������� ������������ ������� �� ������������ ��������
   begin
     select  decode(k.tip,'SP ',to_char(max(fdat),fd_),null)
       into G15_
       from saldoa
      where ostf = 0 and fdat <= l_dat and dos > 0
        and acc in (select n.acc from nd_acc n, accounts a
                     where a.acc = n.acc and n.nd = k.ND and a.tip = 'SPN'
                       and decode(p_type, 1, SNP.fost(a.acc,DI_,1,7), SNP.fost(a.acc,DI_,0,7))<>0 );
     if G15_ is null then
          begin  -- ��������� ��� �������� ��������
            select  decode(k.tip,'SP ',to_char(min(fdat),fd_),null)
              into G15_
              from saldoa
             where ostf <> 0 and fdat <= l_dat and dos = 0 and kos = 0
               and acc in (select n.acc from nd_acc n, accounts a
                            where a.acc = n.acc and n.nd = k.ND and a.tip = 'SPN'
                              and decode(p_type, 1, SNP.fost(a.acc,DI_,1,7), SNP.fost(a.acc,DI_,0,7))<>0);
          EXCEPTION WHEN NO_DATA_FOUND THEN G15_ := null;
          end;
     end if;
   exception when no_data_found then G15_ := null;
   end;

   if to_date(G15_,fd_) > nvl(to_date(G11_,fd_),to_date(G10_,fd_)) then  G15_ := nvl(G11_,G10_); end if;

   --16 ���� �������� �������������i ������i����
   -- ���� ��� ���� ��������� �� ������������, ���� �� ��� - �� �� ���.��������� NOHOP
   begin
     select to_char(to_date(substr(f_get_nd_txt(k.ND, 'NOHOP',l_dat),1,10),fd_),fd_) into G16_ from dual;
    if G16_ is null then
      begin
        select decode(k.tip,'SL ',to_char(max(fdat),fd_),null)
          into G16_
          from saldoa
         where ostf = 0 and fdat <= l_dat and dos > 0
           and acc in (select n.acc from nd_acc n, accounts a
                        where a.acc = n.acc and n.nd = k.ND and a.tip = 'SL ');
      EXCEPTION WHEN NO_DATA_FOUND THEN G16_ := null;
      end;
    end if;
   end;

   bars_audit.trace('%s 6.���.���=%s:G14_=%s,G15_=%s,G16_=%s',l_title,to_char(k.nd),to_char(G14_),to_char(G15_),to_char(G16_));

   --17 ������ _�������� ��_��� ������_������ KL_K061
   select prinsiderlv1 into G17_ from prinsider where prinsider = nvl(k.prinsider,2);

   --18 �i������ ��� ������� ������� i�������� �����
   -- ��� ������ ��������� ��� ��������� ��� �����������
   if G17_ = 1 then
        select substr(f_get_nd_txt(k.ND, 'AUTOR',l_dat),1,250) into G18_ from dual;
   end if;

   bars_audit.trace('%s 7.���.���=%s:rnk=%s,G17_=%s,G18_=%s',l_title,to_char(k.nd),to_char(k.rnk),to_char(G17_),to_char(G18_));

   --19 ����� ���.�����
   begin
     select accs into ACC_SS
       from cc_add ca, accounts a
      where ca.nd = k.nd and ca.adds = 0 and ca.accs = a.acc and (a.dazs is null or a.dazs > l_dat) and a.daos <= l_dat;
   exception when no_data_found then  ACC_SS := k.acc;
   end;

   select nbs  into G19_ from accounts where acc = k.acc;

    --20 ������� � ����?������� �������
   G20_ := k.ob22;

   --21 ����������� ������� ������������� � ������ ��������';
   if k.tip in ('SS ','SP ','SL ') then
     if p_type = 1 then
          G21_ := -(SNP.fost(k.acc,DI_,1,7)/100);
     elsif p_type = 0  then
          G21_ := -(SNP.fost(k.acc,DI_,0,7)/100);
     end if;
   else G21_ := 0;
   end if;

   --22 ����������� ������� ������������� � ������������ ������';
   if k.tip in ('SS ','SP ','SL ') then
     if p_type = 1 then
          G22_ := -(SNP.fost(k.acc,DI_,1,8)/100);
     elsif p_type = 0  then
          G22_ := -(SNP.fost(k.acc,DI_,0,8)/100);
     end if;
   else G22_ := 0;
   end if;

   --23 ���� ���������������� �������� �� ��i��� ����

   begin
   select -decode(k.acc,acc_pot, decode (p_type, 1,
                                         SUM(nvl( SNP.fost(a.acc,DI_,1,8) ,0)/100), SUM(nvl( SNP.fost(a.acc,DI_,0,8) ,0)/100)), 0) into G23_
     from accounts a, nd_acc na
    where a.tip = 'SDI' and a.acc = na.acc and na.nd = k.nd
      and (dazs is null or dazs > l_dat) and a.daos <= l_dat;
   exception when no_data_found then G23_ := 0;
   end;

   bars_audit.trace('%s 8.���.���=%s:G19_=%s,G20_=%s,G21_=%s,G22_=%s,G23_=%s',
                      l_title,to_char(k.nd),to_char(G19_),to_char(G20_),to_char(G21_),to_char(G22_),to_char(G23_));

   --24 ��� ���_�� �������������_ �� ���������� ��������
   begin
     select nd
       into l_nd
       from nd_acc na, accounts a
      where na.acc = a.acc and na.nd = k.nd
        and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
        and  decode(p_type, 1, SNP.fost(a.acc,DI_,1,7), SNP.fost(a.acc,DI_,0,7))<>0
        and a.tip = 'SS ' and rownum = 1;
         begin
           select 3 into G24_
             from nd_acc na, accounts a
            where na.acc = a.acc and na.nd = k.nd
              and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
              and  decode(p_type, 1, SNP.fost(a.acc,DI_,1,7), SNP.fost(a.acc,DI_,0,7))<>0
              and a.tip = 'SP ' and rownum = 1;
         exception when no_data_found then G24_ := 1;
         end;
   exception when no_data_found then G24_ := 2;
   end;

   --25 9129 � ��� ��� �� ����� ���� ������ �� ���� (9129 � ob22=01,10);
   begin
   select a.acc into l_acc9129
     from accounts a, nd_acc n
    where n.nd = k.ND and a.acc = n.acc and a.nbs = '9129' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat and a.ob22 in ('01','10');
      select -decode(k.acc, acc_pot, decode (p_type, 1,
                  nvl(SNP.fost (l_acc9129,DI_,1,8),0)/100, nvl(SNP.fost (l_acc9129,DI_,0,8),0)/100 ), 0)
        into G25_
        from dual;
   exception when no_data_found then G25_ := 0;
             when others then
                 if (sqlcode = -1422) then
		          RAISE_APPLICATION_ERROR (-20078,'� �������� ��� = '||to_char(k.ND)||' ������������ ����� ������ ����� 9129. ����������� � ��������� ����������������!' );
			  return;
		 else raise;
		 end if;
   end;

   --26 9129 � ��� ��� ������� (9129 � ob22=03,5,7,11)
   begin
   select a.acc into l_acc9129
     from accounts a, nd_acc n
    where n.nd = k.ND and a.acc = n.acc and a.nbs = '9129' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat and a.ob22 in ('03','05','07','11');
      select -decode(k.acc, acc_pot, decode (p_type, 1,
                  nvl(SNP.fost (l_acc9129,DI_,1,8),0)/100, nvl(SNP.fost (l_acc9129,DI_,0,8),0)/100 ), 0)
        into G26_
        from dual;
   exception when no_data_found then G26_ := 0;
             when others then
                 if (sqlcode = -1422) then
		          RAISE_APPLICATION_ERROR (-20078,'� �������� ��� = '||to_char(k.ND)||' ������������ ����� ������ ����� 9129. ����������� � ��������� ����������������!' );
			  return;
		 else raise;
		 end if;
   end;


   bars_audit.trace('%s 9.���.���=%s:G24_=%s,G25_=%s,G26_=%s',
                      l_title,to_char(k.nd),to_char(G24_),to_char(G25_),to_char(G26_));

   --27 ����������� c����� (% �������)
    select nvl(acrn.fprocn(k.acc,0,l_dat),0)  into G27_  from dual;

   --27e ����������� c����� (% �������)
    select acrn.fprocn(k.accc,-2,l_dat)  into G27e_  from dual;

   --28 R020(2208,2218,2228,2238) � S270(01,07),S370(0,I)

   --29       R020(2208,2218,2228,2238) � S270(08)
   --    ���  R020(2208,2218,2228,2238) � S270(01,07),S370(J)

     for ss in ( select a.acc
           	   from accounts a, nd_acc n
        	  where n.nd = k.ND and a.acc = n.acc and a.tip = 'SN ' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat )
  	  loop

              bars_audit.trace('%s 10-0.���.���=%s:ss.acc=%s',l_title,to_char(k.nd),to_char(ss.acc));

  	     l_s270 := null;
  	     l_s370 := null;
  	     l_G28_ := 0;
  	     l_G29_ := 0;
             -- s270, s370 ����� ����� �� ��������
             -- ���������� ������� ���������� f_get_s370, � ��� �������� l_s270
	     -- (���� � �������� �� ������ �� ����� (f_get_rez_specparam � ����� ������� ���������� NULL) - ��� ������������)
             select f_get_s270_n(l_dat,
                                       f_get_specparam( 's270' , f_get_rez_specparam( 's270', ss.acc, l_rez_dat, l_rez_id ), ss.acc, l_dat ),
	                                                                                                                                     ss.acc, k.nd)
               into l_s270 from dual;

	     select f_get_s370(l_dat, f_get_specparam( 's370' , f_get_rez_specparam( 's370', ss.acc, l_rez_dat, l_rez_id ), ss.acc, l_dat ),
	                                                                                                                                     ss.acc, k.nd)
               into l_s370 from dual;

             bars_audit.trace('%s 10-1.���.���=%s:ss.acc=%s', l_title,to_char(k.nd),to_char(ss.acc));

	     -- ������ �� ���������  S270, S370 ������� ����� �� ����� SN
	     -- 28  S270(01,07), S370(0,I)
	        begin
                 select nvl(- decode (p_type, 1, sum(SNP.fost (ss.acc,DI_,1,8))/100,
		                                 sum(SNP.fost (ss.acc,DI_,0,8))/100 ) , 0)
                   into l_G28_
                   from dual
                  where l_s270 in ('01', '07')
                    and l_s370 in ('0', 'I');
	        exception when no_data_found then l_G28_ := 0;
	        end;
	        G28_ := G28_ + l_G28_;

                bars_audit.trace('%s 10-2.���.���=%s:l_G28_=%s,G28_=%s', l_title,to_char(k.nd),to_char(l_G28_),to_char(G28_));

	     -- 29  S270(08)  ���  S270(01,07), S370(J)
	        begin
                 select nvl(- decode (p_type, 1, sum(SNP.fost (ss.acc,DI_,1,8))/100,
		                                 sum(SNP.fost (ss.acc,DI_,0,8))/100 ) , 0)
                   into l_G29_
                   from dual
                  where l_s270 in ('08')
                     or
	           (    l_s270 in ('01', '07')
	            and l_s370 in ('J') );
	        exception when no_data_found then l_G29_ := 0;
	        end;
	        G29_ := G29_ + l_G29_;

-- ����� ������� ���� ������, ��� ����, ���� ��������� ��� � ��������, ���������� �������� � ��� ��� 22_2, 22_3, 22_7, 22_8, 22_9,
-- ������� ���� � ������, �� �� ������ � ���.
-- ��� ����� ��� ����� ����� acc ���� ������.
-- Acc ������  22_2, 22_3, 22_7 - ����� � ����  INV_CCK_FL.ACC.
-- Acc ������ 22_8, 22_9 ��� ��� ����� ������ � INV_CCK_FL.ACC2208, �.�. ������������������ ������������ (���� 2208 ����).
-- ��� �� �.�. ������ 2208 ����� ���� ��������� - ����� ������ ������������ �������� �� ��������� �������.
-- ����� ����� �������������, ���� ����� ���� � ������, �����  INV_CCK_FL.ACC, �����  INV_CCK_FL.ACC2208, �����  TMP_INV_2208.ACC

            -- ��������� ������������ ACC ������ SN
	    INSERT INTO TMP_INV_2208 (ACC) VALUES (ss.acc);
  	  end loop;

   select decode(k.acc, acc_pot, G28_, 0) into G28_ from dual;
   select decode(k.acc, acc_pot, G29_, 0) into G29_ from dual;

   bars_audit.trace('%s 10.���.���=%s:G27_=%s,G27e_=%s,G28_=%s,G29_=%s', l_title,to_char(k.nd),to_char(G27_),to_char(G27e_),to_char(G28_),to_char(G29_));

------------
     -- 30-34

     -- ��� ������ �������
     G30_ := 0;
     G31_ := 0;
     G32_ := 0;
     G33_ := 0;
     G34_ := 0;

     for l in ( select a.acc, a.nls, a.kv
                  from accounts a, nd_acc n
                 where n.nd=k.ND and a.acc=n.acc and a.tip in ('SPN','SLN') and (a.dazs is null or a.dazs>l_dat) )
      loop
       -- �������� �����.����������
         l_r013_n := null;
         l_s270_n := null;
         l_s370_n := null;
         l_G30_ := 0;
         l_G31_ := 0;
         l_G32_ := 0;
         l_G33_ := 0;
         l_G34_ := 0;

       -- ������� ��������� �� ���������:
         --r013
         select nvl( f_get_specparam( 'r013',
	                                     f_get_rez_specparam( 'r013', l.acc, l_rez_dat, l_rez_id ),
					                                                               l.acc, l_dat ), 0)
	   into l_r013_n from dual;
	 --s270
         select f_get_s270_n(l_dat,
	                           f_get_specparam( 's270' , f_get_rez_specparam( 's270', l.acc, l_rez_dat, l_rez_id ), l.acc, l_dat ) ,
				                                                                                                         l.acc, k.nd)
	   into l_s270_n from dual;
         --s370
         select f_get_s370(l_dat,
	                          f_get_specparam( 's370' , f_get_rez_specparam( 's370', l.acc, l_rez_dat, l_rez_id ), l.acc, l_dat ) ,
				                                                                                                         l.acc, k.nd)
	   into l_s370_n from dual;

         -- ������� �� ����� ����
	 select nvl(decode (p_type, 1, SNP.fost (l.acc,DI_,1,8), SNP.fost (l.acc,DI_,0,8)),0) into se_ from dual;

         bars_audit.trace('%s 11-1.���.���=%s:l_r013_n=%s,l_s270_n=%s,l_s370_n=%s,se_=%s',
                           l_title,to_char(k.nd),to_char(l_r013_n),to_char(l_s270_n),to_char(l_s370_n),to_char(se_));
	 -- !!!!! ���� �� ���������� !!!!!!
	 if l_r013_n in ('0','1','2') and se_ <> 0 then
              -- ������� �� 31 ���� �����
              sr013_ := gl.p_icurval(l.kv,otcn_pkg.f_GET_R013(l.acc, l_dat),l_dat);

              -- ��������� ����� �� �������� � dat_-60 �� dat_-31 (29 ����)
              SELECT NVL (SUM (o.s), 0)
                INTO ost_
                FROM opldok o, oper p, ref_back r
               WHERE o.acc = l.acc
                 AND o.fdat > l_dat - 60
                 AND o.fdat <= l_dat - 31
                 AND o.sos = 5
                 AND o.dk = 0
                 AND p.REF = o.REF
                 and p.REF = r.ref(+)
                 --��������� �������� ������
                 and o.tt <> 'BAK'
                 --��������� �������� ������� ���� ������������, ���� ���� ������������� ������ ��������
                 and nvl(r.dt,to_date('01014000','ddmmyyyy')) >  l_dat;

              ost_ := gl.p_icurval(l.kv, ost_, l_dat);

              sr013_60 := se_ + (abs(se_)-abs(sr013_)) + ost_;

              bars_audit.trace('%s 11-2.���.���=%s:ost_=%s,sr013_60=%s', l_title,to_char(k.nd),to_char(ost_),to_char(sr013_60));

         else
              sr013_ := 0;
              sr013_60 := 0;
              ost_ := 0;
              s1_ := 0;
              s2_ := 0;
              s3_ := 0;

              bars_audit.trace('%s 11-2.���.���=%s:sr013_=%s', l_title,to_char(k.nd),to_char(sr013_));

         end if;

         -- ������ ����������� �������� ��������������:
         if l_r013_n in ('0','1') and se_ <> 0 and sr013_ < 0 and abs(sr013_)<abs(se_)
         then
            if se_<>0 and sr013_60 <> 0 and sr013_60 < 0 and
	       abs(sr013_60) < abs(sr013_)
            THEN
               s3_ := abs(sr013_60);
               s2_ := abs(sr013_)-abs(sr013_60);
               s1_ := abs(se_)-abs(sr013_);
               bars_audit.trace('%s 11-3.���.���=%s:s3_=%s,s2_=%s,s1_=%s', l_title,to_char(k.nd),to_char(s3_),to_char(s2_),to_char(s1_));
            end if;

            if ABS(sr013_)-ABS(sr013_60)=0 and sr013_60<>0 and sr013_60<0 then
               s3_ := abs(sr013_);
               s2_ := 0;
               s1_ := abs(se_)-abs(sr013_);
               bars_audit.trace('%s 11-4.���.���=%s:s3_=%s,s2_=%s,s1_=%s', l_title,to_char(k.nd),to_char(s3_),to_char(s2_),to_char(s1_));
            end if;

            if ABS(sr013_)-ABS(sr013_60)<0 and sr013_60<>0 and sr013_60<0 then
               s3_ := 0;
               s2_ := abs(sr013_);
               s1_ := abs(se_)-abs(sr013_);
               bars_audit.trace('%s 11-5.���.���=%s:s3_=%s,s2_=%s,s1_=%s', l_title,to_char(k.nd),to_char(s3_),to_char(s2_),to_char(s1_));
            end if;

            if sr013_60 >= 0 then
               s3_ := 0;
               s2_ := abs(sr013_);
               s1_ := abs(se_)-abs(sr013_);
               bars_audit.trace('%s 11-6.���.���=%s:s3_=%s,s2_=%s,s1_=%s', l_title,to_char(k.nd),to_char(s3_),to_char(s2_),to_char(s1_));
            end if;
         else
             if l_r013_n in ('0','1','2') and ABS(se_)=ABS(sr013_) and sr013_<>0 and
                sr013_ < 0
             then
                if se_<>0 and sr013_60 < 0 and abs(sr013_60) < abs(sr013_) THEN
                   s3_ := abs(sr013_60);
                   s2_ := abs(sr013_)-abs(sr013_60);
                   s1_ := 0;
                   bars_audit.trace('%s 11-31.���.���=%s:s3_=%s,s2_=%s,s1_=%s', l_title,to_char(k.nd),to_char(s3_),to_char(s2_),to_char(s1_));
                end if;

                if se_<>0 and sr013_60 < 0 and abs(sr013_60) > abs(sr013_) THEN
                   s3_ := 0;
                   s2_ := abs(sr013_);
                   s1_ := 0;
                   bars_audit.trace('%s 11-41.���.���=%s:s3_=%s,s2_=%s,s1_=%s', l_title,to_char(k.nd),to_char(s3_),to_char(s2_),to_char(s1_));
                end if;

                if se_<>0 and sr013_60 < 0 and abs(sr013_60) = abs(sr013_) THEN
                   s3_ := abs(sr013_);
                   s2_ := 0;
                   s1_ := 0;
                   bars_audit.trace('%s 11-51.���.���=%s:s3_=%s,s2_=%s,s1_=%s', l_title,to_char(k.nd),to_char(s3_),to_char(s2_),to_char(s1_));
                end if;

                if se_<>0 and sr013_60 >= 0 THEN
                   s3_ := 0;
                   s2_ := abs(sr013_);
                   s1_ := 0;
                   bars_audit.trace('%s 11-61.���.���=%s:s3_=%s,s2_=%s,s1_=%s', l_title,to_char(k.nd),to_char(s3_),to_char(s2_),to_char(s1_));
                end if;
             else
                if l_r013_n = '0' then
                   l_r013_n := '1';
                end if;

                if l_r013_n = '3' then
                   s3_ := ABS(se_);
                   s2_ := 0;
                   s1_ := 0;
                elsif l_r013_n = '2' then
                   s3_ := 0;
                   s2_ := ABS(se_);
                   s1_ := 0;
                else
                   s3_ := 0;
                   s2_ := 0;
                   s1_ := ABS(se_);
                end if;
             end if;
		 end if;

             --31   R020(2209,2219,2229,2239)  � R013(1),S270(08)
             -- ��� R020(2209,2219,2229,2239) � R013(1),S270(01,07),S370(J)
             --30 R020(2209,2219,2229,2239) � R013(1),S270(01,07),S370(0,I)
	     if l_s270_n in ('01', '07') and l_s370_n in ('0', 'I')
	     then
            l_G30_ := s1_;
            l_G32_ := s2_;
         elsif l_s270_n in ('08') or ( l_s270_n in ('01', '07') and l_s370_n in ('J') )
         then
            l_G31_ := s1_;
            l_G33_ := s2_;
         end if;

         l_G34_ := s3_;
            bars_audit.trace('%s 11-11.���.���=%s:l_G30_=%s,l_G31_=%s,l_G32_=%s,l_G33_=%s,l_G34_=%s',
                           l_title,to_char(k.nd),to_char(l_G30_),to_char(l_G31_),to_char(l_G32_),to_char(l_G33_),to_char(l_G34_));

         G30_ := G30_ + l_G30_;
         G31_ := G31_ + l_G31_;
         G32_ := G32_ + l_G32_;
         G33_ := G33_ + l_G33_;
         G34_ := G34_ + l_G34_;

        -- ��������� ������������ ACC ������ SPN, SLN
        INSERT INTO TMP_INV_2208 (ACC) VALUES (l.acc);
      end loop;

     select decode(k.acc,acc_pot,G30_,0)/100,decode(k.acc,acc_pot,G31_,0)/100,decode(k.acc,acc_pot,G32_,0)/100,
            decode(k.acc,acc_pot,G33_,0)/100,decode(k.acc,acc_pot,G34_,0)/100
       into G30_, G31_, G32_, G33_, G34_
       from dual;

                   bars_audit.trace('%s 11-12.���.���=%s:G30_=%s,G31_=%s,G32_=%s,G33_=%s,G34_=%s',
                           l_title,to_char(k.nd),to_char(G30_),to_char(G31_),to_char(G32_),to_char(G33_),to_char(G34_));


   --35 ���� ������������ �� ����� ���� � ������ ������ (34 ��� ����� ������������� ��� KL_S031), ���

       begin
         select decode(k.acc,acc_pot,nvl( decode (p_type, 1, sum(SNP.fost (a.acc,DI_,1,8))/100,
		                                 sum(SNP.fost (a.acc,DI_,0,8))/100 ) , 0),null)
           into G35_
           from accounts a, cc_accp z, cc_pawn c, pawn_acc pa
          where z.accs = ACC_SS and z.acc = a.acc and a.nbs = '9031' and a.tip='ZAL' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
	    and a.acc = pa.acc and pa.pawn = c.pawn and c.s031 = 34;
       EXCEPTION WHEN NO_DATA_FOUND THEN G35_ := 0;
       end;

   --36 ��?��� �?��������� ����� ������������ (����)
   --40 ������������ �����
   begin
     select decode(fin,1,'�',2,'�',3,'�',4,'�','�') , OBS
     into G36_, G40_
     from TMP_REZ_RISK
     where acc = k.acc  and id = l_rez_id and dat = l_rez_dat and fl_newacc<>'i';
   EXCEPTION WHEN NO_DATA_FOUND THEN
     if nvl(k.crisk,1)= 1 then G36_ := '�';
     elsIf k.crisk    = 2 then G36_ := '�';
     elsIf k.crisk    = 3 then G36_ := '�';
     elsIf k.crisk    = 4 then G36_ := '�';
     else                      G36_ := '�';
     end if;
     G40_:= k.obs;
   end;

   --39 �������?� ������ �������� ������?�
   begin
     select s080
     into G39_
     from TMP_REZ_RISK
     where acc = k.acc  and id = l_rez_id and dat = l_rez_dat and fl_newacc<>'i';
   EXCEPTION WHEN NO_DATA_FOUND THEN
     begin
       select s080 into G39_ from specparam_update
        where acc = k.acc and idupd=(select max(idupd) from specparam_update where acc = k.acc and fdat<=l_dat);
     EXCEPTION WHEN NO_DATA_FOUND THEN
       begin
         select a.acc into l_acc_sp from accounts a, nd_acc n where a.tip = 'SP ' and a.acc = n.acc and n.nd = k.nd and rownum = 1;
         select s080
           into G39_
           from TMP_REZ_RISK
          where acc = l_acc_sp  and id = l_rez_id and dat = l_rez_dat and fl_newacc<>'i';
       EXCEPTION WHEN NO_DATA_FOUND THEN
         begin
           select s080 into G39_ from specparam_update
           where acc = l_acc_sp and idupd = (select max(idupd) from specparam_update where acc=l_acc_sp and fdat<=l_dat);
         EXCEPTION WHEN NO_DATA_FOUND THEN G39_:= '1';
         end;
       end;
     end;
   end;

   --37 - �����i��i� ��������� ������� ������������
   begin
    select substr(f_get_nd_txt(k.ND, 'VNCRR', l_dat),1,3) into G37_ from dual;
   EXCEPTION WHEN NO_DATA_FOUND THEN G37_:= null;
   end;

   --38 - ���� �������� ��_��� �_�.�����
   begin
     select distinct(nvl(to_char(fact_date,'dd/mm/yyyy'),null)) into G38_
       from cc_sob
      where nd   = k.nd
        and psys = 7
        and otm  = 6
        and fdat = (select max(fdat)
                      from cc_sob
                     where fdat <= l_dat
                       and psys = 7
                       and otm = 6
                       and nd = k.nd);
   EXCEPTION WHEN NO_DATA_FOUND THEN G38_:= null;
   end;

   bars_audit.trace('%s 12.���.���=%s:G36_=%s,G37_=%s,G38_=%s,G39_=%s,G40_=%s',
                      l_title,to_char(k.nd),to_char(G36_),to_char(G37_),to_char(G38_),to_char(G39_),to_char(G40_));
/*
   --41 ��� ������������  (��?��� � ������?������� KL_S031) - ���� ����� ����������� ��������� - �������� 40, ����� - ��� ����������� �� ��������������

   -- ���������� ���-�� ����� ����������� �� ��������
   begin
     select count(coun) into l_count_s031
       from (select count(z.acc) coun, c.s031 vid
               from cc_accp z, accounts a, cc_pawn c, pawn_acc pa
              where z.accs = ACC_SS and z.acc = a.acc and a.nbs like '9%' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
                and a.acc = pa.acc and pa.pawn = c.pawn
              group by c.s031 );
     if l_count_s031  = 0 then G41_:= null;
     -- ���� ��� ���� - ����� ��� s031
     elsif l_count_s031 = 1 then
        begin
          select c.s031 into G41_
               from cc_accp z, accounts a, cc_pawn c, pawn_acc pa
              where z.accs = ACC_SS and z.acc = a.acc and a.nbs like '9%' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat
                and a.acc = pa.acc and pa.pawn = c.pawn and rownum = 1;
        exception when no_data_found then G41_ := null;
        end;
     -- ���� ����� ��������� - ����� 40
     else G41_ := '40';
     end if;
   EXCEPTION WHEN NO_DATA_FOUND THEN G41_:= null;
   end;

   -- ��������� ��� �������, ��� �������  G41_ = 40(���������) ���� 34(������ ������) ������ �������� �� �����,
   -- � ��� ��� ������ ���� ���������� - ������� �� ��������, ��������� ��� �������

   begin
     select nvl(pawn,0) into l_G41_
       from TMP_REZ_RISK
      where acc = k.acc and id = l_rez_id and dat = l_rez_dat and fl_newacc<>'i';
   exception when no_data_found then null;
   end;

   if l_G41_ <> '0' and G41_ <> '40' and G41_ <> '34' and l_G41_ <> G41_ then G41_ := l_G41_; end if;       */

   --41 ��� ������������  (��?��� � ������?������� KL_S031) - ������ ����� ������ �� ��������

   begin
     select nvl(pawn,'') into G41_
       from TMP_REZ_RISK
      where acc = k.acc and id = l_rez_id and dat = l_rez_dat and fl_newacc<>'i';
   exception when no_data_found then null;
   end;

   --42 ���������� ��� �������� �������
   begin
     select to_number(trim(f_get_nd_txt(k.ND, 'ZASTC',l_dat))) into G42_ from dual;
    if G42_ is null then
     begin
       select value into G42_
       from accountsw
       where acc = ACC_ZAL and tag = 'PAWNPAWN' and kf = k.kf;
     EXCEPTION WHEN NO_DATA_FOUND THEN G42_ := null;
     end;
    end if;
   end;

 /*  --����� ������� �� 9129 (�� ���� ��������� � ���. 47-49 � ������ acc_pot)
   begin
      select nvl(SUM(decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,decode(p_type,1,D_REZ1_,D_REZ_)))/100),0)
        into l_G47_
        from TMP_REZ_RISK t
       where acc in (select a.acc
                       from accounts a, nd_acc n
                      where n.nd = k.ND and a.acc = n.acc and a.nbs = '9129' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat)
         and t.id = l_rez_id and t.dat = l_rez_dat and nvl(t.s080,0)<'9' and fl_newacc<>'i';
   exception when no_data_found then l_G47_ := 0;
   end;

   begin
      select nvl(SUM(decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,decode(p_type,1,D_REZ1_,D_REZ2_)))/100),0)
        into l_G48_
        from TMP_REZ_RISK t
       where acc in (select a.acc
                       from accounts a, nd_acc n
                      where n.nd = k.ND and a.acc = n.acc and a.nbs = '9129' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat)
         and t.id = l_rez_id2 and t.dat = l_rez_dat2 and nvl(t.s080,0) = '1' and fl_newacc<>'i';
   exception when no_data_found then l_G48_ := 0;
   end;

   begin
      select nvl(SUM(decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,decode(p_type,1,D_REZ1_,D_REZ2_)))/100),0)
        into l_G49_
        from TMP_REZ_RISK t
       where acc in (select a.acc
                       from accounts a, nd_acc n
                      where n.nd = k.ND and a.acc = n.acc and a.nbs = '9129' and (a.dazs is null or a.dazs>l_dat) and a.daos <= l_dat)
         and t.id = l_rez_id2 and t.dat = l_rez_dat2 and nvl(t.s080,0) <> '1' and nvl(t.s080,0) < '9' and fl_newacc<>'i';
   exception when no_data_found then l_G49_ := 0;
   end;       */


   --43 �������� ���� ������������ �� ����� ���� ��� ���������� ������, ���.
   --44 ���� ������������, �� �������� �� ���������� ������� ��� �?����������� �������� ����� �� ���������� ������?��� �����, ���.';
   --45 ���� �������������?, �� �������� �� ���������� ������� ��� �?����������� �������� ����� �� ���������� ������?��� �����, ���.
   --46 ����?�?��� ������������ �� �������� ������ (%)
   --47 ������������ ���� ������� ��� �?����������� �������� ����� �� ���������� ������?��� �����, ���.
   begin
      select nvl(t.obesp,0), LEAST(nvl(t.soq,0), nvl(t.skq2,0))/100, nvl(t.srq,0)/100, t.pr_rez,
             t.szq/100
        into G43_, G44_, G45_, G46_, G47_
        from TMP_REZ_RISK t
        where t.acc = k.acc and t.id = l_rez_id2 and t.dat = l_rez_dat2 and t.s080<'9' and fl_newacc<>'i';
   exception when no_data_found then G43_ := 0; G44_ := 0; G45_ := 0; G46_ := 0; G47_ := 0;
   end;

   bars_audit.trace('%s 13.���.���=%s:G41_=%s,G43_=%s,G44_=%s,G45_=%s,G46_=%s,G47_=%s',
                      l_title,to_char(k.nd),to_char(G41_),to_char(G43_),to_char(G44_),to_char(G45_),to_char(G46_),to_char(G47_));

   --48  �������� ���������� ���� ������� �� ������� ��������
   -- � TMP_REZ_RISK ����  sznq - �����, �� ���������� � ��������� ����. �� ���� ��� - �� ������� ������. �  szq - ����� ����� ������� �� ����� �����.
  begin
   select nvl(nvl(t.szq,0) - nvl(t.sznq,0),0)/100
     into G48_
     from TMP_REZ_RISK t
    where t.acc = k.acc and t.id = l_rez_id2 and t.dat = l_rez_dat2 and fl_newacc<>'i';
  exception when no_data_found then G48_ := 0;
  end;

   --49  �������� ���������� ���� ������� �� ������� ������� ������
  begin
   select nvl(t.sznq,0)/100
     into G49_
     from TMP_REZ_RISK t
    where t.acc = k.acc and t.id = l_rez_id2 and t.dat = l_rez_dat2  and fl_newacc<>'i';
  exception when no_data_found then G49_ := 0;
  end;

 /*  -- ��� �������� ������ ����������� � 47-49 ���. ������� �� 9129
   if k.acc = acc_pot then
      G47_ := G47_ + l_G47_;
      G48_ := G48_ + l_G48_;
      G49_ := G49_ + l_G49_;
   end if;   */

   --50  �?�������� ����  �������� ������������ ������� �?� ���� �������������� �������
   G50_ := G47_ - (G48_ + G49_);

   bars_audit.trace('%s 14.���.���=%s:G48_=%s,G49_=%s,G50_=%s',l_title,to_char(k.nd),to_char(G48_),to_char(G49_),to_char(G50_));

   --51 �������?� ��������, ��? ����������� �����?��� ������������� ����������
   begin
    select substr(f_get_custw_h (k.rnk, 'CHORN', l_dat),1,1) into G51_ from dual;
     EXCEPTION WHEN NO_DATA_FOUND THEN G51_:= null;
   end;

   --52 ������������ ���� ������� ����������? �� ����?��?����
   G52_ := G30_ + G31_ + G32_ + G33_ + G34_;

   --53 ���� �������� ������������ ������� �� ������������� ����.������i���
  begin
   select  decode(k.acc,acc_pot, sum(t.szq/100),0)
   into G53_
   from TMP_REZ_RISK t, nd_acc n
   where n.nd = k.ND and n.acc = t.acc
     and substr(t.nls,1,4) in (select nbs from srezerv_ob22 where nbs_rez = '2400' and ob22_rez in ('19','20','37','38'))
     and t.id = l_rez_id2 and t.dat = l_rez_dat2 and fl_newacc<>'i';
  exception when no_data_found then G53_ := 0;
  end;

   bars_audit.trace('%s 15.���.���=%s:G51_=%s,G52_=%s,G53_=%s',
                         l_title,to_char(k.nd),to_char(G51_),to_char(G52_),to_char(G53_));

   --54 ���������?��� �� ����?����?� �����
   begin
         select substr(f_get_custw_h (k.rnk, 'WORKB', l_dat),1,1) into G54_ from dual;
      EXCEPTION WHEN NO_DATA_FOUND THEN G54_:= 0;
   end;

   --55 �?����� ����������� ������� (������������ �?���� �� ��������, ������� ����?������ �����)
   If G54_>0 then
        select substr(f_get_nd_txt(k.ND, 'W_AIM',l_dat),1,2) into G55_ from dual;
   end if;

  --56 ���� �������� ���������?� �������
  select to_char(max(fdat),FD_) into G56_ from cc_prol
  where nd = k.ND and npp>0 and mdate is not null
    and fdat <= l_dat;

   bars_audit.trace('%s 16.���.���=%s:G54_=%s,G55_=%s,G56_=%s',
                         l_title,to_char(k.nd),to_char(G54_),to_char(G55_),to_char(G56_));

   -- 57 �� ����� 891, �� ����� ���i��������� ���� �����.�� �������.�����i� �� ��������, �� �� ������ �������i

   begin
   select decode(k.acc,acc_pot,
                 a.nls , null) into G57_
     from accounts a, nd_acc na
    where a.tip = 'S9N' and a.acc = na.acc and na.nd = k.nd
      and (dazs is null or dazs > l_dat) and a.daos <= l_dat;
   exception when no_data_found then G57_ := 0;
   end;

   --58 ���� �����.�� �������.�����i� �� ��������, �� �� ������ �������i

   begin
   select -decode(k.acc, acc_pot, nvl( decode (p_type, 1, SNP.fost (a.acc,DI_,1,8)/100, SNP.fost (a.acc,DI_,0,8)/100), 0), 0)
     into G58_
     from accounts a, nd_acc na
    where a.tip='S9N' and a.acc=na.acc and na.nd=k.nd
      and (dazs is null or dazs>l_dat) and a.daos <= l_dat;
   exception when no_data_found then G58_ := 0;
   end;

   bars_audit.trace('%s 17.���.���=%s:G57_=%s,G58_=%s',
                      l_title,to_char(k.nd),to_char(G57_),to_char(G58_));

   --60 ���� �������� ���������������� �������
   begin
      select to_char(max(fdat),fd_) into G60_ from cck_restr where nd = k.nd and fdat <= l_dat;
   exception when no_data_found then G60_ := null;
   end;

   --61 �������� ���������� ���� ������� ��� ������������ �������� ����� �� ��������������� �����'�������� (���. 3690), ���
  begin
   select decode(k.acc,acc_pot, t.szq/100,0)
   into G61_
   from TMP_REZ_RISK t, nd_acc n
   where n.nd = k.ND and n.acc = t.acc
     and substr(t.nls,1,4) in (select nbs from srezerv_ob22 where nbs_rez = '3690')
     and t.id = l_rez_id2 and t.dat = l_rez_dat2 and fl_newacc<>'i';
  exception when no_data_found then G61_ := 0;
  end;

   --62 ������� ���������� ������� (1-������, 2-г����� ���������)
   select decode(vid, 4, 1, 2) into G62_
     from accounts
    where acc = k.accc;

   --101 ����������� ������� ������������� � ������������ ������ �� ������ ����';
   if k.tip in ('SS ','SP ','SL ') then  G101_ := -(SNP.fost(k.acc,DI_,1,2)/100);
   else G101_ := 0;
   end if;

   --102 ����������� ������� �� %% � ������������ ������ �� ������ ����';
   select -decode(k.acc, acc_pot, nvl(sum(SNP.fost(a.acc,DI_,1,2)/100),0), 0)
     into G102_
     from accounts a, nd_acc n
    where n.nd = k.ND and a.acc = n.acc and a.tip in ('SN ', 'SPN', 'SLN') and (a.dazs is null or a.dazs>trunc(l_dat,'Y')) and a.daos <= trunc(l_dat,'Y');

   --103 ��� ��������
   G103_ := k.prod;

   --104 ���� ����������� ������������� �� ������������ �������
   begin
        select to_char(min(fdat),fd_)
          into G104_
          from saldoa
         where ostf = 0 and fdat <= l_dat and dos > 0
           and acc in (select n.acc from nd_acc n, accounts a
                        where a.acc = n.acc and n.nd = k.ND and a.tip = 'S9N');
   EXCEPTION WHEN NO_DATA_FOUND THEN G104_ := null;
   end;

   --105 ���� ���������� ����� �� ������� � ��������� ����, ���.
   select decode(sign(G101_ - G22_), -1, 0, G101_ - G22_) into G105_ from dual;

   --106 ���� ���������� �������� �� �������� � ��������� ����, ���.
   select decode(sign(G102_ - G28_ - G29_ - G30_ - G31_ - G32_ - G33_ - G34_), -1, 0, G102_ - G28_ - G29_ - G30_ - G31_ - G32_ - G33_ - G34_) into G106_ from dual;

   --107 ������ ������������ ����� �� ����, ���.
   G107_ := null;

   --108 ���� �������� ������� ���������� -- ���� �� ���.��������� "���� �������� ������-�i ������i����", ��� ����� ���� ��������
   --G108_ := to_char(cck_app.get_nd_txt(k.nd,'NOHOP'),fd_);

----------==========================
 -- ��������� � INV_CCK_FL ������ �� �� � ��������� GR = 'C'
 begin
      insert into INV_CCK_FL
      (G01 , G02 , G03 , G04 , G05 , G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
       G13 , G13a, G13b, G13v, G13g, G13d, G13e, G13j, G13z, G13i,
       G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
       G25 , G26 , G27 , G27e, G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
       G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
       G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62 ,
       G00, GT, GR, ACC, RNK, ACC9129,
       G101, G102, G103, G104, G105, G106, G107) --, G108)
       values
       (G01_, G02_, G03_, G04_, G05_, G06_, G07_, G08_, G09_, G10_, G11_, G12_,
        G13_, G13a_, G13b_, G13v_, G13g_, G13d_, G13e_, G13j_, G13z_, G13i_,
        G14_, G15_, G16_, G17_,  G18_, G19_, G20_, G21_, G22_, G23_, G24_,
        G25_, G26_, G27_, G27e_, G28_, G29_, G30_, G31_, G32_, G33_, G34_, G35_, G36_,
        G37_, G38_, G39_, G40_, G41_, G42_, G43_, G44_, G45_, G46_, G47_, G48_,
        G49_, G50_, G51_, G52_, G53_, G54_, G55_, G56_, G57_, G58_, k.nd, G60_, G61_, G62_,
        l_dat, p_type, 'C', k.acc, k.rnk, l_acc9129,
        G101_, G102_, G103_, G104_, G105_, G106_, G107_); --, G108_);
 exception when dup_val_on_index then null;
 end;

 --insert into INV_CCK_FL values gg;  -- Serg's comment

 <<HET>> null;

END LOOP;

--------------------------!!!!!!!!!!!!!!!!! ��� �����������!!!!!!!!!!!!!!!!!--------------------------
bars_audit.trace('%s 18-1.��������� ������ �� ��� �� �����������.',l_title);

   -- ��� ������������ ������ ��� ���������
   l_err := '���: ';

select to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') into l_time_start3 from dual;
bars_audit.trace('%s TIME_3: l_time_start3=%s',l_title, l_time_start3);

  insert into INV_CCK_FL
  (G01 , G02 , G03 , G04 , G05 , G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
   G25 , G26 , G27 , G27e, G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62 ,
   G00 , GT, GR, ACC, RNK, ACC2208, ACC9129)
  (
-- ��� 2202, 2203, � ������� ������� � �������� ���������� (����� 0)
  select b.name G01, a.kf G02, a.branch G03, substr('��� '||c.nmk,1,70) G04, c.okpo G05, 0 G06,
       a.kv G07, ba.nd G08, to_char(get_dat_first_turn(ba.acc_ovr),fd_) G09,
       null G10, null G11, null G12, 0 G13, null G14, 0 G15, null G16, p.prinsiderlv1 G17, null G18, a.nbs G19, a.ob22 G20,
       decode(p_type,1,-SNP.fost(a.acc,DI_,1,7),-SNP.fost(a.acc,DI_,0,7))/100 G21,
       decode(p_type,1,-SNP.fost(a.acc,DI_,1,8),-SNP.fost(a.acc,DI_,0,8))/100 G22, 0 G23, null G24,
       decode(s.ob22,'01',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)),
                         '10',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)), 0) G25,
       decode(s.ob22,'03',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)),
                         '05',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)),
                         '07',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)),
			 '11',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)), 0) G26,
       nvl(acrn.fprocn(ba.acc_ovr,0,l_dat),0) G27,
       null G27e,
     --  -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100 G28, 0 G29,
       case
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('01', '07')
            then
               case
                 when f_get_s370(l_dat,f_get_specparam('s370',f_get_rez_specparam('s370',ba.acc_2208,l_rez_dat,l_rez_id),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('0', 'I')
                   then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
                 else 0
               end
         else 0
       end G28,
       case
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('01', '07')
            then
               case
                 when f_get_s370(l_dat,f_get_specparam('s370',f_get_rez_specparam('s370',ba.acc_2208,l_rez_dat,l_rez_id),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('J')
                   then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
                 else 0
               end
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('08')
            then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
         else 0
       end G29,
       0 G30, 0 G31, 0 G32, 0 G33, 0 G34,  0 G35,
       decode(t.fin,1,'�',2,'�',3,'�',4,'�','�') G36, null G37, null G38,
       nvl(t.s080,'1') G39, t.OBS G40, null G41, null G42,
       decode(t.s080,'9',0,nvl(t.obesp,0))    G43,
       decode(t.s080,'9',0,nvl(t.soq/100,0))    G44,
       decode(t.s080,'9',0,nvl(t.skq2/100,0))+decode(t1.s080,'9',0,nvl(t1.skq2/100,0)) G45,
       t.pr_rez  G46,
      /* decode(t.s080,'9',0,decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,l_dat)))/100
          + decode(t1.s080,'9',0,decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)))/100
	  + decode(t2.s080,'9',0,decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)))/100    G47,
       decode(t.s080,'1',decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,l_dat)), 0)/100
          + decode(t1.s080,'1',decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)), 0)/100
	  + decode(t2.s080,'1',decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)), 0)/100  G48,
       decode(t.s080,'1',0,'9',0, decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,l_dat)))/100
          + decode(t1.s080,'1',0,'9',0, decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)))/100
	  + decode(t2.s080,'1',0,'9',0, decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)))/100  G49,
          decode(t.s080,'9',0,decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,l_dat)))/100
        + decode(t1.s080,'9',0,decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)))/100
        + decode(t2.s080,'9',0,decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)))/100
	-   (   decode(t.s080,'1',decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,l_dat)), 0)/100
              + decode(t1.s080,'1',decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)), 0)/100
              + decode(t2.s080,'1',decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)), 0)/100
              + decode(t.s080,'1',0,'9',0, decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,l_dat)))/100
              + decode(t1.s080,'1',0,'9',0, decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)))/100
	      + decode(t2.s080,'1',0,'9',0, decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)))/100  ) G50, */
       t.szq/100 + t2.szq/100 G47,
       nvl(nvl(t.szq,0) - nvl(t.sznq,0),0)/100 + nvl(nvl(t2.szq,0) - nvl(t2.sznq,0),0)/100 G48,
       nvl(t.sznq,0)/100 + nvl(t2.sznq,0)/100 G49,
       0  G50,
       null G51,  null G52,  t3.szq/100 G53,   null G54,  null G55,  null G56,  null G57,  null G58,
       ba.nd G59,
       null G60,   t1.szq/100 G61,
       null G62,
       l_dat G00, p_type GT, 'R' GR, a.acc ACC, a.rnk RNK, ba.acc_2208 ACC2208, ba.acc_9129  ACC9129
   from bpk_all_accounts ba, customer c, accounts a, branch b, specparam_int s, prinsider p, accounts aa,
        (select acc, s080, fin, obs, obesp, sz1, szq, kv, skq2, soq, skq, sk, pr_rez, sznq
	   from tmp_rez_risk
	  where id = l_rez_id2 and dat = l_rez_dat2 and fl_newacc<>'i' ) t,
	(   select acc, nvl(trr.szq,0) szq, skq2, trr.s080
              from TMP_REZ_RISK trr
             where substr(trr.nls,1,4)  in (select nbs from srezerv_ob22 where nbs_rez = '3690')
               and trr.id = l_rez_id2 and trr.dat = l_rez_dat2 and fl_newacc<>'i' ) t1,
	(select acc, s080, sz1, szq, kv, skq2, soq, skq, sk, sznq
	   from tmp_rez_risk
	  where id = l_rez_id2 and dat = l_rez_dat2 and fl_newacc<>'i' ) t2,
	(select acc, nvl(t.szq,0) szq
           from TMP_REZ_RISK t
          where substr(t.nls,1,4) in (select nbs from srezerv_ob22 where nbs_rez = '2400' and ob22_rez in ('19','20','37','38'))
            and t.id = l_rez_id2 and t.dat = l_rez_dat2 and fl_newacc<>'i' ) t3
  where ba.acc_ovr is not null
    and ba.acc_ovr = a.acc
    and a.nbs in (decode(l_newnbs,0,'2202','2203'),'2203') -- ������!
    and a.daos <= l_dat
    and a.branch   = b.branch
    and a.rnk      = c.rnk
    and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91'
    and ba.acc_pk = aa.acc and aa.nbs = '2625'
    --and  ( decode(p_type,1,-SNP.fost(a.acc,DI_,1,7),-SNP.fost(a.acc,DI_,0,7)) <>0
    --    or decode( ba.acc_2208, null, 0, nvl(decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,7),SNP.fost(ba.acc_2208,DI_,0,7))/100,0)) <>0
    --    or decode( ba.acc_9129, null, 0, nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,7),SNP.fost(ba.acc_9129,DI_,0,7))/100,0)) <>0 )
    and p.prinsider= c.prinsider
    and ba.acc_9129= s.acc(+)
    and a.acc      = t.acc(+)
    and ba.acc_9129= t1.acc(+)
    and ba.acc_pk  = t2.acc(+)
    and ba.acc_2209 = t3.acc(+)
  UNION ALL
-- ���, �� ������� 2202, 2203 ��� �� ������, �� ���� 9129
  select b.name G01, a.kf G02, a.branch G03,  substr('��� '||c.nmk,1,70) G04, c.okpo G05, 0,
       a.kv G07, ba.nd G08,  null G09,
       null, null, null, 0, null, 0, null, p.prinsiderlv1 G17, null, null G19, null G20,
       0 G21,
       0 G22, 0 G23, null,
       decode(s.ob22,'01',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)),
                         '10',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)), 0) G25,
       decode(s.ob22,'03',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)),
                         '05',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)),
                         '07',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)),
			 '11',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)), 0) G26,
       nvl(acrn.fprocn(ba.acc_ovr,0,l_dat),0) G27,
       null G27e,
     --  -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100 G28, 0 G29,
       case
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('01', '07')
            then
               case
                 when f_get_s370(l_dat,f_get_specparam('s370',f_get_rez_specparam('s370',ba.acc_2208,l_rez_dat,l_rez_id),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('0', 'I')
                   then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
                 else 0
               end
         else 0
       end G28,
       case
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('01', '07')
            then
               case
                 when f_get_s370(l_dat,f_get_specparam('s370',f_get_rez_specparam('s370',ba.acc_2208,l_rez_dat,l_rez_id),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('J')
                   then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
                 else 0
               end
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('08')
            then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
         else 0
       end G29,
       0 G30, 0 G31, 0 G32, 0 G33, 0 G34,  0 G35,
       decode(c.crisk,1,'�',2,'�',3,'�',4,'�','�') G36, null, null,
       '1' G39, 1 G40, null, null,
       0  G43,
       0  G44,
       decode(t1.s080,'9',0,nvl(t1.skq2/100,0))  G45,
       null G46,
     /*  decode(t1.s080,'9',0,decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)))/100
       + decode(t2.s080,'9',0,decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)))/100  G47,
       decode(t1.s080,'1',decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)),0)/100
       + decode(t2.s080,'1',decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)),0)/100 G48,
       decode(t1.s080,'1',0,'9',0, decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)))/100
       + decode(t2.s080,'1',0,'9',0, decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)))/100  G49,
       decode(t1.s080,'9',0,decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)))/100
       + decode(t2.s080,'9',0,decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)))/100
         - (   decode(t1.s080,'1',decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)),0)/100
             + decode(t2.s080,'1',decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)),0)/100
	     + decode(t1.s080,'1',0,'9',0, decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)))/100
	     + decode(t2.s080,'1',0,'9',0, decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)))/100 ) G50,    */
       t2.szq/100 G47,
       nvl(nvl(t2.szq,0) - nvl(t2.sznq,0),0)/100 G48,
       nvl(t2.sznq,0)/100 G49,
       0  G50,
       null,  null,  null,   null,  null,  null,  null,  null,
       ba.nd,
       null,    t1.szq/100,
       null,
       l_dat, p_type, 'R',  a.acc, a.rnk, ba.acc_2208, ba.acc_9129  -- ����  ������ a.acc->null !!!!!!!!! ����� �������, ��� ���� g19 �����, � acc ��� - ������...
   from bpk_all_accounts ba, customer c, accounts a, branch b, specparam_int s, prinsider p, accounts aa,
	(   select acc, nvl(t.szq,0) szq, skq2, t.s080
              from TMP_REZ_RISK t
             where substr(t.nls,1,4) in (select nbs from srezerv_ob22 where nbs_rez = '3690')
               and t.id = l_rez_id2 and t.dat = l_rez_dat2 and fl_newacc<>'i' ) t1,
	(select acc, s080, sz1, szq, kv, skq2, soq, skq, sk, sznq
	   from tmp_rez_risk
	  where id = l_rez_id2 and dat = l_rez_dat2 and fl_newacc<>'i' ) t2
  where ba.acc_ovr is null
    and ba.acc_9129 is not null
    and ba.acc_9129 = a.acc
    and a.daos <= l_dat
    and a.branch   = b.branch
    and a.rnk      = c.rnk
    and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91'
    and ba.acc_pk  = aa.acc and aa.nbs = '2625'
    and p.prinsider= c.prinsider
    and ba.acc_9129= s.acc(+)
    and ba.acc_9129= t1.acc(+)
    and ba.acc_pk  = t2.acc(+)
  UNION ALL
-- ���, �� ������� ���� 9129, � 2202, 2203 ������ ����� ���� ������������
  select b.name G01, a.kf G02, a.branch G03,  substr('��� '||c.nmk,1,70) G04, c.okpo G05, 0,
       a.kv G07, ba.nd G08,  null G09,
       null, null, null, 0, null, 0, null, p.prinsiderlv1 G17, null, null G19, null G20,
       0 G21,
       0 G22, 0 G23, null,
       decode(s.ob22,'01',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)),
                         '10',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)), 0) G25,
       decode(s.ob22,'03',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)),
                         '05',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)),
                         '07',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)),
			 '11',-(nvl(decode(p_type,1,SNP.fost(ba.acc_9129,DI_,1,8),SNP.fost(ba.acc_9129,DI_,0,8))/100,0)), 0) G26,
       nvl(acrn.fprocn(ba.acc_ovr,0,l_dat),0) G27,
       null G27e,
     --  -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100 G28, 0 G29,
       case
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('01', '07')
            then
               case
                 when f_get_s370(l_dat,f_get_specparam('s370',f_get_rez_specparam('s370',ba.acc_2208,l_rez_dat,l_rez_id),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('0', 'I')
                   then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
                 else 0
               end
         else 0
       end G28,
       case
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('01', '07')
            then
               case
                 when f_get_s370(l_dat,f_get_specparam('s370',f_get_rez_specparam('s370',ba.acc_2208,l_rez_dat,l_rez_id),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('J')
                   then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
                 else 0
               end
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('08')
            then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
         else 0
       end G29,
       0 G30, 0 G31, 0 G32, 0 G33, 0 G34,  0 G35,
       decode(c.crisk,1,'�',2,'�',3,'�',4,'�','�') G36, null, null,
       '1' G39, 1 G40, null, null,
       0  G43,
       0  G44,
       decode(t1.s080,'9',0,nvl(t1.skq2/100,0))  G45,
       null G46,
     /*  decode(t1.s080,'9',0,decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)))/100
       + decode(t2.s080,'9',0,decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)))/100  G47,
       decode(t1.s080,'1',decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)),0)/100
       + decode(t2.s080,'1',decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)),0)/100 G48,
       decode(t1.s080,'1',0,'9',0, decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)))/100
       + decode(t2.s080,'1',0,'9',0, decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)))/100  G49,
       decode(t1.s080,'9',0,decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)))/100
       + decode(t2.s080,'9',0,decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)))/100
         - (   decode(t1.s080,'1',decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)),0)/100
             + decode(t2.s080,'1',decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)),0)/100
	     + decode(t1.s080,'1',0,'9',0, decode(t1.sz1,null,t1.szq,gl.p_icurval(t1.kv,t1.sz1,l_dat)))/100
	     + decode(t2.s080,'1',0,'9',0, decode(t2.sz1,null,t2.szq,gl.p_icurval(t2.kv,t2.sz1,l_dat)))/100 ) G50,   */
       t2.szq/100 G47,
       nvl(nvl(t2.szq,0) - nvl(t2.sznq,0),0)/100 G48,
       nvl(t2.sznq,0)/100 G49,
       0  G50,
       null,  null,  null,   null,  null,  null,  null,  null,
       ba.nd,
       null,    t1.szq/100,
       null,
       l_dat, p_type, 'R',  a.acc, a.rnk, ba.acc_2208, ba.acc_9129  -- ����  ������ a.acc->null !!!!!!!!! ����� �������, ��� ���� g19 �����, � acc ��� - ������...
   from bpk_all_accounts ba, customer c, accounts a, branch b, specparam_int s, prinsider p, accounts aa, accounts a2,
	(   select acc, nvl(t.szq,0) szq, skq2, t.s080
              from TMP_REZ_RISK t
             where substr(t.nls,1,4) in (select nbs from srezerv_ob22 where nbs_rez = '3690')
               and t.id = l_rez_id2 and t.dat = l_rez_dat2 and fl_newacc<>'i' ) t1,
	(select acc, s080, sz1, szq, kv, skq2, soq, skq, sk, sznq
	   from tmp_rez_risk
	  where id = l_rez_id2 and dat = l_rez_dat2 and fl_newacc<>'i' ) t2
  where ba.acc_ovr = a2.acc and a2.daos > l_dat
    and ba.acc_9129 is not null
    and ba.acc_9129 = a.acc
    and a.daos <= l_dat
    and a.branch   = b.branch
    and a.rnk      = c.rnk
    and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91'
    and ba.acc_pk  = aa.acc and aa.nbs = '2625'
    and p.prinsider= c.prinsider
    and ba.acc_9129= s.acc(+)
    and ba.acc_9129= t1.acc(+)
    and ba.acc_pk  = t2.acc(+)
  UNION ALL
-- ���, �� ������� ��� �� 2202, 2203, �� 9129, �� ���� 2208
  select b.name G01, a.kf G02, a.branch G03,  substr('��� '||c.nmk,1,70) G04, c.okpo G05, 0,
       a.kv G07, ba.nd G08,  null G09,
       null, null, null, 0, null, 0, null, p.prinsiderlv1 G17, null, null G19, null G20,
       0 G21,
       0 G22, 0 G23, null,
       0 G25,
       0 G26,
       0 G27,
       null G27e,
     --  -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100 G28, 0 G29,
       case
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('01', '07')
            then
               case
                 when f_get_s370(l_dat,f_get_specparam('s370',f_get_rez_specparam('s370',ba.acc_2208,l_rez_dat,l_rez_id),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('0', 'I')
                   then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
                 else 0
               end
         else 0
       end G28,
       case
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('01', '07')
            then
               case
                 when f_get_s370(l_dat,f_get_specparam('s370',f_get_rez_specparam('s370',ba.acc_2208,l_rez_dat,l_rez_id),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('J')
                   then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
                 else 0
               end
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('08')
            then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
         else 0
       end G29,
       0 G30, 0 G31, 0 G32, 0 G33, 0 G34,  0 G35,
       decode(c.crisk,1,'�',2,'�',3,'�',4,'�','�') G36, null, null,
       '1' G39, 1 G40, null, null,
       0  G43,
       0  G44,
       0  G45,
       null G46,
       0  G47,
       0  G48,
       0  G49,
       0  G50,
       null,  null,  t3.szq/100,   null,  null,  null,  null,  null,
       ba.nd,
       null,   0,
       null,
       l_dat, p_type, 'R',  a.acc, a.rnk, ba.acc_2208, ba.acc_9129 -- ����  ������ a.acc->null !!!!!!!!!  ����� �������, ��� ���� g19 �����, � acc ��� - ������...
   from bpk_all_accounts ba, customer c, accounts a, branch b, prinsider p, accounts aa,
	(select acc, nvl(t.szq,0) szq
           from TMP_REZ_RISK t
          where substr(t.nls,1,4) in (select nbs from srezerv_ob22 where nbs_rez = '2400' and ob22_rez in ('19','20','37','38'))
            and t.id = l_rez_id2 and t.dat = l_rez_dat2 and fl_newacc<>'i' ) t3
  where (ba.acc_ovr is null or (ba.acc_ovr is not null and exists (select 1 from accounts where acc = ba.acc_ovr and daos > l_dat)) )
    and (ba.acc_9129 is null or (ba.acc_9129 is not null and exists (select 1 from accounts where acc = ba.acc_9129 and daos > l_dat)) )
    --and ( ba.acc_tovr is null or decode( ba.acc_tovr, null, 0, nvl(decode(p_type,1,SNP.fost(ba.acc_tovr,DI_,1,7),SNP.fost(ba.acc_tovr,DI_,0,7))/100,0)) = 0 )
    and ba.acc_2208 = a.acc
    and a.daos <= l_dat
    and a.branch   = b.branch
    and a.rnk      = c.rnk
    and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91'
    and ba.acc_pk  = aa.acc and aa.nbs = '2625'
    and p.prinsider= c.prinsider
    and ba.acc_2209 = t3.acc(+)
  UNION ALL
-- ��� 2625
    select b.name G01, a.kf G02, a.branch G03,  substr('��� '||c.nmk,1,70) G04,  c.okpo G05, 0,
       a.kv G07, ba.nd G08,  null G09,
       null, null, null, 0, null, 0, null, p.prinsiderlv1 G17, null, a.nbs G19, a.ob22 G20,
       decode(p_type,1,nvl(-SNP.fost(ba.acc_pk,DI_,1,7),0),
                       nvl(-SNP.fost(ba.acc_pk,DI_,0,7),0))/100 G21,
       decode(p_type,1,nvl(-SNP.fost(ba.acc_pk,DI_,1,8),0),
                       nvl(-SNP.fost(ba.acc_pk,DI_,0,8),0))/100 G22,
       0 G23, null,
       0 G25, 0 G26,
       nvl(acrn.fprocn(ba.acc_ovr,0,l_dat),0) G27,
       null G27e,
       --decode(ba.acc_ovr, null, -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100, 0) G28, 0 G29,
     case  when ba.acc_ovr is null then
       case
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('01', '07')
            then
               case
                 when f_get_s370(l_dat,f_get_specparam('s370',f_get_rez_specparam('s370',ba.acc_2208,l_rez_dat,l_rez_id),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('0', 'I')
                   then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
                 else 0
               end
         else 0
       end
      else 0 end G28,
     case  when ba.acc_ovr is null then
       case
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('01', '07')
            then
               case
                 when f_get_s370(l_dat,f_get_specparam('s370',f_get_rez_specparam('s370',ba.acc_2208,l_rez_dat,l_rez_id),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('J')
                   then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
                 else 0
               end
         when f_get_s270_n(l_dat,f_get_specparam('s270',f_get_rez_specparam('s270',ba.acc_2208,l_rez_dat,l_rez_id ),ba.acc_2208,l_dat),ba.acc_2208,ba.nd) in ('08')
            then -decode(p_type,1,SNP.fost(ba.acc_2208,DI_,1,8),SNP.fost(ba.acc_2208,DI_,0,8))/100
         else 0
       end
      else 0 end G29,
       0 G30, 0 G31, 0 G32, 0 G33, 0 G34,  0 G35,
       decode(t.fin,1,'�',2,'�',3,'�',4,'�','�') G36, null, null,
       nvl(t.s080,'1') G39, t.OBS G40, null, null,
       decode(t.s080,'9',0,nvl(t.obesp,0))    G43,
       decode(t.s080,'9',0,nvl(soq/100,0))    G44,
       decode(t.s080,'9',0,nvl(t.skq2/100,0)) G45,
       t.pr_rez  G46,
       /*decode(t.s080,'9',0,decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,l_dat)))/100              G47,
       decode(t.s080,'1',decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,l_dat)), 0)/100             G48,
       decode(t.s080,'1',0,'9',0, decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,l_dat)))/100       G49,
       decode(t.s080,'9',0,decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,l_dat)))/100 -
            (   decode(t.s080,'1',decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,l_dat)), 0)/100
              + decode(t.s080,'1',0,'9',0, decode(t.sz1,null,t.szq,gl.p_icurval(t.kv,t.sz1,l_dat)))/100 ) G50,   */
       t.szq/100 G47,
       nvl(nvl(t.szq,0) - nvl(t.sznq,0),0)/100 G48,
       nvl(t.sznq,0)/100 G49,
       0  G50,
       null,  null,  t3.szq/100,   null,  null,  null,  null,  null,
       ba.nd,
       null,    0,
       null,
       l_dat, p_type, 'R', a.acc, a.rnk, ba.acc_2208, ba.acc_9129
   from bpk_all_accounts ba, customer c, accounts a, branch b,
        prinsider p,
        (select acc, s080, fin, obs, obesp, sz1, szq, kv, skq2, soq, skq, sk, pr_rez, sznq
	   from tmp_rez_risk
	  where id = l_rez_id2 and dat = l_rez_dat2 and fl_newacc<>'i' ) t,
	(select acc, nvl(t.szq,0) szq
           from TMP_REZ_RISK t
          where substr(t.nls,1,4) in (select nbs from srezerv_ob22 where nbs_rez = '2400' and ob22_rez in ('19','20','37','38'))
            and t.id = l_rez_id2 and t.dat = l_rez_dat2 and fl_newacc<>'i') t3
  where ba.acc_pk = a.acc
    and a.daos <= l_dat
    and a.branch   = b.branch
    and a.rnk      = c.rnk
    and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91'
    and a.nbs = '2625'
    and p.prinsider= c.prinsider
    and a.acc      = t.acc(+)
    and ba.acc_2209 = t3.acc(+)
    --and ba.acc_tovr is not null
    and nvl(decode(p_type,1,SNP.fost(ba.acc_pk,DI_,1,7),SNP.fost(ba.acc_pk,DI_,0,7))/100,0) <0
	  );

--------------------------!! ��� ����������������� !!-------------------------
bars_audit.trace('%s 18-2.��������� ������ �� ��� �� �����������������.',l_title);

select to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') into l_time_start4 from dual;
bars_audit.trace('%s TIME_4: l_time_start4=%s',l_title, l_time_start4);

  insert into INV_CCK_FL_BPKK
  (G01 , G02 , G03 , G04 , G05 , G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
   G25 , G26 , G27 , G27e, G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62 ,
   G00 , GT, GR, ACC, RNK)
 (
select G01, G02, G03, '���' G04, null, 0, G07, null, null, null, null, null, 0, null, 0, null,
         G17, null, G19, G20, sum(G21), sum(G22), 0, null,
         sum(G25), sum(G26), 0, null, sum(G28), 0, 0 , 0 , 0 , 0 , 0 ,  0 ,
         G36, null, null, G39, G40, null, null,
         sum(G43), sum(G44), sum(G45), null, sum(G47), sum(G48), sum(G49), sum(G50),
         null,  null,  null,   null,  null,  null,  null,  null, null, null, sum(G61), null,
         l_dat, p_type, 'K',  null, null
    from inv_cck_fl
   where G00 = l_dat
     and GT  = p_type
     and GR  = 'R'
  group by G01, G02, G03, G07, G17, G19, G20, G36, G39, G40, G42
 );

--------------------------!!!!!!!!!!!!!!!!! ������ !!!!!!!!!!!!!!!!!--------------------------
bars_audit.trace('%s 19.��������� ��, ��� ������ �� �����',l_title);

select to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') into l_time_start5 from dual;
bars_audit.trace('%s TIME_5: l_time_start5=%s',l_title, l_time_start3);

if p_type = 1 then
  begin
    for nn in
    -- ����.�����, ������� �� ������ � ���������, �� ���� � ������
       (select b.name G01, a.kf G02, a.branch G03,  substr('I��i '||c.nmk,1,70) G04, a.kv G07,
               a.nbs G19, a.ob22 G20,
               decode (a.nbs, decode(l_newnbs,0,'2202','2203'), decode(p_type,1,-SNP.fost(a.acc,di_,1,7),-SNP.fost(a.acc,di_,0,7)),
                              '2203', decode(p_type,1,-SNP.fost(a.acc,di_,1,7),-SNP.fost(a.acc,di_,0,7)),
                      	      decode(l_newnbs,0,'2207','2203'), decode(p_type,1,-SNP.fost(a.acc,di_,1,7),-SNP.fost(a.acc,di_,0,7)),
                      	      '2232', decode(p_type,1,-SNP.fost(a.acc,di_,1,7),-SNP.fost(a.acc,di_,0,7)),
                      	      '2233', decode(p_type,1,-SNP.fost(a.acc,di_,1,7),-SNP.fost(a.acc,di_,0,7)),
                      	      decode(l_newnbs,0,'2237','2233'), decode(p_type,1,-SNP.fost(a.acc,di_,1,7),-SNP.fost(a.acc,di_,0,7)),
        	      0 )/100 G21,
               decode (a.nbs, decode(l_newnbs,0,'2202','2203'), decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                      	      '2203', decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                      	      decode(l_newnbs,0,'2207','2203'), decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                      	      '2232', decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                      	      '2233', decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                      	      decode(l_newnbs,0,'2237','2233'), decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                       0 )/100 G22,
              decode (a.nbs, '9129', decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                       0 )/100 G25,
              decode (a.nbs, '2208', decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                      '2238', decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                       0 )/100 G28,
              decode (a.nbs, decode(l_newnbs,0,'2209','2208'), decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                             decode(l_newnbs,0,'2239','2238'), decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                       0 )/100 G30,
	      a.acc acc, a.rnk rnk
          from ACCM_AGG_MONBALS bb, accounts a, customer c, branch b
         where bb.acc = a.acc
           and (   a.nbs in (decode(l_newnbs,0,'2202','2203'),'2203',decode(l_newnbs,0,'2207','2203'),'2208',decode(l_newnbs,0,'2209','2208'),'2232','2233',decode(l_newnbs,0,'2237','2233'),'2238',decode(l_newnbs,0,'2239','2238'))
	        or (a.nbs = '9129' and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91') )
           and caldt_ID = di_
           -- �������, ��� ����� ��� ����� INV_CCK_FL.ACC
           and not exists (select 1 from inv_cck_fl where acc = a.acc and g00 = l_dat and gt = p_type)
           -- �������, ��� ����� ��� ����� INV_CCK_FL.ACC2208
           and not exists (select 1 from inv_cck_fl where acc2208 is not null and acc2208 = a.acc and g00 = l_dat and gt = p_type)
           -- �������, ��� ����� ��� ����� INV_CCK_FL.ACC9129
           and not exists (select 1 from inv_cck_fl where acc9129 is not null and acc9129 = a.acc and g00 = l_dat and gt = p_type)
           -- �������, ��� ����� ��� ����� TMP_INV_2208.ACC
           and not exists (select 1 from TMP_INV_2208 where acc = a.acc)
           and ( bb.ost + CRkos-CRdos <>0 or bb.ostQ + CRkosQ-CRdosQ <>0)
           and a.branch = b.branch
           and a.rnk = c.rnk    )
       loop
       	   insert into INV_CCK_FL
           	  (G01 , G02 , G03 , G04 , G05 , G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
           	   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
           	   G25 , G26 , G27 , G27e, G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
           	   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
           	   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62, G00 , GT, GR, ACC, RNK)
     		   values
          	   (nn.G01, nn.G02, nn.G03, nn.G04, null, 0, nn.G07, null, null, null, null, null,
	   	   0, null, 0, null, null, null, nn.G19, nn.G20, nn.G21, nn.G22, 0, null,
           	   nn.G25, 0, 0, null, nn.G28, 0, nn.G30, 0 , 0 , 0 , 0 ,  0 , null, null, null, null, null, null, null,
	   	   0, 0, 0, null, 0, 0, 0, 0, null,  null,  null,   null,  null,  null,  null,  null, null, null,  null, null, l_dat , p_type, 'I', nn.ACC, nn.RNK);
       end loop;
  end;
else
  begin
    for nn in
    -- ����.�����, ������� �� ������ � ���������, �� ���� � ������
       (select b.name G01, a.kf G02, a.branch G03,  substr('I��i '||c.nmk,1,70) G04, a.kv G07,
               a.nbs G19, a.ob22 G20,
               decode (a.nbs, decode(l_newnbs,0,'2202','2203'), decode(p_type,1,-SNP.fost(a.acc,di_,1,7),-SNP.fost(a.acc,di_,0,7)),
                              '2203', decode(p_type,1,-SNP.fost(a.acc,di_,1,7),-SNP.fost(a.acc,di_,0,7)),
                      	      decode(l_newnbs,0,'2207','2203'), decode(p_type,1,-SNP.fost(a.acc,di_,1,7),-SNP.fost(a.acc,di_,0,7)),
                      	      '2232', decode(p_type,1,-SNP.fost(a.acc,di_,1,7),-SNP.fost(a.acc,di_,0,7)),
                      	      '2233', decode(p_type,1,-SNP.fost(a.acc,di_,1,7),-SNP.fost(a.acc,di_,0,7)),
                      	      decode(l_newnbs,0,'2237','2233'), decode(p_type,1,-SNP.fost(a.acc,di_,1,7),-SNP.fost(a.acc,di_,0,7)),
        	      0 )/100 G21,
               decode (a.nbs, decode(l_newnbs,0,'2202','2203'), decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                      	      '2203', decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                      	      decode(l_newnbs,0,'2207','2203'), decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                      	      '2232', decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                      	      '2233', decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                      	      decode(l_newnbs,0,'2237','2233'), decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                       0 )/100 G22,
              decode (a.nbs, '9129', decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                       0 )/100 G25,
              decode (a.nbs, '2208', decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                      '2238', decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                       0 )/100 G28,
              decode (a.nbs, decode(l_newnbs,0,'2209','2208'), decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                             decode(l_newnbs,0,'2239','2238'), decode(p_type,1,-SNP.fost(a.acc,di_,1,8),-SNP.fost(a.acc,di_,0,8)),
                       0 )/100 G30,
               a.acc acc, a.rnk rnk
          from ACCM_SNAP_BALANCES bb, accounts a, customer c, branch b
         where bb.acc = a.acc
           and (   a.nbs in (decode(l_newnbs,0,'2202','2203'),'2203',decode(l_newnbs,0,'2207','2203'),'2208',decode(l_newnbs,0,'2209','2208'),'2232','2233',decode(l_newnbs,0,'2237','2233'),'2238',decode(l_newnbs,0,'2239','2238'))
	        or (a.nbs = '9129' and c.custtype = 3 and nvl(trim(c.sed),'00')<>'91') )
           and caldt_ID = di_
           -- �������, ��� ����� ��� ����� INV_CCK_FL.ACC
           and not exists (select 1 from inv_cck_fl where acc = a.acc and g00 = l_dat and gt = p_type)
           -- �������, ��� ����� ��� ����� INV_CCK_FL.ACC2208
           and not exists (select 1 from inv_cck_fl where acc2208 is not null and acc2208 = a.acc and g00 = l_dat and gt = p_type)
           -- �������, ��� ����� ��� ����� INV_CCK_FL.ACC9129
           and not exists (select 1 from inv_cck_fl where acc9129 is not null and acc9129 = a.acc and g00 = l_dat and gt = p_type)
           -- �������, ��� ����� ��� ����� TMP_INV_2208.ACC
           and not exists (select 1 from TMP_INV_2208 where acc = a.acc)
           and ( bb.ost <>0 or bb.ostQ <>0)
           and a.branch = b.branch
           and a.rnk = c.rnk    )
       loop
       	   insert into INV_CCK_FL
           	  (G01 , G02 , G03 , G04 , G05 , G06 , G07 , G08 , G09 , G10 , G11 , G12 ,
           	   G13 , G14 , G15 , G16 , G17 , G18 , G19 , G20 , G21 , G22 , G23 , G24 ,
           	   G25 , G26 , G27 , G27e, G28 , G29 , G30 , G31 , G32 , G33 , G34 , G35 , G36 ,
           	   G37 , G38 , G39 , G40 , G41 , G42 , G43 , G44 , G45 , G46 , G47 , G48 ,
           	   G49 , G50 , G51 , G52 , G53 , G54 , G55 , G56 , G57 , G58 , G59 , G60 , G61 , G62, G00 , GT, GR, ACC, RNK)
     		   values
          	   (nn.G01, nn.G02, nn.G03, nn.G04, null, 0, nn.G07, null, null, null, null, null,
	   	   0, null, 0, null, null, null, nn.G19, nn.G20, nn.G21, nn.G22, 0, null,
           	   nn.G25, 0, 0, null, nn.G28, 0, nn.G30, 0 , 0 , 0 , 0 ,  0 , null, null, null, null, null, null, null,
	   	   0, 0, 0, null, 0, 0, 0, 0, null,  null,  null,   null,  null,  null,  null,  null, null, null,  null, null, l_dat , p_type, 'I', nn.ACC, nn.RNK);
       end loop;
  end;
end if;



   --
   -- ���������� ������� ���������� ���. ���������
   --
   if l_usedwh = '1' then
       bars.bars_dwhcck.set_import_status(
                 p_date        => p_dat,
                 p_daymon_flag => p_type);

   end if;



  commit;

  select to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') into l_time_finish from dual;
  bars_audit.trace('%s TIME_Finish: l_time_finish=%s',l_title, l_time_finish);

  bars_audit.trace('%s 20.����� �������������� �� ��.',l_title);




exception when others then
    bars_audit.error (dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
    raise_application_error(-20000, l_err||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());

end P_INV_CCK_FL ;
/
show err;

PROMPT *** Create  grants  P_INV_CCK_FL ***
grant EXECUTE                                                                on P_INV_CCK_FL    to BARSDWH_ACCESS_USER;
grant EXECUTE                                                                on P_INV_CCK_FL    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_INV_CCK_FL    to RCC_DEAL;
grant EXECUTE                                                                on P_INV_CCK_FL    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_INV_CCK_FL.sql =========*** End 
PROMPT ===================================================================================== 
