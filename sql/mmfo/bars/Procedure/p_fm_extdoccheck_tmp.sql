

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FM_EXTDOCCHECK_TMP.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FM_EXTDOCCHECK_TMP ***

  CREATE OR REPLACE PROCEDURE BARS.P_FM_EXTDOCCHECK_TMP (p_rec number)
--
-- Version 1.0 18/06/2018
-- ��������� ��������� ������ P_FM_EXTDOCCHECK ��� ������������ � ������� �����--
-- �������� �������� (��������) ����������
--   ���������
--
is
  ----
  -- fm_check - �������� ������ ���������
  --
  l_datr  date;
  l_doc_lock_limit constant number := 100;
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
  begin
     begin
        select a.nazn, a.nam_a, a.nam_b, a.mfoa, a.mfob
          into l_nazn, l_nama, l_namb, l_mfoa, l_mfob
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

        for r in ( select rownum rn, rec from rec_que where nvl (fmcheck, 0) = 0 )
        loop
           fm_check (r.rec);
           -- �������� (�������� oper for update) ������ N ����������� ����������
           if mod(r.rn, l_doc_lock_limit) = 0 then
               commit;
           end if;
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

PROMPT *** Create  grants  P_FM_EXTDOCCHECK_TMP ***
grant EXECUTE                                                                on P_FM_EXTDOCCHECK_TMP to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_EXTDOCCHECK_TMP to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FM_EXTDOCCHECK_TMP.sql =========*** 
PROMPT ===================================================================================== 
