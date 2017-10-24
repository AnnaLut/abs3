

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_DATE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_DATE ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_DATE ( dat_ IN DATE DEFAULT NULL) IS

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION NAME   : pay_date
%
% CALLED BY       : client's application
%
% DESCRIPTION     : Clears all documents with
%                   value date equal to the given date.
% TABLES ACCESSED :
%
% MODIFICATION HISTORY: (31/01/2000 MIK)  Rewrite from APO
%                       (07/04/2003 ANNY) Creation of tmp_log table in
%                                         user schema replace with permanent
%                                         table BARS.TMP_LOG
%                       (02/06/2004 DEN)  Change call to doc_ack procedure in
%                                         package CHK
%                       (10/11/2004 DEN)  Modified main cursor within using
%                                         ref_que queue
%                       (20-05-2005 MIK)  Removes record from tdval
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

sum_   NUMBER;
ack_   NUMBER;

ern    CONSTANT POSITIVE       := 716;

pay_er EXCEPTION;
PRAGMA EXCEPTION_INIT(pay_er, -20203);

pos_   NUMBER;

msg_   VARCHAR2(100);

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
id_o_  VARCHAR2(8);    -- Teller identifier
sign_  RAW(128);       -- Signature
datA_  DATE;           -- Input file date/time
d_rec_ VARCHAR2(80);   -- Additional parameters

G_sepnum  INTEGER  DEFAULT NULL;  -- используемая версия СЭП(по параметру 'SEPNUM')

BEGIN

   DELETE FROM TMP_LOG;

   BEGIN
      SELECT   to_number(val)
        INTO   G_sepnum
        FROM   params
       WHERE   par = 'SEPNUM';
   EXCEPTION
        WHEN OTHERS THEN G_sepnum := 0;
   END;

   FOR c IN (SELECT o.ref, o.tt, o.chk, t.fli, SUBSTR(flags,38,1) flg
               FROM tts t, oper o, ref_que q
              WHERE o.ref=q.ref AND t.tt=o.tt
                AND o.sos BETWEEN 1 AND 4 AND o.vdat<=gl.bDATE
                AND o.ref not in (SELECT refl FROM oper
                                   WHERE refl is not null
                                     AND sos BETWEEN 1 AND 4)
              ORDER BY ref, vdat)
   LOOP

      msg_:= 'Оплачен';

      BEGIN
         SELECT SUM(DECODE(dk,0,-s,s)) INTO sum_
           FROM opldok
          WHERE ref = c.ref AND sos < 5 AND fdat <= gl.bDATE;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN sum_ := NULL;
      END;

      IF sum_ = 0 THEN     -- Check if the document acknowleged

         chk.doc_ack ( c.ref,c.tt,c.chk,ack_);

         IF ack_ = 1 THEN

            BEGIN  -- Clear document

               SAVEPOINT pay_before;

               gl.pay ( 2, c.ref, gl.bDATE);

               SELECT
                  mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
                  datD, datP, nam_a, nam_b, nazn, id_a, id_b,
                  id_o, sign, d_rec, sos, ref_a, prty
               INTO
                  mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
                  datD_,datP_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
                  id_o_,sign_,d_rec_, sos_, refA_, prty_
               FROM oper WHERE ref=c.ref FOR UPDATE NOWAIT;

               IF c.tt='R01' AND sos_=5 AND mfob_ = gl.aMFO THEN
                  DELETE FROM tdval WHERE ref=c.ref;
               END IF;

               IF c.fli=1 AND (c.flg=0 OR c.flg=1 OR c.flg=3) THEN

IF deb.debug THEN
   deb.trace(ern,'Inserting to in_sep with',c.ref);
END IF;

                  IF sos_ = 5 THEN -- Value date arrived

                     IF LENGTH(TRIM(NVL(d_rec_,'')))>0 THEN
                        nazns_ := '11';
                     ELSE
                        nazns_ := '10';
                     END IF;

                     IF vob_ NOT IN (1,2,6,33,81) THEN
                        BEGIN
                           SELECT TRIM(val) INTO vob_ FROM params WHERE par='VOB2SEP';
                        EXCEPTION
                           WHEN NO_DATA_FOUND THEN vob_:=1;
                        END;
                     END IF;

                     IF G_sepnum=2 THEN
                        NULL;
                     ELSE
                        nd_    := TRANSLATE(nd_,   sep.WIN_,sep.DOS_);
                        nam_a_ := TRANSLATE(nam_a_,sep.WIN_,sep.DOS_);
                        nam_b_ := TRANSLATE(nam_b_,sep.WIN_,sep.DOS_);
                        nazn_  := TRANSLATE(nazn_, sep.WIN_,sep.DOS_);
                        d_rec_ := TRANSLATE(d_rec_,sep.WIN_,sep.DOS_);
                     END IF;

                     datA_  := TO_DATE (TO_CHAR(datP_,'MM-DD-YYYY')||' '||
                           TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');

                     err_ := -1;
                     rec_ :=  0;

                     sep.in_sep(err_,rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,
                            vob_,nd_,kv_,datD_,datP_,nam_a_,nam_b_,nazn_,
                               NULL,nazns_,id_a_,id_b_,id_o_,refA_,0,sign_,
                               NULL,NULL,datA_,d_rec_,0,c.ref);
IF deb.debug THEN
   deb.trace(ern,'in_sep ret code',err_);
   deb.trace(ern,'rec #',rec_);

END IF;

                     IF err_=0 THEN
                        msg_:= 'Оплачен. Передан в СЭП.';
                     ELSE
                        ROLLBACK TO pay_before;
                        msg_:= 'Невозможно передать в СЭП';
                     END IF;

                     IF prty_>0 THEN    -- Set SSP flag
                        UPDATE arc_rrp SET prty=prty_ WHERE rec=rec_;
                     END IF;

                  END IF;
               END IF;

            EXCEPTION
               WHEN pay_er THEN
                  ROLLBACK TO pay_before;

                  msg_ := SUBSTR(SQLERRM,13,100);
                  pos_ := INSTR(msg_,CHR(10));

                  IF pos_ > 0 THEN
                     msg_ := SUBSTR(msg_,1,pos_-1);
                  END IF;
            END;
         ELSE
            msg_:= 'Не завизирован';
         END IF;
      ELSE
         msg_:= 'Нет проводок для оплаты';
      END IF;

      INSERT INTO tmp_log (ref,msg) VALUES (c.ref, msg_);

   END LOOP;

END pay_date;
 
/
show err;

PROMPT *** Create  grants  PAY_DATE ***
grant EXECUTE                                                                on PAY_DATE        to ABS_ADMIN;
grant EXECUTE                                                                on PAY_DATE        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PAY_DATE        to START1;
grant EXECUTE                                                                on PAY_DATE        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_DATE.sql =========*** End *** 
PROMPT ===================================================================================== 
