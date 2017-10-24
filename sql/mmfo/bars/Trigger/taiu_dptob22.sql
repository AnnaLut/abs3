

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_DPTOB22.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_DPTOB22 ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_DPTOB22 
INSTEAD of INSERT OR UPDATE ON BARS.DPT_OB22
FOR EACH ROW
DECLARE
  --
  -- procedure and function
  --
  function check_params( p_nbs   sb_ob22.r020%type,
                         p_ob22  sb_ob22.ob22%type
                       ) return  boolean
  is
    l_ret  number(1);
  begin
    begin
      select 1
        into l_ret
        from sb_ob22
       where r020 = p_nbs
         and ob22 = p_ob22;
    exception
      when NO_DATA_FOUND then
        bars_error.raise_nerror ('DPU', 'INVALID_OBB22', p_ob22, p_nbs);
        l_ret := 0;
    end;

    Return TRUE;

  end check_params;

  procedure set_dpt_params( p_vidd  in  dpt_vidd_params.vidd%type,
                            p_tag   in  dpt_vidd_params.tag%type ,
                            p_val   in  dpt_vidd_params.val%type )
  is
  begin
    if (p_val is Null) then
      delete from DPT_VIDD_PARAMS
       where VIDD = p_vidd
         and TAG  = p_tag;
    else
      update DPT_VIDD_PARAMS
         set VAL  = p_val
       where VIDD = p_vidd
         and TAG  = p_tag;

      if (sql%rowcount = 0) then
        insert into DPT_VIDD_PARAMS
          (  VIDD,   TAG,   VAL)
        values
          (p_vidd, p_tag, p_val);
      end if;
    end if;
  end set_dpt_params;

BEGIN

  -- DPT_OB22
  if (:old.OB22_DEP != :new.OB22_DEP) or (:old.OB22_DEP is null And :new.OB22_DEP is not null) then
    set_dpt_params(:new.vidd, 'DPT_OB22', :new.OB22_DEP);
  end if;

  -- INT_OB22
  if (:old.OB22_INT != :new.OB22_INT) or (:old.OB22_INT is null And :new.OB22_INT is not null) then
    set_dpt_params(:new.vidd, 'INT_OB22', :new.OB22_INT);
  end if;

  -- DB7_OB22
  if (:old.OB22_EXP != :new.OB22_EXP) or (:old.OB22_EXP is null And :new.OB22_EXP is not null) then
    if (check_params(:new.NBS_EXP, :new.OB22_EXP)) then
      set_dpt_params(:new.vidd, 'DB7_OB22', :new.OB22_EXP);
    end if;
  end if;

  -- KR7_OB22
  set_dpt_params(:new.vidd, 'KR7_OB22', :new.OB22_RED);

  -- AMR_OB22
  if (:old.OB22_AMR != :new.OB22_AMR) or (:old.OB22_AMR is null And :new.OB22_AMR is not null) then
    set_dpt_params(:new.vidd, 'AMR_OB22', :new.OB22_AMR);
  end if;

END TAIU_DPTVIDDOB22;



/
ALTER TRIGGER BARS.TAIU_DPTOB22 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_DPTOB22.sql =========*** End **
PROMPT ===================================================================================== 
