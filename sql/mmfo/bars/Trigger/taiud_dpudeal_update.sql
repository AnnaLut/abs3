

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_DPUDEAL_UPDATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_DPUDEAL_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_DPUDEAL_UPDATE AFTER INSERT OR UPDATE OR DELETE ON BARS.DPU_DEAL FOR EACH ROW
DECLARE
   l_act_id    NUMBER;
   l_user_id   NUMBER;
   l_bankdate  date;
begin

   l_user_id  := gl.aUID;
   l_bankdate := nvl(gl.bd, glb_bankdate);

   IF INSERTING THEN
      l_act_id := 0;  -- заведення договору
   ELSIF UPDATING AND :OLD.CLOSED <> :NEW.CLOSED THEN
      l_act_id := 2;  -- закриття договору
   ELSIF UPDATING AND (:NEW.DAT_BEGIN = :OLD.DAT_END AND :NEW.CNT_DUBL > NVL(:OLD.CNT_DUBL, 0)) THEN
      l_act_id := 3;  -- пролонгація договору
   ELSIF UPDATING THEN
      l_act_id := 1;  -- зміна параметрів договору
   ELSE
      l_act_id := 9;  -- видалення договору
   END IF;

   IF l_act_id = 9 THEN
      INSERT INTO dpu_deal_update
        (idu, useru, dateu, typeu,
         dpu_id, nd, vidd, rnk,
         acc, user_id, freqv, sum,
         dat_begin, dat_end, datz, datv,
         mfo_d, nls_d, nms_d, mfo_p, nls_p, nms_p, okpo_p,
         comments, closed, comproc, dpu_gen, dpu_add,
         min_sum, id_stop, trustee_id, branch, acc2, bdate, cnt_dubl,
         kf, effectdate)
      VALUES
        (0, l_user_id, sysdate, l_act_id,
         :OLD.dpu_id,  :OLD.nd, :OLD.vidd, :OLD.rnk,
         :OLD.acc, :OLD.user_id, :OLD.freqv, :OLD.sum,
         :OLD.dat_begin, :OLD.dat_end, :OLD.datz, :OLD.datv,
         :OLD.mfo_d, :OLD.nls_d, :OLD.nms_d,
         :OLD.mfo_p, :OLD.nls_p, :OLD.nms_p, :OLD.okpo_p,
         :OLD.comments, :OLD.closed, :OLD.comproc, :OLD.dpu_gen, :OLD.dpu_add,
         :OLD.min_sum, :OLD.id_stop, :OLD.trustee_id, :OLD.branch, :OLD.acc2, l_bankdate, :OLD.cnt_dubl,
         :OLD.kf, l_bankdate);
   ELSE
      INSERT INTO dpu_deal_update
        (idu, useru, dateu, typeu,
         dpu_id, nd, vidd, rnk,
         acc, user_id, freqv, sum,
         dat_begin, dat_end, datz, datv,
         mfo_d, nls_d, nms_d, mfo_p, nls_p, nms_p, okpo_p,
         comments, closed, comproc, dpu_gen, dpu_add,
         min_sum, id_stop, trustee_id, branch, acc2, bdate, cnt_dubl,
         kf, effectdate)
      VALUES
        (0, l_user_id, sysdate, l_act_id,
         :NEW.dpu_id,  :NEW.nd, :NEW.vidd, :NEW.rnk,
         :NEW.acc, :NEW.user_id, :NEW.freqv, :NEW.sum,
         :NEW.dat_begin, :NEW.dat_end, :NEW.datz, :NEW.datv,
         :NEW.mfo_d, :NEW.nls_d, :NEW.nms_d,
         :NEW.mfo_p, :NEW.nls_p, :NEW.nms_p, :NEW.okpo_p,
         :NEW.comments, :NEW.closed, :NEW.comproc, :NEW.dpu_gen, :NEW.dpu_add,
         :NEW.min_sum, :NEW.id_stop,:NEW.trustee_id, :NEW.branch, :NEW.acc2, l_bankdate, :NEW.cnt_dubl,
         :NEW.kf, l_bankdate);
   END IF;
END;


/
ALTER TRIGGER BARS.TAIUD_DPUDEAL_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_DPUDEAL_UPDATE.sql =========**
PROMPT ===================================================================================== 
