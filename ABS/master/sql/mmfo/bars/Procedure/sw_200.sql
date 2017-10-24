

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SW_200.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SW_200 ***

  CREATE OR REPLACE PROCEDURE BARS.SW_200 (P_REF NUMBER ) IS
   AA ACCOUNTS%ROWTYPE;
   KV_  NUMBER;
   KV2_  NUMBER;
   NLS_ VARCHAR2(15);
   NLS2_ VARCHAR2(15);
   OO OPER%ROWTYPE;
   i  number;
   bic BIC_ACC%ROWTYPE;
   l_bic_b BIC_ACC.BIC%TYPE;
   l_their_acc_b BIC_ACC.THEIR_ACC%TYPE;
   l_osc_bic varchar2(260);
   l_alt_partyb FOREX_ALIEN.INTERM_B%TYPE;
   l_NLSK FOREX_ALIEN.NLSK%TYPE;
   l_stmt_72 varchar2(500);

BEGIN
--logger.info('NOS-1 '|| p_ref );
    BEGIN

      SELECT * INTO OO FROM OPER WHERE REF = P_REF  and tt = 'CVE' ;

      IF OO.DK = 0 THEN  KV_ := OO.KV              ; NLS_ := OO.NLSA; nls2_:= OO.NLSb;  KV2_ := nvl(OO.KV2, oo.kv) ;
      else               KV_ := nvl(OO.KV2, oo.kv) ; NLS_ := OO.NLSb; nls2_:= OO.NLSa;  KV2_ := OO.KV;
      End if;

--logger.info('NOS-2 '|| nls_ );

      SELECT (select substr(name,1,26)||chr(13)||chr(10)||substr(name,28,31)||chr(13)||chr(10)||'G.'||CITY from sw_banks  where bic = 'COSBUAUKXXX') osc_bic,A.acc, b.bic,(select their_Acc from bic_acc where acc=a.acc) their_Acc,(select their_Acc from bic_acc where acc=ab.acc) their_AccB, (select bic from bic_acc where acc=a.acc) bic_b INTO l_osc_bic,AA.acc, bic.bic, bic.their_Acc, l_their_acc_b, l_bic_b FROM ACCOUNTS A, accounts ab, BIC_ACC B  WHERE B.ACC= Ab.ACC AND  A.KV = kv_ and a.nls = nls_  and ab.nls=nls2_ AND  Ab.KV = kv2_;
--logger.info('NOS-3 '|| aa.acc );



    EXCEPTION WHEN NO_DATA_FOUND THEN return;
    end;
    select count(*) into i from opldok where ref = P_REF and acc = aa.acc;
--logger.info('NOS-3-1 count(acc)=>'|| i );

    if KV_=643 then
      begin
        select alt_partyb,nlsk INTO l_alt_partyb,l_nlsk from forex_alien  where substr(bic,1,8)=SUBSTR(bic.bic,1,8) and kv=643 and rownum=1;
      exception when no_data_found then l_alt_partyb:=null;
      end;

    end if;


   if KV_=643 then
              begin
                 insert into operw (ref, tag, value) values (oo.ref, 'f',     'MT 202');
              exception
               when dup_val_on_index then
                        update operw set value = 'MT 202' where ref = oo.ref and tag = 'f';
              end;
   else
                        begin
              insert into operw (ref, tag, value) values (oo.ref, 'f',     'MT 200');
             exception
            when dup_val_on_index then
                        update operw set value = 'MT 200' where ref = oo.ref and tag = 'f';
              end;
   end if;
    insert into operw (ref, tag, value) values (oo.ref, 'NOS_A', to_char(aa.acc)  );

    begin
    insert into operw (ref, tag, value) values (oo.ref, '53B', '/D/'||bic.their_Acc );
    exception
               when dup_val_on_index then
                        update operw set value =  '/D/'||bic.their_Acc   where ref = oo.ref and tag = '53B';
              end;

    if KV_=643 then
                begin
               insert into operw (ref, tag, value) values (oo.ref, '57D', l_alt_partyb );
                exception
               when dup_val_on_index then
                        update operw set value =  l_alt_partyb  where ref = oo.ref and tag = '57D';
              end;
              else
                        begin
               insert into operw (ref, tag, value) values (oo.ref, '57A', bic.bic );
                exception
                when dup_val_on_index then
                        update operw set value =  bic.bic  where ref = oo.ref and tag = '57A';
              end;
   end if;

      if KV_=643 then
                begin
               insert into operw (ref, tag, value) values (oo.ref, '58D', '/'||l_their_acc_b||chr(13)||chr(10)||'œ¿Œ √Œ—”ƒ¿–—“¬≈ÕÕ€… ŒŸ¿ƒÕ€… ¡¿Õ '||chr(13)||chr(10)||'” –¿»Õ€'||chr(13)||chr(10)||'√. »≈¬');
                exception
               when dup_val_on_index then
                        update operw set value =  '/'||l_their_acc_b||chr(13)||chr(10)||'œ¿Œ √Œ—”ƒ¿–—“¬≈ÕÕ€… ŒŸ¿ƒÕ€… ¡¿Õ '||chr(13)||chr(10)||'” –¿»Õ€'||chr(13)||chr(10)||'√. »≈¬'  where ref = oo.ref and tag = '58D';
              end;


              l_stmt_72:='/RPP/'||trunc(dbms_random.value()*1000)||'.'||to_char(oo.vdat, 'yymmdd')||'.5.ELEK.01'||chr(13)||chr(10)||
              '/NZP/''(VO60071)''œŒœŒÀÕ≈Õ»≈'||chr(13)||chr(10)||
              '// Œ–.—◊≈“¿ Õƒ— Õ≈“';

              begin
               insert into operw (ref, tag, value) values (oo.ref, '72', l_stmt_72 );
              exception
               when dup_val_on_index then
                update operw set value =  l_stmt_72  where ref = oo.ref and tag = '72';
              end;


   end if;

--logger.info('NOS-4 '|| bic.bic );

    bars_swift_msg.docmsg_process_document2(oo.ref, 1);
--logger.info('NOS-5 '|| aa.acc );

--  insert into operw (ref, tag, value) values (oo.ref,  'KOD_G', ll.country);
--  insert into operw (ref, tag, value) values (oo.ref,  'KOD_N', nvl(KODN_,LL.KOD_N) ) ;

END SW_200;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SW_200.sql =========*** End *** ==
PROMPT ===================================================================================== 
