prompt create trigger TIUD_STO_DET
CREATE OR REPLACE TRIGGER TIUD_STO_DET
after insert or update or delete ON BARS.STO_DET for each row
/* Историзация макетов регулярных платежей */
declare
    l_rec      sto_det_update%rowtype;
  
    procedure save_changes
    is
    begin
        select bars_sqnc.get_nextval('S_STO_DET_UPDATE')into l_rec.idupd from dual;
        l_rec."WHEN" := sysdate;
        l_rec.userid := gl.auid;
        if ( l_rec.ACTION = -1 ) then
            l_rec.kf            := :old.kf;                    l_rec.ids         := :old.ids;                 l_rec.vob         := :old.vob;
            l_rec.dk            := :old.dk;                    l_rec.tt          := :old.tt;                  l_rec.nlsa        := :old.nlsa;
            l_rec.kva           := :old.kva;                   l_rec.nlsb        := :old.nlsb;                l_rec.kvb         := :old.kvb;
            l_rec.mfob          := :old.mfob;                  l_rec.polu        := :old.polu;                l_rec.nazn        := :old.nazn;
            l_rec.fsum          := :old.fsum;                  l_rec.okpo        := :old.okpo;                l_rec.dat1        := :old.dat1;
            l_rec.dat2          := :old.dat2;                  l_rec.freq        := :old.freq;                l_rec.dat0        := :old.dat0;
            l_rec.wend          := :old.wend;                  l_rec.stmp        := :old.stmp;                l_rec.idd         := :old.idd;
            l_rec.ord           := :old.ord;                   l_rec.dr          := :old.dr;                  l_rec.branch      := :old.branch;
            l_rec.userid        := :old.userid;                l_rec.userid_made := :old.userid_made;         l_rec.branch_made := :old.branch_made;
            l_rec.datetimestamp := :old.datetimestamp;         l_rec.branch_card := :old.branch_card;         l_rec.status_id   := :old.status_id;
            l_rec.disclaim_id   := :old.disclaim_id;           l_rec.status_date := :old.status_date;         l_rec.status_uid  := :old.status_uid;

        else
            l_rec.kf            := :new.kf;                    l_rec.ids         := :new.ids;            l_rec.vob         := :new.vob;
            l_rec.dk            := :new.dk;                    l_rec.tt          := :new.tt;             l_rec.nlsa        := :new.nlsa;
            l_rec.kva           := :new.kva;                   l_rec.nlsb        := :new.nlsb;           l_rec.kvb         := :new.kvb;
            l_rec.mfob          := :new.mfob;                  l_rec.polu        := :new.polu;           l_rec.nazn        := :new.nazn;
            l_rec.fsum          := :new.fsum;                  l_rec.okpo        := :new.okpo;           l_rec.dat1        := :new.dat1;
            l_rec.dat2          := :new.dat2;                  l_rec.freq        := :new.freq;           l_rec.dat0        := :new.dat0;
            l_rec.wend          := :new.wend;                  l_rec.stmp        := :new.stmp;           l_rec.idd         := :new.idd;
            l_rec.ord           := :new.ord;                   l_rec.dr          := :new.dr;             l_rec.branch      := :new.branch;
            l_rec.userid        := :new.userid;                l_rec.userid_made := :new.userid_made;    l_rec.branch_made := :new.branch_made;
            l_rec.datetimestamp := :new.datetimestamp;         l_rec.branch_card := :new.branch_card;    l_rec.status_id   := :new.status_id;
            l_rec.disclaim_id   := :new.disclaim_id;           l_rec.status_date := :new.status_date;    l_rec.status_uid  := :new.status_uid;
        end if;
        insert into sto_det_update values l_rec;
    end save_changes;
begin
    if deleting then
        l_rec.action := -1; -- удаление
        save_changes;
    elsif inserting then
        l_rec.action := 0;  -- открытие
        save_changes;
    elsif updating then
        l_rec.action := 1; -- изменение
        -- проверим, действительно ли что-то менялось
        if   :old.IDS          != :new.IDS     OR (:old.IDS is null and :new.IDS is not null) OR (:old.IDS is not null and :new.IDS is null)
          OR :old.VOB          != :new.VOB     OR (:old.VOB is null and :new.VOB is not null) OR (:old.VOB is not null and :new.VOB is null)
          OR :old.DK           != :new.DK      OR (:old.DK is null and :new.DK is not null) OR (:old.DK is not null and :new.DK is null)
          OR :old.TT           != :new.TT      OR (:old.TT is null and :new.TT is not null) OR (:old.TT is not null and :new.TT is null)
          OR :old.NLSA         != :new.NLSA    OR (:old.NLSA is null and :new.NLSA is not null) OR (:old.NLSA is not null and :new.NLSA is null)
          OR :old.KVA          != :new.KVA     OR (:old.KVA is null and :new.KVA is not null) OR (:old.KVA is not null and :new.KVA is null)
          OR :old.NLSB         != :new.NLSB    OR (:old.NLSB is null and :new.NLSB is not null) OR (:old.NLSB is not null and :new.NLSB is null)
          OR :old.KVB          != :new.KVB     OR (:old.KVB is null and :new.KVB is not null) OR (:old.KVB is not null and :new.KVB is null)
          OR :old.MFOB         != :new.MFOB    OR (:old.MFOB is null and :new.MFOB is not null) OR (:old.MFOB is not null and :new.MFOB is null)
          OR :old.POLU         != :new.POLU    OR (:old.POLU is null and :new.POLU is not null) OR (:old.POLU is not null and :new.POLU is null)
          OR :old.NAZN         != :new.NAZN    OR (:old.NAZN is null and :new.NAZN is not null) OR (:old.NAZN is not null and :new.NAZN is null)
          OR :old.FSUM         != :new.FSUM    OR (:old.FSUM is null and :new.FSUM is not null) OR (:old.FSUM is not null and :new.FSUM is null)
          OR :old.OKPO         != :new.OKPO    OR (:old.OKPO is null and :new.OKPO is not null) OR (:old.OKPO is not null and :new.OKPO is null)
          OR :old.DAT1         != :new.DAT1    OR (:old.DAT1 is null and :new.DAT1 is not null) OR (:old.DAT1 is not null and :new.DAT1 is null)
          OR :old.DAT2         != :new.DAT2    OR (:old.DAT2 is null and :new.DAT2 is not null) OR (:old.DAT2 is not null and :new.DAT2 is null)
          OR :old.FREQ         != :new.FREQ    OR (:old.FREQ is null and :new.FREQ is not null) OR (:old.FREQ is not null and :new.FREQ is null)
          OR :old.DAT0         != :new.DAT0    OR (:old.DAT0 is null and :new.DAT0 is not null) OR (:old.DAT0 is not null and :new.DAT0 is null)
          OR :old.WEND         != :new.WEND    OR (:old.WEND is null and :new.WEND is not null) OR (:old.WEND is not null and :new.WEND is null)
          OR :old.STMP         != :new.STMP    OR (:old.STMP is null and :new.STMP is not null) OR (:old.STMP is not null and :new.STMP is null)
          OR :old.ORD          != :new.ORD     OR (:old.ORD is null and :new.ORD is not null) OR (:old.ORD is not null and :new.ORD is null)
          OR :old.KF           != :new.KF      OR (:old.KF is null and :new.KF is not null) OR (:old.KF is not null and :new.KF is null)
          OR :old.DR           != :new.DR      OR (:old.DR is null and :new.DR is not null) OR (:old.DR is not null and :new.DR is null)
          OR :old.BRANCH       != :new.BRANCH  OR (:old.BRANCH is null and :new.BRANCH is not null) OR (:old.BRANCH is not null and :new.BRANCH is null)
          OR :old.USERID_MADE  != :new.USERID_MADE   OR (:old.USERID_MADE is null and :new.USERID_MADE is not null) OR (:old.USERID_MADE is not null and :new.USERID_MADE is null)
          OR :old.BRANCH_MADE  != :new.BRANCH_MADE   OR (:old.BRANCH_MADE is null and :new.BRANCH_MADE is not null) OR (:old.BRANCH_MADE is not null and :new.BRANCH_MADE is null)
          OR :old.DATETIMESTAMP!= :new.DATETIMESTAMP OR (:old.DATETIMESTAMP is null and :new.DATETIMESTAMP is not null) OR (:old.DATETIMESTAMP is not null and :new.DATETIMESTAMP is null)
          OR :old.BRANCH_CARD  != :new.BRANCH_CARD   OR (:old.BRANCH_CARD is null and :new.BRANCH_CARD is not null) OR (:old.BRANCH_CARD is not null and :new.BRANCH_CARD is null)
          OR :old.STATUS_ID    != :new.STATUS_ID     OR (:old.STATUS_ID is null and :new.STATUS_ID is not null) OR (:old.STATUS_ID is not null and :new.STATUS_ID is null)
          OR :old.DISCLAIM_ID  != :new.DISCLAIM_ID   OR (:old.DISCLAIM_ID is null and :new.DISCLAIM_ID is not null) OR (:old.DISCLAIM_ID is not null and :new.DISCLAIM_ID is null)
          OR :old.STATUS_DATE  != :new.STATUS_DATE   OR (:old.STATUS_DATE is null and :new.STATUS_DATE is not null) OR (:old.STATUS_DATE is not null and :new.STATUS_DATE is null)
          OR :old.STATUS_UID   != :new.STATUS_UID    OR (:old.STATUS_UID is null and :new.STATUS_UID is not null) OR (:old.STATUS_UID is not null and :new.STATUS_UID is null)
        then
            save_changes;      
        else
            return; -- ничего не менялось, выходим
        end if;
    end if;
end;
/
Show errors;
ALTER TRIGGER BARS.TIUD_STO_DET ENABLE;