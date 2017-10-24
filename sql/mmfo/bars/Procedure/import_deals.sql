

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/IMPORT_DEALS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure IMPORT_DEALS ***

  CREATE OR REPLACE PROCEDURE BARS.IMPORT_DEALS 
IS
   l_nsk        skrynka.n_sk%TYPE;
   l_osk        skrynka.o_sk%TYPE;
   l_error      VARCHAR2 (1000);
   l_ref        NUMBER (38);
   l_nd         NUMBER;
   l_nls_3600   accounts.nls%TYPE;
   l_nms_3600   accounts.nms%TYPE;
   l_nls_g      accounts.nls%TYPE;
   l_nms_g      accounts.nms%TYPE;
   l_nls_nds    accounts.nls%TYPE;
   l_nms_nds    accounts.nms%TYPE;
   l_userid     OPER.USERID%TYPE;
   l_tmpacc		accounts.acc%TYPE;
   l_nms2909k    accounts.nms%TYPE;
   l_nls2909k    accounts.nls%TYPE;
   l_nms2909    accounts.nms%TYPE;
   l_nls2909    accounts.nls%TYPE;

Procedure pay_dok (p_nlsa oper.nlsa%type,
                   p_nmsa oper.nam_a%type,
                   p_nlsb oper.nlsb%type,
                   p_nmsb oper.nam_b%type,
                   p_s    oper.s%type,
                   p_nazn oper.nazn%type,
                   p_nd skrynka_nd.nd%type)
is
opr oper%rowtype;
begin

case p_s
   when 0  then return;
           else null;
end case;

logger.trace ('p_nlsa='||p_nlsa||chr(10)||
              'p_nmsa='||p_nmsa||chr(10)||
              'p_nlsb='||p_nlsb||chr(10)||
              'p_nmsb='||p_nmsb);

   opr.id_a := f_ourokpo;


            gl.REF (opr.ref);

            INSERT INTO oper (REF,      tt,         vob,        nd,
                              dk,      pdat,        vdat,     datd,
                              datp,   nam_a,        nlsa,     mfoa,
                              kv,         s,       nam_b,     nlsb,
                              mfob,     kv2,          s2,     nazn,
                              userid,  id_a,        id_b,       sk)
                 VALUES (
                           opr.ref,     'SN2',          6,       opr.ref,
                           1,         SYSDATE,   gl.bdate,      gl.bdate,
                           gl.bdate,   p_nmsa,     p_nlsa,       gl.amfo,
                           980,           p_s,     p_nmsb,        p_nlsb,
                           gl.amfo,       980,        p_s,        p_nazn,
                           l_userid, opr.id_a,   opr.id_a,          NULL);

            gl.payv (0, opr.ref, gl.bdate, 'SN2', 1, 980,  p_nlsa,  p_s, 980, p_nlsb, p_s);

            INSERT INTO skrynka_nd_ref (REF, bdate, nd)
                 VALUES (opr.ref, gl.bdate, p_nd);
end;


BEGIN
   FOR k IN (SELECT DISTINCT branch
               FROM skr_import_deals
              WHERE imported = 0)
   LOOP
      BEGIN
         bc.subst_branch (k.branch);
      EXCEPTION
         WHEN OTHERS
         THEN
            l_error := SUBSTR (SQLERRM, 1, 1000);

            UPDATE skr_import_deals
               SET error = l_error
             WHERE branch = k.branch;

            CONTINUE;
      END;

      FOR s IN (SELECT SAFE_num,
                       safe_type_id,
                       key_used,
                       key_number,
                       key_count,
                       bail_sum,
                       day_sum,
					   peny_sum,
                       future_sum,
                       deal_num,
                       deal_date,
                       deal_start_date,
                       deal_end_date,
                       custtype,
                       fio,
                       okpo,
                       doc,
                       issued,
                       address,
                       birthplace,
                       birthdate,
                       phone,
                       NMK,
                       nlsk,
                       mfok,
                       branch, nls2909, nls3600
                  FROM skr_import_deals
                 WHERE branch = k.branch AND imported = 0)
      LOOP
         BEGIN
            SELECT n_sk, o_sk
              INTO l_nsk, l_osk
              FROM skrynka
             WHERE snum = s.safe_num AND branch = s.branch;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               UPDATE skr_import_deals
                  SET error = 'Safe not found'
                WHERE deal_num = s.deal_num AND branch = k.branch;

               CONTINUE;
         END;

         BEGIN
            SAFE_DEPOSIT.DEAL (l_nsk,
                               l_osk,
                               0,
                               s.key_number,
                               s.key_count,
                               s.bail_sum,
                               NULL,
                               NULL,
                               bars_sqnc.get_nextval('S_CC_DEAL'),
                               s.deal_num,
                               -1,
                               s.deal_date,
                               s.deal_start_date,
                               s.deal_end_date,
                               s.custtype,
                               s.fio,
                               s.okpo,
                               s.doc,
                               s.issued,
                               s.address,
                               s.birthplace,
                               s.birthdate,
                               s.phone,
                               s.NMK,
                               s.nlsk,
                               s.mfok,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               1);

            SELECT nd
              INTO l_nd
              FROM skrynka_nd
             WHERE n_sk = l_nsk AND sos = 0;

			begin
				select acc
				into l_tmpacc
				from skrynka_nd_acc
				where nd = l_nd and TIP = 'D';
			exception when no_data_found then
				safe_deposit.OPEN_3600 (l_nd, SUBSTR (f_newnls (1, 'SD_DR', '3600'), 1, 14));
			end;

            SELECT a.nls, SUBSTR (a.nms, 1, 38)
              INTO l_nls_3600, l_nms_3600
              FROM accounts a, skrynka_nd_acc n
             WHERE A.ACC = N.ACC AND N.TIP = 'D' AND N.ND = l_nd;


        --котловий рахунок 3600
             Begin
               SELECT  a.nls, SUBSTR (a.nms, 1, 38)
                 INTO  l_nls_g, l_nms_g
                 FROM accounts a
                WHERE nls = s.nls3600 and kv = 980;
               exception when no_data_found then
                SELECT a.nls, SUBSTR (a.nms, 1, 38)
                  INTO l_nls_g, l_nms_g
                  FROM accounts a, branch_parameters b
                 WHERE     a.nls = b.val
                       AND a.kv = 980
                       AND A.KF = gl.amfo
                       AND B.TAG = 'DEP_S5'
                       AND A.BRANCH = b.branch
                       AND b.branch = k.branch;
            End;

            SELECT a.nls, SUBSTR (a.nms, 1, 38)
              INTO l_nls_nds, l_nms_nds
              FROM accounts a, branch_parameters b
             WHERE     a.nls = b.val
                   AND a.kv = 980
                   AND A.KF = gl.amfo
                   AND B.TAG = 'DEP_S7'
                   --AND A.BRANCH = b.branch
                   AND b.branch = k.branch;

  		    SELECT b.val
              INTO l_userid
              FROM branch_parameters b
             WHERE B.TAG = 'DEP_ISP' AND b.branch = k.branch;

            UPDATE skrynka_nd
               SET sd = s.day_sum,
			       peny = s.peny_sum,
				   s_arenda =  s.day_sum*( s.deal_end_date - s.deal_start_date + 1),
				   prskidka = 0,
				   amort_date = last_day(trunc(bankdate,'MM')-1)
             WHERE nd = l_nd;


         -- котловий рахунок 2909
         Begin
           SELECT SUBSTR (a.nms, 1, 38), a.nls
             INTO l_nms2909k, l_nls2909k
             FROM accounts a
            WHERE nls = s.nls2909 and kv = 980;
           exception when no_data_found then
              BEGIN
                 SELECT a.nls, SUBSTR (a.nms, 1, 38)
                   INTO l_nls2909k,  l_nms2909k
                   FROM accounts a
                  WHERE a.nls = (SELECT val  FROM branch_parameters
                                  WHERE tag = 'DEP_KAS' AND branch = k.branch)
                        and a.kv = 980;
              EXCEPTION WHEN NO_DATA_FOUND
                 THEN  bars_error.raise_nerror('SKR', 'PARAM_NOT_FOUND', 'DEP_KAS');
              END;
          End;

          -- рахунок залогу ячейки
           SELECT a.nms, a.nls
             INTO l_nms2909, l_nls2909
             FROM skrynka_acc s, accounts a, skrynka_nd n
            WHERE s.tip = 'M' and s.n_SK = n.n_sk and s.acc = a.acc and n.nd = l_nd  and n.sos = 0;




    -- міграція внесених сум залогу по угодах

          pay_dok (p_nlsa => l_nls2909k     ,
                   p_nmsa => l_nms2909k     ,
                   p_nlsb => l_nls2909  ,
                   p_nmsb => l_nms2909  ,
                   p_s    => s.bail_sum,
                   p_nazn =>  'Міграція залогу по сейф№'|| TO_CHAR (s.safe_num)|| ' по договору №'|| TO_CHAR (s.deal_num),
                   p_nd   => l_nd    );

           -- відмітка про видачу ключа
                     UPDATE skrynka
                        SET keyused = 1
                      WHERE n_sk = l_nsk;




    -- міграція внесених сум доходів по угодах
          pay_dok (p_nlsa => l_nls_g     ,
                   p_nmsa => l_nms_g     ,
                   p_nlsb => l_nls_3600  ,
                   p_nmsb => l_nms_3600  ,
                   p_s    => s.future_sum,
                   p_nazn =>  'Міграція доходів майбутніх періодів сейф№'|| TO_CHAR (s.safe_num)|| ' по договору №'|| TO_CHAR (s.deal_num),
                   p_nd   => l_nd    );


    -- відокремлення сум ПДВ
          pay_dok (p_nlsa => l_nls_3600     ,
                   p_nmsa => l_nms_3600     ,
                   p_nlsb => l_nls_nds  ,
                   p_nmsb => l_nms_nds  ,
                   p_s    => round(s.future_sum/6),
                   p_nazn =>  'ПДВ по сейф№'|| TO_CHAR (s.safe_num)|| ' по договору №'|| TO_CHAR (s.deal_num),
                   p_nd   => l_nd    );




            UPDATE skr_import_deals
               SET error = 'Open successfully', imported = 1
             WHERE deal_num = s.deal_num AND branch = k.branch;

			commit;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_error := substr(sqlerrm || chr(10)
                                                  ||dbms_utility.format_error_backtrace||
                                                    dbms_utility.format_call_stack(), 0, 4000);
               rollback;
               UPDATE skr_import_deals
                  SET error = l_error
                WHERE deal_num = s.deal_num AND branch = k.branch;

               CONTINUE;
         END;
      END LOOP;
   END LOOP;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/IMPORT_DEALS.sql =========*** End 
PROMPT ===================================================================================== 
