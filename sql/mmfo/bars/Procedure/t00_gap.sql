create or replace procedure T00_GAP ( p_dat date ) is l_acc number;
begin
    begin 
      select acc into l_acc from accounts where kv = 980 and tip =  'T00';
    exception when no_data_found then RETURN;
    end;

    execute immediate 'truncate TABLE TMP_OPER_PS1' ;

 

    insert into TMP_OPER_PS1 (ref, vdat, tt, mfoa, mfob, dk, s , sos, nazn)
    select ref, vdat, tt, mfoa, mfob, dk, s , sos, nazn
      from oper
     where ref in (select ref
              from (select ref from arc_rrp  where kv = 980  and dk = 1
                       AND (mfoa=gl.KF and fn_b like '$A%' and dat_b > p_dat-1  and dat_b <= p_dat
                            OR
                            mfob=gl.KF and fn_a like '$B%' and dat_a > p_dat-1  and dat_a <= p_dat
                            )
                    union all  select ref from zag_a where kv = 980 and fn like '$B%' and dat = p_dat
                    union all  select ref from zag_b where kv = 980 and fn like '$A%' and dat = p_dat
                   ) x
              where not exists (select 1 from opldok where ref = x.ref and acc = l_acc )
             );
  end T00_GAP ;
/