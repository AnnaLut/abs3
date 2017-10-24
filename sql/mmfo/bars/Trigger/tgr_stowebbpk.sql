

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TGR_STOWEBBPK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TGR_STOWEBBPK ***

  CREATE OR REPLACE TRIGGER BARS.TGR_STOWEBBPK 
       INSTEAD OF UPDATE OR INSERT OR DELETE
       ON BARS.STO_WEB_BPK REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  l_msg varchar2(3000);
  acc_  number  ;
  IDG_  number  := 3;
  IDS_  Number  ;
  rnk_  number  ;
  tt1_  char(3) :='W4F';
  tt2_  char(3) :='W4G';
  tt_   char(3) ;
  KV_   number  :=980;
  mfob_ varchar2(12);
  okpo_ varchar2(14);
  polu_ varchar2(38);
  SS_   VARCHAR2(15);
  dd1_  DATE     ;
  dd2_  DATE;
  NLS_  VARCHAR2(15) ;
  NLSB_ VARCHAR2(15) ;
  ORD_  int;
  vob_  tts_vob.vob%type;

  p_nazn sto_det.nazn%type;
  mfob sto_det.mfob%type;
  nlsb sto_det.nlsb%type;
  okpo sto_det.okpo%type;
  polu sto_det.polu%type;
  DAT1 sto_det.DAT1%type;
  DAT2 sto_det.DAT2%type;



begin

          barsweb_session.set_session_id(substr(sys_context('userenv','client_identifier'),-24));

          IF  :new.NAZN IS NULL THEN p_nazn := barsweb_session.get_varchar2('NAZN');  else p_nazn := :new.NAZN; END IF;
          IF  :new.MFOB IS NULL THEN MFOB := barsweb_session.get_varchar2('MFOB');  else MFOB := :new.MFOB; END IF;
          IF  :new.NLSB IS NULL THEN NLSB := barsweb_session.get_varchar2('NLSB');  else NLSB := :new.NLSB; END IF;
          IF  :new.OKPO IS NULL THEN OKPO := barsweb_session.get_varchar2('OKPO');  else OKPO := :new.OKPO; END IF;
		  IF  :new.POLU IS NULL THEN POLU := barsweb_session.get_varchar2('POLU');  else POLU := :new.POLU; END IF;
	--	  IF  :new.DAT1 IS NULL THEN DAT1 := barsweb_session.get_date('DAT1');  else DAT1 := :new.DAT1; END IF;
	--	  IF  :new.DAT2 IS NULL THEN DAT2 := barsweb_session.get_date('DAT2');  else DAT2 := :new.DAT2; END IF;



	if (inserting) then	   --ТОЛЬКО ПРИ ВСТАВКЕ

	if web_utl.is_web_user = 1 then

		  barsweb_session.set_varchar2  ('NAZN',  p_NAZN);
		  barsweb_session.set_varchar2  ('MFOB',  MFOB);
		  barsweb_session.set_varchar2  ('NLSB',  NLSB);
		  barsweb_session.set_varchar2  ('OKPO',  OKPO);
		  barsweb_session.set_varchar2  ('POLU',  POLU);
	--	  barsweb_session.set_date  ('DAT1',  DAT1);
	--	  barsweb_session.set_date  ('DAT2',  DAT2);

		 end if;

	END IF;


		 IF :old.IDD is NOT null and (deleting) then
			 DELETE FROM sto_dat WHERE IDD =:old.IDD;
			 DELETE FROM sto_det WHERE IDD =:old.IDD;
			 RETURN;
		 end if;


        If :new.nlsa IS null then return;  end if;

		 dd1_ := nvl(TO_DATE(:NEW.DAT1,'DD.MM.YYYY'), dat1);
		 dd2_ := nvl(TO_DATE(:NEW.DAT2,'DD.MM.YYYY'), dat2);


		 IF :new.IDD  is null then
		   begin
				select rnk,acc, NLS into RNK_, ACC_, NLS_
				   from accounts where kv=KV_ and nls=:new.nlsa and nbs = '2625'
				  and branch=sys_context('bars_context','user_branch');
			   exception when NO_DATA_FOUND THEN
				 l_msg := 'Введений рах-платник ' || NLS_ || '/' || kv_ ||
						' не знайдено в вашому бранчi ' ||
			   sys_context('bars_context','user_branch');
				 goto RET_ERR;
		   end;

				   begin
    			    	  select ids into IDS_ from STO_LST where rnk=RNK_ and NAME=to_char(acc_);
	     			 exception when NO_DATA_FOUND THEN
		    			  SELECT s_sto_ids.NEXTVAL INTO ids_ FROM dual;
			    	      INSERT INTO sto_lst (IDG , IDS , RNK ,NAME, SDAT ) VALUES (IDG_, IDS_, RNK_, to_char(acc_), gl.bdate);
				   end;
		 end if;

		 mfob_:= nvl(:new.mfob, mfob);


		 If MfoB_=gl.amfo then
		   begin
				select substr(c.nmk,1,38), c.okpo, A.NLS into polu_, okpo_, NLSB_
				   from accounts a, customer c
				where a.kv=kv_ and nls=nvl(:new.nlsb, nlsb) and a.dazs is null and a.rnk=c.rnk;

			exception when NO_DATA_FOUND THEN
				  l_msg := 'Введений рах-отримувач ' || :new.nlsb || '/' || kv_ ||
							 ' не знайдено в вашому MFO '|| mfob_;
			goto RET_ERR;
		   end;
		   TT_ := TT1_;
		 else
			  NLSB_:= nvl(:new.nlsb, nlsb);

			If :new.nlsB<> vkrzn( substr(mfob_,1,5), nlsb_) then
				  l_msg := 'Введений рах-отримувач ' || nlsb_ || '/' || kv_ ||
						 ' не вiдповiдає по контр.розр. MFO '|| mfob_ ;
				goto RET_ERR;
			  end if;
			  TT_ := TT2_;
			  polu_:= nvl(POLU,:new.polu);
			  okpo_:= NVL(:new.okpo,OKPO);
		 end if;
---
   If length(NVL(:new.nazn,p_NAZN))<4 then l_msg:='Пом. в призначеннi платежу.'; end if;
   If length(polu_)<4     then l_msg:=l_msg||chr(10)||'Пом. в назвi отрим.';end if;
   If :new.Fsum<=0        then l_msg:=l_msg||chr(10)||'Пом. в сумi.'; end if;
   If length(okpo_)<5     then l_msg:=l_msg||chr(10)||'Пом. в ОКПО отрим.'; end if;
   If length(l_msg)>0     then goto RET_ERR; end if;
---------------------------------

  if :new.Fsum != :old.Fsum then
  SS_:=to_CHAR( replace(:new.Fsum,',','.') * 100 );
  else
  SS_:=to_CHAR( replace(:new.Fsum,',','.') );
  end if;

  If SS_<=0        then l_msg:=l_msg||chr(10)||'Пом. в сумi.'; end if;

   If :new.ORD is null then
      select NVL(max(ord),0) + 1 into ORD_ from STO_DET where ids=IDS_;
   else
       ORD_:= :new.ORD;
   end if;


  begin
        select vob
          into vob_
          from tts_vob
         where tt=tt_ and rownum = 1;
         exception when NO_DATA_FOUND THEN vob_:=1;
   end;

   IF :new.IDD is null and (inserting) then

   INSERT INTO sto_det(ids, ord, tt, vob, dk, nlsa,kva, nlsb,kvb,mfob, polu,
                       nazn, fsum, okpo, DAT1, DAT2, FREQ, WEND  )
               values (IDS_, ORD_, TT_, vob_, 1, NLS_, KV_, NLSB_,KV_,MFOB_,POLU_,
                       p_NAZN, SS_, OKPO_,  dd1_, DD2_, 5, 1  );

   elsif :new.IDD is NOT null and (updating) then
   UPDATE sto_det SET tt=TT_, nlsb=:new.NlsB,kvb= Kv_, mfob=MfoB_, polu= Polu_,
                      nazn=p_Nazn, fsum=SS_,okpo=Okpo_,DAT1= DD1_, DAT2=DD2_,
                      ord =ORD_
       WHERE IDD = :new.IDD;

   end if;
   RETURN;
----------------------
  <<RET_ERR>>
       l_msg := 'Увага ! '|| l_msg || chr(10)|| dbms_utility.format_call_stack;
       bars_audit.error(l_msg);
       raise_application_error(-20000, l_msg, true);
       return;
END tgr_STOWEBBPK;


/
ALTER TRIGGER BARS.TGR_STOWEBBPK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TGR_STOWEBBPK.sql =========*** End *
PROMPT ===================================================================================== 
