

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_DPT_DEPOSIT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_DPT_DEPOSIT ***

CREATE OR REPLACE TRIGGER TIUD_DPT_DEPOSIT
after insert or update or delete ON BARS.DPT_DEPOSIT for each row
declare
  --------------------
  -- коммерч.банк   --
  --------------------
  l_bankdate date          := gl.bdate;
  l_userid   number(38)    := gl.auid;
  l_tchtype  tips.tip%type := 'TCH';
  l_istchacc number(1)     := 0;
  l_actionid number(1);
  l_idupd    number(38);
begin


  if deleting then

    if :old.dat_end >= l_bankdate then
      l_actionid := 2;  -- досрочное закрытие
    else
      l_actionid:= 1;   -- перемещение в архив
    end if;

    select bars_sqnc.get_nextval('s_dpt_deposit_clos') into l_idupd from dual;

    insert into dpt_deposit_clos
      (idupd, deposit_id, nd, vidd, acc, kv, rnk,
       freq, datz, dat_begin, dat_end, dat_end_alt,
       mfo_p, nls_p, name_p, okpo_p,
       dpt_d, acc_d, mfo_d, nls_d, nms_d, okpo_d,
       limit, deposit_cod, comments,
       action_id, actiion_author, "WHEN", bdate, stop_id,
       cnt_dubl, cnt_ext_int, dat_ext_int, userid, archdoc_id, forbid_extension, branch, wb)
    values
      (l_idupd,:old.deposit_id,:old.nd,:old.vidd,:old.acc,:old.kv,:old.rnk,
       :old.freq,:old.datz,:old.dat_begin,:old.dat_end,:old.dat_end_alt,
       :old.mfo_p,:old.nls_p,:old.name_p,:old.okpo_p,
       :old.dpt_d,:old.acc_d,:old.mfo_d,:old.nls_d,:old.nms_d,:old.okpo_d,
       :old.limit,:old.deposit_cod,:old.comments,
       l_actionid, l_userid, sysdate, l_bankdate, :old.stop_id,
       :old.cnt_dubl, :old.cnt_ext_int, :old.dat_ext_int, :old.userid, :old.archdoc_id, :old.forbid_extension, :old.branch, :old.wb);

      DPT_WEB.CLOSE_STO_ARGMNT(P_DPTID    => :old.deposit_id,
                               P_ACCID    => :old.acc,
                               P_ARGMNTID => NULL);
  elsif inserting then

    if sys_context('USERENV','ACTION') = 'recovery_deposit' then
      l_actionid := 7;  -- восстановление
    else	
      l_actionid := 0;  -- открытие
    end if;

    select bars_sqnc.get_nextval('s_dpt_deposit_clos') into l_idupd from dual;

    insert into dpt_deposit_clos
      (idupd, deposit_id, nd, vidd, acc, kv, rnk,
       freq, datz, dat_begin, dat_end, dat_end_alt,
       mfo_p, nls_p, name_p, okpo_p,
       dpt_d, acc_d, mfo_d, nls_d, nms_d, okpo_d,
       limit, deposit_cod, comments,
       action_id, actiion_author, "WHEN", bdate, stop_id,
       cnt_dubl, cnt_ext_int, dat_ext_int, userid, archdoc_id, forbid_extension, branch, wb)
    values
      (l_idupd,:new.deposit_id,:new.nd,:new.vidd,:new.acc,:new.kv,:new.rnk,
       :new.freq,:new.datz,:new.dat_begin,:new.dat_end,:new.dat_end_alt,
       :new.mfo_p,:new.nls_p,:new.name_p,:new.okpo_p,
       :new.dpt_d,:new.acc_d,:new.mfo_d,:new.nls_d,:new.nms_d,:new.okpo_d,
       :new.limit,:new.deposit_cod,:new.comments,
       l_actionid, l_userid, sysdate, l_bankdate, :new.stop_id,
       :new.cnt_dubl, :new.cnt_ext_int, :new.dat_ext_int, :new.userid, :new.archdoc_id, :new.forbid_extension, :new.branch, :new.wb);

  else
    -- проверим, действительно ли что-то менялось
    if
        nvl(:old.deposit_id,  -10111977) != nvl(:new.deposit_id,  -10111977)
     or nvl(:old.vidd,        -10111977) != nvl(:new.vidd,        -10111977)
     or nvl(:old.acc,         -10111977) != nvl(:new.acc,         -10111977)
     or nvl(:old.kv,          -10111977) != nvl(:new.kv,          -10111977)
     or nvl(:old.rnk,         -10111977) != nvl(:new.rnk,         -10111977)
     or nvl(:old.freq,        -10111977) != nvl(:new.freq,        -10111977)
     or nvl(:old.dpt_d,       -10111977) != nvl(:new.dpt_d,       -10111977)
     or nvl(:old.acc_d,       -10111977) != nvl(:new.acc_d,       -10111977)
     or nvl(:old.limit,       -10111977) != nvl(:new.limit,       -10111977)
     or nvl(:old.stop_id,     -10111977) != nvl(:new.stop_id,     -10111977)
     or nvl(:old.cnt_dubl,    -10111977) != nvl(:new.cnt_dubl,    -10111977)
     or nvl(:old.cnt_ext_int, -10111977) != nvl(:new.cnt_ext_int, -10111977)
     or nvl(:old.userid,      -10111977) != nvl(:new.userid,      -10111977)
     or nvl(:old.archdoc_id,  -10111977) != nvl(:new.archdoc_id,  -10111977)
     or nvl(:old.forbid_extension,  -10111977) != nvl(:new.forbid_extension,  -10111977)
     or nvl(:old.nd,          '_____')   != nvl(:new.nd,          '_____')
     or nvl(:old.mfo_p,       '_____')   != nvl(:new.mfo_p,       '_____')
     or nvl(:old.nls_p ,      '_____')   != nvl(:new.nls_p ,      '_____')
     or nvl(:old.name_p,      '_____')   != nvl(:new.name_p,      '_____')
     or nvl(:old.okpo_p,      '_____')   != nvl(:new.okpo_p,      '_____')
     or nvl(:old.mfo_d ,      '_____')   != nvl(:new.mfo_d ,      '_____')
     or nvl(:old.nls_d ,      '_____')   != nvl(:new.nls_d ,      '_____')
     or nvl(:old.nms_d ,      '_____')   != nvl(:new.nms_d ,      '_____')
     or nvl(:old.okpo_d  ,    '_____')   != nvl(:new.okpo_d  ,    '_____')
     or nvl(:old.deposit_cod, '_____')   != nvl(:new.deposit_cod, '_____')
     or nvl(:old.comments,    '_____')   != nvl(:new.comments,    '_____')
     or nvl(:old.datz,        to_date('10.11.4977','dd.mm.yyyy')) !=
        nvl(:new.datz,        to_date('10.11.4977','dd.mm.yyyy'))
     or nvl(:old.dat_begin,   to_date('10.11.4977','dd.mm.yyyy')) !=
        nvl(:new.dat_begin,   to_date('10.11.4977','dd.mm.yyyy'))
     or nvl(:old.dat_end,     to_date('10.11.4977','dd.mm.yyyy')) !=
        nvl(:new.dat_end,     to_date('10.11.4977','dd.mm.yyyy'))
     or nvl(:old.dat_end_alt, to_date('10.11.4977','dd.mm.yyyy')) !=
        nvl(:new.dat_end_alt, to_date('10.11.4977','dd.mm.yyyy'))
     or nvl(:old.dat_ext_int, to_date('10.11.4977','dd.mm.yyyy')) !=
        nvl(:new.dat_ext_int, to_date('10.11.4977','dd.mm.yyyy'))
     or nvl(:old.branch,    '_____')   != nvl(:new.branch,    '_____') -- ребранчинг
     or nvl(:old.wb, 'E') != nvl(:new.wb, 'E')
    then

      if (:old.vidd <> :new.vidd)
      then
          l_actionid := 6;  -- изменение вида вклада
      elsif
         (:old.dat_begin is null     and :new.dat_begin is not null) or
         (:old.dat_end   is null     and :new.dat_end   is not null) or
         (:old.dat_begin is not null and :new.dat_begin is null)     or
         (:old.dat_end   is not null and :new.dat_end   is null)     or
         (:old.dat_begin != :new.dat_begin)                          or
         (:old.dat_end   != :new.dat_end)
      then
          l_actionid := 3;  -- переоформление
      else
          l_actionid := 4;  -- изменение параметров
      end if;
      
      select bars_sqnc.get_nextval('s_dpt_deposit_clos') into l_idupd from dual;

      insert into dpt_deposit_clos
        (idupd, kf, deposit_id, nd, vidd, acc, kv, rnk,
         freq, datz, dat_begin, dat_end, dat_end_alt,
         mfo_p, nls_p, name_p, okpo_p,
         dpt_d, acc_d, mfo_d, nls_d, nms_d, okpo_d,
         limit, deposit_cod, comments,
         action_id, actiion_author, "WHEN", bdate, stop_id,
         cnt_dubl, cnt_ext_int, dat_ext_int, userid, archdoc_id, forbid_extension, branch, wb)
      values
        (l_idupd, :new.kf, :new.deposit_id,:new.nd,:new.vidd,:new.acc,:new.kv,:new.rnk,
         :new.freq,:new.datz,:new.dat_begin,:new.dat_end,:new.dat_end_alt,
         :new.mfo_p,:new.nls_p,:new.name_p,:new.okpo_p,
         :new.dpt_d,:new.acc_d,:new.mfo_d,:new.nls_d,:new.nms_d,:new.okpo_d,
         :new.limit,:new.deposit_cod,:new.comments,
         l_actionid, l_userid, sysdate, l_bankdate, :new.stop_id,
         :new.cnt_dubl, :new.cnt_ext_int, :new.dat_ext_int, :new.userid, :new.archdoc_id,:new.forbid_extension, :new.branch, :new.wb);


    else
    
      return; -- ничего не менялось, выходим

    end if;

  end if;

end;

/

ALTER TRIGGER BARS.TIUD_DPT_DEPOSIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_DPT_DEPOSIT.sql =========*** En
PROMPT ===================================================================================== 
