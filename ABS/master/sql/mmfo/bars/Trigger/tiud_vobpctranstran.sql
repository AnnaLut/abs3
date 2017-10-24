

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_VOBPCTRANSTRAN.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_VOBPCTRANSTRAN ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_VOBPCTRANSTRAN 
instead of update on v_obpc_trans_tran for each row
declare
  l_acc_tr  number;
  l_acc_fs  number;
  l_acc_fl  number;
  l_acc_us  number;
  l_acc_ul  number;
function get_acc(p_nls varchar2, p_kv number) return number
is
  l_acc number;
begin
  if p_nls is not null then
     begin
       select acc into l_acc
         from accounts
        where nls = p_nls and kv = p_kv
          and branch = sys_context('bars_context','user_branch');
     exception when no_data_found then
        if p_kv = 840 then
           begin
             select acc into l_acc
               from accounts
              where nls = p_nls and kv = 980
                and branch = sys_context('bars_context','user_branch');
           exception when no_data_found then
              raise_application_error(-20000, 'Рахунок не знайдено: NLS=' || p_nls || ', KV=USD,UAH');
           end;
        else
           raise_application_error(-20000, 'Рахунок не знайдено: NLS=' || p_nls || ', KV=' || p_kv);
        end if;
     end;
  else
     l_acc := null;
  end if;
  return l_acc;
end;
begin

  if :new.t980 is null and
     :new.t980_f_short is null and :new.t980_f_long is null and
     :new.t980_u_short is null and :new.t980_u_long is null then
     delete from obpc_trans_tran
      where tran_type = :old.tran_type and tip = :old.tip and kv = 980
        and branch = sys_context('bars_context','user_branch');
  else
     l_acc_tr := get_acc(:new.t980,980);
     l_acc_fs := get_acc(:new.t980_f_short,980);
     l_acc_fl := get_acc(:new.t980_f_long,980);
     l_acc_us := get_acc(:new.t980_u_short,980);
     l_acc_ul := get_acc(:new.t980_u_long,980);
     update obpc_trans_tran
        set transit_acc = l_acc_tr,
            acc_f_short = l_acc_fs,
            acc_f_long  = l_acc_fl,
            acc_u_short = l_acc_us,
            acc_u_long  = l_acc_ul
      where tran_type = :old.tran_type and tip = :old.tip and kv = 980
        and branch = sys_context('bars_context','user_branch');
     if sql%rowcount = 0 then
        insert into obpc_trans_tran(tran_type, tip, kv, transit_acc, acc_f_short, acc_f_long, acc_u_short, acc_u_long, branch)
        values(:new.tran_type, :new.tip, 980, l_acc_tr, l_acc_fs, l_acc_fl, l_acc_us, l_acc_ul, sys_context('bars_context','user_branch'));
     end if;
  end if;

  if :new.t840 is null and
     :new.t840_f_short is null and :new.t840_f_long is null and
     :new.t840_u_short is null and :new.t840_u_long is null then
     delete from obpc_trans_tran
      where tran_type = :old.tran_type and tip = :old.tip and kv = 840
        and branch = sys_context('bars_context','user_branch');
  else
     l_acc_tr := get_acc(:new.t840,nvl(:new.v840,840));
     l_acc_fs := get_acc(:new.t840_f_short,nvl(:new.v840_f_short,840));
     l_acc_fl := get_acc(:new.t840_f_long,nvl(:new.v840_f_long,840));
     l_acc_us := get_acc(:new.t840_u_short,nvl(:new.v840_u_short,840));
     l_acc_ul := get_acc(:new.t840_u_long,nvl(:new.v840_u_long,840));
     update obpc_trans_tran
        set transit_acc = l_acc_tr,
            acc_f_short = l_acc_fs,
            acc_f_long  = l_acc_fl,
            acc_u_short = l_acc_us,
            acc_u_long  = l_acc_ul
      where tran_type = :old.tran_type and tip = :old.tip and kv = 840
        and branch = sys_context('bars_context','user_branch');
     if sql%rowcount = 0 then
        insert into obpc_trans_tran(tran_type, tip, kv, transit_acc, acc_f_short, acc_f_long, acc_u_short, acc_u_long, branch)
        values(:new.tran_type, :new.tip, 840, l_acc_tr, l_acc_fs, l_acc_fl, l_acc_us, l_acc_ul, sys_context('bars_context','user_branch'));
     end if;
  end if;

end tiud_vobpctranstran;



/
ALTER TRIGGER BARS.TIUD_VOBPCTRANSTRAN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_VOBPCTRANSTRAN.sql =========***
PROMPT ===================================================================================== 
