PROMPT =============== *** start onetime set bonus  *** ==========================

declare
  l_title constant varchar2(16) := 'dpt_bonus_addit:';
  l_bonusval  number;
  l_bonus_cnt number;
  l_bonusdate date;
  l_zp_count  number;
  p_dat       DATE := trunc(sysdate);
  l_brate     bars.int_ratn.br%type;
  l_irate     bars.int_ratn.ir%type;
  l_indrate   bars.Dpt_Vidd_Extdesc%rowtype;
  l_brtype    varchar2(25);
  l_err varchar2(200);
  l_iserror boolean;
BEGIN
  bc.go('/');
  FOR cur IN (SELECT kf FROM bars.mv_kf where kf in (328845, 337568))
  
   LOOP
    bc.go(cur.kf);
    bars_audit.info('Onetime_set_bonus. ������ ��������� ������� ����� ��� kf = '||to_char(cur.kf));
    
   For i in (select * from tmp_int_ddpt tid
        where tid.kf = cur.kf
        and nvl(trim(tid.note),'-') <> 'OK') loop
       BEGIN
        l_bonusval := 0;
        l_err := '';
        l_iserror := false;
        
        bars_audit.trace('%s ������ ��������� ������� �����', l_title);
        l_err := l_err ||'1-';
        bars.dpt_bonus.set_bonus(i.deposit_id); -- ������������ �����
        commit;
        bars_audit.trace('%s ������ ����������', l_title);
        bars_audit.trace('%s ����� �������� ���������� ������, �� ��������� �������������', l_title);
        
        --������� �� ���. ���������� � �������������        
        delete from dpt_depositw
           where tag = 'BONUS'
             and DPT_ID = i.deposit_id;
          l_err := l_err ||'3-';
        begin
          DPT_BONUS.SET_BONUS_RATE_long(i.deposit_id, p_dat + 1, l_bonusval);
          bars_audit.trace('%s ����������� ������� ������ = %s',
                           l_title,
                           to_char(l_bonusval));
        exception when others then
          l_err := '������ ��������� �������� ������ acc = '||to_char(i.acc)||' ir = '||to_char(l_bonusval)||' dat = '||to_char(p_dat+1 ,'DD/MM/YYYY');
          l_iserror := true; 
        end;    
          l_err := l_err ||'4-';
        
        if i.type_code = 'MPRG' then --#3
                 -- � ���, ���� ������� �������������, �� ����� ���� �������� ��� ������ 12-� �����������
              select nvl(max(dat_begin), i.dat_begin)
              into l_bonusdate
              from bars.dpt_deposit_clos
              where deposit_id = i.deposit_id
              and nvl(cnt_dubl,0) = trunc(nvl(i.cnt_dubl,0)/12) * 12;
        else --#3
           l_bonusdate := i.dat_begin; 
        end if; --#3
        
        l_zp_count := dpt_bonus.get_MMFO_ZPcard_count(i.rnk, l_bonusdate);
        
        if l_iserror then
        
        update BARS.tmp_int_ddpt 
        set note = 'err: '||l_err,
        bonus = l_bonusval,
        open_zp_cnt = l_zp_count
        where deposit_id = i.deposit_id
        and acc = i.acc
        and kf = i.kf;
        
        else  
        
        update BARS.tmp_int_ddpt 
        set note = 'OK',
        bonus = l_bonusval,
        open_zp_cnt = l_zp_count
        where deposit_id = i.deposit_id
        and acc = i.acc
        and kf = i.kf;
        
        end if;
         
        EXCEPTION 
          WHEN OTHERS 
           THEN 
             l_err := substr(l_err ||' - '||sqlerrm, 1,200);
        update BARS.tmp_int_ddpt 
        set note = 'err: '||l_err
        where deposit_id = i.deposit_id
        and acc = i.acc
        and kf = i.kf;
        END;
        
  end loop;
  commit;
  bars_audit.info('Onetime_set_bonus. ������ ��� kf = '||to_char(cur.kf)||' ���������� ');
  end loop;
  bc.home;

end;
/
show error

PROMPT =============== *** finish onetime set bonus  *** ==========================
