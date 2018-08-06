create or replace package cp_rep_dgp is

  -- Author  : SERHII.HONCHARUK
  -- Created : 25.09.2017 10:34:23
  -- Purpose : ���. ������� �� �� (DGP-7, 8, 9)

  G_HEADER_VERSION constant varchar2(64) := 'v.1.0  25.09.2017';

  procedure prepare_dgp(p_date_from cp_dgp_zv.date_from%type,
                        p_date_to   cp_dgp_zv.date_to%type,
                        p_type_id   cp_dgp_zv_type.type_id%type);

end cp_rep_dgp;
/
create or replace package body cp_rep_dgp is
  G_BODY_VERSION constant varchar2(64) := 'v.1.10  06.08.2018';
  G_TRACE        constant varchar2(20) := 'CP_REP_DGP.';
  ---
  cursor G_CUR (p_nlsb_arr string_list, p_date_from date, p_date_to date)

  is
              select e.ID,
                     e.RYN,
                     e.ACC,
                     e.REF,
                     -a.ostc / 100 sa,
                     o.nd,
                     o.vdat dat_k,
                     ar.sumb / 100 sumb,
                     ar.ref_repo,
                     ar.n / 100 sumn,
                     ar.nom,
                     ar.stiket,
                     ar.op,
                     ar.ref_main, -- rnbu
                     substr(a.nls, 1, 4) nbs1,
                     o.s / 100 s_kupl,
                     a.kv,
                     a.pap,
                     a.rnk,
                     k.rnk rnk_e,
                     a.grp,
                     a.isp,
                     a.mdate,
                     a.nls,
                     substr(a.nms, 1, 38) nms,
                     e.accD,
                     e.accP,
                     e.accR,
                     e.accR2,
                     e.accR3,
                     e.AccS,
                     substr(d.nms, 1, 38) nms_d,
                     substr(p.nms, 1, 38) nms_p,
                     substr(r.nms, 1, 38) nms_r,
                     substr(r2.nms, 1, 38) nms_r2,
                     substr(s.nms, 1, 38) nms_s,
                     a.pap pap_n,
                     d.pap pap_d,
                     p.pap pap_p,
                     s.pap pap_s,
                     r.pap pap_r,
                     r2.pap pap_r2,
                     k.cp_id,
                     k.emi,
                     k.DATP dat_pg,
                     k.dat_em,
                     k.ir,
                     k.cena,
                     nvl(k.cena_start, k.cena) cena_start,
                     -d.ostc / 100 sd,
                     d.nls NLSD,
                     -p.ostc / 100 sp,
                     p.nls NLSP,
                     -nvl(r.ostc, 0) / 100 sr,
                     r.nls NLSR,
                     -nvl(r2.ostc, 0) / 100 sr2,
                     r2.nls NLSR2,
                     -s.ostc / 100 ss,
                     s.nls nlss,
                     k.ky,
                     k.name,
                     c.okpo,
                     c.nmkk nmk,
                     k.dox,
                     e.initial_ref,
                     e.dat_bay,
                     e.op e_op,
                     e.ref_new,
                     e.dat_ug,
                     ks.title,
                     nvl(c.prinsider, 99) prinsider,
                     e.accunrec,
                     e.accexpr,
                     k.vydcp_id,
                     k.klcpe_id
                from cp_deal  e,
                     cp_kod   k,
                     cp_spec_cond ks,
                     oper     o,
                     opldok   od,
                     cp_arch  ar,
                     accounts a,
                     accounts d,
                     accounts p,
                     accounts r,
                     accounts r2,
                     accounts r3,
                     accounts s,
                     customer c
               where ((e.acc = a.acc and substr(a.nls, 1, 1) != '8' and
                     k.dox > 1) or (nvl(e.accd, e.accp) = a.acc and k.dox = 1))
                 --and (a.dapp > p_date_from - 3 or a.ostc != 0 or a.ostb != 0)
                 and substr(a.nls, 1, 4) in (select column_value from table( p_nlsb_arr ))
                 --and o.vdat between p_date_from and p_date_to --
                 --and o.ref = od.ref
                 and od.acc = a.acc
                 and od.fdat between p_date_from and p_date_to
                 and e.id = k.id
                 and k.rnk = c.rnk(+)
                 and o.ref = e.ref
                 and e.ref = ar.ref
                 and e.accd = d.acc(+)
                 and e.accp = p.acc(+)
                 and e.accr = r.acc(+)
                 and e.accr2 = r2.acc(+)
                 and e.accr3 = r3.acc(+)
                 and e.accs = s.acc(+)
                 and k.spec_cond_id = ks.id(+)
                 and k.tip = 1 --and k.country=804  --and k.kv=980
                 --and nvl(k.datp, to_date('01/01/2050', 'dd/mm/yyyy')) > p_date_from
                 --and rez.ostc96(e.acc, p_date_from - 1) != 0
                    --  and k.dox > 1        -- 1 - ����� 2 - ���
                 and o.sos = 5 --- and k.emi in (0,6) -- ����/�� ����/���
               order by 4; --1,3,4
  -----------------------------------------------------------------


  function header_version return varchar2 is
  begin
    return 'package header cp_rep_dgp: ' || G_HEADER_VERSION || chr(10);
  end header_version;
  -----------------------------------------------------------------
  function body_version return varchar2 is
  begin
    return 'package body cp_rep_dgp: ' || G_BODY_VERSION || chr(10);
  end body_version;
  -----------------------------------------------------------------
  function get_type_bcp(p_id cp_kod.id%type) return varchar2 is
    l_t_bcp varchar2(1) := 'S';
  begin
    /* ���� ���. �������� �� ��
       select * from CP_KODW t where t.tag = 'TYPCP'
       ���� ���� ����� ��������� ��������:
       "������� ���������� ����� ���������� ���:
       ���������� -"��� ����������" = 2 (�������)+ ���������� "���� ��" (������� ����� % ������) = 0.
       ��� � ����� ���������� ������"
    */
    begin
      select 'D' into l_t_bcp from cp_kod c where c.id = p_id and c.dox = 2 and nvl(c.ir,0) = 0;
      exception
        when NO_DATA_FOUND then
          l_t_bcp := 'S';
    end;
    return l_t_bcp;
  end;

  function get_class_cp(p_id cp_kod.id%type, p_nlsb varchar2, p_nlspb varchar2) return varchar2 is
    l_pf        cp_vidd.pf%type;
    l_class_cp  varchar2(1);
  begin
    begin
      select v.pf into l_pf from cp_kod c, cp_vidd v where c.id = p_id and c.emi = v.emi and v.vidd in (p_nlsb, p_nlspb);
    exception
      when NO_DATA_FOUND then
        l_pf := 99;
    end;
    if l_pf = 1 then
      l_class_cp := 2;
    elsif l_pf = 4 then
      l_class_cp := 1;
    elsif l_pf = 3 then
      l_class_cp := 3;
    else
      l_class_cp := null;
    end if;
    return l_class_cp;
  end;

  function get_cp_refw(p_ref cp_deal.ref%type, p_tag cp_refw.tag%type) return varchar2 is
    l_val cp_refw.value%type;
  begin
    begin
      select substr(value, 1, 255) into l_val from cp_refw where ref = p_ref and tag = p_tag;
      exception
        when NO_DATA_FOUND then
          l_val := null;
    end;
    return l_val;
  end;

  function get_cp_kodw(p_id cp_kod.id%type, p_tag cp_kodw.tag%type) return varchar2 is
    l_val cp_kodw.value%type;
  begin
    begin
      select substr(value, 1, 255) into l_val from cp_kodw where id = p_id and tag = p_tag;
      exception
        when NO_DATA_FOUND then
          l_val := null;
    end;
    return l_val;
  end;

  function get_pay_period(l_ky cp_kod.ky%type) return varchar2 is
    l_period varchar2(255);
  begin
    if l_ky = 1 then
      l_period := '������';
    elsif l_ky = 2 then
      l_period := '��� �� ������';
    elsif l_ky = 4 then
      l_period := '������������';
    elsif l_ky = 12 then --�� ���� �������
      l_period := '��������';
    else
      l_period := '���������';
    end if;
    return l_period;
  end;

  function get_kontragent(p_ref int,
                          p_isk varchar2 default '�����������',
                          p_vx  int default 1) return varchar is
    l_title         constant varchar2(25) := 'get_kontragent: ';                          
    l_ref  int;
    ttt1   varchar2(4000);
    pos    int; --  �����������  :�� "�������-����"
    l_isk  varchar2(15); --  �i� �����������:
    l_name varchar2(30);
  begin
    l_ref := P_ref;
    l_isk := P_isk;
    begin
      select get_stiket(l_ref) into ttt1 from dual;
      exception
        when others then
          bars_audit.error(G_TRACE || l_title ||' l_ref='||l_ref||' '|| substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));
          ttt1 := null;
    end;
    if ttt1 is null then
      return '***?';
    end if;
    select instr(ttt1, l_isk, 1, p_vx) into pos from dual;
    if pos != 0 then
      l_name := substr(ttt1, pos + 14, 30);
    else
      l_name := '??';
    end if;
    return l_name;
  end get_kontragent;

  --% ������ �� ����
  function get_hist_ir(p_id cp_kod.id%type, p_date date) return number is
    l_ir cp_kod_update.ir%type;
  begin
    begin
      select ir into l_ir from cp_kod_update c where c.idupd = (select max(idupd) from cp_kod_update where id = p_id and effectdate <= p_date);
      exception
        when NO_DATA_FOUND then
          l_ir := null;
    end;
    return l_ir;
  end;

  function get_cena_voprosa(p_id cp_kod.id%type, p_date date, p_cena cp_kod.cena%type, p_cena_start cp_kod.cena_start%type)   return number is
    l_cena     cp_kod.cena%type;
  begin
    if p_cena != p_cena_start then
      begin
        select p_cena_start - sum(nvl(a.nom, 0))
          into l_cena
          from cp_dat a
         where a.id = p_id
           and a.DOK <= p_date;
         exception
           when NO_DATA_FOUND then l_cena := p_cena_start;
      end;
      else
        l_cena := p_cena_start;
    end if;
    return  l_cena;
  end;

  function get_count_cp(p_id cp_kod.id%type, p_date date, p_cena cp_kod.cena%type, p_cena_start cp_kod.cena_start%type, p_acc cp_deal.acc%type,
                        p_nom out number ) --������� ������ ������� �� ���� (��������� �������)
  return number is
    l_cena     cp_kod.cena%type;
    l_cnt_cp   number;
  begin
    l_cena := get_cena_voprosa(p_id, p_date + 1, p_cena, p_cena_start);

    select -rez.ostc96(p_acc, p_date) / 100 into p_nom from dual;

    l_cnt_cp := round(p_nom / l_cena, 0);

    return l_cnt_cp;
  end get_count_cp;


  function get_turnaround(p_ref opldok.ref%type, p_acc opldok.acc%type) return number is
    l_sum number := 0;
  begin
    --���� ��� ����� � ��������� �� �����? ������� � ������ ���� ���������� ���� �� ��� ���� ����������� � ���� �� ���� ���� ���������
    select nvl(sum(decode(o.dk, 0, 1, 0) * o.s), 0) / 100 --, nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
      into l_sum
      from opldok o
     where o.ref = p_ref
       and acc = p_acc;
    return l_sum;
  end;

  function get_days_delay(p_ref cp_deal.ref%type, p_date date) return number is
    l_c number;
  begin
    for cur in (select p.days_corr
                from prvn_loss_delay_days p
                where p.ref_agr = p_ref
                  and p.reporting_date =
                                          (select max(reporting_date) from prvn_loss_delay_days
                                           where ref_agr = p_ref and reporting_date <= p_date)
                 order by p.zo desc)
    loop     --�������� � zo = 1
      l_c := cur.days_corr;
      return l_c;
    end loop;
    return l_c;
  end;

  function get_riven(p_id cp_kod.id%type, p_date date) return number is
    l_r number;
  begin
    select c.hierarchy_id
    into l_r
    from cp_hierarchy_hist c where c.cp_id = p_id
                                 and c.fdat = (select max(fdat)
                                               from cp_hierarchy_hist
                                               where cp_id = p_id and fdat <= p_date);
    return l_r;
    exception
      when no_data_found then
        return null;
  end;


  function get_is_default(p_ref cp_deal.ref%type, p_date date) return number is
    l_c number;
  begin
    /*ϳ������ �� ������� ��������
    ID_CALC_SET - ���� - ������ ��������� ���� ������ ��������
    �� - ����� ������ ������ ����� (������� �������� �� ���� ���� ��������� ������ , �� � ������ ������ ���� ���� ������������)
    */
    /* �� � ���������� �� ���� */
    
    /* 19.03.2018 �� ������� ��������
       �������� ��������� �������  prvn_fv_rez
       ������� �����, �� �������� � ����� �������. 
       IS_DEFAULT - ������ ������.
    select is_default
      into l_c
      from bars.prvn_fv_rez
     where unique_bars_is = '9/' || p_ref
       and substr(id_calc_set, 1, 6) =
                                      (select max(substr(id_calc_set, 1, 6))
                                        from bars.prvn_fv_rez
                                       where unique_bars_is = '9/' || p_ref
                                         and to_date(substr(id_calc_set, 1, 6), 'YYMMDD') <= p_date)
       and rownum = 1;
    return l_c;
    exception
      when NO_DATA_FOUND then
        l_c := null;
        return l_c;
        
     */
    return null;    
  end;

  function get_ss_kor(p_accs cp_deal.accs%type, p_date date) return number is
    l_c number;
  begin
    if p_accs is not null then
        select sum(decode(o.dk, 0, 1, 1, -1) * o.sq) / 100
          into l_c                                                                         --3115 - ��������� ���������� - ���� ���������
          from opldok o, opldok o2
         where o.dk = 1 - o2.dk
           and o.stmt = o2.stmt
           and o.tt = '096'
           and o2.tt = '096'
           and o.ref = o2.ref
           and o2.acc = p_accs
           and o2.fdat <= p_date
           and o.sos = 5;
    end if;
    return nvl(l_c, 0);
  end;

  function get_rezq39(p_ref cp_deal.ref%type, p_date date) return number is
    l_c number;
  begin
    -- ���� �������, ������������� ����� ����� ���� 39 �� ������� ������� ������
      select sum(rezq39)
      into l_c
      from nbu23_rez where tipa=9 and nd = p_ref and
                           fdat = (select max(fdat) from  nbu23_rez
                                   where tipa=9 and nd = p_ref and
                                   fdat <= p_date);
      return l_c;
  end;

  procedure send_msg( p_txt varchar2 )
  is
  begin
    if getglobaloption('BMS')='1' then -- BMS �������: 1-����������� �������� ���������
    -- bms.add_subscriber( gl.aUid);
       bms.enqueue_msg( p_txt, dbms_aq.no_delay, dbms_aq.never, gl.aUid );
    end if;
--    bars_audit.info( 'OSA=>BMS:'||p_txt );
  end send_msg;

  --���� ����� ����� ����: ��������� cp_zv_D , ������� tmp_cp_zv, ����� v_cp_zv7k
  /* ��������� ������� ��� ���� DGP-007:
     "���������� � ������ ���� ������, ���� ���������"
  */
  procedure dgp7(p_date_from cp_dgp_zv.date_from%type,
                 p_date_to   cp_dgp_zv.date_to%type) is
    l_title         constant varchar2(25) := 'dgp7: ';
    l_cp_dgp_zv_row cp_dgp_zv%rowtype;
    l_nlsb_arr      string_list := string_list('3010', '3011', '3012', '3013', '3014', '3110', '3111', '3112', '3113', '3114', '3210', '3211', '3212', '3213', '3214');
    l_cnt           pls_integer := 0;

    --���� ������ ��� ������� �� �������� �� ��� ��� ���� �������
    l_sd            number;--�������
    l_sp            number;--�����
    l_sr            number;--R
    l_sr2           number;--R2
    l_sr3           number;--R3
    l_ss            number;--����������
    --l_ss_kor        number;--���������� ���������
    l_sn            number;--������
    l_sb            number;--��������� ������� (���������� � ����/������ ���������)
    l_sr_ur         number;--������. ������
    l_sr_expr       number;--�����. ����� ���.
    l_rez           number;--���� �������
    ----------------
    l_zp            number;
    l_rp            number;
    --
    l_cena_bay_n    number;
    l_cena          number;
    l_kl            number;
    l_koeff         number;
    ----------------
    l_dat_k2        date;
    ----------------
    l_dnk           date;
    ----------------
    l_cnt_prod      pls_integer;
    l_days_cnt      pls_integer;
    l_is_default    number(1);
    --
    l_chr_start_time number;
    l_chr_end_time   number;
    --
    k               G_CUR%ROWTYPE;

  begin

    open G_CUR(l_nlsb_arr, p_date_from, p_date_to);
    loop
      FETCH G_CUR INTO k;
      EXIT WHEN G_CUR%NOTFOUND;
      l_cnt := l_cnt + 1;
      /*������� ��������*/
      l_cp_dgp_zv_row.ref       := k.ref;
      l_cp_dgp_zv_row.id        := k.id;
      l_cp_dgp_zv_row.type_id   := 7;
      l_cp_dgp_zv_row.date_from := p_date_from;
      l_cp_dgp_zv_row.date_to   := p_date_to;
      l_cp_dgp_zv_row.user_id   := user_id();
      l_cp_dgp_zv_row.date_reg  := sysdate;
      l_cp_dgp_zv_row.kf        := gl.kf;
      ---------
      l_cp_dgp_zv_row.g001 := k.nbs1;                                                       --����� ����������� �������
      l_cp_dgp_zv_row.g002 := '�';                                                         --���� (���/�)
      l_cp_dgp_zv_row.g003 := nvl(get_cp_kodw(k.id, 'TPCP'), get_type_bcp(k.id));          --�� ����--�� �������(������ �����������, ��� ��������, ������ ���������� � ����)--��� ��������� ������� ������
      l_cp_dgp_zv_row.g004 := k.kv;                                                         --������ (���)
      l_cp_dgp_zv_row.g005 := get_class_cp(k.id, k.nbs1, nvl(substr(k.nlsp, 1, 4), ''));    --������������ ������ ������ (1-����������, 2-� �������� ��� �������, 3-��������� �� ���������)
      l_cp_dgp_zv_row.g006 := nvl(k.title, get_cp_kodw(k.id, 'OS_UM'));                     --�������� ��������� ����
      l_cp_dgp_zv_row.g007 := nvl(k.nmk, '***');                                            --����� �������
      l_cp_dgp_zv_row.g008 := k.okpo;                                                        --��� ������
      l_cp_dgp_zv_row.g009 := case when k.prinsider = 99 then '�' else '���' end;           --�� ����--�� ������� � ��������-������--���'����� ������� (���/�)
      if k.klcpe_id is null then
         l_cp_dgp_zv_row.g010 := get_cp_kodw(k.id, 'KLCPE');                                   --�� ����--�� �������--������������ ������ ������ � ��������� �� �������
         else
           begin
             select title
             into l_cp_dgp_zv_row.g010 
             from cp_klcpe 
             where id = k.klcpe_id;
           exception 
             when NO_DATA_FOUND then
               l_cp_dgp_zv_row.g010 := '�� �������� ����� �� ���� '||k.klcpe_id;
           end;
      end if;   
--      raise_application_error(-20001, 'k.ryn='||k.ryn||' k.ref='||k.ref);
      select series
      into l_cp_dgp_zv_row.g011                                                             --�� ����--������������--���� ��������
      from cp_ryn where ryn = k.ryn;

      l_cp_dgp_zv_row.g012 := nvl(get_cp_refw(k.ref, 'AUKC'), k.nd);                        --����� ��������
      l_cp_dgp_zv_row.g013 := k.cp_id;                                                      --̳��������� ���������������� ����� ������� ������ (ISIN)
      l_cp_dgp_zv_row.g014 := get_pay_period(k.ky);                                         --����������� ������ ������
      /*��������� �����: ������� �� ������� ������*/
      l_cp_dgp_zv_row.g015 := to_char(k.dat_ug, 'DD.MM.YYYY');                              --���� ��������� (� ������� ������ o.vdat dat_k)
      l_cp_dgp_zv_row.g016 := case when k.stiket is null then '���� �� ��������'
                                   else get_kontragent(k.ref) end;                          --����� ��������
      l_cp_dgp_zv_row.g017 := to_char(nvl(get_hist_ir(k.id, p_date_from), k.ir),
                                      '99.99999');                                          --³�������� ������ �� ������� ������� ������

      if k.kv = 980 then
          l_cp_dgp_zv_row.g018 := k.s_kupl;                                                  --����--!!!!ֳ�� ���������
          else
            l_cp_dgp_zv_row.g018 := gl.p_icurval(k.kv, k.s_kupl * 100, k.dat_k) / 100;     -- -//- (� ���������)
      end if;

      l_cp_dgp_zv_row.g019 := get_count_cp(k.id, p_date_from - 1, k.cena, k.cena_start, k.acc,  --ʳ������ �� ������� ������� ������, ��.
                                           l_sn);
      if k.kv = 980 then
          l_cp_dgp_zv_row.g020 := l_sn;                                                      --��������� ������� �� ������� ������� ������
        else
          l_cp_dgp_zv_row.g020 := gl.p_icurval(k.kv, l_sn * 100, p_date_from - 1) / 100;     -- -//- (� ���������)
      end if;

      l_sd := 0; l_sp := 0;
      if k.accd is not null then
        l_sd := -rez.ostc96(k.accd, p_date_from - 1) / 100;
      end if;
      if k.accp is not null then
        l_sp := -rez.ostc96(k.accp, p_date_from - 1) / 100;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g021 := l_sd + l_sp;                                                 --��������������� �������/����� �� ������� ������� ������
        else
          l_cp_dgp_zv_row.g021 := gl.p_icurval(k.kv, l_sd * 100, p_date_from - 1) / 100      -- -//- (� ���������)
                                + gl.p_icurval(k.kv, l_sp * 100, p_date_from - 1) / 100;
      end if;

      l_sr := 0; l_sr2 := 0; l_sr3 := 0;
      if k.accr is not null then
        l_sr := -rez.ostc96(k.accr, p_date_from - 1) / 100;
      end if;
      if k.accr2 is not null then
        l_sr2 := -rez.ostc96(k.accr2, p_date_from - 1) / 100;
      end if;
      if k.accr3 is not null then
        l_sr3 := -rez.ostc96(k.accr3, p_date_from - 1) / 100;
      end if;
      if k.accunrec is not null then
        l_sr_ur := -rez.ostc96(k.accunrec, p_date_from - 1) / 100; --�������� ������
      end if;
      if k.accexpr is not null then
        l_sr_expr := -rez.ostc96(k.accexpr, p_date_from - 1) / 100; --��������� �����. ���
      end if;

      if k.kv = 980 then
        l_cp_dgp_zv_row.g022 := l_sr + l_sr2 + l_sr3 - l_sr_ur + l_sr_expr;                  --����--��������� (���% (R+R2+R3 - !!!R (������������)+ ������������!!!)--���������/ ����������/�������� ������� ������ �� ����� ��� ����� ����
        else
          l_cp_dgp_zv_row.g022 := gl.p_icurval(k.kv, l_sr * 100, p_date_from - 1) / 100      -- -//- (� ���������)
                                + gl.p_icurval(k.kv, l_sr2 * 100, p_date_from - 1) / 100
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_from - 1) / 100
                                - gl.p_icurval(k.kv, l_sr_ur * 100, p_date_from - 1) / 100
                                + gl.p_icurval(k.kv, l_sr_expr * 100, p_date_from - 1) / 100
                                ;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g023 := l_sr2 + l_sr3;                                                --��������� ����������� �������� ����� �� ������� ������� ������
        else
          l_cp_dgp_zv_row.g023 := gl.p_icurval(k.kv, l_sr2 * 100, p_date_from - 1) / 100      ---//- (� ���������)
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_from - 1) / 100;
      end if;

      begin
        select sum(crq)
        into l_cp_dgp_zv_row.g024                                                               -- ���� ���������� ������  ������������ �� ������� ������� ������ (����� ��������� � 351)
        from nbu23_rez where tipa=9 and nd = k.ref and
                             fdat = (select max(fdat) from  nbu23_rez
                                     where tipa=9 and nd = k.ref and
                                     fdat <= p_date_from );
        exception
          when NO_DATA_FOUND then
            l_cp_dgp_zv_row.g024  := null;
      end;


      l_rez := get_rezq39(k.ref, p_date_from);                                                    --����--��������� -- ���� �������, ������������� ����� ����� ���� 39 �� ������� ������� ������
      l_cp_dgp_zv_row.g025 := l_rez;
      l_rez := nvl(l_rez, 0);

      l_ss := 0;
      if k.accs is not null then
        l_ss := -rez.ostc96(k.accs, p_date_from - 1) / 100;
      end if;
      /*������ ���� ����� �������� �� ���������� (��������������, ������� ������������)
          �������� ����� ��������
            ��� �������  (g025):
              ref 96104973401 �������� � Finevare. �������� ������ �� ���� ���������� �� ���= 9/21425065701
                * � cp_deal ������� 31189925065701 ��� ���. ����� ����� 21425065701 �����.
                  ��� ��� ���� �������� nbu23_rez - ������ ������ ���� ��� �� �������������
            ��� ���������� (g026):
              ref 90685271001 ��������� ������ �� ���.��� "����������" �.V, �.179428, ��.�.91 ����.XV �����.� ���.��.����.� �� �� ���.��. ����.����.����.��� 22.06.2015 �. �400.
      */
      /* � ������ �������, ���� ������� �� ���� �������� ....
      l_ss_kor := get_ss_kor(k.accs, p_date_from - 1) / 100;
      l_ss := l_ss + l_ss_kor;
      */
      if k.kv = 980 then
        l_cp_dgp_zv_row.g026 := l_ss;                                                        --����--��������� --���� ���������� �� ������� ������� ������, ��������� �������� �� ����� ����
        else
          l_cp_dgp_zv_row.g026 := gl.p_icurval(k.kv, l_ss * 100, p_date_from - 1) / 100;     -- -//- (� ���������)
      end if;
      /* ������� �������� �� � ���������� ����������*/
      l_sb := l_sn + (l_sd + l_sp) + (l_sr + l_sr2 + l_sr3) - l_rez  + l_ss;
      if  k.kv = 980 then
        l_cp_dgp_zv_row.g027 := l_sb;                                                        --����--��������� --��������� ������� �� ������� ������� ������ (����� ����)
        else
          l_cp_dgp_zv_row.g027 := gl.p_icurval(k.kv, l_sb * 100, p_date_from - 1) / 100;     -- -//- (� ���������)
      end if;

      l_days_cnt := get_days_delay(k.ref, p_date_from);
      l_cp_dgp_zv_row.g028 := nvl(to_char(l_days_cnt), '�������');                                    --����--���� ������--��������� � ��������-- ʳ������ ��� ����������

      /*�������� �� ���������� �� ������ Is_default  � Finevare (������� PRVN_FV_REZ)*/
      l_chr_start_time := dbms_utility.get_time;
      l_is_default := get_is_default(k.ref, p_date_from);
      l_chr_end_time := dbms_utility.get_time;
      if (l_chr_end_time - l_chr_start_time) / (100 * 60) > 1 then /*min*/
        bars_audit.info(G_TRACE || l_title || ' ������� get_is_default('||k.ref||','||p_date_from||') ���������� '||(l_chr_end_time - l_chr_start_time) / (100 * 60)||' ������');
      end if;
      if l_is_default = 1 then
        l_cp_dgp_zv_row.g029 := '4';                                                           --����--��������� -- �������� ����� �� ���� �� ������� ������
        else
          if l_is_default = 0 and l_days_cnt = 0 then
            l_cp_dgp_zv_row.g029 := '1';
          elsif l_is_default = 0 and l_days_cnt <= 30  then
            l_cp_dgp_zv_row.g029 := '2';
          elsif l_is_default = 0 and l_days_cnt between 30+1 and 60  then
            l_cp_dgp_zv_row.g029 := '3';
          else
            l_cp_dgp_zv_row.g029 := '�������';
          end if;
      end if;

      l_cp_dgp_zv_row.g030  := get_riven(k.id, p_date_from);                                 --����--��������� -- г���� �� ������� ������� ������
      /*��������� �����: ��������� �������� ������� ������*/
      if k.dat_k between p_date_from and p_date_to then
        l_dat_k2 := k.dat_k;
        else
          l_dat_k2 := null;
      end if;
      if l_dat_k2 is not null then
        l_sn := get_turnaround(k.ref, k.acc);
        if  k.kv = 980 then
          l_cp_dgp_zv_row.g031 := l_sn;                                                        -- ��������� (������) �� ������ ����� (��������� �������)
          else
            l_cp_dgp_zv_row.g031 := gl.p_icurval(k.kv, l_sn * 100, l_dat_k2) / 100;            -- -//- (� ���������)
        end if;

        l_cena_bay_n := get_cena_voprosa(k.id, k.dat_k, k.cena, k.cena_start);
        l_kl         := round(l_sn / l_cena_bay_n, 0);
        l_cp_dgp_zv_row.g032 := l_kl;                                                           -- ��������� (������) �� ������ �����, �������
        if l_kl != 0 then
          if  k.kv = 980 then
            l_cp_dgp_zv_row.g033 := round(nvl(k.sumb, k.s_kupl) / l_kl, 2);                       -- ֳ�� ���������
            else
              l_cp_dgp_zv_row.g033 := gl.p_icurval(k.kv, round(nvl(k.sumb, k.s_kupl) / l_kl, 2) * 100, l_dat_k2) / 100; -- -//- (� ���������)
          end if;
        end if;
        l_cp_dgp_zv_row.g034 := k.s_kupl;                                                          --����--��������� --���� �������� ��������� ����� �� ������� �� (���� �� ���������)

        l_sr := get_turnaround(k.ref, nvl(k.accr2, k.accr));
        /*if l_kl != 0 then
           l_cp_dgp_zv_row.g035 := round(l_sr / l_kl, 2);                                          --��������� -- ���� ��������� ����������� ������ � ��� ���������(1��???)
        end if;
       �:������ �� ����������� ������� � ������� ���� ����� ���������, �� �� �� ������� � ���� ������� �������� - 1 ��?
       ����: �� ���� ����� ���������� �����. � ����� ������� �� ����, ��� �������� � ���  �������� ��� ���������� ��� ��������. ��� ���� ����� ����� ������� ����� � ���� �������. �� ��� ������, ��� ��� ��� ������� �� 1418,1428 ��� 3118 � �� ���� �������� ��� ������� (R2 � R3)
       */
        l_cp_dgp_zv_row.g035 := l_sr;                                                              --����


        l_cp_dgp_zv_row.g036 := f_operw(k.ref, 'CP_FC');                                         --����--��������� --����� �������?

        l_cp_dgp_zv_row.g037 := to_char(l_dat_k2, 'DD.MM.YYYY');                                 --���� ���������
        l_cp_dgp_zv_row.g038 := l_cp_dgp_zv_row.g016;                                            --����� ��������

      end if;  --end l_dat_k2 is not null
      /*��������� �����: ������� �� ����� ������*/
      l_cp_dgp_zv_row.g051 := to_char(k.dat_pg, 'DD.MM.YYYY');                                   --���� ���������

      select min(offer_date)
        into l_cp_dgp_zv_row.g052                                                                --����--��������� -- ���� ������ (��������� ���� ����� ����)
        from cp_dat
        where id = k.id
          and dok > p_date_to;
      begin
        select nvl(a.dok, k.dat_pg)
          into l_dnk
          from cp_dat a
         where a.id = k.ID
           and a.DOK = (select min(dok)
                          from cp_dat
                         where id = k.id
                           and dok > p_date_to);

        exception
          when NO_DATA_FOUND then
            l_dnk := null;
      end;
      l_cp_dgp_zv_row.g053 := to_char(l_dnk, 'DD.MM.YYYY');                                      -- ���� ������� ������ (��������� ���� ����� ����)
      l_cp_dgp_zv_row.g054 := to_char(nvl(get_hist_ir(k.id, p_date_to), k.ir),
                                      '99.99999');                                               -- ³�������� ������ �� ����� ��� ����� ����

      l_sn := -rez.ostc96(k.acc, p_date_to+1) / 100;
      l_cena := get_cena_voprosa(k.id, p_date_to+1, k.cena, k.cena_start);
      l_cp_dgp_zv_row.g055 := round(l_sn / l_cena, 0);                                           --ʳ������ ������ �� ����� ��� ����� ����
      if  k.kv = 980 then
          l_cp_dgp_zv_row.g056 := l_sn;                                                        -- ��������� ������� �� ����� ��� ����� ����
          else
            l_cp_dgp_zv_row.g056 := gl.p_icurval(k.kv, l_sn * 100, p_date_to+1) / 100;         -- -//- (� ���������)
      end if;

      l_sd := 0; l_sp := 0;
      if k.accd is not null then
        l_sd := -rez.ostc96(k.accd, p_date_to+1) / 100;
      end if;
      if k.accp is not null then
        l_sp := -rez.ostc96(k.accp, p_date_to+1) / 100;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g057 := l_sd + l_sp;                                                 --��������������� �������/����� �� ����� ��� ����� ����
        else
          l_cp_dgp_zv_row.g057 := gl.p_icurval(k.kv, l_sd * 100, p_date_to+1) / 100      -- -//- (� ���������)
                                + gl.p_icurval(k.kv, l_sp * 100, p_date_to+1) / 100;
      end if;

      l_sr := 0; l_sr2 := 0; l_sr3 := 0;
      if k.accr is not null then
        l_sr := -rez.ostc96(k.accr, p_date_to+1) / 100;
      end if;
      if k.accr2 is not null then
        l_sr2 := -rez.ostc96(k.accr2, p_date_to+1) / 100;
      end if;
      if k.accr3 is not null then
        l_sr3 := -rez.ostc96(k.accr3, p_date_to+1) / 100;
      end if;
      if k.accunrec is not null then
        l_sr_ur := -rez.ostc96(k.accunrec, p_date_to+1) / 100; --�������� ������
      end if;
      if k.accexpr is not null then
        l_sr_expr := -rez.ostc96(k.accexpr, p_date_to+1) / 100; --��������� �����. ���
      end if;

      if k.kv = 980 then
        l_cp_dgp_zv_row.g058 := l_sr + l_sr2 + l_sr3 - l_sr_ur + l_sr_expr;                  --����--��������� G022 --���������/ ����������/�������� ������� ������ �� ����� ��� ����� ����
        else
          l_cp_dgp_zv_row.g058 := gl.p_icurval(k.kv, l_sr * 100, p_date_to+1) / 100      -- -//- (� ���������)
                                + gl.p_icurval(k.kv, l_sr2 * 100, p_date_to+1) / 100
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_to+1) / 100
                                - gl.p_icurval(k.kv, l_sr_ur * 100, p_date_to+1) / 100
                                + gl.p_icurval(k.kv, l_sr_expr * 100, p_date_to+1) / 100
                                ;
      end if;

      if k.kv = 980 then
        l_cp_dgp_zv_row.g059 := l_sr2 + l_sr3;                                             --����������� (�����������) �������� ����� �� ����� ��� ����� ����
        else
          l_cp_dgp_zv_row.g059 := gl.p_icurval(k.kv, l_sr2 * 100, p_date_to+1) / 100
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_to+1) / 100 ;      -- -//- (� ���������)
      end if;

      l_cp_dgp_zv_row.g060 := '-';                                                        --������� ��������?--���������-- ���� �������, �������� ������������ �� ����� ��� ����� ����, ��� (����� ��������� � 23)


      l_rez := get_rezq39(k.ref, p_date_to);
      l_cp_dgp_zv_row.g061 := l_rez;                                                      --����--��������� g025-- ���� �������, ������������� ����� ����� ���� 39 �� ����� ��� ����� ����
      l_rez := nvl(l_rez, 0);

      l_ss := 0;
      if k.accs is not null then
        l_ss := -rez.ostc96(k.accs, p_date_to+1) / 100;
      end if;
      /* � ������ �������, ���� ������� �� ���� �������� ....
      l_ss_kor := get_ss_kor(k.accs, p_date_to+1) / 100;
      l_ss := l_ss + l_ss_kor;
      */
      if k.kv = 980 then
        l_cp_dgp_zv_row.g062 := l_ss;                                                        --��������� --���� ���������� �� ����� ��� ����� ����, ��������� �������� �� ����� ����
        else
          l_cp_dgp_zv_row.g062 := gl.p_icurval(k.kv, l_ss * 100, p_date_to+1) / 100;     -- -//- (� ���������)
      end if;

      l_sb := l_sn + (l_sd + l_sp) + (l_sr + l_sr2 + l_sr3) - l_rez  + l_ss;
      if  k.kv = 980 then
        l_cp_dgp_zv_row.g063 := l_sb;                                                        --����--��������� G027--��������� ������� �� ����� ��� ����� ���� (����� ����)
        else
          l_cp_dgp_zv_row.g063 := gl.p_icurval(k.kv, l_sb * 100, p_date_to+1) / 100;     -- -//- (� ���������)
      end if;

      /*���������: ����� �� ��� � ��� ���������� . �� ������ ������ ���������� = ������������, �� � ������� �������� �� �����, � � �� 1 ��*/
      if l_sn = 0 then
        l_sb := null;
        else
          l_sb := round(l_sb / round(l_sn / l_cena, 0), 2);
      end if;
      if  k.kv = 980 then
        l_cp_dgp_zv_row.g064 := l_sb;                                                        --����--���������--����������� ������� �� ����� ���� 39 �� ����� ���� �� 1 ��
        else
          l_cp_dgp_zv_row.g064 := gl.p_icurval(k.kv, l_sb * 100, p_date_to+1) / 100;     -- -//- (� ���������)
      end if;

      l_cp_dgp_zv_row.g065 := l_cp_dgp_zv_row.g063;                                          --����--���������--����������� ������� ������ �� ����� ���� 39 �� ����� ����

      l_days_cnt := get_days_delay(k.ref, p_date_to);
      /*�������� �� ���������� �� ������ Is_default  � Finevare (������� PRVN_FV_REZ)*/
      l_chr_start_time := dbms_utility.get_time;
      l_is_default := get_is_default(k.ref, p_date_to+1);
      l_chr_end_time := dbms_utility.get_time;
      if (l_chr_end_time - l_chr_start_time) / (100 * 60) > 1 then /*������*/
        bars_audit.info(G_TRACE || l_title || ' ������� get_is_default('||k.ref||','||to_char(p_date_to+1, 'DD.MM.YYYY')||') ���������� '||(l_chr_end_time - l_chr_start_time) / (100 * 60)||' ������');
      end if;
      if l_is_default = 1 then
        l_cp_dgp_zv_row.g066 := '4';                                                           --����--��������� g029-- �������� ����� �� ���� �� ����� ��� ����� ����
        else
          if l_is_default = 0 and l_days_cnt = 0 then
            l_cp_dgp_zv_row.g066 := '1';
          elsif l_is_default = 0 and l_days_cnt <= 30  then
            l_cp_dgp_zv_row.g066 := '2';
          elsif l_is_default = 0 and l_days_cnt between 30+1 and 60  then
            l_cp_dgp_zv_row.g066 := '3';
          else
            l_cp_dgp_zv_row.g066 := '�������';
          end if;
      end if;

      l_cp_dgp_zv_row.g067 := nvl(to_char(l_days_cnt), '�������');                          --����--��������� g028-- ʳ������ ��� ����������
      l_cp_dgp_zv_row.g068 := get_riven(k.id, p_date_to);                                    --����--��������� g030-- г���� ������ �� ����� ����


      /*��� ��� � ����� �������,
        ���� �� ���� ������� ��������� ������� ����� � ��� �� ������� �������
        (������� 0 �� ������� �� 0 ��������� :-) )
        [������ ��� �� ������� ���������� ������ ��� �� ������]
      */
      l_cnt_prod := 0;
      for p in (select o.ref,
                  pp.nd,
                  pp.s / 100 s_p, -- ���� ����� ������� ������ ������
                  o.s / 100 s,
                  o.stmt,
                  o.tt,
                  decode(vob, 096, pp.vdat, o.fdat) dat_opl,
                  pp.datp dat_ug,
                  ar.op ar_op,
                  nvl(ar.sumb, 0) / 100  ar_sumb,
                  nvl(ar.n, 0) / 100 ar_n
             from opldok o, oper pp, cp_arch ar
            where o.acc = k.acc
              and o.dk = 1
              and o.ref = pp.ref
              and o.ref = ar.ref(+)
              and o.fdat between p_date_from and p_date_to
              and o.sos = 5
              and pp.nazn like '������%'
            order by 1)
      loop
        l_cnt_prod := l_cnt_prod + 1;
        /*��������� �����: ��������� �������� ������� ������*/
        /*�������*/
        l_cp_dgp_zv_row.ref_sale := p.ref;
        -------
        if k.kv = 980 then
          l_cp_dgp_zv_row.g039 := p.s;                                                        --��������� (���������) �� ������ ����� (��������� �������)
          else
            l_cp_dgp_zv_row.g039 := gl.p_icurval(k.kv, p.s * 100, p.dat_opl) / 100;     -- -//- (� ���������)
        end if;

        if k.cena != k.cena_start then
          -- ��������� ��������� ���� 1 ��
          begin
            select k.cena_start - sum(nvl(a.nom, 0)) +
                   sum(decode(a.dok, k.dat_pg, nvl(a.nom, 0), 0))
              into l_cena --  6/04-15
              from cp_dat a
             where a.id = k.ID
               and a.DOK <= p.dat_opl;
             exception
               when NO_DATA_FOUND then l_cena := k.cena;
          end;
        else
          l_cena := k.cena; -- ���������
        end if;

        l_kl := round(p.s / nvl(l_cena, k.cena), 0);
        l_cp_dgp_zv_row.g040 := l_kl;                                                        --��������� (���������) �� ������ �����, �������

        if p.ar_op in (2, 3) then
          if nvl(l_kl, 1) != 0 then
            l_sn := case when nvl(p.ar_n, 0) = 0 then p.s else p.ar_n end;
            l_koeff := round(p.s / l_sn, 5);
            l_cena := round(nvl(p.ar_sumb, p.s_p) * l_koeff / nvl(l_kl, 1), 2);
          end if;
          elsif p.ar_op = 20 then
            l_cena := f_cena_cp(k.id, p.dat_opl);
          elsif p.ar_op = 22 then
            begin
              select nvl(nom, 0)
                into l_cena
                from cp_dat a
               where a.id = k.ID
                 and a.dok = (select max(dok)
                                from cp_dat
                               where id = k.id
                                 and dok < p.dat_opl);
            exception
              when NO_DATA_FOUND then
                l_cena := 0;
            end;
          else
            l_cena := 0;
        end if;

        if k.kv = 980 then
          l_cp_dgp_zv_row.g041 := l_cena;                                                        --ֳ�� ���������
          else
            l_cp_dgp_zv_row.g041 := gl.p_icurval(k.kv, l_cena * 100, p.dat_opl) / 100;     -- -//- (� ���������)
        end if;

        if k.kv = 980 then
          l_cp_dgp_zv_row.g042 := p.s_p;                                                        --����--���� �������� ��������� ����� �� ������ �� (���� �� ���������)
          else
            l_cp_dgp_zv_row.g042 := gl.p_icurval(k.kv, p.s_p * 100, p.dat_opl) / 100;     -- -//- (� ���������)
        end if;

        select sum(o.sq) / 100 -- ������ �� R/R2 ��� �������
          into l_cp_dgp_zv_row.g043                                                          --����������� �������� �����, ��������� � ��� ���������
          from opldok o
         where o.acc in (k.accr, k.accr2)
           and o.dk = 1
           and o.sos = 5 -- !? OBU/BARS
           and o.ref = p.ref;

        l_cp_dgp_zv_row.g044 := f_operw(p.ref, 'CP_FC');                                     --����--��������� G036 --����� ���������� ����������

        l_cp_dgp_zv_row.g045 := to_char(p.dat_opl, 'DD.MM.YYYY');                            -- ���� ���������

        l_cp_dgp_zv_row.g046 := nvl(nvl(get_cp_refw(p.ref, 'BRDOG'), get_cp_refw(k.ref, 'BRDOG')), p.nd);  --����� ������ �����

        l_cp_dgp_zv_row.g047 := trim(get_kontragent(p.ref,
                                             '� �����������'));                              --����� �������
        if k.vydcp_id is null then
           l_cp_dgp_zv_row.g048 := substr(get_cp_kodw(k.id, 'VYDCP'), 1, 255);                 --����--��������� --��� ������� ������
           else 
             begin
               select title
               into l_cp_dgp_zv_row.g048
               from cp_vydcp
               where id = k.vydcp_id;
             exception 
               when NO_DATA_FOUND then
                    l_cp_dgp_zv_row.g048 := '�� �������� ����� �� ���� '||k.vydcp_id;
             end;               
        end if;   
        l_cp_dgp_zv_row.g049 := f_operw(p.ref, 'CP_VD');                                    --����--��������� --��� ��������/���������
        if l_cp_dgp_zv_row.g049 is null then
           l_cp_dgp_zv_row.g049 := get_cp_refw(p.ref, 'VDOGO');                                
        end if;  
        l_cp_dgp_zv_row.g050 := f_operw(p.ref, 'CP_VO');                                    --����--��������� --��� ��������
        if l_cp_dgp_zv_row.g050 is null then
           l_cp_dgp_zv_row.g050 := get_cp_refw(p.ref, 'VOPER');                                
        end if;   

        /*��������� �����: ������ �� ������� ��������, ������� �������� ������� ������*/

        select sum(decode(o.dk, 0, 1, 1, -1) * o.sq) / 100
          into l_rp                                                                         --������������� ��������� �� �������
          from opldok o, opldok o2, accounts ak
         where o.dk = 1 - o2.dk
           and o.stmt = o2.stmt
           and o.tt = 'FXT'
           and o2.tt = 'FXT'
           and o.ref = o2.ref
           and o.ref = p.ref
           and ak.acc = o2.acc
           and (
                ak.nls like '6393%' or ak.nls like '6203%' or ak.nls like '3800%' -- OBU
               )
           and o.sos = 5;

        select sum(decode(o.dk, 0, 1, 1, -1) * o.sq) / 100
          into l_zp                                                                         --3115 - ��������� ���������� ��� ������
          from opldok o, opldok o2, cp_deal d
         where o.dk = 1 - o2.dk
           and o.stmt = o2.stmt
/*           and o.tt = 'FX7'
           and o2.tt = 'FX7'*/
           and o.ref = o2.ref
           and o.ref = p.ref
           and d.accs = o2.acc
           and o.sos = 5;

        l_cp_dgp_zv_row.g069 := l_rp + l_zp;                                                --����--������������� ����� ��������--�������� ����� �������� ������� ������

        select sum(decode(o1.dk, 0, 1, 1, -1) * o1.sq) / 100
          into l_cp_dgp_zv_row.g070                                                         --����--6390 dk= 1, 7390 dk = 0 --������������--��������� --�������� ���������� ��� ��������� ������� (������� 6390,7390)
          from opldok o1, opldok k1, accounts ak
         where o1.dk = 1 - k1.dk
           and o1.stmt = k1.stmt
/*           and o.tt = 'FXT'
           and k.tt = 'FXT'*/
           and o1.ref = k1.ref
           and o1.ref = /*p.ref*/ k.ref /*��� ����� � ? */
           and ak.acc = k1.acc
           and (
                ak.nls like '6390%' or ak.nls like '7390%'
               )
           and o1.sos = 5;


        l_cp_dgp_zv_row.g071 := '-';                                                        --��������� --������� ������, ��� ������ �� ��� ������� ��������� ������ (������ �� ������ �� ���� ����������� � ������ �� ���� �������� ������� ��������� �������), ���.
        /* Գ�������: ������ �� ������ ��� �������,  ���� �� ������  ������ � ������ �� ���������� �� �������� ����������. */

        l_cp_dgp_zv_row.g072 := '-';                                                        --��������� ����� ��������--��������� ���������� ������� �������� ���� �������� ����� �������� ������� ������
       /* ��������: ��, � ����� ������� ������������, �� ������, ��� ������ �� ���� �������, �� �� ��� ����� � ��� ����� ��������...
                   ������, ��� � ��������� ����� ������ ���������*/

        select /*nvl(sum(o.s), 0) / 100,*/ nvl(sum(o.sq), 0) / 100 -- �� D ��� ����������� �� 6
            into l_cp_dgp_zv_row.g073                                                        --����--��������� --����������� �������� �������� ������� ������
            from opldok o
           where o.acc = k.accd
             and o.dk = 0
             and o.sos = 5
             and o.fdat >= p_date_from
             and o.fdat <= p_date_to
             --and o.tt in ('FXM', '080', '013')
             ;

        select /*nvl(sum(o.s), 0) / 100,*/ nvl(sum(o.sq), 0) / 100 -- �� D ��� ����������� �� 6
            into l_cp_dgp_zv_row.g074                                                        --����--��������� g073--����������� ���쳿 �������� ������� �����
            from opldok o
           where o.acc = k.accp
             and o.dk = 0
             and o.sos = 5
             and o.fdat >= p_date_from
             and o.fdat <= p_date_to
             --and o.tt in ('FXM', '080', '013')
             ;

        select /*nvl(sum(o.s), 0) / 100, */nvl(sum(o.sq), 0) / 100 -- �� R ��� ���������� �� 605
          into l_cp_dgp_zv_row.g075                                                          --����--��������� ���� ����������� ������ �������� ������� ������
          from opldok o --, OPER P
         where o.acc = k.accr
           and o.dk = 0 --and o.ref=p.ref
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to --and o.tt in ('FXU','FXU'
--           and o.tt in ('FX%', '080', '013')
           ;

        /* Գ�������: ��������: ���� ������, �� ��� �� ��� ������ ( ���� ��� � �����) ���� ��������� ����������. � ������ ��� ���� �������� (��1415, ��5102),
                      � ��������� ��� ������- ������ (��5102 �� 1415). � ���������� �� ����� 1415 � �������� � ��� ���� � �� � ��.
                      �����: �� ����� �� ����� �����  �� ������ (+) ��� (-). */
        select nvl(sum(case when o.dk = 0 then 0 else o.sq end), 0) / 100  - nvl(sum(case when o.dk = 1 then 0 else o.sq end), 0) / 100
          into l_cp_dgp_zv_row.g076                                                          --����--��������� --����� ����� �������� ������ �� ������ �� ���� � ������� ������ ������ �� ���� �� ������ �����
          from opldok o
         where o.acc = k.accs
--           and o.dk = 0
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to
--           and o.tt in ('FX%', '080', '013')
           ;


        select nvl(sum(o.sq), 0) / 100
          into l_cp_dgp_zv_row.g077                                                          --��������� �����, ���
          from opldok o
         where o.acc in (k.accr, k.accr2, k.accr3)
           and o.dk = 1
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to;
           --and o.tt in ('FX7', 'FX8', 'F80');

        insert into cp_dgp_zv values l_cp_dgp_zv_row;
      end loop;--�� ��������

      l_cp_dgp_zv_row.g078 := '-';
      l_cp_dgp_zv_row.g079 := '-';
      l_cp_dgp_zv_row.g080 := '-';
      l_cp_dgp_zv_row.g081 := '-';
      l_cp_dgp_zv_row.g082 := '-';
      l_cp_dgp_zv_row.g083 := '-';
      l_cp_dgp_zv_row.g084 := '-';
      l_cp_dgp_zv_row.g085 := '-';
      l_cp_dgp_zv_row.g086 := '-';
      l_cp_dgp_zv_row.g087 := '-';
      l_cp_dgp_zv_row.g088 := '-';

      if l_cnt_prod = 0 then --����� ������, ��� � ������ ����
        insert into cp_dgp_zv values l_cp_dgp_zv_row;
      end if;
      bars_audit.trace(G_TRACE || l_title || ' l_cnt =  '||l_cnt);
    end loop;
    close G_CUR;
    bars_audit.info(G_TRACE || l_title || ' Itog l_cnt =  '||l_cnt);
    send_msg('ʳ���� ���������� DGP007: ��� ��������� ���������� ��� ������� ���� ������ ͳ');                
    exception
      when others then
        bars_audit.error(G_TRACE || l_title || substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));
        if G_CUR%ISOPEN then
          close G_CUR;
        end if;
        send_msg('��� DGP007 ��� ��������� ������� �������: '||G_TRACE || l_title || substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));
        raise_application_error(-20001, G_TRACE || l_title || substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));
  end;

  /* ��������� ������� ��� ���� DGP-008:
     "���������� � ������� ���� ������"
  */
  procedure dgp8(p_date_from cp_dgp_zv.date_from%type,
                 p_date_to   cp_dgp_zv.date_to%type) is
    l_title         constant varchar2(25) := 'dgp8: ';
    l_cp_dgp_zv_row cp_dgp_zv%rowtype;
    l_nlsb_arr      string_list := string_list('1400','1404', '1410', '1412', '1420', '1430', '1435', '1440');
    l_cnt           pls_integer := 0;

    --���� ������ ��� ������� �� �������� �� ��� ��� ���� �������
    l_sd            number;--�������
    l_sp            number;--�����
    l_sr            number;--R
    l_sr2           number;--R2
    l_sr3           number;--R3
    l_ss            number;--����������
    l_sn            number;--������
    l_sb            number;--��������� ������� (���������� � ����/������ ���������)
    l_sr_ur         number;--������. ������
    l_sr_expr       number;--�����. ����� ���.
    l_rez           number;--���� �������
    ----------------
    l_zp            number;
    l_rp            number;
    --
    l_cena_bay_n    number;
    l_cena          number;
    l_kl            number;
    l_koeff         number;
    ----------------
    l_dat_k2        date;
    ----------------
    l_dnk           date;
    ----------------
    l_cnt_prod      pls_integer;
    l_days_cnt      pls_integer;
    l_is_default    number(1);
    --
    l_chr_start_time number;
    l_chr_end_time   number;
    --
    k               G_CUR%ROWTYPE;

  begin
    bars_audit.info(G_TRACE || l_title || ' OPEN CURSOR ');
    open G_CUR(l_nlsb_arr, p_date_from, p_date_to);
    bars_audit.info(G_TRACE || l_title || ' START LOOP ');
    loop
      FETCH G_CUR INTO k;
      EXIT WHEN G_CUR%NOTFOUND;
      l_cnt := l_cnt + 1;
      /*������� ��������*/
      l_cp_dgp_zv_row.ref       := k.ref;
      l_cp_dgp_zv_row.id        := k.id;
      l_cp_dgp_zv_row.type_id   := 8;
      l_cp_dgp_zv_row.date_from := p_date_from;
      l_cp_dgp_zv_row.date_to   := p_date_to;
      l_cp_dgp_zv_row.user_id   := user_id();
      l_cp_dgp_zv_row.date_reg  := sysdate;
      l_cp_dgp_zv_row.kf        := gl.kf;
      ---------
      l_cp_dgp_zv_row.g001 := k.nbs1;                                                       --!����� ����������� �������
      l_cp_dgp_zv_row.g002 := '�';                                                         --!���� (���/�)
      l_cp_dgp_zv_row.g003 := nvl(get_cp_kodw(k.id, 'TPCP'), get_type_bcp(k.id));          --!�� ����--�� �������(������ �����������, ��� ��������, ������ ���������� � ����)--��� ��������� ������� ������
      l_cp_dgp_zv_row.g004 := k.kv;                                                         --!������ (���)
      l_cp_dgp_zv_row.g005 := get_class_cp(k.id, k.nbs1, nvl(substr(k.nlsp, 1, 4), ''));    --!������������ ������ ������ (1-����������, 2-� �������� ��� �������, 3-��������� �� ���������)
      l_cp_dgp_zv_row.g006 := nvl(k.title, get_cp_kodw(k.id, 'OS_UM'));                     --!�������� ��������� ����
      l_cp_dgp_zv_row.g007 := nvl(k.nmk, '***');                                            --!����� �������
      l_cp_dgp_zv_row.g008 := k.okpo;                                                        --!��� ������
      l_cp_dgp_zv_row.g009 := case when k.prinsider = 99 then '�' else '���' end;           --!�� ����--�� ������� � ��������-������--���'����� ������� (���/�)

      select series
      into l_cp_dgp_zv_row.g010                                                             --!�� ����--������������--���� ��������
      from cp_ryn where ryn = k.ryn;

      l_cp_dgp_zv_row.g011 := nvl(get_cp_refw(k.ref, 'AUKC'), k.nd);                        --!����� ��������
      l_cp_dgp_zv_row.g012 := k.cp_id;                                                      --!̳��������� ���������������� ����� ������� ������ (ISIN)
      l_cp_dgp_zv_row.g013 := get_pay_period(k.ky);                                         --!����������� ������ ������
      /*��������� �����: ������� �� ������� ������*/
      l_cp_dgp_zv_row.g014 := to_char(k.dat_ug, 'DD.MM.YYYY');                              --!���� ��������� (� ������� ������ o.vdat dat_k)
      l_cp_dgp_zv_row.g015 := case when k.stiket is null then '���� �� ��������'
                                   else get_kontragent(k.ref) end;                          --!����� ��������
      l_cp_dgp_zv_row.g016 := to_char(nvl(get_hist_ir(k.id, p_date_from), k.ir),
                                      '99.99999');                                          --!³�������� ������ �� ������� ������� ������

      l_kl := k.sumn / k.nom; --������� ��������� � cp_arch
      if k.kv = 980 then
          l_cp_dgp_zv_row.g017 := round(k.s_kupl / l_kl, 2);                                  --!����--!!!!ֳ�� ��������� (Գ�������: ���� ���� ������, �� ���� ������� ������ ���� �� 1 �� )
          else
            l_cp_dgp_zv_row.g017 := round((gl.p_icurval(k.kv, k.s_kupl * 100, k.dat_k) / 100 ) / l_kl, 2);     -- -//- (� ���������)
      end if;

      l_cp_dgp_zv_row.g018 := get_count_cp(k.id, p_date_from - 1, k.cena, k.cena_start, k.acc,  --!ʳ������ �� ������� ������� ������, ��.
                                           l_sn);
      if k.kv = 980 then
          l_cp_dgp_zv_row.g019 := l_sn;                                                      --!��������� ������� �� ������� ������� ������
        else
          l_cp_dgp_zv_row.g019 := gl.p_icurval(k.kv, l_sn * 100, p_date_from - 1) / 100;     -- -//- (� ���������)
      end if;

      l_sd := 0; l_sp := 0;
      if k.accd is not null then
        l_sd := -rez.ostc96(k.accd, p_date_from - 1) / 100;
      end if;
      if k.accp is not null then
        l_sp := -rez.ostc96(k.accp, p_date_from - 1) / 100;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g020 := l_sd + l_sp;                                                 --!��������������� �������/����� �� ������� ������� ������
        else
          l_cp_dgp_zv_row.g020 := gl.p_icurval(k.kv, l_sd * 100, p_date_from - 1) / 100      -- -//- (� ���������)
                                + gl.p_icurval(k.kv, l_sp * 100, p_date_from - 1) / 100;
      end if;

      l_sr := 0; l_sr2 := 0; l_sr3 := 0; l_sr_ur := 0; l_sr_expr := 0;
      if k.accr is not null then
        l_sr := -rez.ostc96(k.accr, p_date_from - 1) / 100;
      end if;
      if k.accr2 is not null then
        l_sr2 := -rez.ostc96(k.accr2, p_date_from - 1) / 100;
      end if;
      if k.accr3 is not null then
        l_sr3 := -rez.ostc96(k.accr3, p_date_from - 1) / 100;
      end if;
      if k.accunrec is not null then
        l_sr_ur := -rez.ostc96(k.accunrec, p_date_from - 1) / 100; --�������� ������
      end if;
      if k.accexpr is not null then
        l_sr_expr := -rez.ostc96(k.accexpr, p_date_from - 1) / 100; --��������� �����. ���
      end if;

      if k.kv = 980 then
        l_cp_dgp_zv_row.g021 := l_sr + l_sr2 + l_sr3 - l_sr_ur + l_sr_expr;                  --!����--��������� (���% (R+R2+R3 - !!!R (������������)+ ������������!!!)--���������/ ����������/�������� ������� ������ �� ����� ��� ����� ����
        else
          l_cp_dgp_zv_row.g021 := gl.p_icurval(k.kv, l_sr * 100, p_date_from - 1) / 100      -- -//- (� ���������)
                                + gl.p_icurval(k.kv, l_sr2 * 100, p_date_from - 1) / 100
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_from - 1) / 100
                                - gl.p_icurval(k.kv, l_sr_ur * 100, p_date_from - 1) / 100
                                + gl.p_icurval(k.kv, l_sr_expr * 100, p_date_from - 1) / 100
                                ;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g022 := l_sr2 + l_sr3;                                                --!��������� ����������� �������� ����� �� ������� ������� ������
        else
          l_cp_dgp_zv_row.g022 := gl.p_icurval(k.kv, l_sr2 * 100, p_date_from - 1) / 100      ---//- (� ���������)
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_from - 1) / 100;
      end if;

      l_cp_dgp_zv_row.g023 := '-';                                                               --!�������? ���� �������, �������� ������������ �� ������� ������� ������ (����� ��������� � 23), ���

      l_rez := get_rezq39(k.ref, p_date_from);
      l_cp_dgp_zv_row.g024 := l_rez;                                                             --!����--��������� -- ���� �������, ������������� ����� ����� ���� 39 �� ������� ������� ������
      l_rez := nvl(l_rez, 0);

      l_ss := 0;
      if k.accs is not null then
        l_ss := -rez.ostc96(k.accs, p_date_from - 1) / 100;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g025 := l_ss;                                                        --!����--��������� --���� ���������� �� ������� ������� ������, ��������� �������� �� ����� ����
        else
          l_cp_dgp_zv_row.g025 := gl.p_icurval(k.kv, l_ss * 100, p_date_from - 1) / 100;     -- -//- (� ���������)
      end if;
      /*³������ ����� �� ����������:
            ���� ������������� �������  �� ����� ���������� (���� �� ���� ��) � ������ , ���� ���� �������������� ��������.
             ��� , ��� � ��� ������� �� ��������� ������� ������� (����).
            � �� ���� ��� ������, ��� �� ���� �����. �������� � �������� ������� �����, �� ��� �����������. �� ���������� �� ���?
        ���� ���� ����� ������ ������� ������� ������� �� ������� ����������
      */
      /* ������� �������� �� � ���������� ����������, ��� ���� �� �������������*/
      l_sb := l_sn + (l_sd + l_sp) + (l_sr + l_sr2 + l_sr3) - l_rez  + l_ss;
      if  k.kv = 980 then
        l_cp_dgp_zv_row.g026 := l_sb;                                                        --!����--��������� --��������� ������� �� ������� ������� ������ (����� ����)
        else
          l_cp_dgp_zv_row.g026 := gl.p_icurval(k.kv, l_sb * 100, p_date_from - 1) / 100;     -- -//- (� ���������)
      end if;

      l_days_cnt := get_days_delay(k.ref, p_date_to);
      /*�������� �� ���������� �� ������ Is_default  � Finevare (������� PRVN_FV_REZ)*/
      l_chr_start_time := dbms_utility.get_time;
      l_is_default := get_is_default(k.ref, p_date_from);
      l_chr_end_time := dbms_utility.get_time;
      if (l_chr_end_time - l_chr_start_time) / (100 * 60) > 1 then /*������*/
        bars_audit.info(G_TRACE || l_title || ' ������� get_is_default('||k.ref||','||p_date_from||') ���������� '||(l_chr_end_time - l_chr_start_time) / (100 * 60)||' ������');
      end if;
      if l_is_default = 1 then
        l_cp_dgp_zv_row.g027 := '4';                                                           --����-- �������� ����� �� ���� �� ��� ����� ����
        else
          if l_is_default = 0 and l_days_cnt = 0 then
            l_cp_dgp_zv_row.g027 := '1';
          elsif l_is_default = 0 and l_days_cnt <= 30  then
            l_cp_dgp_zv_row.g027 := '2';
          elsif l_is_default = 0 and l_days_cnt between 30+1 and 60  then
            l_cp_dgp_zv_row.g027 := '3';
          else
            l_cp_dgp_zv_row.g027 := '�������';
          end if;
      end if;

      l_cp_dgp_zv_row.g028  := get_riven(k.id, p_date_from);                                 --!����--��������� -- г���� �� ������� ������� ������
      /*��������� �����: ��������� �������� ������� ������*/
      if k.dat_k between p_date_from and p_date_to then
        l_dat_k2 := k.dat_k;
        else
          l_dat_k2 := null;
      end if;
      if l_dat_k2 is not null then
        l_sn := get_turnaround(k.ref, k.acc);
        if  k.kv = 980 then
          l_cp_dgp_zv_row.g029 := l_sn;                                                        --!��������� (������) �� ������ ����� (��������� �������)
          else
            l_cp_dgp_zv_row.g029 := gl.p_icurval(k.kv, l_sn * 100, l_dat_k2) / 100;            -- -//- (� ���������)
        end if;

        l_cena_bay_n := get_cena_voprosa(k.id, k.dat_k, k.cena, k.cena_start);
        l_kl         := round(l_sn / l_cena_bay_n, 0);
        l_cp_dgp_zv_row.g030 := l_kl;                                                           --! ��������� (������) �� ������ �����, �������
        if l_kl != 0 then
          if  k.kv = 980 then
            l_cp_dgp_zv_row.g031 := round(nvl(k.sumb, k.s_kupl) / l_kl, 2);                       --! ֳ�� ���������
            else
              l_cp_dgp_zv_row.g031 := gl.p_icurval(k.kv, round(nvl(k.sumb, k.s_kupl) / l_kl, 2) * 100, l_dat_k2) / 100; -- -//- (� ���������)
          end if;
        end if;
        l_cp_dgp_zv_row.g032 := k.s_kupl;                                                          --!����--��������� --���� �������� ��������� ����� �� ������� �� (���� �� ���������)

        l_sr := get_turnaround(k.ref, nvl(k.accr2, k.accr));
        /*if l_kl != 0 then
           l_cp_dgp_zv_row.g035 := round(l_sr / l_kl, 2);                                          --��������� -- ���� ��������� ����������� ������ � ��� ���������(1��???)
        end if;
       �:������ �� ����������� ������� � ������� ���� ����� ���������, �� �� �� ������� � ���� ������� �������� - 1 ��?
       ����: �� ���� ����� ���������� �����. � ����� ������� �� ����, ��� �������� � ���  �������� ��� ���������� ��� ��������. ��� ���� ����� ����� ������� ����� � ���� �������. �� ��� ������, ��� ��� ��� ������� �� 1418,1428 ��� 3118 � �� ���� �������� ��� ������� (R2 � R3)
       */
        l_cp_dgp_zv_row.g033 := l_sr;                                                              --!����


        l_cp_dgp_zv_row.g034 := f_operw(k.ref, 'CP_FC');                                         --!����--��������� --����� ���������� ����������

        l_cp_dgp_zv_row.g035 := to_char(l_dat_k2, 'DD.MM.YYYY');                                 --!���� ���������
        l_cp_dgp_zv_row.g036 := l_cp_dgp_zv_row.g015;                                            --!����� ��������

      end if;  --end l_dat_k2 is not null
      /*��������� �����: ������� �� ����� ������*/
      l_cp_dgp_zv_row.g049 := to_char(k.dat_pg, 'DD.MM.YYYY');                                   --!���� ���������

      select min(offer_date)
        into l_cp_dgp_zv_row.g050                                                                --!����--��������� -- ���� ������ (��������� ���� ����� ����)
        from cp_dat
        where id = k.id
          and dok > p_date_to;
      begin
        select nvl(a.dok, k.dat_pg)
          into l_dnk
          from cp_dat a
         where a.id = k.ID
           and a.DOK = (select min(dok)
                          from cp_dat
                         where id = k.id
                           and dok > p_date_to);

        exception
          when NO_DATA_FOUND then
            l_dnk := null;
      end;
      l_cp_dgp_zv_row.g051 := to_char(l_dnk, 'DD.MM.YYYY');                                      --! ���� ������� ������ (��������� ���� ����� ����)
      l_cp_dgp_zv_row.g052 := to_char(nvl(get_hist_ir(k.id, p_date_to), k.ir),
                                      '99.99999');                                               --! ³�������� ������ �� ����� ��� ����� ����

      l_sn := -rez.ostc96(k.acc, p_date_to+1) / 100;
      l_cena := get_cena_voprosa(k.id, p_date_to+1, k.cena, k.cena_start);
      l_cp_dgp_zv_row.g053 := round(l_sn / l_cena, 0);                                           --!ʳ������ ������ �� ����� ��� ����� ����
      if  k.kv = 980 then
          l_cp_dgp_zv_row.g054 := l_sn;                                                        --!��������� ������� �� ����� ��� ����� ����
          else
            l_cp_dgp_zv_row.g054 := gl.p_icurval(k.kv, l_sn * 100, p_date_to+1) / 100;         -- -//- (� ���������)
      end if;

      l_sd := 0; l_sp := 0;
      if k.accd is not null then
        l_sd := -rez.ostc96(k.accd, p_date_to+1) / 100;
      end if;
      if k.accp is not null then
        l_sp := -rez.ostc96(k.accp, p_date_to+1) / 100;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g055 := l_sd + l_sp;                                                 --!��������������� �������/����� �� ����� ��� ����� ����
        else
          l_cp_dgp_zv_row.g055 := gl.p_icurval(k.kv, l_sd * 100, p_date_to+1) / 100      -- -//- (� ���������)
                                + gl.p_icurval(k.kv, l_sp * 100, p_date_to+1) / 100;
      end if;

      l_sr := 0; l_sr2 := 0; l_sr3 := 0;
      if k.accr is not null then
        l_sr := -rez.ostc96(k.accr, p_date_to+1) / 100;
      end if;
      if k.accr2 is not null then
        l_sr2 := -rez.ostc96(k.accr2, p_date_to+1) / 100;
      end if;
      if k.accr3 is not null then
        l_sr3 := -rez.ostc96(k.accr3, p_date_to+1) / 100;
      end if;
      if k.accunrec is not null then
        l_sr_ur := -rez.ostc96(k.accunrec, p_date_to+1) / 100; --�������� ������
      end if;
      if k.accexpr is not null then
        l_sr_expr := -rez.ostc96(k.accexpr, p_date_to+1) / 100; --��������� �����. ���
      end if;

      if k.kv = 980 then
        l_cp_dgp_zv_row.g056 := l_sr + l_sr2 + l_sr3 - l_sr_ur + l_sr_expr;                  --!����--��������� G022 --���������/ ����������/�������� ������� ������ �� ����� ��� ����� ����
        else
          l_cp_dgp_zv_row.g056 := gl.p_icurval(k.kv, l_sr * 100, p_date_to+1) / 100      -- -//- (� ���������)
                                + gl.p_icurval(k.kv, l_sr2 * 100, p_date_to+1) / 100
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_to+1) / 100
                                - gl.p_icurval(k.kv, l_sr_ur * 100, p_date_to+1) / 100
                                + gl.p_icurval(k.kv, l_sr_expr * 100, p_date_to+1) / 100
                                ;
      end if;

      if k.kv = 980 then
        l_cp_dgp_zv_row.g057 := l_sr2 + l_sr3;                                             --!����������� (�����������) �������� ����� �� ����� ��� ����� ����
        else
          l_cp_dgp_zv_row.g057 := gl.p_icurval(k.kv, l_sr2 * 100, p_date_to+1) / 100
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_to+1) / 100 ;      -- -//- (� ���������)
      end if;

      l_cp_dgp_zv_row.g058 := '-';                                                        --!������� ��������?--���������-- ���� �������, �������� ������������ �� ����� ��� ����� ����, ��� (����� ��������� � 23)

      l_rez := get_rezq39(k.ref, p_date_to);
      l_cp_dgp_zv_row.g059 := l_rez;                                                      --!����--��������� g025-- ���� �������, ������������� ����� ����� ���� 39 �� ����� ��� ����� ����
      l_rez := nvl(l_rez,0);

      l_ss := 0;
      if k.accs is not null then
        l_ss := -rez.ostc96(k.accs, p_date_to+1) / 100;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g060 := l_ss;                                                        --!��������� --���� ���������� �� ����� ��� ����� ����, ��������� �������� �� ����� ����
        else
          l_cp_dgp_zv_row.g060 := gl.p_icurval(k.kv, l_ss * 100, p_date_to+1) / 100;     -- -//- (� ���������)
      end if;

      l_sb := l_sn + (l_sd + l_sp) + (l_sr + l_sr2 + l_sr3) - l_rez  + l_ss;
      if  k.kv = 980 then
        l_cp_dgp_zv_row.g061 := l_sb;                                                        --!����--��������� G027--��������� ������� �� ����� ��� ����� ���� (����� ����)
        else
          l_cp_dgp_zv_row.g061 := gl.p_icurval(k.kv, l_sb * 100, p_date_to+1) / 100;     -- -//- (� ���������)
      end if;

      /*���������: ����� �� ��� � ��� ���������� . �� ������ ������ ���������� = ������������, �� � ������� �������� �� �����, � � �� 1 ��*/
      if l_sn = 0 then
        l_sb := null;
        else
          l_sb := round(l_sb / round(l_sn / l_cena, 0), 2);
      end if;
      if  k.kv = 980 then
        l_cp_dgp_zv_row.g062 := l_sb;                                                        --!����--���������--����������� ������� �� ����� ���� 39 �� ����� ���� �� 1 ��
        else
          l_cp_dgp_zv_row.g062 := gl.p_icurval(k.kv, l_sb * 100, p_date_to+1) / 100;     -- -//- (� ���������)
      end if;


      l_days_cnt := get_days_delay(k.ref, p_date_to);
      /*�������� �� ���������� �� ������ Is_default  � Finevare (������� PRVN_FV_REZ)*/
      l_chr_start_time := dbms_utility.get_time;
      l_is_default := get_is_default(k.ref, p_date_to+1);
      l_chr_end_time := dbms_utility.get_time;
      if (l_chr_end_time - l_chr_start_time) / (100 * 60) > 1 then /*������*/
        bars_audit.info(G_TRACE || l_title || ' ������� get_is_default('||k.ref||','||to_char(p_date_to+1, 'DD.MM.YYYY')||') ���������� '||(l_chr_end_time - l_chr_start_time) / (100 * 60)||' ������');
      end if;
      if l_is_default = 1 then
        l_cp_dgp_zv_row.g063 := '4';                                                           --����-- --��������� g027-- �������� ����� �� ���� �� ����� ��� ����� ����
        else
          if l_is_default = 0 and l_days_cnt = 0 then
            l_cp_dgp_zv_row.g063 := '1';
          elsif l_is_default = 0 and l_days_cnt <= 30  then
            l_cp_dgp_zv_row.g063 := '2';
          elsif l_is_default = 0 and l_days_cnt between 30+1 and 60  then
            l_cp_dgp_zv_row.g063 := '3';
          else
            l_cp_dgp_zv_row.g063 := '�������';
          end if;
      end if;

      l_cp_dgp_zv_row.g064 := get_riven(k.id, p_date_to);                                    --!����--��������� g030-- г���� ������ �� ����� ����


      /*��� ��� � ����� �������,
        ���� �� ���� ������� ��������� ������� ����� � ��� �� ������� �������
        (������� 0 �� ������� �� 0 ��������� :-) )
        [������ ��� �� ������� ���������� ������ ��� �� ������]
      */
      l_cnt_prod := 0;
      for p in (select o.ref,
                  pp.nd,
                  pp.s / 100 s_p, -- ���� ����� ������� ������ ������
                  o.s / 100 s,
                  o.stmt,
                  o.tt,
                  decode(vob, 096, pp.vdat, o.fdat) dat_opl,
                  pp.datp dat_ug,
                  ar.op ar_op,
                  nvl(ar.sumb, 0) / 100  ar_sumb,
                  nvl(ar.n, 0) / 100 ar_n,
                  pp.nazn
             from opldok o, oper pp, cp_arch ar
            where o.acc = k.acc
              and o.dk = 1
              and o.ref = pp.ref
              and o.ref = ar.ref(+)
              and o.fdat between p_date_from and p_date_to
              and o.sos = 5
              and pp.nazn like '������%'
            order by 1)
      loop
        l_cnt_prod := l_cnt_prod + 1;
        bars_audit.info(G_TRACE || l_title || ' l_cnt_prod =  '||l_cnt_prod||' k.acc='||k.acc||' ref_sale='||p.ref||' ref_buy='||k.ref||' nazn='||p.nazn);
        /*��������� �����: ��������� �������� ������� ������*/
        /*�������*/
        l_cp_dgp_zv_row.ref_sale := p.ref;
        -------
        if k.kv = 980 then
          l_cp_dgp_zv_row.g037 := p.s;                                                        --!��������� (���������) �� ������ ����� (��������� �������)
          else
            l_cp_dgp_zv_row.g037 := gl.p_icurval(k.kv, p.s * 100, p.dat_opl) / 100;     -- -//- (� ���������)
        end if;

        if k.cena != k.cena_start then
          -- ��������� ��������� ���� 1 ��
          begin
            select k.cena_start - sum(nvl(a.nom, 0)) +
                   sum(decode(a.dok, k.dat_pg, nvl(a.nom, 0), 0))
              into l_cena --  6/04-15
              from cp_dat a
             where a.id = k.ID
               and a.DOK <= p.dat_opl;
             exception
               when NO_DATA_FOUND then l_cena := k.cena;
          end;
        else
          l_cena := k.cena; -- ���������
        end if;

        l_kl := round(p.s / nvl(l_cena, k.cena), 0);
        l_cp_dgp_zv_row.g038 := l_kl;                                                        --!��������� (���������) �� ������ �����, �������

        if p.ar_op in (2, 3) then
          if nvl(l_kl, 1) != 0 then
            l_sn := case when nvl(p.ar_n, 0) = 0 then p.s else p.ar_n end;
            l_koeff := round(p.s / l_sn, 5);
            l_cena := round(nvl(p.ar_sumb, p.s_p) * l_koeff / nvl(l_kl, 1), 2);
          end if;
          elsif p.ar_op = 20 then
            l_cena := f_cena_cp(k.id, p.dat_opl);
          elsif p.ar_op = 22 then
            begin
              select nvl(nom, 0)
                into l_cena
                from cp_dat a
               where a.id = k.ID
                 and a.dok = (select max(dok)
                                from cp_dat
                               where id = k.id
                                 and dok < p.dat_opl);
            exception
              when NO_DATA_FOUND then
                l_cena := 0;
            end;
          else
            l_cena := 0;
        end if;

        if k.kv = 980 then
          l_cp_dgp_zv_row.g039 := l_cena;                                                        --!ֳ�� ���������
          else
            l_cp_dgp_zv_row.g039 := gl.p_icurval(k.kv, l_cena * 100, p.dat_opl) / 100;     -- -//- (� ���������)
        end if;

        if k.kv = 980 then
          l_cp_dgp_zv_row.g040 := p.s_p;                                                        --!����--���� �������� ��������� ����� �� ������ �� (���� �� ���������)
          else
            l_cp_dgp_zv_row.g040 := gl.p_icurval(k.kv, p.s_p * 100, p.dat_opl) / 100;     -- -//- (� ���������)
        end if;

        select sum(o.sq) / 100 -- ������ �� R/R2 ��� �������
          into l_cp_dgp_zv_row.g041                                                          --!����������� �������� �����, ��������� � ��� ���������
          from opldok o
         where o.acc in (k.accr, k.accr2)
           and o.dk = 1
           and o.sos = 5 -- !? OBU/BARS
           and o.ref = p.ref;

        l_cp_dgp_zv_row.g042 := f_operw(p.ref, 'CP_FC');                                     --!����--��������� G036 --����� ���������� ����������

        l_cp_dgp_zv_row.g043 := to_char(p.dat_opl, 'DD.MM.YYYY');                            --! ���� ���������

        l_cp_dgp_zv_row.g044 := nvl(nvl(get_cp_refw(p.ref, 'BRDOG'), get_cp_refw(k.ref, 'BRDOG')), p.nd);  --!����� ������ �����

        l_cp_dgp_zv_row.g045 := trim(get_kontragent(p.ref,
                                             '� �����������'));                              --!����� �������

        if k.vydcp_id is null then
           l_cp_dgp_zv_row.g046 := substr(get_cp_kodw(k.id, 'VYDCP'), 1, 255);                 --!����--��������� --��� ������� ������
           else 
             begin
               select title
               into l_cp_dgp_zv_row.g046
               from cp_vydcp
               where id = k.vydcp_id;
             exception 
               when NO_DATA_FOUND then
                    l_cp_dgp_zv_row.g046 := '�� �������� ����� �� ���� '||k.vydcp_id;
             end;               
        end if;  
        l_cp_dgp_zv_row.g047 := f_operw(p.ref, 'CP_VD');                                    --!����--��������� --��� ��������/���������
        if l_cp_dgp_zv_row.g047 is null then
           l_cp_dgp_zv_row.g047 := get_cp_refw(p.ref, 'VDOGO');                                
        end if;  
        l_cp_dgp_zv_row.g048 := f_operw(p.ref, 'CP_VO');                                    --!����--��������� --��� ��������
        if l_cp_dgp_zv_row.g048 is null then
           l_cp_dgp_zv_row.g048 := get_cp_refw(p.ref, 'VOPER');                                
        end if;   


        /*��������� �����: ������ �� ������� ��������, ������� �������� ������� ������*/

        select sum(decode(o.dk, 0, 1, 1, -1) * o.sq) / 100
          into l_rp                                                                         --������������� ��������� �� �������
          from opldok o, opldok o2, accounts ak
         where o.dk = 1 - o2.dk
           and o.stmt = o2.stmt
           and o.tt = 'FXT'
           and o2.tt = 'FXT'
           and o.ref = o2.ref
           and o.ref = p.ref
           and ak.acc = o2.acc
           and (
                ak.nls like '6393%' or ak.nls like '6203%' or ak.nls like '3800%' -- OBU
               )
           and o.sos = 5;

        select sum(decode(o.dk, 0, 1, 1, -1) * o.sq) / 100
          into l_zp                                                                         --3115 - ��������� ���������� ��� ������
          from opldok o, opldok o2, cp_deal d
         where o.dk = 1 - o2.dk
           and o.stmt = o2.stmt
/*           and o.tt = 'FX7'
           and o2.tt = 'FX7'*/
           and o.ref = o2.ref
           and o.ref = p.ref
           and d.accs = o2.acc
           and o.sos = 5;

        l_cp_dgp_zv_row.g065 := l_rp + l_zp;                                                --!����--������������� ����� ��������--�������� ����� �������� ������� ������
        /*!!!!!!! ������� �� �����������  (� �.�. ����������� ��������/���쳿)*/
        select /*nvl(sum(o.s), 0) / 100, */nvl(sum(o.sq), 0) / 100 -- �� R ��� ���������� �� 605
          into l_cp_dgp_zv_row.g066                                                          --����--��������� ���� ����������� ������ �������� ������� ������(� �.�. ����������� ��������/���쳿)
          from opldok o --, OPER P
         where o.acc = k.accr
           and o.dk = 0 --and o.ref=p.ref
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to --and o.tt in ('FXU','FXU'
--           and o.tt in ('FX%', '080', '013')
           ;

        select sum(decode(o1.dk, 0, 1, 1, -1) * o1.sq) / 100
          into l_cp_dgp_zv_row.g067                                                         --!����--6390 dk= 1, 7390 dk = 0 --������������--��������� --�������� ���������� ��� ��������� ������� (������� 6390,7390)
          from opldok o1, opldok k1, accounts ak
         where o1.dk = 1 - k1.dk
           and o1.stmt = k1.stmt
/*           and o.tt = 'FXT'
           and k.tt = 'FXT'*/
           and o1.ref = k1.ref
           and o1.ref = /*p.ref*/ k.ref /*��� ����� � ? */
           and ak.acc = k1.acc
           and (
                ak.nls like '6390%' or ak.nls like '7390%'
               )
           and o1.sos = 5;


        l_cp_dgp_zv_row.g068 := '-';                                                        --!��������� --������� ������, ��� ������ �� ��� ������� ��������� ������ (������ �� ������ �� ���� ����������� � ������ �� ���� �������� ������� ��������� �������), ���.
        /* Գ�������: ������ �� ������ ��� �������,  ���� �� ������  ������ � ������ �� ���������� �� �������� ����������. */

        l_cp_dgp_zv_row.g069 := '-';                                                        --!��������� ����� ��������--��������� ���������� ������� �������� ���� �������� ����� �������� ������� ������
       /* ��������: ��, � ����� ������� ������������, �� ������, ��� ������ �� ���� �������, �� �� ��� ����� � ��� ����� ��������...
                   ������, ��� � ��������� ����� ������ ���������*/


        select /*nvl(sum(o.s), 0) / 100, */nvl(sum(o.sq), 0) / 100 -- �� R ��� ���������� �� 605
          into l_cp_dgp_zv_row.g070                                                          --!����--��������� ���� ����������� ������ �������� ������� ������
          from opldok o --, OPER P
         where o.acc = k.accr
           and o.dk = 0 --and o.ref=p.ref
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to --and o.tt in ('FXU','FXU'
--           and o.tt in ('FX%', '080', '013')
           ;

        /*!*/--l_cp_dgp_zv_row.g071 := '-';                                                        --��������� �����.����� �� ������ �����
        select nvl(sum(o.sq), 0) / 100
          into l_cp_dgp_zv_row.g071                                                          --��������� �����, ���
          from opldok o
         where o.acc in (k.accr, k.accr2, k.accr3)
           and o.dk = 1
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to;
           --and o.tt in ('FX7', 'FX8', 'F80');

        select /*nvl(sum(o.s), 0) / 100,*/ nvl(sum(o.sq), 0) / 100 -- �� D ��� ����������� �� 6
            into l_cp_dgp_zv_row.g072                                                        --!����--��������� --����������� �������� �������� ������� ������
            from opldok o
           where o.acc = k.accd
             and o.dk = 0
             and o.sos = 5
             and o.fdat >= p_date_from
             and o.fdat <= p_date_to
             --and o.tt in ('FXM', '080', '013')
             ;

        select /*nvl(sum(o.s), 0) / 100,*/ nvl(sum(o.sq), 0) / 100 -- �� D ��� ����������� �� 6
            into l_cp_dgp_zv_row.g073                                                        --!����--��������� --����������� ���쳿 �������� ������� �����
            from opldok o
           where o.acc = k.accp
             and o.dk = 0
             and o.sos = 5
             and o.fdat >= p_date_from
             and o.fdat <= p_date_to
             --and o.tt in ('FXM', '080', '013')
             ;



        /* Գ�������: ��������: ���� ������, �� ��� �� ��� ������ ( ���� ��� � �����) ���� ��������� ����������. � ������ ��� ���� �������� (��1415, ��5102),
                      � ��������� ��� ������- ������ (��5102 �� 1415). � ���������� �� ����� 1415 � �������� � ��� ���� � �� � ��.
                      �����: �� ����� �� ����� �����  �� ������ (+) ��� (-). */
        select nvl(sum(case when o.dk = 0 then 0 else o.sq end), 0) / 100  - nvl(sum(case when o.dk = 1 then 0 else o.sq end), 0) / 100
          into l_cp_dgp_zv_row.g074                                                          --!����--��������� --����� ����� �������� ������ �� ������ �� ���� � ������� ������ ������ �� ���� �� ������ �����
          from opldok o
         where o.acc = k.accs
--           and o.dk = 0
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to
--           and o.tt in ('FX%', '080', '013')
           ;


        insert into cp_dgp_zv values l_cp_dgp_zv_row;
      end loop;--�� ��������

      l_cp_dgp_zv_row.g075 := '-';
      l_cp_dgp_zv_row.g076 := '-';
      l_cp_dgp_zv_row.g077 := '-';
      l_cp_dgp_zv_row.g078 := '-';
      l_cp_dgp_zv_row.g079 := '-';
      l_cp_dgp_zv_row.g080 := '-';
      l_cp_dgp_zv_row.g081 := '-';
      l_cp_dgp_zv_row.g082 := '-';
      l_cp_dgp_zv_row.g083 := '-';
      l_cp_dgp_zv_row.g084 := '-';
      l_cp_dgp_zv_row.g085 := '-';
      l_cp_dgp_zv_row.g086 := '-';

      if l_cnt_prod = 0 then --����� ������, ��� � ������ ����
        insert into cp_dgp_zv values l_cp_dgp_zv_row;
      end if;
      bars_audit.trace(G_TRACE || l_title || ' l_cnt =  '||l_cnt);
    end loop;
    close G_CUR;
    bars_audit.info(G_TRACE || l_title || ' Itog l_cnt =  '||l_cnt);
    send_msg('ʳ���� ���������� DGP008: ��� ��������� ���������� ��� ������� ���� ������ ͳ');            
    exception
      when others then
        bars_audit.error(G_TRACE || l_title || substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));
        if G_CUR%ISOPEN then
          close G_CUR;
        end if;
        send_msg('��� DGP008 ��� ��������� ������� �������: '||G_TRACE || l_title || substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));        
        raise_application_error(-20001, G_TRACE || l_title || substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));
  end dgp8;


  procedure info_report_progress(p_date_from cp_dgp_zv.date_from%type,
                                 p_date_to   cp_dgp_zv.date_to%type,
                                 p_type_id   cp_dgp_zv_type.type_id%type) is
  pragma autonomous_transaction;
  /*
    - �� ���� ���� ����� ���������� ���� � ��� ����������� �� ��������
    - ��� ������� ���� ������� ������ "ͳ", ��� �� �������� ��� ������� ������ ���������� ��� ��� �����
  */
    l_id        cp_kod.id%type;
    l_cp_dgp_zv cp_dgp_zv%rowtype;
  begin

    delete from cp_dgp_zv
     where user_id = user_id()
       and type_id = p_type_id;


    select id into l_id from cp_kod where rownum = 1;
    l_cp_dgp_zv.id          := l_id;
    l_cp_dgp_zv.user_id     := user_id();
    l_cp_dgp_zv.ref         := 0;
    l_cp_dgp_zv.type_id     := p_type_id;
    l_cp_dgp_zv.date_from   := p_date_from;
    l_cp_dgp_zv.date_to     := p_date_to;
    l_cp_dgp_zv.date_reg    := sysdate;
    l_cp_dgp_zv.kf          := gl.kf;
    l_cp_dgp_zv.g001        := '��� �� '||to_char(p_date_from,'DD.MM.YYYYY')||'-'||to_char(p_date_to,'DD.MM.YYYY');
    l_cp_dgp_zv.g002        := '�������� � '||to_char(sysdate,'HH24:MI DD.MM.YYYY');
    l_cp_dgp_zv.g003        := '��� ��������� ��� ����� �� �� �������';
    insert into  cp_dgp_zv values l_cp_dgp_zv;
    commit;
  end;


  procedure prepare_dgp(p_date_from cp_dgp_zv.date_from%type,
                        p_date_to   cp_dgp_zv.date_to%type,
                        p_type_id   cp_dgp_zv_type.type_id%type) is
    l_title      constant varchar2(25) := 'prepare_dgp: ';
    l_date_from  cp_dgp_zv.date_from%type := nvl(p_date_from, gl.bd);
    l_date_to    cp_dgp_zv.date_to%type   := nvl(p_date_to, gl.bd);
  begin
    bars_audit.info(G_TRACE || l_title || ' Start p_date_from=>' ||
                    p_date_from || ' p_date_to=>' || p_date_to ||
                    ' p_type_id=>' || p_type_id);
    info_report_progress(l_date_from, l_date_to, p_type_id);--�������� ���������� ����������� ��� ����� ������� (� ��� � ������� ���������� �� ���������������� ����)
    delete from cp_dgp_zv
     where user_id = user_id()
       and type_id = p_type_id;
    case p_type_id
      when 7 then
        dgp7(l_date_from, l_date_to);
      when 8 then
        dgp8(l_date_from, l_date_to);
    end case;
    bars_audit.info(G_TRACE || l_title || ' End');
  end prepare_dgp;

end cp_rep_dgp;
/
 show err;
 
PROMPT *** Create  grants  BARS_ALIEN_PRIVS ***
grant EXECUTE                                                                on cp_rep_dgp to WR_ALL_RIGHTS;
grant EXECUTE                                                                on cp_rep_dgp to BARS_ACCESS_DEFROLE;