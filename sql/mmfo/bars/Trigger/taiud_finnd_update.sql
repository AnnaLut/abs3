

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_FINND_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_FINND_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_FINND_UPDATE 
after insert or update of fdat, s, nd or delete ON BARS.FIN_ND
for each row
 WHEN (
nvl(old.fdat, to_date('01-01-1900','dd-mm-yyyy')) != new.fdat
       or nvl(old.s, 0) != new.s
       or old.nd != new.nd
      ) declare
  l_otm    fin_nd_update.chgaction%type := 0;
  l_idupd  fin_nd_update.idupd%type;
  l_FDAT    fin_nd_update.fdat%type;
  l_IDF    fin_nd_update.idf%type;
  l_KOD  fin_nd_update.kod%type;
  l_S    fin_nd_update.s%type;
  l_ND    fin_nd_update.nd%type;
  l_rnk    fin_nd_update.rnk%type;
  l_kf    fin_nd_update.kf%type;
begin
  if deleting then
    l_otm          := 3;
    l_nd           := :old.nd;
    l_rnk          := :old.rnk;
    l_FDAT         := :old.fdat;
    l_IDF          := :old.idf;
    l_KOD          := :old.kod;
    l_S            := :old.s;
    l_kf           := :old.kf;
  else
    if inserting then
      l_otm := 1;
    elsif UPDATING then
      l_otm := 2;
    end if;
    if l_otm>0 then
    l_nd           := :new.nd;
    l_rnk          := :new.rnk;
    l_FDAT         := :new.fdat;
    l_IDF          := :new.idf;
    l_KOD          := :new.kod;
    l_S            := :new.s;
    l_kf           := :new.kf;
    end if;
  end if;

  if l_otm>0 then
    l_idupd   := bars_sqnc.get_nextval('s_fin_nd_update', l_kf);
    insert
    into   fin_nd_update (        nd      ,
                                  rnk     ,
                                  fdat      ,
                                  idf    ,
                                  kod      ,
                                  s,
                                  kf,
                                  chgdate  ,
                                  chgaction,
                                  doneby   ,
                                  idupd)
                     values (   l_nd    ,
                                l_rnk   ,
                                l_fdat    ,
                                l_idf  ,
                                l_kod    ,
                                l_s,
                                l_kf,
                                sysdate  ,
                                l_otm    ,
                                user_name,
                                l_idupd);
  end if;
end;
/
ALTER TRIGGER BARS.TAIUD_FINND_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_FINND_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
