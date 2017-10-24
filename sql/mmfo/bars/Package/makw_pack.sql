
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/makw_pack.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MAKW_PACK 
AS


-------------------------------
-- Добавлення(обновлення) допреквізита для платежу
-- MAKW_PACK.ADD_OPERW(ID_ IN NUMBER, TAG_ IN VARCHAR2, VALUE_ IN VARCHAR2)
-------------------------------
PROCEDURE ADD_OPERW(ID_     NUMBER,
                    TAG_    VARCHAR2,
                    VALUE_  VARCHAR2);

-------------------------------
-- Добавлення(обновлення) групи макету
-- MAKW_PACK.add_grp(GRP_ IN NUMBER, NAME_ IN VARCHAR2);
-------------------------------
PROCEDURE ADD_GRP  (GRP_     NUMBER,
                    NAME_    VARCHAR2);


-------------------------------
-- Добавлення(обновлення) макету платежу
-------------------------------
PROCEDURE ADD_DET  (  ID_      NUMBER               ,
					  GRP_     NUMBER               ,
					  TT_      VARCHAR2             ,
					  NLSA_    VARCHAR2             ,
					  NLSB_    VARCHAR2             ,
					  MFOB_    VARCHAR2             ,
					  OKPOB_   VARCHAR2             ,
					  NAZN_    VARCHAR2             ,
					  SUMP_    NUMBER               ,
					  NAM_B_   VARCHAR2 default null,
					  BRANCH_  VARCHAR2 default null,
					  VOB_     NUMBER   default null,
					  ORD_     number,
					  Err_Code    out int,
                      Err_Message out varchar2
);


-------------------------------
-- Оплата макету платежу
-------------------------------

PROCEDURE ADD_PAY  (  ID_      NUMBER               ,
					  GRP_     NUMBER               ,
					  NAZN_    VARCHAR2             ,
					  SUMP_    NUMBER               ,
					  REF_ OUT varchar2
);


PROCEDURE DEL_DET  (  ID_      NUMBER               ,
					  GRP_     NUMBER
);
END MAKW_PACK;
/
CREATE OR REPLACE PACKAGE BODY BARS.MAKW_PACK 
AS


PROCEDURE ADD_OPERW(ID_       NUMBER,
                    TAG_      VARCHAR2,
                    VALUE_    VARCHAR2)
IS
l_col number;
BEGIN


 if VALUE_ is null then

 delete  makw_operw where id = ID_ and tag = TAG_;

 else

   UPDATE makw_operw
      SET value = value_
	WHERE id=id_
	  AND tag=tag_;
	if SQL%rowcount = 0 then
				INSERT INTO  makw_operw(id,   tag,  value)
					 VALUES            (id_,  tag_, value_);
			end if;
  end if;

 END ADD_OPERW;



 PROCEDURE ADD_GRP  (GRP_     NUMBER,
                     NAME_    VARCHAR2)
IS
l_col number;
BEGIN


 UPDATE makw_GRP
      SET NAME = NAME_
	WHERE GRP=GRP_ ;
		if SQL%rowcount = 0 then
				INSERT INTO  makw_GRP(GRP,   NAME)
					 VALUES          (GRP_,  NAME_);
			end if;


END ADD_GRP;

PROCEDURE ADD_DET  (  ID_      NUMBER               ,
					  GRP_     NUMBER               ,
					  TT_      VARCHAR2             ,
					  NLSA_    VARCHAR2             ,
					  NLSB_    VARCHAR2             ,
					  MFOB_    VARCHAR2             ,
					  OKPOB_   VARCHAR2             ,
					  NAZN_    VARCHAR2             ,
					  SUMP_    NUMBER               ,
					  NAM_B_   VARCHAR2 default null,
					  BRANCH_  VARCHAR2 default null,
					  VOB_     NUMBER   default null,
					  ORD_     number,
					  Err_Code    out int,
                      Err_Message out varchar2
)
IS
STOP_PRC EXCEPTION;
accoun accounts%rowtype;
tts_ tts%rowtype;
l_m number;
l_col number;
p_mfo varchar2(10);
BEGIN

 BEGIN

         select fli   -- 0 -внутрібанк 1- міжбанк
		  into tts_.fli
		  from tts
         where tt = TT_;

            begin
				select  nms
				  into  accoun.nms
				  from saldo
				 where nls = NLSA_ and kv = 980 and dazs is null ;
			  exception when NO_DATA_FOUND THEN
 					    ERR_Code    := 1;
                        ERR_Message := '     Рахунок '||NLSA_||' не знайдено або закрито';
					    raise STOP_PRC;

    		END;


         if  MFOB_ = gl.kf   then
		 begin
				select  nms, rnk
				  into  accoun.nms, accoun.rnk
				  from accounts
				 where nls = NLSB_ and kv = 980 and dazs is null ;
			  exception when NO_DATA_FOUND THEN
 					    ERR_Code    := 1;
                        ERR_Message := '     Рахунок '||NLSB_||' не знайдено або закрито';
					    raise STOP_PRC;

    		END;

			if tts_.fli != 0 then
 					    ERR_Code    := 1;
                        ERR_Message := '     Код операуції '||TT_||' не призначена для внутрібанківських операцій';
					    raise STOP_PRC;
             end if;


		else

		    BEGIN
            select mfo
			  into p_mfo
 			  from banks$base
			 where blk = 0	and mfo = MFOB_	;
		     exception when NO_DATA_FOUND THEN
 					    ERR_Code    := 1;
                        ERR_Message := '     МФО '||MFOB_||' не знайдено або закрито';
					    raise STOP_PRC;

    		END;

		     if NLSB_ != vkrzn(substr(MFOB_,1,5), NLSB_ ) then
			            ERR_Code    := 1;
                        ERR_Message := '     Рахунок '||NLSB_||' не ключується з МФО'||MFOB_;
					    raise STOP_PRC;
			 end if;


					if tts_.fli != 1 then
 					    ERR_Code    := 1;
                        ERR_Message := '     Код операуції '||TT_||' не призначена для міжбанківських операцій';
					    raise STOP_PRC;
                    end if;

			begin
             select 1
			   into l_m
			   from chklist_tts
			   where f_in_charge = 3
				 and tt = tt_;
            exception when NO_DATA_FOUND THEN
 					    ERR_Code    := 1;
                        ERR_Message := '     Операція '||MFOB_||' не містить підпису СЕП';
					    raise STOP_PRC;
            end;


        end if;


 UPDATE makw_det
      SET TT = TT_,
          NLSA = NLSA_,
		  NLSB = NLSB_,
          MFOB = MFOB_,
          OKPOB = OKPOB_,
          NAZN = NAZN_,
          SUMP = nvl(SUMP_,0),
          NAM_B = NAM_B_,
          BRANCH = BRANCH_,
          VOB = VOB_,
          ORD = ORD_
	WHERE GRP=GRP_
      AND ID =ID_ ;
	if SQL%rowcount = 0 then
				INSERT INTO  makw_det(ID, GRP, TT, NLSA, NLSB, MFOB, OKPOB, NAZN,     SUMP,    NAM_B, BRANCH, VOB, ORD)
					 VALUES          ( 0, GRP_,TT_,NLSA_,NLSB_,MFOB_,OKPOB_,NAZN_,nvl(SUMP_,0),NAM_B_,BRANCH_,VOB_, ORD_);
			end if;

	 exception
    when others then
      --rollback;
      if ERR_Message is null then
         ERR_Code    := 1;
         ERR_Message := SQLERRM;
      end if;
null;

	end;
END ADD_DET;


PROCEDURE ADD_PAY  (  ID_      NUMBER               ,
					  GRP_     NUMBER               ,
					  NAZN_    VARCHAR2             ,
					  SUMP_    NUMBER               ,
					  REF_ OUT varchar2
)
IS
opr oper%rowtype;
cust customer%rowtype;
det makw_det%rowtype;
p_nazn varchar2(160);
l_m number;
S varchar2(254);
BEGIN


p_nazn := substr(nazn_,1,159);

select *
  into det
 from makw_det
 where id = ID_ and grp =GRP_;


 BEGIN
 select substr(nms,1,38), rnk
   into opr.nam_a, cust.rnk
    from accounts a
   where nls = det.nlsa and kv = 980 and dazs is null;
 exception when NO_DATA_FOUND THEN
		     raise_application_error(-(20001),'\ ' ||'  Рахунок '||det.nlsa||' незнайдено, або закрито',TRUE);
 END;

 BEGIN
 select okpo, substr(nmkk,1,38)
   into cust.okpo, cust.nmkk
    from customer
   where rnk = cust.rnk;
 exception when NO_DATA_FOUND THEN
					     raise_application_error(-(20001),'\ ' ||'  Контрагента '||cust.rnk||' незнайдено',TRUE);
 END;


 -- провірим реквізити рахунка Б якщо рахунок внутрібанківський
 if det.mfob = gl.aMfo then

 BEGIN
  select substr(nms,1,38), rnk
   into det.nam_b, cust.rnk
    from accounts a
   where nls = det.nlsb and kv = 980 and dazs is null;
 exception when NO_DATA_FOUND THEN
					     raise_application_error(-(20001),'\ ' ||'  Рахунок '||det.nlsa||' незнайдено, або закрито',TRUE);
 END;

 BEGIN
 select okpo--, substr(nmkk,1,38)
   into det.okpob--, det.nam_b
    from customer
   where rnk = cust.rnk;
 exception when NO_DATA_FOUND THEN
					     raise_application_error(-(20001),'\ ' ||'  Контрагента '||cust.rnk||' незнайдено',TRUE);
 END;
 else

 begin
 select 1
   into l_m
   from chklist_tts
   where f_in_charge = 3
     and det.tt = tt;
 exception when NO_DATA_FOUND THEN
       --raise_application_error(-(20001),'\ ' ||'  Операція '||det.tt||' - відсутній підпис СЕП ',TRUE);
	 ref_ := 0;
	goto err_exit;
 end;

 end if;



                                   gl.ref (opr.REF);

                                  gl.in_doc3(ref_  => opr.REF,
                                            tt_    => det.tt ,
                                            vob_   => det.vob,
                                            nd_    => substr(to_char(opr.REF),1,10),
                                            pdat_  => SYSDATE ,
                                            vdat_  => gl.BDATE,
                                            dk_    => 1,
                                            kv_    => gl.baseval,
                                            s_     => sump_,
                                            kv2_   => gl.baseval,
                                            s2_    => sump_,
                                            sk_    =>  null ,
                                            data_  => gl.bdate ,
                                            datp_  => gl.bdate ,
                                            nam_a_ => substr((case when det.mfob = gl.aMfo then opr.nam_a else cust.nmkk end ),1,38),
                                            nlsa_  => det.nlsa ,
                                            mfoa_  => gl.aMfo  ,
                                            nam_b_ => substr(det.nam_b,1,38),
                                            nlsb_  => det.nlsb ,
                                            mfob_  => det.mfob  ,
                                            nazn_  => p_nazn,
                                            d_rec_ => null,
                                            id_a_  => cust.okpo ,
                                            id_b_  => det.okpob ,
                                            id_o_  => null,
                                            sign_  => null,
                                            sos_   => 1,
                                            prty_  => null,
                                            uid_   => null);


                 insert into operw (ref, tag, value)
	                  select opr.REF, tag, value from makw_operw where id = ID_;

					  			 paytt (   flg_  => 0,          -- флаг оплаты
                                            ref_  => opr.REF,    -- референция
                                            datv_ => gl.bdate,   -- дата валютировния
                                            tt_   => det.tt,     -- тип транзакции
											dk0_  => 1,          -- признак дебет-кредит
											kva_  => gl.baseval, -- код валюты А
                                            nls1_ => det.nlsa,   -- номер счета А
                                            sa_   => sump_,      -- сумма в валюте А
                                            kvb_  => gl.baseval, -- код валюты Б
                                            nls2_ => det.nlsb  ,  -- номер счета Б
                                            sb_   => sump_    -- сумма в валюте Б
                                           );
                        begin
					   for k in (
					   select t.tt, t.s, s.dk from ttsap s, tts t where s.tt = det.tt and s.ttap = t.tt
						  )
						  loop

						begin

						   S := REPLACE(k.s,'#(REF)',TO_CHAR(opr.REF));
						   S := REPLACE(S,'#(TT)',''''||det.tt||'''');
						   S := REPLACE(S,'#(NLSA)',''''||det.nlsa||'''');
						   S := REPLACE(S,'#(NLSB)',''''||det.nlsb||'''');
						   S := REPLACE(S,'#(KVA)',TO_CHAR(980));
						   S := REPLACE(S,'#(KVB)',TO_CHAR(980));
						   S := REPLACE(S,'#(S)',   TO_CHAR(sump_));
						   S := REPLACE(S,'#(SA)',  TO_CHAR(sump_));
						   S := REPLACE(S,'#(SB)',  TO_CHAR(sump_));
						   S := REPLACE(S,'#(S2)',  TO_CHAR(sump_));
						   S := REPLACE(S,'#(MFOA)',  gl.aMfo);
						   S := REPLACE(S,'#(MFOB)',  det.mfob);
                         end;

						  begin
								  execute immediate 'select '||S||' from dual' into opr.s ;
								  exception when NO_DATA_FOUND
										 THEN opr.s :=0;
                          end;

                                   paytt (  flg_  => 0,          -- флаг оплаты
                                            ref_  => opr.REF,    -- референция
                                            datv_ => gl.bdate,   -- дата валютировния
                                            tt_   => k.tt,     -- тип транзакции
                                            dk0_  => (case when k.dk=0 then 1 else 0 end),          -- признак дебет-кредит
                                            kva_  => gl.baseval, -- код валюты А
                                            nls1_ => det.nlsa,   -- номер счета А
                                            sa_   => opr.s,      -- сумма в валюте А
                                            kvb_  => gl.baseval, -- код валюты Б
                                            nls2_ => det.nlsb  ,  -- номер счета Б
                                            sb_   => opr.s    -- сумма в валюте Б
                                           );
						 end loop;
						 end;

                                   REF_ := opr.REF;

if det.branch is not null then

 /*  Insert into OPERW (REF,TAG,VALUE)
        values (opr.REF, 'TOBO3', det.branch);
 */
	update opldok
       set 	txt =  det.branch
	   where ref = opr.REF;

end if;




null;


<<err_exit>>
null;

END ADD_PAY;

PROCEDURE DEL_DET  (  ID_      NUMBER               ,
					  GRP_     NUMBER
)
is
BEGIN

 delete makw_det where id = ID_ and grp = GRP_;

END DEL_DET;



END MAKW_PACK;
/
 show err;
 
PROMPT *** Create  grants  MAKW_PACK ***
grant EXECUTE                                                                on MAKW_PACK       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/makw_pack.sql =========*** End *** =
 PROMPT ===================================================================================== 
 