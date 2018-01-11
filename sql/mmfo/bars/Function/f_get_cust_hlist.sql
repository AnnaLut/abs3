
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_cust_hlist.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_CUST_HLIST (
  p_rnk number,
  p_par number,
  p_dat date ) return varchar2
is
-- ============================================================================
--                    f_get_cust_hlist - ��� ��
--                      VERSION 16.7 (04/11/2016)
-- ============================================================================
/*
 ������ ���������� ��� AWK.exe ���  AW.bat
 -- NDR  �����
 -- UPB  ��� - ������ �������� ������
 -- SBER ����
 �����:   AW f_get_cust_hlist.sql f_get_cust_hlist.<xxx> <���������>
 AW f_get_cust_hlist.sql f_get_cust_hlist.sb   SBER    * ��� �����
 AW f_get_cust_hlist.sql f_get_cust_hlist.ndr  NDR     * ��� �����
 AW f_get_cust_hlist.sql f_get_cust_hlist.upb  UPB     * ��� ���
*/

--    SBER ����

  l_ret varchar2(32000) := null;
  l_turn_out      number;
  l_turn_out_prev number;
  l_delta_out     number;
  l_turn_in       number;
  l_turn_in_prev  number;
  l_delta_in      number;
  l_custtype      number(3);
  l_count         number;
begin

  pul.set_mas_ini('DAT', to_char(p_dat, 'dd/MM/yyyy'), '�������� ����');

  if    p_par = 1 then
     -- �������� ���������� �����

     for k in ( select distinct substr(p.name, 1, decode(nvl(instr(lower(p.name),','),0), 0, 30, instr(lower(p.name),',')-1)) name
                  from accounts a, ps p
                 where a.rnk   = p_rnk
                   and a.nbs   = p.nbs
                   and a.daos <= p_dat
                   and ( a.dazs is null or a.dazs > p_dat)
                   and ( p.d_close is null or p.d_close > p_dat )
                   and p.sb in ('B','V')
                   and lower(p.name) not like '�����' )
     loop
        l_ret := substr(l_ret || k.name || '; ', 1, 6000);
     end loop;

  elsif p_par = 2 then
     -- �������� ������ �������

     for k in (select nls, kv
                 from accounts
                where rnk   = p_rnk
                  and daos <= p_dat
                  and ( dazs is null or dazs > p_dat)
                  and substr(nbs,1,1) not in ('8','9')
                  and ( nbs in ('2600', '2601', '2602', '2604', '2605', '2606', '2610', '2611', '2615', '2620', '2622', '2625', '2630', '2635', '2640',
                                '2641', '2642', '2643', '2650', '2651', '2652', '2655', '2560', '2570') or (nbs = '2603' and kv = 980)  )
              )
     loop
        l_ret := substr(l_ret || k.nls || '/' || to_char(k.kv) || '; ', 1, 6000);
     end loop;

  elsif p_par = 3 then
     -- �������� ���, ��������� � ��������

     for k in ( select r.relatedness || ' ' || b.name bun
                  from cust_bun_bydate b, cust_rel r
                 where b.rnka   = p_rnk
                   and b.id_rel = r.id )
     loop
        l_ret := substr(l_ret || trim(k.bun) || '; ', 1, 6000);
     end loop;

  elsif p_par = 4 then
     -- �����_� ��_�, ������������� �_��� �_� _���_ ��_����


     for k in ( select tr.position || decode(tr.position,'','',': ') || tr.name || ', ' || p.name || ' ' || tr.doc_serial || ' ' || tr.doc_number ||
                       decode(tr.doc_issuer,'','',' ������� ') || tr.doc_issuer || ' ' || to_char(tr.doc_date, 'dd/mm/yyyy') ||
                       decode(tr.birthday,'','',', ���� �����. ') || to_char(tr.birthday, 'dd/mm/yyyy') || decode(tr.okpo_u,'','',', ���� ') || tr.okpo_u ||
                       decode(tr.adr,'','',', ������ ') || tr.adr   trust
                  from TRUSTEE_DOCUMENT_TYPE tdt, cust_bun_bydate tr, passp p
                 where tr.rnka    = p_rnk
                   and((p_dat between tr.bdate and tr.edate)
                   or (p_dat>=tr.bdate and tr.edate is null)
                   or (tr.bdate is null and p_dat<=tr.edate)
                   or (tr.bdate is null and tr.edate is null))
                   and tr.id_rel  = 20
                   and tr.document_type_id = tdt.id(+)
                   and tr.doc_type = p.passp(+)   )
     loop
        l_ret := substr(l_ret || trim(k.trust) || '; ', 1, 6000);
     end loop;

/*  elsif p_par = 42 then
     -- �����_� ��_�, ������������� �_��� �_� _���_ ��_����


     for k in ( select tr.position || ': ' || tr.name || ', ' || p.name || ' ' || tr.doc_serial || ' ' || tr.doc_number ||
                       decode(tr.doc_issuer,'','',' ���. ') || tr.doc_issuer || ' ' || to_char(tr.doc_date, 'dd/mm/yyyy') ||
                       decode(tr.birthday,'','',', ���� �����. ') || to_char(tr.birthday, 'dd/mm/yyyy') || decode(tr.okpo_u,'','',', ���� ') || tr.okpo_u ||
                       decode(tr.adr,'','',', ������ ') || tr.adr   trust
                  from TRUSTEE_DOCUMENT_TYPE tdt, cust_bun_bydate tr, passp p
                 where tr.rnka    = p_rnk
                   and tr.id_rel  = 20
                   and tr.document_type_id = tdt.id(+)
                   and tr.doc_type = p.passp(+)   )
     loop
        l_ret := substr(l_ret || trim(k.trust) || '; ', 2001, 6000);
     end loop;

  elsif p_par = 43 then
     -- �����_� ��_�, ������������� �_��� �_� _���_ ��_����


     for k in ( select tr.position || ': ' || tr.name || ', ' || p.name || ' ' || tr.doc_serial || ' ' || tr.doc_number ||
                       decode(tr.doc_issuer,'','',' ���. ') || tr.doc_issuer || ' ' || to_char(tr.doc_date, 'dd/mm/yyyy') ||
                       decode(tr.birthday,'','',', ���� �����. ') || to_char(tr.birthday, 'dd/mm/yyyy') || decode(tr.okpo_u,'','',', ���� ') || tr.okpo_u ||
                       decode(tr.adr,'','',', ������ ') || tr.adr   trust
                  from TRUSTEE_DOCUMENT_TYPE tdt, cust_bun_bydate tr, passp p
                 where tr.rnka    = p_rnk
                   and tr.id_rel  = 20
                   and tr.document_type_id = tdt.id(+)
                   and tr.doc_type = p.passp(+)   )
     loop
        l_ret := substr(l_ret || trim(k.trust) || '; ', 4001, 6000);
     end loop;    */

  elsif p_par = 5 then
     -- �_������_ ���� ��������� ��_�  (³������ ��� ������ ��������� �� �� ������������ �����)


     for k in ( select b.notes ||' ' || b.name || ', ' || p.name || ' ' || b.doc_serial || ' ' || b.doc_number || decode(b.doc_date,'','',', ������� ') ||
                        to_char(b.doc_date,'dd/mm/yyyy') || decode(b.doc_issuer,'','',decode(b.doc_date,'',' ������� � �.',' � �.')) || b.doc_issuer ||
                        decode(b.okpo_u,'','',' ��� ') || b.okpo_u ||
                        decode(b.birthday,'','',', ���� ���������� ') || to_char(b.birthday, 'dd/mm/yyyy') ||
                        decode(b.adr,'','',', ����� �� ������� ') || b.adr    posad
                  from cust_bun_bydate b, passp p
                 where b.rnka   = p_rnk
                   and b.id_rel = 26 -- �������_ ����� � cust_rel
                   and b.doc_type = p.passp(+)
                   and b.custtype_u = 2 --(������)
           )


     loop
        l_ret := substr(l_ret || trim(k.posad) || '; ', 1, 6000);
     end loop;


  elsif p_par = 6 then
     -- �������_ _������ �����_

     for k in (  select b.name || ', ' || p.name || ' ' || b.doc_serial || ' ' || b.doc_number ||
                        decode (b.doc_issuer,'','',', ������� ')      || b.doc_issuer ||' '||
                        to_char(b.doc_date,'dd/mm/yyyy')  || ' �.'    ||
                        decode(b.okpo_u,'','',' ��� ') || b.okpo_u ||
                        decode(b.birthday,'','',', ���� ���������� ') || to_char(b.birthday, 'dd/mm/yyyy') ||
                        decode(b.adr,'','',', ����� �� ������� ') || b.adr ||
                        decode(b.vaga1,'','','. ���� ����� �����i ') || b.vaga1 || decode(b.vaga1,'','','% ') ||
                        decode(b.vaga2,'','','. ���� ��������. �����i ') || b.vaga2 || decode(b.vaga2,'','','% ') VLASN
                  from cust_bun_bydate b, passp p
                 where b.rnka   = p_rnk
                   and b.id_rel = 1  -- �������_ _������ �����_ � cust_rel
                   and b.doc_type = p.passp(+)
                  -- and b.custtype_u >= 2
                   group by  b.name, p.name ,b.doc_serial, b.doc_number, b.doc_date, doc_issuer,b.okpo_u,b.birthday,b.adr,b.tel,b.vaga1,b.vaga2 )

     loop
        l_ret := substr(l_ret || trim(k.vlasn) || '; ', 1, 6000);
     end loop;

  elsif p_par = 7 then
     -- ����� ��������������� �����

     for k in (  select b.name || ', ' || p.name || ' ' || b.doc_serial || ' ' || b.doc_number || decode(b.doc_date,'','',', ������� ') ||
                        to_char(b.doc_date,'dd/mm/yyyy') || decode(b.doc_issuer,'','',decode(b.doc_date,'',' ������� � �.',' � �.')) || b.doc_issuer ||
                        decode(b.okpo_u,'','',', ��� ') || b.okpo_u ||
                        decode(b.birthday,'','',', ���� ���������� ') || to_char(b.birthday, 'dd/mm/yyyy') ||
                        decode(b.adr,'','',', ����� �� ������� ') || b.adr ||
                        decode(b.tel,'','',', ���. ') || b.tel ||
                        decode(b.vaga1,'','','. ���� ������� ������ ') || b.vaga1 || decode(b.vaga1,'','','% ') ||
                        decode(b.vaga2,'','','. ���� ��������. ������ ') || b.vaga2 || decode(b.vaga2,'','','% ')||
            decode(b.notes,'','','. �_������ ������ - ') || b.notes vpl
                  from cust_bun_bydate b, passp p
                 where b.rnka   = p_rnk
                   and b.id_rel =  27
                   and b.doc_type = p.passp(+)
                   --and b.custtype_u >= 2
           )

     loop
        l_ret := substr(l_ret || trim(k.vpl) || '; ', 1, 6000);
     end loop;

  elsif p_par = 8 then
     -- ������������� ����������� ���_�����

     for k in ( select  b.name || ', ' || p.name || ' ' || b.doc_serial || ' ' || b.doc_number ||
                        decode (b.doc_issuer,'','',', ������� ')      || b.doc_issuer ||' '||
                        to_char(b.doc_date,'dd/mm/yyyy')  || ' �.'    ||
                        decode(b.okpo_u,'','',', ��� ') || b.okpo_u ||
                        decode(b.birthday,'','',', ���� ���������� ') || to_char(b.birthday, 'dd/mm/yyyy') ||
                        decode(b.notes,'','','. �������� - ') || b.notes predst
                  from cust_bun_bydate b,  passp p
                 where b.rnka   = p_rnk
                   and b.id_rel = 7
                  and b.doc_type = p.passp(+)
                  and b.custtype_u = 2
           )

     loop
        l_ret := substr(l_ret || trim(k.predst) || '; ', 1, 6000);
     end loop;

  elsif p_par = 9 then
     -- �������� �� (³������ ��� ���������� �������� �����)

     for k in ( select  b.name || ', ' || p.name || ' ' || b.doc_serial || ' ' || b.doc_number ||
                        decode (b.doc_issuer,'','',', ������� ')      || b.doc_issuer ||' '||
                        to_char(b.doc_date,'dd/mm/yyyy')  || ' �.'    ||
                        decode(b.okpo_u,'','',', ��� ') || b.okpo_u ||
                        decode(b.birthday,'','',', ���� ���������� ') || to_char(b.birthday, 'dd/mm/yyyy') ||
                        decode(b.adr,'','',', ����� �� ������� ') || b.adr ||
                        decode(b.notes,'','','. �i������ ������ - ') || b.notes vplfo
                  from cust_bun_bydate b, passp p
                 where b.rnka   = p_rnk
                   and b.id_rel = 29
                   and b.doc_type = p.passp(+)
                   and b.custtype_u = 2
           )

     loop
        l_ret := substr(l_ret || trim(k.vplfo) || '; ', 1, 6000);
     end loop;

  elsif p_par = 10 then
     -- �������� ���������� ������������

     select partner_list
       into l_ret
       from fm_stable_partner_arc f, customer c
      where c.rnk = p_rnk
        and case when substr('0000000000' || c.okpo, -10) != '0000000000' then substr('0000000000' || c.okpo, -10) else TO_CHAR(c.rnk) end = f.rnk
        and dat = /*TO_DATE('01.01.2017', 'dd.mm.yyyy');*/trunc(p_dat, 'Q');

  elsif p_par = 11 then
     -- �������� ������ � ������ ������

     for k in ( select c.mfo, b.nb, c.nls, c.kv
                  from corps_acc c, banks b
                 where c.rnk = p_rnk
                   and c.mfo = b.mfo
              )

     loop
        l_ret := substr(l_ret || k.mfo || ' ' || k.nb || '/' || k.nls || '(' || to_char(k.kv) || ')' || '; ', 1, 6000);
     end loop;

     l_ret := substr(l_ret || trim(substr(f_get_custw_h(p_rnk,'AINAB',p_dat),1,500)), 1, 6000); -- �������� ������� � ��������� ��� � �� ���.����������

  elsif p_par = 12 then
     -- ����� �������� �������� �� ������ ������� � ���

     for k in ( select round(f.turn_in/100000,1) turn, t.lcv
                  from fm_turn_arc f, tabval t
                 where f.rnk = p_rnk
                   and f.dat = trunc ( p_dat, 'Q')
                   and f.kv = t.kv
              )

     loop
        l_ret := substr(l_ret || trim(to_char(k.turn,'9999999990.99')) || ' (' || k.lcv || '); ', 1, 6000);
     end loop;

  elsif p_par = 13 then
     -- ����� �������� �������� �� ������ ������� �� ����.������� � ���

     for k in ( select round(f.turn_in/100000,1) turn, t.lcv
                  from fm_turn_arc f, tabval t
                 where f.rnk = p_rnk
                   and f.dat = trunc( add_months( p_dat, -3),'Q')
                   and f.kv = t.kv
              )

     loop
        l_ret := substr(l_ret || trim(to_char(k.turn,'9999999990.99')) || ' (' || k.lcv || '); ', 1, 6000);
     end loop;

  elsif p_par = 14 then
     -- ����� ��������� �������� �� ������ �������

     for k in ( select round(f.turn_out/100000,1) turn, t.lcv
                  from fm_turn_arc f, tabval t
                 where f.rnk = p_rnk
                   and f.dat = trunc ( p_dat, 'Q')
                   and f.kv = t.kv
              )

     loop
        l_ret := substr(l_ret || trim(to_char(k.turn,'9999999990.99')) || ' (' || k.lcv || '); ', 1, 6000);
     end loop;

  elsif p_par = 15 then
     -- ����� ��������� �������� �� ������ ������� �� ����.�������

     for k in ( select round(f.turn_out/100000,1) turn, t.lcv
                  from fm_turn_arc f, tabval t
                 where f.rnk = p_rnk
                   and f.dat = trunc( add_months( p_dat, -3),'Q')
                   and f.kv = t.kv
              )

     loop
        l_ret := substr(l_ret || trim(to_char(k.turn,'9999999990.99')) || ' (' || k.lcv || '); ', 1, 6000);
     end loop;

  elsif p_par = 16 then
     -- ������ �������� �������� �� ������ ������� �� ��������� � ����.��������

     for k in
       (select f.rnk, f.dat, trunc( add_months( p_dat, -3),'Q') datpr, f.kv, t.lcv
          from fm_turn_arc f, tabval t
     where f.rnk = p_rnk
       and f.dat = trunc ( p_dat, 'Q')
       and f.kv  = t.kv )

         loop

        l_turn_in := 0;
        l_turn_in_prev := 0;

            begin
              select round(turn_in/100000,1) turn
                into l_turn_in
                from fm_turn_arc
               where rnk = k.rnk
                 and dat = k.dat
                 and kv  = k.kv;
        exception when no_data_found then null;
            end;

            begin
              select round(turn_in/100000,1) turn
                into l_turn_in_prev
                from fm_turn_arc
               where rnk = k.rnk
                 and dat = k.datpr
                 and kv  = k.kv;
        exception when no_data_found then null;
            end;

            if    ( l_turn_in = 0 and l_turn_in_prev <> 0 )
           then l_delta_in := 100;
        elsif ( l_turn_in <> 0 and l_turn_in_prev = 0 )
           then l_delta_in := 999;
        elsif  ( l_turn_in = 0 and l_turn_in_prev = 0 )
           then l_delta_in := 0;
        else
               l_delta_in  := round((l_turn_in/l_turn_in_prev)*100,1);
            end if;

            if l_delta_in > 300 then l_delta_in := 999; end if;

            select substr(l_ret || decode(l_delta_in,999,'>300',to_char(l_delta_in,'990.9')) || ' (' || k.lcv || '); ', 1, 6000) into l_ret from dual;

         end loop;


  elsif p_par = 17 then
     -- -- ������ ��������� �������� �� ������ ������� �� ��������� � ����.��������

     for k in
       (select f.rnk, f.dat, trunc( add_months( p_dat, -3),'Q') datpr,  f.kv, t.lcv
          from fm_turn_arc f, tabval t
     where f.rnk = p_rnk
       and f.dat = trunc ( p_dat, 'Q')
       and f.kv  = t.kv )

         loop

        l_turn_out := 0;
        l_turn_out_prev := 0;

            begin
              select round(turn_out/100000,1) turn
                into l_turn_out
                from fm_turn_arc
               where rnk = k.rnk
                 and dat = k.dat
                 and kv  = k.kv;
        exception when no_data_found then null;
            end;

            begin
              select round(turn_out/100000,1) turn
                into l_turn_out_prev
                from fm_turn_arc
               where rnk = k.rnk
                 and dat = k.datpr
                 and kv  = k.kv;
        exception when no_data_found then null;
            end;

            if    ( l_turn_out = 0 and l_turn_out_prev <> 0 )
           then l_delta_out := 100;
        elsif ( l_turn_out <> 0 and l_turn_out_prev = 0 )
           then l_delta_out := 999;
        elsif  ( l_turn_out = 0 and l_turn_out_prev = 0 )
           then l_delta_out := 0;
        else
               l_delta_out  := round((l_turn_out/l_turn_out_prev)*100,1);
            end if;

            if l_delta_out > 300 then l_delta_out := 999; end if;

            select substr(l_ret || decode(l_delta_out,999,'>300',to_char(l_delta_out,'990.9')) || ' (' || k.lcv || '); ', 1, 6000) into l_ret  from dual;

         end loop;


  elsif p_par = 20 then
     -- ��������� ��

     for k in ( select  b.name || ', ' || decode(b.okpo_u,'','',', ��� ������ ') || b.okpo_u || decode(b.adr,'','',', ������ ') || b.adr ||decode(b.notes,'','','. ���� �����i ') || b.notes   posad
                  from cust_bun_bydate b
                 where b.rnka   = p_rnk
                   and b.id_rel = 12
                   and b.custtype_u = 1
           )
     loop
        l_ret := substr(l_ret || trim(k.posad) || '; ', 1, 6000);
     end loop;

  elsif p_par = 21 then
     -- �����.��������, �������

     for k in ( select  b.name || ', ' || decode(b.okpo_u,'','',', ��� ������ ') || b.okpo_u ||decode(b.adr,'','',', ������ ') || b.adr ||decode(b.notes,'','','. ϳ������ ���������� - ') || b.notes  posad
                  from cust_bun_bydate b
                 where b.rnka   = p_rnk
                   and b.id_rel = 8
                   and b.custtype_u = 1
           )
     loop
        l_ret := substr(l_ret || trim(k.posad) || '; ', 1, 6000);
     end loop;

  elsif p_par = 22 then
     -- �������������� ��� ��� ���, �� ����� ����� �������������� ��������� �� ������

     for k in ( select  b.name || ', ' || p.name || ' ' || b.doc_serial || ' ' || b.doc_number || decode(b.doc_date,'','',', ������� ') ||
                        to_char(b.doc_date,'dd/mm/yyyy') || decode(b.doc_issuer,'','',decode(b.doc_date,'',' ������� � �.',' � �.')) || b.doc_issuer ||
                        decode(b.okpo_u,'','',' ��� ') || b.okpo_u ||
                        decode(b.birthday,'','',', ���� ���������� ') || to_char(b.birthday, 'dd/mm/yyyy') ||
                        decode(b.adr,'','',', ����� �� ������� ') || b.adr    posad
                  from cust_bun_bydate b, passp p
                 where b.rnka   = p_rnk
                   and b.id_rel = 22 -- �� ����� ������������� ������ � cust_rel
                   and b.doc_type = p.passp(+)
                   --and b.custtype_u >= 2
           )

     loop
        l_ret := substr(l_ret || trim(k.posad) || '; ', 1, 6000);
     end loop;


  elsif p_par = 23 then
     -- ���������� ���� ������

      -- ����
/*    for k in (select count(*) cr
                  from customer_risk
                 where rnk = p_rnk
                   and risk_id in (1,200,201,202,203)
                   and dat_begin <= p_dat
                   and (dat_end is null or dat_end > p_dat))

            loop
              if k.cr >= 1 then  l_ret := '����������� �������'; return l_ret; end if;
            end loop;

    for l in (select count(*) cr
                  from customer_risk
                 where rnk = p_rnk
                   and ((risk_id >= 2 and risk_id <= 4) or risk_id in(8, 46, 48) or ( risk_id >= 62 and risk_id <= 66))
                   and dat_begin <= p_dat
                   and (dat_end is null or dat_end > p_dat))

           loop
               if l.cr >= 1 then l_ret := '�������'; return l_ret;

            else

                for m in (select count(*) cr
                         from customer_risk
                        where rnk = p_rnk
                          and ((risk_id >= 5 and risk_id <= 7) or (risk_id >= 9 and risk_id <= 18) or (risk_id >= 20 and risk_id <= 44) or (risk_id >= 49 and risk_id <= 61))
                          and dat_begin <= p_dat
                          and (dat_end is null or dat_end > p_dat))
                    loop
                       if m.cr >= 1 then  l_ret := '�������'; return l_ret;
                                     else l_ret := '�������';
                    end if;
                   end loop;
            end if;
        end loop;*/
    begin
      select case res
               when 1 then
                '����������� �������'
               when 2 then
                '�������'
               when 3 then
                '�������'
               when 4 then
                '�������'
             end
        into l_ret
        from (select case
                       when c.RISK_ID in (1, 201, 202, 203, 204, 205, 206, 207) then 1
                       when c.RISK_ID in (2, 3, 5, 6, 7, 8, 10, 45, 46, 48, 62, 63, 64, 65, 66, 72) then 2
                       when c.RISK_ID in (4, 11, 12, 13, 14, 17, 18, 21, 33, 43, 47, 49, 67, 68, 70, 71, 73, 74, 75, 76, 77, 78, 79, 80) then 3
                       else 4
                     end as res
                from customer_risk c
               where c.RNK = p_rnk
                 and c.DAT_BEGIN <= p_dat
                 and (dat_end is null or dat_end > p_dat)
               order by res)
       where rownum = 1;
     exception when no_data_found then l_ret := '�������';
     end;


  elsif p_par = 24 then
     -- ��� ����� ���� ������ ��� ���
     for k in ( select c.rnk, c.value, to_char(c.chgdate,'DD/MM/YYYY') chgdate
                  from customerw_update c ,
                               (select rnk, to_char(chgdate,'DD/MM/YYYY'), max(idupd) idupd
                                  from customerw_update
                                 where tag = 'RIZIK'
                                   and chgaction < 3
                                   and trunc(chgdate)<= p_dat
                              group by rnk, to_char(chgdate,'DD/MM/YYYY')) d
                 where c.tag = 'RIZIK'
                   and c.rnk = p_rnk
                   and c.chgaction < 3
                   and trunc(chgdate)<= p_dat
                   and c.rnk = d.rnk
                   and C.IDUPD = d.idupd
               order by c. chgdate, c.idupd
               )

     loop
        l_ret := substr(l_ret || k.chgdate || ' - ' || trim(substr(k.value,1,19)) || '; ', 1, 6000);
     end loop;


  elsif p_par = 25 then
     -- ��, ������������ ���� �� ���� �볺���

     for k in ( select  b.name || ', ' || p.name || ' ' || b.doc_serial || ' ' || b.doc_number || decode(b.doc_date,'','',', ������� ') ||
                        to_char(b.doc_date,'dd/mm/yyyy') || decode(b.doc_issuer,'','',decode(b.doc_date,'',' ������� � �.',' � �.')) || b.doc_issuer ||
                        decode(b.okpo_u,'','',', ��� ') || b.okpo_u ||
                        decode(b.birthday,'','',', ���� ���������� ') || to_char(b.birthday, 'dd/mm/yyyy') ||
                        decode(b.adr,'','',', ����� �� ������� ') || b.adr ||
                        decode(b.country_u,'','','. ������������ - ') || c.name upovnovazh
                  from cust_bun_bydate b, passp p, country c
                 where b.rnka   = p_rnk
                   and b.id_rel = 20
                   and b.doc_type = p.passp(+)
                   and b.custtype_u = 2
           and b.country_u = c.country(+)
           )

     loop
        l_ret := substr(l_ret || trim(k.upovnovazh) || '; ', 1, 6000);
     end loop;

  elsif p_par = 31 then
     -- ��������� ������������ ������ �� ���������� ������� �������

     for k in ( select nvl(c.name,'') || decode(ca.zip,'','',', ') || ca.zip || decode(ca.domain,'','',', ') || ca.domain ||
                       decode(ca.locality,'','',', ') || ca.locality || decode(ca.address,'','',', ') || ca.address   adru
                  from customer_address ca, country c
                 where ca.rnk  = p_rnk
                   and ca.type_id = 1
                   and ca.country = c.country
           )

     loop
        l_ret := substr(l_ret || trim(k.adru) , 1, 6000);
     end loop;

  elsif p_par = 32 then
     -- ��������� ������������ ������ �� ���������� ������� �������

     for k in ( select nvl(c.name,'') || decode(ca.zip,'','',', ') || ca.zip || decode(ca.domain,'','',', ') || ca.domain ||
                       decode(ca.locality,'','',', ') || ca.locality || decode(ca.address,'','',', ') || ca.address   adru
                  from customer_address ca, country c
                 where ca.rnk  = p_rnk
                   and ca.type_id = 2
                   and ca.country = c.country
           )

     loop
        l_ret := substr(l_ret || trim(k.adru) , 1, 6000);
     end loop;


  elsif p_par = 33 then
    select decode(custtype,1,2,2,2,3,decode(trim(sed),'91',391,3),3) into l_custtype from customer where rnk = p_rnk;

    if l_custtype = 2 then
    -- �������������� ������ �� �.1-5 (������ 26,1,7,29,22) � ��������� ����� (������ 32)
    /*  10/02/2012
      ���� ����� � �� � �� ������ �. 1-5 ������ �� "������� �����" �� ������ (���������) �. 6 ������ �.�.�. ���� �����.  */

     for k in ( select distinct b.name   publp
                  from cust_bun_bydate b
                 where b.rnka   = p_rnk
                   and b.id_rel in (26, 1, 7, 29, 22)
                   and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 32)
                   and b.custtype_u = 2    -- ��
           )

     loop
        l_ret := substr(l_ret || trim(k.publp) || '; ', 1, 6000);
     end loop;

    elsif l_custtype = 3 then
       select f_get_custw_h(p_rnk,'PUBLP',p_dat)||decode(f_get_custw_h(p_rnk,'PUBLP',p_dat),null,null,'; ') into l_ret from dual;

     for k in ( select distinct publp
                  from ( select distinct name publp, rnkb
                           from cust_bun_bydate
                          where rnka   = p_rnk
                            and id_rel in (35, 29, 20)
                             -- ��
                            and custtype_u = 2 ) b
                 where exists (select 1 from cust_bun_bydate where rnka = p_rnk and rnkb = b.rnkb and id_rel = 32) )

     loop
        l_ret := substr(l_ret || trim(k.publp) || '; ', 1, 6000);
     end loop;

    elsif l_custtype = 391 then
       select f_get_custw_h(p_rnk,'PUBLP',p_dat)||decode(f_get_custw_h(p_rnk,'PUBLP',p_dat),null,null,'; ') into l_ret from dual;

     for k in ( select distinct publp
                  from ( select distinct name publp, rnkb
                          from cust_bun_bydate
                         where rnka   = p_rnk
                           and id_rel in (29,20)
                            -- ��
                           and custtype_u = 2 ) b
                 where exists (select 1 from cust_bun_bydate where rnka = p_rnk and rnkb = b.rnkb and id_rel = 32) )

     loop
        l_ret := substr(l_ret || trim(k.publp) || '; ', 1, 6000);
     end loop;

    end if;


  elsif p_par = 34 then
     -- ���������� ��� ��������� ���, ���������� � ������� 10, 13-15 (������ 1,29,22) ���� ������� �� �������� ����� ��� ���'������ � ���� ���  (������ 32)
     /* 28/02/2013 ��������� �������� �������� ����� �����:
        ����� "," ��������� �.�.�. ���, �������� � �.2 �. 10, 13-15 ������, ��� ���� ����������� ������ ���'������� "������� �����"", �� ���������� �������� "����". */

      for k in ( select distinct b.name   publp
                  from cust_bun_bydate b
                 where b.rnka   = p_rnk
                   and b.id_rel in (1, 29, 22)
                   and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 32)
                   and b.custtype_u = 2    -- ��
           )

     loop
        l_ret := substr(l_ret || trim(k.publp) || '; ', 1, 6000);
     end loop;


  elsif p_par = 35 then
     -- ��, ��� ������� ������� �� ��'� �볺���

     for k in ( select  b.name || ', ' || p.name || ' ' || b.doc_serial || ' ' || b.doc_number  ||
                        decode (b.doc_issuer,'','',', ������� ')      || b.doc_issuer ||' '||
                        to_char(b.doc_date,'dd/mm/yyyy')  || ' �.'    ||
                        decode(b.okpo_u,'','',', ��� ') || b.okpo_u ||
                        decode(b.birthday,'','',', ���� ���������� ') || to_char(b.birthday, 'dd/mm/yyyy') ||
                        decode(b.adr,'','',', ����� �� ������� ') || b.adr  upovnovazh
                  from cust_bun_bydate b, passp p
                 where b.rnka   = p_rnk
                   and b.id_rel = 35
                   and b.doc_type = p.passp(+)
                   and b.custtype_u = 2
           )

     loop
        l_ret := substr(l_ret || trim(k.upovnovazh) || '; ', 1, 6000);
     end loop;

  elsif p_par = 55 then


/*#ifdef SBER
      -- ��������

     for k in ( select rnk, value, to_char(chgdate,'DD/MM/YYYY HH24:MI') chgdate
                  from customerw_update
                 where tag = 'FSVSN'
                   and rnk = p_rnk
                   and chgaction < 3
                   and trunc(chgdate)<= p_dat
                order by idupd)

     loop
        l_ret := substr(l_ret || k.chgdate || ' - ' || trim(substr(k.value,1,20)) || '; ', 1, 6000);
     end loop;
 */
--#else
      -- ������
      select nvl(trim(substr(f_get_custw_h(p_rnk,'FSVSN',p_dat),1,6000)),chr(160)) INTO l_ret from dual;

--#endif


elsif p_par = 56 then
     -- ��������� ������������ ������ �� ���������� ������� �������

    /* for k in ( select nvl(c.name,'') || decode(ca.zip,'','',', ') || ca.zip || decode(ca.domain,'','',', ') || ca.domain ||
                       decode(ca.locality,'','',', ') || ca.locality || decode(ca.address,'','',', ') || ca.address   adru
                  from customer_address ca, country c
                 where ca.rnk  = p_rnk
                   and ca.type_id = 1
                   and ca.country = c.country
           )*/
   --


    for k in (select   nvl(c.name,'') ||
         decode(ca.zip,'','',', ') || ca.zip ||
         decode(ca.domain,'','',', ') ||  decode(f_cust_gap(ca.domain), 0, initcap(trim(ca.domain)) ||' ���.', replace(initcap(ca.domain),'�������', '���'))||
         decode(ca.region,'','',', ') || decode(f_cust_gap(ca.region), 0, trim(ca.region) ||' �-�', replace(initcap(ca.region),'�����', '�-�'))||
         decode(ca.locality,'','',', ') ||decode(ca.locality_type, 1, '�. ', 2, '���. ', 3, '�. ', 4,'���. ', 5, '��. ', null)  || ca.locality ||
         decode(ca.address,'','',', ') ||ca.address   adru
       from customer_address_update ca, country c,
           (select max(idupd) IDUPD from customer_address_update where rnk=p_rnk  and trunc(chgdate)<= p_dat and  type_id = 1) d
       where ca.rnk  = p_rnk
           and  ca.type_id = 1
           and ca.country = c.country
           and trunc(ca.chgdate)<= p_dat
           and ca.idupd=d.idupd)

    loop
        l_ret := substr(l_ret || trim(k.adru) , 1, 6000);
     end loop;

 elsif p_par = 60 then
     -- ��������� � ���� ������ ��������� �볺���
     for k in ( select c.rnk, c.value, to_char(c.chgdate,'DD/MM/YYYY') chg_o_rep
                  from customerw_update c ,
                               (select rnk, to_char(chgdate,'DD/MM/YYYY'), max(idupd) idupd
                                  from customerw_update
                                 where tag = 'O_REP'
                                   and chgaction < 3
                                   and trunc(chgdate)<= p_dat
                              group by rnk, to_char(chgdate,'DD/MM/YYYY')) d
                 where c.tag = 'O_REP'
                   and c.rnk = p_rnk
                   and c.chgaction < 3
                   and trunc(chgdate)<= p_dat
                   and c.rnk = d.rnk
                   and C.IDUPD = d.idupd
               order by c. chgdate, c.idupd )

     loop
        l_ret := substr(l_ret || k.chg_o_rep || ' - ' || trim(substr(k.value,1,12)) || '; ', 1, 6000);
     end loop;

 elsif p_par = 61 then
     -- ���� ��������� �� ������ ���� ��������� ���������� �������� �볺���
     for k in ( select  c.value chg_daidi
                  from customerw_update c ,
                               (select rnk, to_char(chgdate,'DD/MM/YYYY'), max(idupd) idupd
                                  from customerw_update
                                 where tag = 'DAIDI'
                                   and chgaction < 3
                                   and trunc(chgdate)<= p_dat
                              group by rnk, to_char(chgdate,'DD/MM/YYYY')) d
                 where c.tag = 'DAIDI'
                   and c.rnk = p_rnk
                   and c.chgaction < 3
                   and trunc(chgdate)<= p_dat
                   and c.rnk = d.rnk
                   and C.IDUPD = d.idupd
               order by c. chgdate, c.idupd
               )

     loop
       l_ret := substr(l_ret || k.chg_daidi || '; ', 1, 6000);
     end loop;

 elsif p_par = 62 then
     -- ������� �� ������ ����������� ����� �� ����� ��������� �� ������� �볺���
     for k in ( select
                    (select decode(value,'Ta�', '����� �����; ', null)
                        from(select trim(f_get_custw_h(p_rnk,'DJOWF', p_dat)) value from dual)) DJOWF,
                    (select decode(upper(value),'Ͳ',null, null, null, '��������������� ����� '||value||' ���.; ')
                         from(select trim(f_get_custw_h(p_rnk,'DJAVI', p_dat)) value from dual)) DJAVI,
                    (select decode(value,'Ta�', '�� ������� ��������; ', null)
                         from(select trim(f_get_custw_h(p_rnk,'DJ_MA', p_dat)) value from dual)) DJ_MA,
                    (select decode(value,'Ta�', '� ������ ��������� ��������; ', null)
                         from(select trim(f_get_custw_h(p_rnk,'DJ_FH', p_dat)) value from dual)) DJ_FH,
                    (select decode(value,'Ta�', '�� ������� ������ ������; ', null)
                         from(select trim(f_get_custw_h(p_rnk,'DJ_CP', p_dat)) value from dual)) DJ_CP,
                    (select decode(value,'Ta�', '�� ������� ��� ����������� ����� ������� ������; ', null)
                         from(select trim(f_get_custw_h(p_rnk,'DJ_TC', p_dat)) value from dual)) DJ_TC,
                    (select decode(value,'Ta�', '� ������ ������; ', null)
                         from(select trim(f_get_custw_h(p_rnk,'DJ_LN', p_dat)) value from dual)) DJ_LN,
                    (select decode(value,'Ta�', '�� ��������� ��������� ��������� ��� ������������ ����� �������� ���������� ����������� ����; ', null)
                         from(select trim(f_get_custw_h(p_rnk,'DJCFI', p_dat)) value from dual)) DJCFI,
                    (select decode (upper(value),'Ͳ', null, null, null, value||';')
                         from(select trim(f_get_custw_h(p_rnk,'DJOTH', p_dat)) value from dual)) DJOTH
                 from dual

               )

       loop
           l_ret := substr(l_ret ||k.DJOWF||k.DJAVI||k.DJ_MA||k.DJ_FH||k.DJ_CP||k.DJ_TC||k.DJ_LN||k.DJCFI||k.DJOTH ,  1, 6000);
      end loop;

 elsif p_par = 63 then
       for k in (
               select case
                         when f_get_cust_h(p_rnk,'okpo',p_dat) like '000000000%'
                             then  f_get_cust_h(p_rnk,'okpo',p_dat) || ( select ', '||ser||' '||numdoc from person where rnk=p_rnk)
                         else f_get_cust_h(p_rnk,'okpo',p_dat)
                      end INN
               from dual )

       loop
           l_ret := substr(l_ret ||k.INN ,  1, 6000);
       end loop;

 elsif p_par = 64 then
   --ϲ� �������� �����
        for k in ( select  b.name mngr
                       from cust_bun_bydate b
                   where b.rnka   = p_rnk
                      and b.id_rel = 40
                      and b.custtype_u = 2  )
        loop
          l_ret := substr(l_ret || trim(k.mngr) || '; ', 1, 6000);
        end loop;

 elsif p_par = 65 then
    --��������� �� �������� �������� ��������
        for k in ( select category_name ctg_name
                       from v_customer_category
                    where rnk=p_rnk and value=1
                    )
        loop
          l_ret := substr(l_ret || trim(k.ctg_name)||'; ', 1, 6000);
        end loop;

 elsif p_par = 66 then
    --���������� ��� ��������� �볺��� �� �������� �����
        select count(*) into l_count  from v_customer_risk
                    where risk_id in (2, 3, 62, 63, 64, 65)
                    and rnk=p_rnk and value=1;

      if l_count>=1 then l_ret :='���; ';

        for k in (select risk_name   from v_customer_risk
                    where risk_id in (2, 3, 62, 63, 64, 65)
                    and rnk=p_rnk and value=1
                    order by risk_id )

          loop
           l_ret := substr(l_ret || trim(k.risk_name ) || '; ', 1, 6000);
          end loop;
      end if;

 elsif p_par = 67 then
      select decode(custtype,1,2,2,2,3,decode(trim(sed),'91',391,3),3) into l_custtype from customer where rnk = p_rnk;

      if l_custtype = 3 then
        for k in  ( select distinct b.name   ponat
                      from cust_bun_bydate b
                    where b.rnka   = p_rnk
                          and b.id_rel in (20, 35)
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 32) --��-�����������
                          and b.custtype_u = 2 )

         loop
           l_ret := substr(l_ret || trim(k.ponat)|| '; ', 1, 6000);
         end loop;

      elsif l_custtype <= 2 then

         for k in ( select distinct b.name   ponat
                      from cust_bun_bydate b
                    where b.rnka   = p_rnk
                          and b.id_rel in (20, 40, 29)
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 32) --��-�����������
                          and b.custtype_u = 2 )

         loop
           l_ret := substr(l_ret || trim(k.ponat)|| '; ', 1, 6000);
         end loop;

      elsif l_custtype = 391 then

        for k in ( select distinct b.name   ponat
                      from cust_bun_bydate b
                    where b.rnka   = p_rnk
                          and b.id_rel=7
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 32) --��-�����������
                          and b.custtype_u = 2 )

         loop
           l_ret := substr(l_ret || trim(k.ponat)|| '; ', 1, 6000);
         end loop;
      end if;

 elsif p_par = 68 then
      select decode(custtype,1,2,2,2,3,decode(trim(sed),'91',391,3),3) into l_custtype from customer where rnk = p_rnk;

      if l_custtype = 3 then
       for k in  ( select distinct b.name   bcnpp
                  from cust_bun_bydate b
                 where b.rnka   = p_rnk
                   and b.id_rel in (20, 35)
                   and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 38) --������� ����� ���.��
                   and b.custtype_u = 2 )

        loop
            l_ret := substr(l_ret || trim(k.bcnpp)|| '; ', 1, 6000);
         end loop;

      elsif l_custtype <= 2 then

         for k in ( select distinct b.name   ponat
                      from cust_bun_bydate b
                    where b.rnka   = p_rnk
                          and b.id_rel in (20, 40, 29)
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 38) --������� ����� ���.��
                          and b.custtype_u = 2 )

         loop
           l_ret := substr(l_ret || trim(k.ponat)|| '; ', 1, 6000);
         end loop;

      elsif l_custtype = 391 then

        for k in ( select distinct b.name   ponat
                      from cust_bun_bydate b
                    where b.rnka   = p_rnk
                          and b.id_rel=7
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 38) --������� ����� ���.��
                          and b.custtype_u = 2 )

         loop
           l_ret := substr(l_ret || trim(k.ponat)|| '; ', 1, 6000);
         end loop;
      end if;

 elsif p_par = 69 then
      select decode(custtype,1,2,2,2,3,decode(trim(sed),'91',391,3),3) into l_custtype from customer where rnk = p_rnk;

      if l_custtype = 3 then
        for k in  ( select distinct b.name   bfnpp
                  from cust_bun_bydate b
                 where b.rnka   = p_rnk
                   and b.id_rel in (20, 35)
                   and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 50) --�������� � �������� ������
                   and b.custtype_u = 2 )

        loop
          l_ret := substr(l_ret || trim(k.bfnpp)|| '; ', 1, 6000);
        end loop;

      elsif l_custtype <= 2 then

        for k in ( select distinct b.name   ponat
                      from cust_bun_bydate b
                    where b.rnka   = p_rnk
                          and b.id_rel in (20, 40, 29)
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 50) --������� ����� ���.��
                          and b.custtype_u = 2 )

         loop
           l_ret := substr(l_ret || trim(k.ponat)|| '; ', 1, 6000);
         end loop;

      elsif l_custtype = 391 then

        for k in ( select distinct b.name   ponat
                      from cust_bun_bydate b
                    where b.rnka   = p_rnk
                          and b.id_rel=7
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 50) --������� ����� ���.��
                          and b.custtype_u = 2 )

         loop
           l_ret := substr(l_ret || trim(k.ponat)|| '; ', 1, 6000);
         end loop;
      end if;

 elsif p_par = 70 then
       select decode(custtype,1,2,2,2,3,decode(trim(sed),'91',391,3),3) into l_custtype from customer where rnk = p_rnk;

      if l_custtype = 3 then
         for k in  ( select distinct b.name   bunpp
                  from cust_bun_bydate b
                 where b.rnka   = p_rnk
                   and b.id_rel in (20, 35)
                   and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 50) --�������� � �������� ������
                   and b.custtype_u = 1 )

         loop
          l_ret := substr(l_ret || trim(k.bunpp)|| '; ', 1, 6000);
         end loop;

      elsif l_custtype <= 2 then

       for k in  ( select distinct b.name   bunpp
                  from cust_bun_bydate b
                 where b.rnka   = p_rnk
                   and b.id_rel in (20, 40, 29)
                   and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 50) --�������� � �������� ������
                   and b.custtype_u = 1 )

         loop
          l_ret := substr(l_ret || trim(k.bunpp)|| '; ', 1, 6000);
         end loop;

      elsif l_custtype = 391 then

       for k in  ( select distinct b.name   bunpp
                  from cust_bun_bydate b
                 where b.rnka   = p_rnk
                   and b.id_rel=7
                   and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 50) --�������� � �������� ������
                   and b.custtype_u = 1 )

         loop
          l_ret := substr(l_ret || trim(k.bunpp)|| '; ', 1, 6000);
         end loop;
      end if;

 elsif p_par = 71 then
       select decode(custtype,1,2,2,2,3,decode(trim(sed),'91',391,3),3) into l_custtype from customer where rnk = p_rnk;

      if l_custtype = 3 then
        for k in  ( select distinct b.name   bunpp
                  from cust_bun_bydate b
                 where b.rnka   = p_rnk
                   and b.id_rel in (20, 35)
                   and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel in (36,37,39)) -- ���-��������, ���-������ ����.�-��� � ���.���-��,
                   and b.custtype_u = 2 )                                                                                     --�������� ����� ����.�λ;

          loop
            l_ret := substr(l_ret || trim(k.bunpp)|| '; ', 1, 6000);
          end loop;

      elsif l_custtype <= 2 then

        for k in  ( select distinct b.name   bunpp
                  from cust_bun_bydate b
                 where b.rnka   = p_rnk
                   and b.id_rel in (20, 40, 29)
                   and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel in (36,37,39)) -- ���-��������, ���-������ ����.�-��� � ���.���-��,
                   and b.custtype_u = 2 )                                                                                     --�������� ����� ����.�λ;

          loop
            l_ret := substr(l_ret || trim(k.bunpp)|| '; ', 1, 6000);
          end loop;

      elsif l_custtype = 391 then

        for k in ( select distinct b.name   ponat
                      from cust_bun_bydate b
                    where b.rnka   = p_rnk
                          and b.id_rel=7
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel in (36,37,39)) -- ���-��������, ���-������ ����.�-��� � ���.���-��,
                          and b.custtype_u = 2 )                                                                                    --�������� ����� ����.�λ;

         loop
           l_ret := substr(l_ret || trim(k.ponat)|| '; ', 1, 6000);
         end loop;

      end if;

  elsif p_par = 72 then

        for k in  (select distinct b.name   ponat_p
                      from cust_bun_bydate b
                    where b.rnka = (select rel_rnk from customer_rel where rnk=p_rnk and rel_id=10)
                          and b.id_rel in (1, 29, 22,40)
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 32) --��-�����������
                          and b.custtype_u = 2
        union all
       select distinct b.name   ponat_p
                      from cust_bun_bydate b
                    where b.rnka = p_rnk
                          and b.id_rel in (20)
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 32) --��-�����������
                          and b.custtype_u = 2)

         loop
           l_ret := substr(l_ret || trim(k.ponat_p)|| '; ', 1, 6000);
         end loop;


  elsif p_par = 73 then

        for k in  (select distinct b.name   ponat_p
                      from cust_bun_bydate b
                    where b.rnka = (select rel_rnk from customer_rel where rnk=p_rnk and rel_id=10)
                          and b.id_rel in (1, 29, 22,40)
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 38)
                          and b.custtype_u = 2
        union all
       select distinct b.name   ponat_p
                      from cust_bun_bydate b
                    where b.rnka = p_rnk
                          and b.id_rel in (20)
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 38)
                          and b.custtype_u = 2)

         loop
           l_ret := substr(l_ret || trim(k.ponat_p)|| '; ', 1, 6000);
         end loop;


    elsif p_par = 74 then

        for k in  (select distinct b.name   ponat_p
                      from cust_bun_bydate b
                    where b.rnka = (select rel_rnk from customer_rel where rnk=p_rnk and rel_id=10)
                          and b.id_rel in (1, 29, 22,40)
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 50)
                          and b.custtype_u = 2
        union all
       select distinct b.name   ponat_p
                      from cust_bun_bydate b
                    where b.rnka = p_rnk
                          and b.id_rel in (20)
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 50)
                          and b.custtype_u = 2)

         loop
           l_ret := substr(l_ret || trim(k.ponat_p)|| '; ', 1, 6000);
         end loop;

     elsif p_par = 76 then

        for k in  (select distinct b.name   ponat_p
                      from cust_bun_bydate b
                    where b.rnka = (select rel_rnk from customer_rel where rnk=p_rnk and rel_id=10)
                          and b.id_rel in (1, 29, 22,40)
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel = 50)
                          and b.custtype_u = 2
        union all
       select distinct b.name   ponat_p
                      from cust_bun_bydate b
                    where b.rnka = p_rnk
                          and b.id_rel in (20)
                          and exists (select 1 from cust_bun_bydate where rnkb = b.rnkb and rnka = b.rnka and id_rel in (36,37,39) )
                          and b.custtype_u = 2)

         loop
           l_ret := substr(l_ret || trim(k.ponat_p)|| '; ', 1, 6000);
         end loop;
 end if;
  return  substr(l_ret , 1, 4000);
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_CUST_HLIST ***
grant EXECUTE                                                                on F_GET_CUST_HLIST to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_CUST_HLIST to CC_DOC;
grant EXECUTE                                                                on F_GET_CUST_HLIST to START1;
grant EXECUTE                                                                on F_GET_CUST_HLIST to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_cust_hlist.sql =========*** E
 PROMPT ===================================================================================== 
 