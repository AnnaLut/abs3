

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FM_INTDOCCHECK.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FM_INTDOCCHECK ***

CREATE OR REPLACE PROCEDURE BARS.P_FM_INTDOCCHECK (p_ref number default null)
--
-- Version 1.5 09/10/2018
--
-- �������� ��������� (���������) ����������
--   ���������
--   � ��������� ���.����������
--
is
  -- ��� ������ ����������� "������������� ���.������������"
  c_grp   constant number := getglobaloption ('FM_GRP1');
  l_datr  date;
  l_doc_lock_limit constant number := 100;
  ----
  -- fm_check - �������� �� ������ ���������
  --
  procedure fm_check (p_ref number)
  is
     resource_busy   exception;
     pragma exception_init (resource_busy, -54);
     --
     l_nazn  oper.nazn%type;
     l_nama  oper.nam_a%type;
     l_namb  oper.nam_b%type;
     l_tt    oper.tt%type;
     l_flag  number;
     l_otm   number := 0;
     l_id_a  oper.id_a%type;
     l_id_b  oper.id_b%type;
  begin
     begin
        select o.tt, o.nazn, o.nam_a, o.nam_b, o.id_a , o.id_b
          into l_tt, l_nazn, l_nama, l_namb, l_id_a , l_id_b          
          from oper o
         where o.ref = p_ref
           for update of o.sos nowait;
     exception
        when no_data_found then return;
        when resource_busy then return;
     end;

     -- �� ��������� �������� � ������ "�� ������� �� ������� �����������"
     begin
        select nvl(f.value,0) into l_flag from tts_flags f where f.tt = l_tt and f.fcode = 30;
     exception when no_data_found then
        l_flag := 0;
     end;
     if l_flag = 1 then
        return;
     end if;

     -- �������� �� ���������� �� ������� �����������
     -- ������������ �����������
     l_otm := f_istr (l_nama);
     -- ������������ ����������
     if l_otm = 0 then
        l_otm := f_istr (l_namb);
     end if;
     -- ���������� �������
     if l_otm = 0 then
        l_otm := f_istr (l_nazn);
     end if;


     if l_otm = 0 then
        for d in ( select value
                     from operw
                    where ref = p_ref
                      and tag in ('FIO', 'FIO2', 'OTRIM') )
        loop
           l_otm := f_istr (d.value);
           if l_otm > 0 then
              exit;
           end if;
        end loop;
     end if;

    /*
      COBUSUPABS-9160
    */
    -------------------------------
    -- ���� � l_id_a , l_id_b � ���� � ����������
    if l_otm = 0 then
       begin
            select fin_r.c1 into l_otm
              from bars.FINMON_REFT fin_r
             where fin_r.c25 is not null
               and regexp_like(fin_r.c25, '^([[:digit:]]{8}|[[:digit:]]{10})$')
               and fin_r.c25 in (l_id_a , l_id_b)
               and rownum = 1;
       exception
         when no_data_found then l_otm := 0;
       end;
    end if;
    -- ���� � l_nazn � ���� � ����������
    if l_otm = 0 then
       begin 
        with tab_okpo as
         (SELECT regexp_replace(res_okpo, '[^0-9]') res_okpo
            FROM (SELECT REGEXP_SUBSTR(str, '[^ ]+', 1, LEVEL) AS res_okpo
                    FROM (SELECT l_nazn AS str
                            FROM DUAL)
                  CONNECT BY LEVEL <= LENGTH(REGEXP_REPLACE(str, '[^ ]+')) + 1)
           WHERE REGEXP_LIKE(res_okpo, '(^|\D)(\d{8}|\d{10})(\D|$)'))
        select fin_r.c1 into l_otm
          from bars.FINMON_REFT fin_r, tab_okpo
         where fin_r.c25 = tab_okpo.res_okpo
           and fin_r.c25 is not null
           and regexp_like(fin_r.c25, '^([[:digit:]]{8}|[[:digit:]]{10})$')
           and rownum = 1;
           exception
         when no_data_found then l_otm := 0;
       end;
    end if;
    -- ���� � TAG =>FIO � ����� �/3 ��� ����� �� ����� ��������� ����������� �������
    if l_otm = 0 then
       begin
        for check_str in ( 
                           select level as element,
                                  regexp_substr(str, '(.*?)( (�����)|(�/�)|$)', 1, level, null, 1) as element_value
                             from (select value str
                                     from operw
                                    where ref = p_ref
                                      and tag = 'FIO'
                                      and rownum =1 
                                  ) 
                             where regexp_like(str,'�/�|�����') 
                             connect by level <= regexp_count(str, '�����') + regexp_count(str, '�/�')+ 1
                          )
        loop
           l_otm := f_istr (check_str.element_value);
           if l_otm > 0 then
              exit;
           end if;
        end loop;
       exception
         when no_data_found then l_otm := 0;  
       end;
    end if;
    ------------------------------

     /*COBUSUPABS-5202
     �� ��������� � ������ CVO, IBO, CVS ��������� ��������� �� �������� ��������� � ������� ���������� ������� �������� "59" �SWT.59 Beneficiare Customer�
     (%TERROR%, �� TERROR - ������������ ������� ��� ϲ� ����� � ������� ���).
� ������ ��� �������� ����������, ������ �� ϲ� ��������.*/
     if l_otm = 0 and l_tt in ('CVO', 'IBO', 'CVS') then
       begin
          with o59 as
          (select f_translate_kmu(o.value) as t59 from bars.operw o where ref = p_ref and tag = '59')
          select c1 into l_otm
          from bars.v_finmon_reft r, o59
          where regexp_like(o59.t59, '[^A-Za-z�-��-�]'||REGEXP_REPLACE ( f_translate_kmu(c6 || ' ' || c7 || ' ' || c8 || ' ' || c9), '([()\:"])', '\\\1', 1, 0)||'[^A-Za-z�-��-�]')
          and rownum = 1;
       exception
         when no_data_found then l_otm := 0;
       end;
     end if;
     /*COBUSUPABS-5202 end*/

     -- ������ ������� "���������" ��� ���������
     update ref_que set fmcheck = 1 where ref = p_ref;

    -- ��� �������� ) ���������� � ������. �������� �������, ���� � ��� �� ϲ� - �������� ���������.
    -- ��� ���� �� ������ ��������� ���� ���������� ����� � ������� � � ��������, � ���� ���� �� ���, �� ����� ��� �������� �� ���������.
     if l_otm >= 10000 then
       bars_audit.info('l_otm>= 10000 = '||l_otm);
        begin
         select to_date(c13,'dd.mm.yyyy')
           into l_datr
           from finmon_reft
          where c1 = l_otm;
          bars_audit.info('���� �������� �� finmon_reft = '||to_char(l_datr,'dd.mm.yyyy'));
        exception when value_error
                  then l_datr := null;
                       bars_audit.info('���� �������� �� finmon_reft �� ������� ��� �� � ���e dd.mm.yyyy');
        end;

        if l_datr is not null
        then
         begin
            for dats in ( select to_date(value,'dd/mm/yyyy') value
                         from operw
                        where ref = p_ref
                          and tag in ('DATN', 'DRDAY', 'DT_R') )
            loop
               if dats.value = l_datr
               then bars_audit.info('���� �������� �� operw = '||to_char(dats.value,'dd.mm.yyyy'));
                    exit;
               else l_otm := 0;
                    bars_audit.info('���� �������� �� operw = '||to_char(dats.value,'dd.mm.yyyy')|| ' �� ����� ���� �������� � ������. ���������� �������.');
               end if;
            end loop;
         exception when value_error
                   then bars_audit.info('���� �������� �� operw �� ������� ��� �� � ���e dd.mm.yyyy');
         end;
        end if;
     end if;
     -- ���� �������� ��������������, ������� ��� � ������� ������. ����������
     if l_otm > 0 then
        begin
           insert into fm_ref_que (ref, otm)
           values (p_ref, l_otm);
        exception
           -- ������ ��� ����
           when dup_val_on_index then null;
        end;
        if c_grp is not null then
           insert into oper_visa (ref, dat, userid, groupid, status)
           values (p_ref, sysdate, user_id, c_grp, 1);
        end if;
     end if;

  end fm_check;
begin
  if p_ref is not null then
     -- �������� ������ ���������
     for r in (select ref from ref_que where nvl(fmcheck, 0) = 0 and ref = p_ref )
     loop
        fm_check(r.ref);
     end loop;
  else
     for b in ( select kf from mv_kf )
     loop
        -- �������������� ����� ���
        bc.subst_mfo(b.kf);


        for r in (select rownum rn, ref from ref_que where nvl(fmcheck, 0) = 0 )
        loop
           fm_check(r.ref);
           -- �������� (�������� oper for update) ������ N ����������� ����������
           if mod(r.rn, l_doc_lock_limit) = 0 then
               commit;
           end if;
        end loop;


        -- ������������ � ����
        bc.set_context;
     end loop;

  end if;

exception when others then

  --
  -- ���� ���� �����, ����� �� ���������� � ����� ������
  --
  -- ������������ � ����
  bc.set_context;
  --

  -- ����������� ����������� ������ ������
  raise_application_error(-20000,
        dbms_utility.format_error_stack() || chr(10) ||
        dbms_utility.format_error_backtrace());

end;
/
show err;

PROMPT *** Create  grants  P_FM_INTDOCCHECK ***
grant EXECUTE                                                                on P_FM_INTDOCCHECK to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_INTDOCCHECK to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FM_INTDOCCHECK.sql =========*** 
PROMPT ===================================================================================== 
