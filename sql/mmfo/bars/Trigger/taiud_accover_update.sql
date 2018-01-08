

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_ACCOVER_UPDATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_ACCOVER_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_ACCOVER_UPDATE 
after insert or delete or update
of  ACC, ACCO, TIPO, FLAG, ND, DAY, SOS, DATD, SD, NDOC, VIDD, DATD2
    , KRL, USEOSTF, USELIM, ACC_9129, ACC_8000, OBS, TXT, USERID
    , DELETED, PR_2600A, PR_KOMIS, PR_9129, PR_2069, ACC_2067, ACC_2069, ACC_2096
    , KF, FIN, FIN23, OBS23, KAT23, K23, ACC_3739, ACC_3600
    , S_3600, FLAG_3600
ON BARS.ACC_OVER
for each row
declare
  -- ver. 05.05.2016
  l_rec  BARS.ACC_OVER_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.ACC := :old.ACC;              l_rec.ACCO := :old.ACCO;            l_rec.TIPO := :old.TIPO;            l_rec.FLAG := :old.FLAG;
        l_rec.ND := :old.ND;                l_rec.DAY := :old.DAY;              l_rec.SOS := :old.SOS;              l_rec.DATD := :old.DATD;
        l_rec.SD := :old.SD;                l_rec.NDOC := :old.NDOC;            l_rec.VIDD := :old.VIDD;            l_rec.DATD2 := :old.DATD2;
        l_rec.KRL := :old.KRL;              l_rec.USEOSTF := :old.USEOSTF;      l_rec.USELIM := :old.USELIM;        l_rec.ACC_9129 := :old.ACC_9129;
        l_rec.ACC_8000 := :old.ACC_8000;    l_rec.OBS := :old.OBS;              l_rec.TXT := :old.TXT;              l_rec.USERID := :old.USERID;
        l_rec.DELETED := :old.DELETED;      l_rec.PR_2600A := :old.PR_2600A;    l_rec.PR_KOMIS := :old.PR_KOMIS;    l_rec.PR_9129 := :old.PR_9129;
        l_rec.PR_2069 := :old.PR_2069;      l_rec.ACC_2067 := :old.ACC_2067;    l_rec.ACC_2069 := :old.ACC_2069;    l_rec.ACC_2096 := :old.ACC_2096;
        l_rec.KF := :old.KF;                l_rec.FIN := :old.FIN;              l_rec.FIN23 := :old.FIN23;          l_rec.OBS23 := :old.OBS23;
        l_rec.KAT23 := :old.KAT23;          l_rec.K23 := :old.K23;              l_rec.ACC_3739 := :old.ACC_3739;    l_rec.ACC_3600 := :old.ACC_3600;
        l_rec.S_3600 := :old.S_3600;        l_rec.FLAG_3600 := :old.FLAG_3600;
    else
        l_rec.ACC := :new.ACC;              l_rec.ACCO := :new.ACCO;            l_rec.TIPO := :new.TIPO;            l_rec.FLAG := :new.FLAG;
        l_rec.ND := :new.ND;                l_rec.DAY := :new.DAY;              l_rec.SOS := :new.SOS;              l_rec.DATD := :new.DATD;
        l_rec.SD := :new.SD;                l_rec.NDOC := :new.NDOC;            l_rec.VIDD := :new.VIDD;            l_rec.DATD2 := :new.DATD2;
        l_rec.KRL := :new.KRL;              l_rec.USEOSTF := :new.USEOSTF;      l_rec.USELIM := :new.USELIM;        l_rec.ACC_9129 := :new.ACC_9129;
        l_rec.ACC_8000 := :new.ACC_8000;    l_rec.OBS := :new.OBS;              l_rec.TXT := :new.TXT;              l_rec.USERID := :new.USERID;
        l_rec.DELETED := :new.DELETED;      l_rec.PR_2600A := :new.PR_2600A;    l_rec.PR_KOMIS := :new.PR_KOMIS;    l_rec.PR_9129 := :new.PR_9129;
        l_rec.PR_2069 := :new.PR_2069;      l_rec.ACC_2067 := :new.ACC_2067;    l_rec.ACC_2069 := :new.ACC_2069;    l_rec.ACC_2096 := :new.ACC_2096;
        l_rec.KF := :new.KF;                l_rec.FIN := :new.FIN;              l_rec.FIN23 := :new.FIN23;          l_rec.OBS23 := :new.OBS23;
        l_rec.KAT23 := :new.KAT23;          l_rec.K23 := :new.K23;              l_rec.ACC_3739 := :new.ACC_3739;    l_rec.ACC_3600 := :new.ACC_3600;
        l_rec.S_3600 := :new.S_3600;        l_rec.FLAG_3600 := :new.FLAG_3600;
    end if;
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_acc_over_update', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := gl.aUID;
    l_rec.CHGDATE       := sysdate;

    insert into BARS.ACC_OVER_UPDATE values l_rec;

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
        when (:old.acc <> :new.acc or :old.acco <> :new.acco or :old.nd <> :new.nd)
        -- ND у вивантаженнях прирівнюється до складника первинного ключа
        then

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;

        when (    :old.TIPO <> :new.TIPO OR (:old.TIPO IS NULL AND :new.TIPO IS NOT NULL) OR (:old.TIPO IS NOT NULL AND :new.TIPO IS NULL)
               or :old.FLAG <> :new.FLAG OR (:old.FLAG IS NULL AND :new.FLAG IS NOT NULL) OR (:old.FLAG IS NOT NULL AND :new.FLAG IS NULL)
--             or :old.ND <> :new.ND OR (:old.ND IS NULL AND :new.ND IS NOT NULL) OR (:old.ND IS NOT NULL AND :new.ND IS NULL)
               or :old.DAY <> :new.DAY OR (:old.DAY IS NULL AND :new.DAY IS NOT NULL) OR (:old.DAY IS NOT NULL AND :new.DAY IS NULL)
               or :old.SOS <> :new.SOS OR (:old.SOS IS NULL AND :new.SOS IS NOT NULL) OR (:old.SOS IS NOT NULL AND :new.SOS IS NULL)
               or :old.DATD <> :new.DATD OR (:old.DATD IS NULL AND :new.DATD IS NOT NULL) OR (:old.DATD IS NOT NULL AND :new.DATD IS NULL)
               or :old.SD <> :new.SD OR (:old.SD IS NULL AND :new.SD IS NOT NULL) OR (:old.SD IS NOT NULL AND :new.SD IS NULL)
               or :old.NDOC <> :new.NDOC OR (:old.NDOC IS NULL AND :new.NDOC IS NOT NULL) OR (:old.NDOC IS NOT NULL AND :new.NDOC IS NULL)
               or :old.VIDD <> :new.VIDD OR (:old.VIDD IS NULL AND :new.VIDD IS NOT NULL) OR (:old.VIDD IS NOT NULL AND :new.VIDD IS NULL)
               or :old.DATD2 <> :new.DATD2 OR (:old.DATD2 IS NULL AND :new.DATD2 IS NOT NULL) OR (:old.DATD2 IS NOT NULL AND :new.DATD2 IS NULL)
               or :old.KRL <> :new.KRL OR (:old.KRL IS NULL AND :new.KRL IS NOT NULL) OR (:old.KRL IS NOT NULL AND :new.KRL IS NULL)
               or :old.USEOSTF <> :new.USEOSTF OR (:old.USEOSTF IS NULL AND :new.USEOSTF IS NOT NULL) OR (:old.USEOSTF IS NOT NULL AND :new.USEOSTF IS NULL)
               or :old.USELIM <> :new.USELIM OR (:old.USELIM IS NULL AND :new.USELIM IS NOT NULL) OR (:old.USELIM IS NOT NULL AND :new.USELIM IS NULL)
               or :old.ACC_9129 <> :new.ACC_9129 OR (:old.ACC_9129 IS NULL AND :new.ACC_9129 IS NOT NULL) OR (:old.ACC_9129 IS NOT NULL AND :new.ACC_9129 IS NULL)
               or :old.ACC_8000 <> :new.ACC_8000 OR (:old.ACC_8000 IS NULL AND :new.ACC_8000 IS NOT NULL) OR (:old.ACC_8000 IS NOT NULL AND :new.ACC_8000 IS NULL)
               or :old.OBS <> :new.OBS OR (:old.OBS IS NULL AND :new.OBS IS NOT NULL) OR (:old.OBS IS NOT NULL AND :new.OBS IS NULL)
               or :old.TXT <> :new.TXT OR (:old.TXT IS NULL AND :new.TXT IS NOT NULL) OR (:old.TXT IS NOT NULL AND :new.TXT IS NULL)
               or :old.USERID <> :new.USERID OR (:old.USERID IS NULL AND :new.USERID IS NOT NULL) OR (:old.USERID IS NOT NULL AND :new.USERID IS NULL)
               or :old.DELETED <> :new.DELETED OR (:old.DELETED IS NULL AND :new.DELETED IS NOT NULL) OR (:old.DELETED IS NOT NULL AND :new.DELETED IS NULL)
               or :old.PR_2600A <> :new.PR_2600A OR (:old.PR_2600A IS NULL AND :new.PR_2600A IS NOT NULL) OR (:old.PR_2600A IS NOT NULL AND :new.PR_2600A IS NULL)
               or :old.PR_KOMIS <> :new.PR_KOMIS OR (:old.PR_KOMIS IS NULL AND :new.PR_KOMIS IS NOT NULL) OR (:old.PR_KOMIS IS NOT NULL AND :new.PR_KOMIS IS NULL)
               or :old.PR_9129 <> :new.PR_9129 OR (:old.PR_9129 IS NULL AND :new.PR_9129 IS NOT NULL) OR (:old.PR_9129 IS NOT NULL AND :new.PR_9129 IS NULL)
               or :old.PR_2069 <> :new.PR_2069 OR (:old.PR_2069 IS NULL AND :new.PR_2069 IS NOT NULL) OR (:old.PR_2069 IS NOT NULL AND :new.PR_2069 IS NULL)
               or :old.ACC_2067 <> :new.ACC_2067 OR (:old.ACC_2067 IS NULL AND :new.ACC_2067 IS NOT NULL) OR (:old.ACC_2067 IS NOT NULL AND :new.ACC_2067 IS NULL)
               or :old.ACC_2069 <> :new.ACC_2069 OR (:old.ACC_2069 IS NULL AND :new.ACC_2069 IS NOT NULL) OR (:old.ACC_2069 IS NOT NULL AND :new.ACC_2069 IS NULL)
               or :old.ACC_2096 <> :new.ACC_2096 OR (:old.ACC_2096 IS NULL AND :new.ACC_2096 IS NOT NULL) OR (:old.ACC_2096 IS NOT NULL AND :new.ACC_2096 IS NULL)
               or :old.KF <> :new.KF OR (:old.KF IS NULL AND :new.KF IS NOT NULL) OR (:old.KF IS NOT NULL AND :new.KF IS NULL)
               or :old.FIN <> :new.FIN OR (:old.FIN IS NULL AND :new.FIN IS NOT NULL) OR (:old.FIN IS NOT NULL AND :new.FIN IS NULL)
               or :old.FIN23 <> :new.FIN23 OR (:old.FIN23 IS NULL AND :new.FIN23 IS NOT NULL) OR (:old.FIN23 IS NOT NULL AND :new.FIN23 IS NULL)
               or :old.OBS23 <> :new.OBS23 OR (:old.OBS23 IS NULL AND :new.OBS23 IS NOT NULL) OR (:old.OBS23 IS NOT NULL AND :new.OBS23 IS NULL)
               or :old.KAT23 <> :new.KAT23 OR (:old.KAT23 IS NULL AND :new.KAT23 IS NOT NULL) OR (:old.KAT23 IS NOT NULL AND :new.KAT23 IS NULL)
               or :old.K23 <> :new.K23 OR (:old.K23 IS NULL AND :new.K23 IS NOT NULL) OR (:old.K23 IS NOT NULL AND :new.K23 IS NULL)
               or :old.ACC_3739 <> :new.ACC_3739 OR (:old.ACC_3739 IS NULL AND :new.ACC_3739 IS NOT NULL) OR (:old.ACC_3739 IS NOT NULL AND :new.ACC_3739 IS NULL)
               or :old.ACC_3600 <> :new.ACC_3600 OR (:old.ACC_3600 IS NULL AND :new.ACC_3600 IS NOT NULL) OR (:old.ACC_3600 IS NOT NULL AND :new.ACC_3600 IS NULL)
               or :old.S_3600 <> :new.S_3600 OR (:old.S_3600 IS NULL AND :new.S_3600 IS NOT NULL) OR (:old.S_3600 IS NOT NULL AND :new.S_3600 IS NULL)
               or :old.FLAG_3600 <> :new.FLAG_3600 OR (:old.FLAG_3600 IS NULL AND :new.FLAG_3600 IS NOT NULL) OR (:old.FLAG_3600 IS NOT NULL AND :new.FLAG_3600 IS NULL)
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

end TAIUD_ACCOVER_UPDATE;
/
ALTER TRIGGER BARS.TAIUD_ACCOVER_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_ACCOVER_UPDATE.sql =========**
PROMPT ===================================================================================== 
