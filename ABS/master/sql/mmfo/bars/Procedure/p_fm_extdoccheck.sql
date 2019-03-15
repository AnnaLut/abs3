

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FM_EXTDOCCHECK.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FM_EXTDOCCHECK ***

  CREATE OR REPLACE PROCEDURE BARS.P_FM_EXTDOCCHECK (p_rec number default null)
--
-- Version 1.6 06/09/2016
--
-- �������� �������� (��������) ����������
--   ���������
--
is
  ----
  -- fm_check - �������� ������ ���������
  --
  l_datr  date;
  procedure fm_check (p_rec number)
  is
     resource_busy   exception;
     pragma exception_init (resource_busy, -54);
     --
     l_nazn          arc_rrp.nazn%type;
     l_nama          arc_rrp.nam_a%type;
     l_namb          arc_rrp.nam_b%type;
     l_mfoa          arc_rrp.mfoa%type;
     l_mfob          arc_rrp.mfob%type;
     l_otm           number;
     l_id_a          arc_rrp.id_a%type;
     l_id_b          arc_rrp.id_b%type;
  begin
     begin
        select a.nazn, a.nam_a, a.nam_b, a.mfoa, a.mfob , a.id_a , a.id_b
          into l_nazn, l_nama, l_namb, l_mfoa, l_mfob , l_id_a, l_id_b
          from arc_rrp a
         where a.rec = p_rec
           for update of a.blk nowait;
     exception
        when no_data_found then return;
        when resource_busy then return;
     end;

     --
     -- �������� �� ���������� �� ������� �����������:
     -- �� ��������� ���� ��������� � �������� ��������� (��������� �������� �� ���������)
     if (l_mfoa = f_ourmfo or l_mfob = f_ourmfo) then
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
     else
        l_otm := 0;
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
                                    where ref = p_rec
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
	 
	 
     -- ������ ������� "���������" ��� ���������
     update rec_que set fmcheck = 1 where rec = p_rec;
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
                        where ref = p_rec
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
     -- ���� �������� ��������������, ������ ������� ���������� 131313
     -- � ������� ��� � ������� ������. ����������
     if l_otm > 0 then
        update arc_rrp set blk = 131313 where rec = p_rec;

        begin
           insert into fm_rec_que (rec, otm)
           values (p_rec, l_otm);
        exception
           -- ������ ��� ����
           when dup_val_on_index then null;
        end;
     end if;

  end fm_check;

begin

  -- �������� ������ ���������
  if p_rec is not null then
     for r in ( select rec from rec_que where nvl (fmcheck, 0) = 0 and rec = p_rec )
     loop
        fm_check (r.rec);
     end loop;
  -- ��������� ��������
  else
     for b in (select kf from mv_kf)
     loop
        -- �������������� ����� ���
        bc.subst_mfo (b.kf);

        for r in ( select rec from rec_que where nvl (fmcheck, 0) = 0 )
        loop
           fm_check (r.rec);
        end loop;

        -- ������������ � ����
        bc.set_context;
    end loop;
  end if;

exception
  when others then
     -- ������������ � ����
     bc.set_context;
     -- ����������� ����������� ������ ������
     raise_application_error (
        -20000,
           dbms_utility.format_error_stack ()
        || chr (10)
        || dbms_utility.format_error_backtrace ());
end;
/
show err;

PROMPT *** Create  grants  P_FM_EXTDOCCHECK ***
grant EXECUTE                                                                on P_FM_EXTDOCCHECK to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_EXTDOCCHECK to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FM_EXTDOCCHECK.sql =========*** 
PROMPT ===================================================================================== 
