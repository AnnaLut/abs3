create or replace trigger TAIUD_SPECPARAM_UPDATE
after insert or delete or update
of ACC, R011, R013, S080, S180, S181, S190, S200, S230, S240, D020, S260, S270, R014, K072, Z290, S250, S090,
   NKD, S031, R114, S280, S290, S370, R012, S580, S130, ISTVAL, KF
ON SPECPARAM
for each row
declare
  l_rec  SPECPARAM_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.kf := :old.kf;     l_rec.ACC  := :old.ACC;  l_rec.R011 := :old.R011; l_rec.R013 := :old.R013;
        l_rec.S180 := :old.S180; l_rec.S181 := :old.S181; l_rec.S190 := :old.S190; l_rec.S200 := :old.S200;
        l_rec.S230 := :old.S230; l_rec.S240 := :old.S240; l_rec.D020 := :old.D020; l_rec.KF := :old.KF;
        l_rec.S260 := :old.S260; l_rec.S270 := :old.S270; l_rec.R014 := :old.R014; l_rec.K072 := :old.K072;
        l_rec.Z290 := :old.Z290; l_rec.S250 := :old.S250; l_rec.S090 := :old.S090; l_rec.NKD := :old.NKD;
        l_rec.S031 := :old.S031; l_rec.S080 := :old.S080; l_rec.R114 := :old.R114; l_rec.S280 := :old.S280;
        l_rec.S290 := :old.S290; l_rec.S370 := :old.S370; l_rec.R012 := :old.R012; l_rec.ISTVAL := :old.ISTVAL;
        l_rec.S580 := :old.S580; l_rec.S130 := :old.S130;
/*  далі поля, по яких ПОКИ ЩО, ПРИНАЙМНІ, не відслідковуємо змін значень
        l_rec.KEKD := :old.KEKD; l_rec.KTK := :old.KTK; l_rec.KVK := :old.KVK; l_rec.IDG := :old.IDG;
        l_rec.IDS  := :old.IDS;  l_rec.SPS := :old.SPS; l_rec.KBK := :old.KBK; l_rec.S120 := :old.S120;
        l_rec.S182 := :old.S182; l_rec.D1#F9 := :old.D1#F9; l_rec.NF#F9 := :old.NF#F9;
        l_rec.DP1  := :old.DP1;  l_rec.KVD := :old.KVD; l_rec.R016 := :old.R016;
*/
    else
        l_rec.kf := :new.kf;     l_rec.ACC  := :new.ACC;  l_rec.R011 := :new.R011; l_rec.R013 := :new.R013;
        l_rec.S180 := :new.S180; l_rec.S181 := :new.S181; l_rec.S190 := :new.S190; l_rec.S200 := :new.S200;
        l_rec.S230 := :new.S230; l_rec.S240 := :new.S240; l_rec.D020 := :new.D020; l_rec.KF := :new.KF;
        l_rec.S260 := :new.S260; l_rec.S270 := :new.S270; l_rec.R014 := :new.R014; l_rec.K072 := :new.K072;
        l_rec.Z290 := :new.Z290; l_rec.S250 := :new.S250; l_rec.S090 := :new.S090; l_rec.NKD := :new.NKD;
        l_rec.S031 := :new.S031; l_rec.S080 := :new.S080; l_rec.R114 := :new.R114; l_rec.S280 := :new.S280;
        l_rec.S290 := :new.S290; l_rec.S370 := :new.S370; l_rec.R012 := :new.R012; l_rec.ISTVAL := :new.ISTVAL;
        l_rec.S580 := :new.S580; l_rec.S130 := :new.S130; 
/*  далі поля, по яких ПОКИ ЩО, ПРИНАЙМНІ, не відслідковуємо змін значень
        l_rec.KEKD := :new.KEKD; l_rec.KTK := :new.KTK; l_rec.KVK := :new.KVK; l_rec.IDG := :new.IDG;
        l_rec.IDS := :new.IDS; l_rec.SPS := :new.SPS; l_rec.KBK := :new.KBK; l_rec.S120 := :new.S120;
        l_rec.S130 := :new.S130; l_rec.S182 := :new.S182; l_rec.D1#F9 := :new.D1#F9; l_rec.NF#F9 := :new.NF#F9;
        l_rec.DP1 := :new.DP1; l_rec.KVD := :new.KVD; l_rec.R016 := :new.R016;
*/
    end if;

    l_rec.IDUPD        := bars_sqnc.get_nextval( 'S_SPECPARAM_UPDATE', l_rec.kf );
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE := sysdate;
    l_rec.USER_NAME    := user_name;
    l_rec.fdat         := sysdate;

    insert into BARS.SPECPARAM_UPDATE values l_rec;

  end SAVE_CHANGES;
  ---
begin

  case
    when inserting
    then

      l_rec.CHGACTION := 'I';
      SAVE_CHANGES;

    when deleting
    then

      l_rec.CHGACTION := 'D';
      SAVE_CHANGES;

    when updating
    then

      case
        when (:old.ACC <> :new.ACC OR :old.KF <> :new.KF)
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when ( :old.R011 != :new.R011 OR (:old.R011 IS NULL AND :new.R011 IS NOT NULL) OR (:old.R011 IS NOT NULL AND :new.R011 IS NULL) OR
               :old.R012 != :new.R012 OR (:old.R012 IS NULL AND :new.R012 IS NOT NULL) OR (:old.R012 IS NOT NULL AND :new.R012 IS NULL) OR
               :old.R013 != :new.R013 OR (:old.R013 IS NULL AND :new.R013 IS NOT NULL) OR (:old.R013 IS NOT NULL AND :new.R013 IS NULL) OR
               :old.R014 != :new.R014 OR (:old.R014 IS NULL AND :new.R014 IS NOT NULL) OR (:old.R014 IS NOT NULL AND :new.R014 IS NULL) OR
               :old.R114 != :new.R114 OR (:old.R114 IS NULL AND :new.R114 IS NOT NULL) OR (:old.R114 IS NOT NULL AND :new.R114 IS NULL) OR
               :old.S031 != :new.S031 OR (:old.S031 IS NULL AND :new.S031 IS NOT NULL) OR (:old.S031 IS NOT NULL AND :new.S031 IS NULL) OR
               :old.S080 != :new.S080 OR (:old.S080 IS NULL AND :new.S080 IS NOT NULL) OR (:old.S080 IS NOT NULL AND :new.S080 IS NULL) OR
               :old.S180 != :new.S180 OR (:old.S180 IS NULL AND :new.S180 IS NOT NULL) OR (:old.S180 IS NOT NULL AND :new.S180 IS NULL) OR
               :old.S090 != :new.S090 OR (:old.S090 IS NULL AND :new.S090 IS NOT NULL) OR (:old.S090 IS NOT NULL AND :new.S090 IS NULL) OR
               :old.S130 != :new.S130 OR (:old.S130 IS NULL AND :new.S130 IS NOT NULL) OR (:old.S130 IS NOT NULL AND :new.S130 IS NULL) OR
               :old.S181 != :new.S181 OR (:old.S181 IS NULL AND :new.S181 IS NOT NULL) OR (:old.S181 IS NOT NULL AND :new.S181 IS NULL) OR
               :old.S190 != :new.S190 OR (:old.S190 IS NULL AND :new.S190 IS NOT NULL) OR (:old.S190 IS NOT NULL AND :new.S190 IS NULL) OR
               :old.S200 != :new.S200 OR (:old.S200 IS NULL AND :new.S200 IS NOT NULL) OR (:old.S200 IS NOT NULL AND :new.S200 IS NULL) OR
               :old.S230 != :new.S230 OR (:old.S230 IS NULL AND :new.S230 IS NOT NULL) OR (:old.S230 IS NOT NULL AND :new.S230 IS NULL) OR
               :old.S240 != :new.S240 OR (:old.S240 IS NULL AND :new.S240 IS NOT NULL) OR (:old.S240 IS NOT NULL AND :new.S240 IS NULL) OR
               :old.S250 != :new.S250 OR (:old.S250 IS NULL AND :new.S250 IS NOT NULL) OR (:old.S250 IS NOT NULL AND :new.S250 IS NULL) OR
               :old.S260 != :new.S260 OR (:old.S260 IS NULL AND :new.S260 IS NOT NULL) OR (:old.S260 IS NOT NULL AND :new.S260 IS NULL) OR
               :old.S270 != :new.S270 OR (:old.S270 IS NULL AND :new.S270 IS NOT NULL) OR (:old.S270 IS NOT NULL AND :new.S270 IS NULL) OR
               :old.S280 != :new.S280 OR (:old.S280 IS NULL AND :new.S280 IS NOT NULL) OR (:old.S280 IS NOT NULL AND :new.S280 IS NULL) OR
               :old.S290 != :new.S290 OR (:old.S290 IS NULL AND :new.S290 IS NOT NULL) OR (:old.S290 IS NOT NULL AND :new.S290 IS NULL) OR
               :old.S370 != :new.S370 OR (:old.S370 IS NULL AND :new.S370 IS NOT NULL) OR (:old.S370 IS NOT NULL AND :new.S370 IS NULL) OR
               :old.S580 != :new.S580 OR (:old.S580 IS NULL AND :new.S580 IS NOT NULL) OR (:old.S580 IS NOT NULL AND :new.S580 IS NULL) OR
               :old.D020 != :new.D020 OR (:old.D020 IS NULL AND :new.D020 IS NOT NULL) OR (:old.D020 IS NOT NULL AND :new.D020 IS NULL) OR
               :old.K072 != :new.K072 OR (:old.K072 IS NULL AND :new.K072 IS NOT NULL) OR (:old.K072 IS NOT NULL AND :new.K072 IS NULL) OR
               :old.Z290 != :new.Z290 OR (:old.Z290 IS NULL AND :new.Z290 IS NOT NULL) OR (:old.Z290 IS NOT NULL AND :new.Z290 IS NULL) OR
               :old.NKD  != :new.NKD  OR (:old.NKD IS NULL  AND :new.NKD  IS NOT NULL) OR (:old.NKD  IS NOT NULL AND :new.NKD  IS NULL) OR
               :old.ISTVAL != :new.ISTVAL OR (:old.ISTVAL IS NULL AND :new.ISTVAL IS NOT NULL) OR (:old.ISTVAL IS NOT NULL AND :new.ISTVAL IS NULL)
            )
        then -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY

          -- протоколюємо внесені зміни
          l_rec.CHGACTION := 'U';
          SAVE_CHANGES;

        else
          Null;
      end case;

    else
      null;
  end case;

end TAIUD_SPECPARAM_UPDATE;
/

show errors;
