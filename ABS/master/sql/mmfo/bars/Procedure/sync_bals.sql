

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SYNC_BALS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SYNC_BALS ***

  CREATE OR REPLACE PROCEDURE BARS.SYNC_BALS (p_mode in number default 1)
is
l_fdat  date;
l_pmon  date;
begin

    for c in (select kf from mv_kf)
    loop
        bc.subst_branch('/' || c.kf || '/');

        -- �������� ���������� ����
        select max(fdat) into l_fdat
          from fdat where fdat <= (select max(to_date(val, 'mm/dd/yyyy')) 
                                     from params$base 
                                    where par = 'BANKDATE');
        -- �������� ���� ����������� ������ 
        l_pmon := trunc(trunc(l_fdat, 'mon')-1, 'mon');
    
        -- ��������� ������������� ������� ��������
        bars_accm_sync.sync_snap('BALANCE', l_fdat);
    
        -- ��������� ������������� �������� ���������� (�� ����. �����)
        bars_accm_sync.sync_agg('MONBAL', l_pmon);
    
        bc.set_context;
    end loop;    
    
end sync_bals; 
 
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SYNC_BALS.sql =========*** End ***
PROMPT ===================================================================================== 
