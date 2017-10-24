

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/VISA_SSR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure VISA_SSR ***

  CREATE OR REPLACE PROCEDURE BARS.VISA_SSR (
  grp_ number,
  tt_  char,
  cnt_ number) is

PROCEDURE put_ack0(ref_ NUMBER) AS
sum_   NUMBER;
ack_   NUMBER;
tt_    CHAR(3);
chk_   VARCHAR2(80);
hex_   VARCHAR2(6);

pay_er EXCEPTION;
PRAGMA EXCEPTION_INIT(pay_er, -20203);

pos_   NUMBER;

msg_   VARCHAR2(100);
dat_   DATE;

fli_   NUMBER;
flg_   NUMBER;
refL_  NUMBER;
refA_  VARCHAR2(9);
prty_  NUMBER;
sos_   NUMBER;

err_   NUMBER;    -- Return code
rec_   NUMBER;    -- Record number
mfoa_  VARCHAR2(12);   -- Sender's MFOs
nlsa_  VARCHAR2(15);   -- Sender's account number
mfob_  VARCHAR2(12);   -- Destination MFO
nlsb_  VARCHAR2(15);   -- Target account number
dk_    NUMBER;         -- Debet/Credit code
s_     DECIMAL(24);    -- Amount
vob_   NUMBER;         -- Document type
nd_    VARCHAR2(10);   -- Document number
kv_    NUMBER;         -- Currency code
datD_  DATE;           -- Document date
datP_  DATE;           -- Posting date
nam_a_  VARCHAR2(38);  -- Sender's customer name
nam_b_  VARCHAR2(38);  -- Target customer name
nazn_   VARCHAR(160);  -- Narrative
nazns_ CHAR(2);        -- Narrative contens type
id_a_  VARCHAR2(14);   -- Sender's customer identifier
id_b_  VARCHAR2(14);   -- Target's customer identifier
id_o_  VARCHAR2(6);    -- Teller identifier
sign_  RAW(128);       -- Signature
datA_  DATE;           -- Input file date/time
d_rec_ VARCHAR2(80);   -- Additional parameters


PROCEDURE to_log (ref_ NUMBER, msg_ VARCHAR2, dat_ DATE) IS
      PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   INSERT INTO tmp_log (ref,msg,dat_msg) VALUES (ref_, msg_, dat_);
   COMMIT;
END;


BEGIN
   BEGIN
      SELECT o.tt,o.chk,t.fli,SUBSTR(flags,38,1),o.refl
        INTO   tt_, chk_, fli_,flg_,refL_
        FROM tts t, oper o
       WHERE o.ref=ref_ AND t.tt=o.tt AND o.sos>0 AND o.sos<5 AND o.vdat<=gl.bDATE
         FOR UPDATE OF sos NOWAIT;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN RETURN;
   END;

   BEGIN
      SELECT SUM(DECODE(dk,0,-s,s)) INTO sum_
        FROM opldok
       WHERE ref = ref_ AND sos < 5 AND fdat <= gl.bDATE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN sum_ := NULL;
   END;

   IF sum_ = 0 THEN     -- Check if the document acknowleged

      BEGIN  -- Clear document

         SAVEPOINT chk_pay_before;
         hex_:=chk.put_stmp(grp_);


         UPDATE oper SET chk=RTRIM(NVL(chk,''))||hex_ WHERE ref=ref_
             RETURNING chk INTO chk_;
         INSERT INTO oper_visa (ref, dat, userid, groupid, status)
               VALUES (ref_, sysdate, gl.aUID, grp_,    1);

         chk.doc_ack ( ref_,tt_,chk_,ack_);

         IF ack_ = 1 THEN

            gl.pay ( 2, ref_, gl.bDATE);

            IF fli_=1 AND (flg_=0 OR flg_=1 OR flg_=3) THEN

               SELECT mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
                      datd, datp, nam_a, nam_b, nazn, id_a, id_b,
                      id_o, sign, d_rec, sos, ref_a, prty
                 INTO mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
                      datd_,datp_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
                      id_o_,sign_,d_rec_, sos_, refA_, prty_
                 FROM oper WHERE ref=ref_;

               IF sos_ = 5 THEN -- Value date arrived

                  IF LENGTH(TRIM(NVL(d_rec_,'')))>0 THEN
                     nazns_ := '11';
                  ELSE
                     nazns_ := '10';
                  END IF;

                  datA_  := TO_DATE (TO_CHAR(datP_,'MM-DD-YYYY')||' '||
                            TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');

                  err_ := -1;
                  rec_ :=  0;

                  sep.in_sep(err_,rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,
                         vob_,nd_,kv_,datD_,datP_,nam_a_,nam_b_,nazn_,
                          NULL,nazns_,id_a_,id_b_,'******',refA_,0,'00',
                               NULL,NULL,datA_,d_rec_,0,ref_);

                  IF err_=0 THEN
                     msg_:= 'Оплачен. Передан в СЭП.';
                     IF prty_>0 THEN    -- Set SSP flag
                         UPDATE arc_rrp SET prty=prty_ WHERE rec=rec_;
                     END IF;
                  ELSE
                     ROLLBACK TO chk_pay_before;
                     msg_:= 'Невозможно передать в СЭП: Ош.'||err_;
                  END IF;

               END IF;
            END IF;
         ELSE
            msg_:= 'Не завизирован';
         END IF; -- ack_ = 1

      EXCEPTION
         WHEN OTHERS THEN ROLLBACK TO chk_pay_before;

         msg_ := SUBSTR(SQLERRM,13,100);
         pos_ := INSTR(msg_,CHR(10));

         IF pos_ > 0 THEN
            msg_ := SUBSTR(msg_,1,pos_-1);
         END IF;
      END;
   ELSE
      msg_:= 'Нет проводок для оплаты';
   END IF;
   deb.trace(1,msg_,ref_);
   to_log(ref_, msg_, dat_);
END put_ack0;


BEGIN
   FOR c IN (SELECT * FROM oper WHERE tt=tt_ AND
                    ref IN (SELECT ref FROM ref_que)
                and rownum<=cnt_
                AND sos BETWEEN 1 AND 3 FOR UPDATE OF chk NOWAIT)
   LOOP
      put_ack0(c.ref);
   END LOOP;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/VISA_SSR.sql =========*** End *** 
PROMPT ===================================================================================== 
