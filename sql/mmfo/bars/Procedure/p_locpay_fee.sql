

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LOCPAY_FEE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LOCPAY_FEE ***

  CREATE OR REPLACE PROCEDURE BARS.P_LOCPAY_FEE (p_date date) is

 --процедура по списанию комисии
 aa1 accounts%rowtype ;
 aa2 accounts%rowtype ;
 ab accounts%rowtype ;
 l_sum_2924 oper.s%type ;
 l_sum_3739 oper.s%type ;
 l_sum_k oper.s%type ;
 l_first_date date;
 l_last_date  date;
 l_ref oper.ref%type ;
 l_check number(1);
PROCEDURE set_LOG(P_REF NUMBER, P_S NUMBER, P_NLSTR VARCHAR2, P_DAT DATE, P_KF VARCHAR2) AS
  BEGIN
    INSERT INTO LOCPAY_FEE_LOG (REF, S, NLSTR , DAT, KF)
    values (P_REF, P_S, P_NLSTR, P_DAT, P_KF);
  exception when dup_val_on_index then
          raise_application_error (
             -20203,
            'Документ вже створено REF = '||P_REF);
  END set_LOG;
begin

       l_first_date:= ADD_MONTHS(TRUNC(p_date,'MM'),-1);

       l_last_date := ADD_MONTHS(LAST_DAY(p_date),-1);

       bars_audit.info('locpay_fee_1 l_first_date = '||l_first_date||' l_last_date = '||l_last_date);

    SAVEPOINT before_pay;

    BEGIN
       SELECT a.*
         INTO ab
         FROM accounts a
        WHERE a.NLS = nbs_ob22_null (case when newnbs.g_state= 1 then '6510' else'6110' end, 'F4') AND a.dazs IS NULL;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN
          raise_application_error (
             -20203,
             'Не знайдено рахунок доходів NBS = '||case when newnbs.g_state= 1 then '6510' else'6110' end||' OB22 = F4');
    END;
   -- Создание документа по 2924
   begin


        BEGIN
           SELECT a.*
             INTO aa1
             FROM accounts a
            WHERE a.NLS = GetGlobalOption ('NLS_292427_LOCPAYFEE') AND a.dazs IS NULL and a.kv = 980;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
              raise_application_error (
                 -20203,
                 'Не знайдено транзитний рахунок NBS = 2924 OB22 = 28');
        END;

        BEGIN
           SELECT 1
             INTO l_check
             FROM LOCPAY_FEE_LOG
            WHERE dat = to_date(l_last_date,'dd/mm/yyyy') and NLSTR = aa1.nls and kf = sys_context('bars_context','user_mfo');
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
             l_check := 0;
        END;

      l_sum_2924 := fost(aa1.acc,l_last_date);

      If aa1.ostc >= l_sum_2924 and l_sum_2924 <> 0 and l_check = 0 then
           gl.ref(l_ref);
           bars_audit.info('locpay_fee_3 l_ref = '||l_ref);
           gl.in_doc3(ref_=>l_ref, tt_  =>'024', vob_=> 6   , nd_ => substr(l_ref,1,10) , pdat_=> SYSDATE, vdat_=> gl.BDATE ,
                      dk_ => 1 , kv_  => '980', s_  => l_sum_2924, kv2_=> '980', s2_  => l_sum_2924, sk_  => null   , data_=> gl.BDATE , datp_=> gl.bdate,
                 nam_a_=> substr(aa1.nms,1,38), nlsa_=>aa1.nls, mfoa_=> gl.aMfo , nam_b_=> substr(ab.nms,1,38), nlsb_=> ab.nls, mfob_=> gl.aMfo ,
                 nazn_ => 'Комісійні доходи за перек. віль. рекв.  за період з ' ||to_char(l_first_date,'dd.mm.yyyy') || ' по ' || to_char(l_last_date,'dd.mm.yyyy'),
                d_rec_ => null,     id_a_=> null,id_b_=> null, id_o_ => null,     sign_=> null   , sos_ => 1, prty_ => null, uid_=>gl.aUID) ;
                bars_audit.info('locpay_fee_4 l_ref = '||l_ref);
           gl.payv ( 0, l_ref, gl.BDATE , '024', 1, '980', aa1.nls, l_sum_2924, '980', ab.nls, l_sum_2924 );
           bars_audit.info('locpay_fee_5 l_ref = '||l_ref);
           gl.pay  ( 2, l_ref, gl.BDATE);
           set_LOG(l_ref, l_sum_2924, aa1.nls, to_date(l_last_date,'dd/mm/yyyy'),sys_context('bars_context','user_mfo'));
      end if;

   end;

 -- Создание документа по 3739
   begin


        BEGIN
           SELECT a.*
             INTO aa2
             FROM accounts a
            WHERE a.NLS = GetGlobalOption ('NLS_373914_LOCPAYFEE') AND a.dazs IS NULL and a.kv = 980;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
              raise_application_error (
                 -20203,
                 'Не знайдено транзитний рахунок NBS = 3739 OB22 = 15');
        END;

        BEGIN
           SELECT 1
             INTO l_check
             FROM LOCPAY_FEE_LOG
            WHERE dat = to_date(l_last_date,'dd/mm/yyyy') and NLSTR = aa2.nls and kf = sys_context('bars_context','user_mfo');
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
             l_check := 0;
        END;


      l_sum_3739 := fost(aa2.acc,l_last_date);

      If aa2.ostc >= l_sum_3739 and l_sum_3739 <>0  and l_check = 0 then
           gl.ref(l_ref);
           gl.in_doc3(ref_=>l_ref, tt_  =>'024', vob_=> 6   , nd_ => substr(l_ref,1,10) , pdat_=> SYSDATE, vdat_=> gl.BDATE ,
                      dk_ => 1 , kv_  => '980', s_  => l_sum_3739, kv2_=> '980', s2_  => l_sum_3739, sk_  => null   , data_=> gl.BDATE , datp_=> gl.bdate,
                 nam_a_=> substr(aa2.nms,1,38), nlsa_=>aa2.nls, mfoa_=> gl.aMfo , nam_b_=>  substr(ab.nms,1,38), nlsb_=> ab.nls, mfob_=> gl.aMfo ,
                 nazn_ => 'Комісійні доходи за перек. віль. рекв.  за період з ' ||to_char(l_first_date,'dd.mm.yyyy') || ' по ' || to_char(l_last_date,'dd.mm.yyyy'),
                d_rec_ => null,     id_a_=> null,id_b_=> null, id_o_ => null,     sign_=> null   , sos_ => 1, prty_ => null, uid_=>gl.aUID) ;
           gl.payv ( 0, l_ref, gl.BDATE , '024', 1, '980', aa2.nls, l_sum_3739, '980', ab.nls, l_sum_3739 );
           gl.pay  ( 2, l_ref, gl.BDATE);
           set_LOG(l_ref, l_sum_3739, aa2.nls, to_date(l_last_date,'dd/mm/yyyy'),sys_context('bars_context','user_mfo'));
      end if;

   end;
exception when others then
          bars_audit.error('locpay_fee : ' || SQLERRM);
          ROLLBACK TO before_pay;
end;
/
show err;

PROMPT *** Create  grants  P_LOCPAY_FEE ***
grant EXECUTE                                                                on P_LOCPAY_FEE    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_LOCPAY_FEE    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LOCPAY_FEE.sql =========*** End 
PROMPT ===================================================================================== 
