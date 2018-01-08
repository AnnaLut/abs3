

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_TTS_UPDATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_TTS_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_TTS_UPDATE 
after insert or delete or update
of   TT,  NAME , DK, NLSM ,  KV ,  NLSK ,  KVK  ,
  NLSS, NLSA  ,  NLSB ,  MFOB ,  FLC ,  FLI ,
  FLV ,  FLR    ,  S   ,  S2  ,  SK  ,  PROC ,
  S3800 ,  S6201 ,  S7201 ,  RANG  ,  FLAGS ,
  NAZN  ,  ID 
ON BARS.TTS
for each row

declare
  l_rec  BARS.TTS_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.CHGACTION = 'DELETING' )
    then
       l_rec.TT :=  :old.tt;
       l_rec.NAME := :old.name;
       l_rec.DK := :old.dk;
       l_rec.NLSM:=  :old.nlsm;
       l_rec.KV  := :old.kv;
       l_rec.NLSK  := :old.nlsk;
       l_rec.KVK := :old.kvk;
       l_rec.NLSS:= :old.nlss;
       l_rec.NLSA  := :old.nlsa;
       l_rec.NLSB := :old.nlsb;
       l_rec.MFOB:= :old.mfob;
       l_rec.FLC  := :old.flc;
       l_rec.FLI:= :old.fli;
       l_rec.FLV  := :old.flv;
       l_rec.FLR    :=  :old.flr; 
       l_rec.S   := :old.s;
       l_rec.S2  := :old.s2;
       l_rec.SK  := :old.sk;
       l_rec.PROC := :old.proc;
       l_rec.S3800 := :old.s3800;
       l_rec.S6201 := :old.s6201;
       l_rec.S7201 := :old.s7201;
       l_rec.RANG  := :old.rang;
       l_rec.FLAGS:= :old.flags;
       l_rec.NAZN   := :old.nazn;
       l_rec.ID:= :old.id;
    else
       l_rec.TT :=  :new.tt;
       l_rec.NAME := :new.name;
       l_rec.DK := :new.dk;
       l_rec.NLSM:=  :new.nlsm;
       l_rec.KV  := :new.kv;
       l_rec.NLSK  := :new.nlsk;
       l_rec.KVK := :new.kvk;
       l_rec.NLSS:= :new.nlss;
       l_rec.NLSA  := :new.nlsa;
       l_rec.NLSB := :new.nlsb;
       l_rec.MFOB:= :new.mfob;
       l_rec.FLC  := :new.flc;
       l_rec.FLI:= :new.fli;
       l_rec.FLV  := :new.flv;
       l_rec.FLR    :=  :new.flr; 
       l_rec.S   := :new.s;
       l_rec.S2  := :new.s2;
       l_rec.SK  := :new.sk;
       l_rec.PROC := :new.proc;
       l_rec.S3800 := :new.s3800;
       l_rec.S6201 := :new.s6201;
       l_rec.S7201 := :new.s7201;
       l_rec.RANG  := :new.rang;
       l_rec.FLAGS:= :new.flags;
       l_rec.NAZN   := :new.nazn;
       l_rec.ID:= :new.id;
    end if;
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_tts_update');
    l_rec.EFFECTDATE    := COALESCE(gl.bd, trunc(sysdate));
    l_rec.DONEBY        := gl.aUID;
    l_rec.CHGDATE       := sysdate;
    l_rec.MACHINE:= sys_context('bars_global', 'host_name');
    l_rec.IP:=sys_context('USERENV', 'IP_ADDRESS');
    l_rec.OSUSERS:=sys_context('USERENV', 'OS_USER') ;

    insert into BARS.TTS_UPDATE values l_rec;

  end SAVE_CHANGES;
  ---
begin

  case
    when inserting
    then

      l_rec.CHGACTION := 'INSERTING';
      SAVE_CHANGES;

    when deleting
    then

      l_rec.CHGACTION := 'DELETING';
      SAVE_CHANGES;

    when updating
    then

      case
        when (:old.tt <> :new.tt )
        
        then

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'DELETING';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'INSERTING';
          SAVE_CHANGES;

        when (    
                :old.NAME <> :new.NAME OR (:old.NAME IS NULL AND :new.NAME IS NOT NULL) OR (:old.NAME IS NOT NULL AND :new.NAME IS NULL)
              or :old.DK <> :new.DK OR (:old.DK IS NULL AND :new.DK IS NOT NULL) OR (:old.DK IS NOT NULL AND :new.DK IS NULL)
              or :old.NLSM <> :new.NLSM OR (:old.NLSM IS NULL AND :new.NLSM IS NOT NULL) OR (:old.NLSM IS NOT NULL AND :new.NLSM IS NULL)
              or :old.KV <> :new.KV OR (:old.KV IS NULL AND :new.KV IS NOT NULL) OR (:old.KV IS NOT NULL AND :new.KV IS NULL)
              or :old.NLSK <> :new.NLSK OR (:old.NLSK IS NULL AND :new.NLSK IS NOT NULL) OR (:old.NLSK IS NOT NULL AND :new.NLSK IS NULL)
              or :old.KVK <> :new.KVK OR (:old.KVK IS NULL AND :new.KVK IS NOT NULL) OR (:old.KVK IS NOT NULL AND :new.KVK IS NULL)
              or :old.NLSS <> :new.NLSS OR (:old.NLSS IS NULL AND :new.NLSS IS NOT NULL) OR (:old.NLSS IS NOT NULL AND :new.NLSS IS NULL)
              or :old.NLSA <> :new.NLSA OR (:old.NLSA IS NULL AND :new.NLSA IS NOT NULL) OR (:old.NLSA IS NOT NULL AND :new.NLSA IS NULL)
              or :old.NLSB <> :new.NLSB OR (:old.NLSB IS NULL AND :new.NLSB IS NOT NULL) OR (:old.NLSB IS NOT NULL AND :new.NLSB IS NULL)
              or :old.MFOB <> :new.MFOB OR (:old.MFOB IS NULL AND :new.MFOB IS NOT NULL) OR (:old.MFOB IS NOT NULL AND :new.MFOB IS NULL)
              or :old.FLC <> :new.FLC OR (:old.FLC IS NULL AND :new.FLC IS NOT NULL) OR (:old.FLC IS NOT NULL AND :new.FLC IS NULL)
              or :old.FLI <> :new.FLI OR (:old.FLI IS NULL AND :new.FLI IS NOT NULL) OR (:old.FLI IS NOT NULL AND :new.FLI IS NULL)
              or :old.FLV <> :new.FLV OR (:old.FLV IS NULL AND :new.FLV IS NOT NULL) OR (:old.FLV IS NOT NULL AND :new.FLV IS NULL)
              or :old.FLR <> :new.FLR OR (:old.FLR IS NULL AND :new.FLR IS NOT NULL) OR (:old.FLR IS NOT NULL AND :new.FLR IS NULL)
              or :old.S <> :new.S OR (:old.S IS NULL AND :new.S IS NOT NULL) OR (:old.S IS NOT NULL AND :new.S IS NULL)
              or :old.S2 <> :new.S2 OR (:old.S2 IS NULL AND :new.S2 IS NOT NULL) OR (:old.S2 IS NOT NULL AND :new.S2 IS NULL)
              or :old.SK <> :new.SK OR (:old.SK IS NULL AND :new.SK IS NOT NULL) OR (:old.SK IS NOT NULL AND :new.SK IS NULL)
              or :old.PROC <> :new.PROC OR (:old.PROC IS NULL AND :new.PROC IS NOT NULL) OR (:old.PROC IS NOT NULL AND :new.PROC IS NULL)
              or :old.S3800 <> :new.S3800 OR (:old.S3800 IS NULL AND :new.S3800 IS NOT NULL) OR (:old.S3800 IS NOT NULL AND :new.S3800 IS NULL)
              or :old.S6201 <> :new.S6201 OR (:old.S6201 IS NULL AND :new.S6201 IS NOT NULL) OR (:old.S6201 IS NOT NULL AND :new.S6201 IS NULL)
              or :old.S7201 <> :new.S7201 OR (:old.S7201 IS NULL AND :new.S7201 IS NOT NULL) OR (:old.S7201 IS NOT NULL AND :new.S7201 IS NULL)
              or :old.RANG <> :new.RANG OR (:old.RANG IS NULL AND :new.RANG IS NOT NULL) OR (:old.RANG IS NOT NULL AND :new.RANG IS NULL)
              or :old.FLAGS <> :new.FLAGS OR (:old.FLAGS IS NULL AND :new.FLAGS IS NOT NULL) OR (:old.FLAGS IS NOT NULL AND :new.FLAGS IS NULL)
              or :old.NAZN <> :new.NAZN OR (:old.NAZN IS NULL AND :new.NAZN IS NOT NULL) OR (:old.NAZN IS NOT NULL AND :new.NAZN IS NULL)
              or :old.ID <> :new.ID OR (:old.ID IS NULL AND :new.ID IS NOT NULL) OR (:old.ID IS NOT NULL AND :new.ID IS NULL)
             )

        then 
          l_rec.CHGACTION := 'UPDATING';
          SAVE_CHANGES;
        else
          Null;
      end case;
    else
      null;
  end case;

end TAIUD_TTS_UPDATE;
/
ALTER TRIGGER BARS.TAIUD_TTS_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_TTS_UPDATE.sql =========*** En
PROMPT ===================================================================================== 
