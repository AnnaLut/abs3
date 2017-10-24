

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_DPUTYPESOB22.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_DPUTYPESOB22 ***

  CREATE OR REPLACE TRIGGER BARS.TIU_DPUTYPESOB22 
before insert or update on BARS.DPU_TYPES_OB22
for each row
declare
  --------------------
  procedure check_ob22
  ( p_nbs  in   sb_ob22.R020%type,
    p_ob22 in   sb_ob22.OB22%type
  ) is
    l_count     pls_integer;
  begin
    select count(1)
      into l_count
      from SB_OB22
     where r020 = p_nbs
       and ob22 = p_ob22
       and d_close is null;

    If (l_count = 0) Then
      bars_error.raise_nerror ('DPU', 'INVALID_OBB22', p_ob22, p_nbs);
    End if;

  end check_ob22;
  -------------------
  /*
  procedure check_nbs
  is
    l_nbs_dep   sb_ob22.R020%type;
    l_nbs_int   sb_ob22.R020%type;
    l_nbs_exp   sb_ob22.R020%type;
    l_nbs_red   sb_ob22.R020%type;
  begin
    begin
      select NBS_DEP, NBS_INT, NBS_EXP, NBS_RED
        into l_nbs_dep, l_nbs_int, l_nbs_exp, l_nbs_red
        from BARS.DPU_NBS4CUST
       where K013 = :new.K013
         and S181 = :new.S181;
    exception
      when NO_DATA_FOUND then
        raise_application_error( -20911, 'Недопустима комбінація параметрів K013 та S181!', True );
    end;

    Case
      -- DEP
      when (:new.NBS_DEP is Null) Then
        :new.NBS_DEP := l_nbs_dep;
      when (:new.NBS_DEP <> l_nbs_dep) Then
        raise_application_error( -20911, 'Недопустимий бал.рах. '||:new.NBS_DEP||' для комбінації параметрів K013 та S181!', True );
      -- INT
      when (:new.NBS_INT is Null) Then
        :new.NBS_INT := l_nbs_int;
      when (:new.NBS_INT <> l_nbs_int) Then
        raise_application_error( -20911, 'Недопустимий бал.рах. '||:new.NBS_INT||' для комбінації параметрів K013 та S181!', True );
      -- EXP
      when (:new.NBS_EXP is Null) Then
        :new.NBS_EXP := l_nbs_exp;
      when (:new.NBS_EXP <> l_nbs_exp) Then
        raise_application_error( -20911, 'Недопустимий бал.рах. '||:new.NBS_EXP||' для комбінації параметрів K013 та S181!', True );
      -- RED
      when (:new.NBS_RED is Null) Then
        :new.NBS_RED := l_nbs_red;
      when (:new.NBS_RED <> l_nbs_red) Then
        raise_application_error( -20911, 'Недопустимий бал.рах. '||:new.NBS_RED||' для комбінації параметрів K013 та S181!', True );
      else
        null;
    End case;

  end check_nbs;
  */
begin
  /* перевірка правильності заповнення балансового рахунка       */
  -- check_nbs();

  /* перевірка правильності заповнення комбінації бал.рах + об22 */

  -- для рахунка депозиту
  If ((:new.NBS_DEP = :old.NBS_DEP) And (:new.OB22_DEP = :old.OB22_DEP)) Then
    null;
  Else
    check_ob22(:new.NBS_DEP, :new.OB22_DEP);
  End If;

  -- для рахунка відсотків
  If ((:new.NBS_INT = :old.NBS_INT) And (:new.OB22_INT = :old.OB22_INT)) Then
    null;
  Else
    check_ob22(:new.NBS_INT, :new.OB22_INT);
  End If;

  -- для рахунка витрат
  If ((:new.NBS_EXP = :old.NBS_EXP) And (:new.OB22_EXP = :old.OB22_EXP)) Then
    null;
  Else
    check_ob22(:new.NBS_EXP, :new.OB22_EXP);
  End If;

  -- для рахунка зменшення витрат (достр.вилучення)
  If ((:new.NBS_RED is Null) Or (:new.OB22_RED is Null)) Then
    :new.NBS_RED  := Null;
    :new.OB22_RED := Null;
  Else
    If ((:new.NBS_RED = :old.NBS_RED) And (:new.OB22_RED = :old.OB22_RED)) Then
      null;
    Else
      check_ob22(:new.NBS_RED, :new.OB22_RED);
    End If;
  End If;

end TIU_DPUTYPESOB22;


/
ALTER TRIGGER BARS.TIU_DPUTYPESOB22 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_DPUTYPESOB22.sql =========*** En
PROMPT ===================================================================================== 
