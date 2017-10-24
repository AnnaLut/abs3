

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_PAY_ALT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_PAY_ALT ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_PAY_ALT 
    before insert or update ON BARS.PAY_ALT for each row

-- Sta 20-01-2010 потеря пулл - переменных

declare
    IDa_ oper.ID_A%type ;   IDb_ oper.ID_B%type;
    BRA_ branch.branch%type :=sys_context('bars_context','user_branch');
    --BRA3_ branch.branch%type ;
    TAR_ tarif.kod%type :=70; --общебанковский код тарифа для зачислений по спискам
    nTmp_ int;
begin
   if length(bra_)=15  then    bra_:=bra_||'060'||substr(bra_,12,3)||'/';
   end if;

   if (inserting) then
      -- вставка нового
      select S_PAY_ALT.nextval into :new.ID from dual;
      :NEW.SOS  := NULL;   :NEW.ISP := USER_ID;    :new.sos  := null;
      :new.cep_acc := null;   nTmp_    := 0;
   end if;

----------------------------
   -- подбор SK_ZB
   If :new.SK_ZB is null then
      -- использовать вытяжку
      if web_utl.is_web_user = 1 then
         :new.SK_ZB := barsweb_session.get_number  ('ALT_SK_ZB') ;
      else
         :new.SK_ZB := to_number(pul.Get_Mas_Ini_Val('SK_ZB'));
      end if;
   end if;

   -- умолчательный символ
   If :new.SK_ZB is null then
      If    :new.NLSB_alt is not null  then :new.SK_ZB := 87;
      elsIf :new.NLSA_alt is not null  then :new.SK_ZB := 95;
      end if;
   end if;
-----
/*
   -- подбор NLS6
   If :new.NLS6 is null then
      -- использовать вытяжку
      if web_utl.is_web_user = 1 then
         :new.NLS6 := substr(barsweb_session.get_varchar2('ALT_NLS6' ),1,14) ;
      else
         :new.NLS6 := substr(pul.Get_Mas_Ini_Val('NLS6' )             ,1,14) ;
      end if;
   end if;
----------
   -- подбор IR
   If :new.IR is null then
      -- использовать вытяжку
      if web_utl.is_web_user = 1 then
         :new.IR   := barsweb_session.get_number  ('ALT_IR' );
      else
         :new.IR   := to_number(pul.Get_Mas_Ini_Val('IR'   ));
      end if;
   end if;
*/
--------------
   -- подбор ND
   If :new.ND is null then
      -- использовать вытяжку
      if web_utl.is_web_user = 1 then
         :new.ND  := substr(barsweb_session.get_varchar2('ALT_ND' ),1,10);
      else
         :new.ND  := substr(pul.Get_Mas_Ini_Val('ND' )             ,1,10);
      end if;
   end if;
-----------------
   -- установить вытяжку
   if web_utl.is_web_user = 1 then
      barsweb_session.set_number  ('ALT_SK_ZB',:new.SK_ZB);
      barsweb_session.set_varchar2('ALT_NLS6' ,:new.NLS6 );
      barsweb_session.set_number  ('ALT_IR'   ,:new.IR   );
      barsweb_session.set_varchar2('ALT_ND'   ,:new.ND   );
   else
      PUL.Set_Mas_Ini( 'SK_ZB', to_char(:new.SK_ZB), 'Симв.' );
      PUL.Set_Mas_Ini( 'NLS6',          :new.NLS6  , 'NLS6' );
      PUL.Set_Mas_Ini( 'IR',    to_char(:new.IR )  , 'IR' );
      PUL.Set_Mas_Ini( 'ND',            :new.ND    , 'ND' );
   end if;

   -- подбор счета А
   If :new.NLSA is NOT null then
      if web_utl.is_web_user = 1 then
          barsweb_session.set_varchar2('ALT_NLSA',:new.NLSA);
      else
          PUL.Set_Mas_Ini( 'NLSA', :new.NLSA, 'Сч.А' );
      end if;

      If :new.NMSA is null then
         begin
            select substr(a.nms,1,38),c.okpo into :new.NMSA,IDa_
            from saldo a, customer c
            where a.kv=gl.baseval and a.nls=:new.NLSA and a.dazs is null
              and a.rnk=c.rnk;
        --and a.branch=BRA_;

            if web_utl.is_web_user = 1 then
               barsweb_session.set_varchar2('ALT_NMSA',:new.NMSA);
            else
               PUL.Set_Mas_Ini( 'NMSA', :new.NMSA, 'nameСч.А' );
            end if;
         EXCEPTION WHEN NO_DATA_FOUND THEN null;
         end;
      End if;

   end if;

   -- подбор счета Б
   if :new.NLSb  is null AND :new.NLSb_alt is not null  then
      :new.cep_acc := null; nTmp_ := 0;

      for k in (select a.ACC, a.NLS, substr(c.nmk,1,38) NMS, c.okpo
                from accounts a, customer c
                where a.kv=gl.baseval and a.nlsalt=:new.NLSb_alt
                  and a.dazs is null
                  and a.rnk=c.rnk and a.branch=BRA_
                  and a.tip in ('PDM','DEP')
                  and substr(a.nbs,4,1)<>'8'
                order by decode(a.tip,'PDM',1,'DEP',2, 3),
                            a.daos desc, a.acc desc  )
       loop
          :new.NLSb := k.NLS;  :new.NMSb := k.NMS;  idb_:= k.OKPO;
          nTmp_ := nTmp_ +1;

          If nTmp_ > 1 then
             :new.cep_acc := :new.cep_acc || ',';
          end if;

          :new.cep_acc  := :new.cep_acc || to_char(k.ACC)  ;

       end loop;

       If nTmp_ = 1 then
          :new.cep_acc := null;
       end if;

   elsIf :new.NLSb is NOT null then
      if web_utl.is_web_user = 1 then
         barsweb_session.set_varchar2('ALT_NLSB',:new.NLSB);
      else
         PUL.Set_Mas_Ini( 'NLSB', :new.NLSB, 'Сч.B' );
      end if;

      If :new.NMSb is null then
         begin
            select substr(c.nmk,1,38),c.okpo into :new.NMSb, idb_
            from accounts a, customer c
            where a.kv=gl.baseval and a.nls=:new.NLSb and a.dazs is null
              and a.rnk=c.rnk and a.branch=BRA_;
            if web_utl.is_web_user = 1 then
               barsweb_session.set_varchar2('ALT_NMSB',:new.NMSB);
            else
               PUL.Set_Mas_Ini( 'NMSB', :new.NMSB, 'nameСч.B' );
              end if;
         EXCEPTION WHEN NO_DATA_FOUND THEN null;
         end;
      End if;
   end if;

   :NEW.DATD := NVL(:NEW.DATD,GL.BDATE);

   If :NEW.NAZN is null  then
      If    :new.NLSB_alt is not null then
            :NEW.NAZN :='Зарах.на рах.'|| :new.NLSB_alt ||' '||:NEW.NMSB;
      elsIf :new.NLSA_alt is not null then
            :NEW.NAZN :='Списан.з рах.'|| :new.NLSA_alt ||' '||:NEW.NMSA;
      elsIf :new.NLSB is not null then
            :NEW.NAZN :='Зарах.на рах.'|| :new.NLSB ||' '||:NEW.NMSB;
      elsIf :new.NLSA is not null then
            :NEW.NAZN :='Списан.з рах.'|| :new.NLSA ||' '||:NEW.NMSA;
      end if;
   end if;

   ------------------------------------
   If :new.sos=1  AND :new.NLSa is not null AND :new.NLSb is not null AND
      :new.S >0   then
      :new.sos:=0;
      -- попытка опл по плану
      declare
        ref_ oper.REF%type ;
        vob_ oper.VOB%type := 6;
        tt_  oper.TT%type  := 'ALT';
        ttk_ oper.TT%type  := 'ALK';
        kv_  oper.KV%type  := gl.baseval;
        S_   oper.S%type   := :new.S*100;
        K_   oper.S%type   := 0;
      begin

        If ida_ is null then
           begin
              select c.okpo into IDa_ from accounts a, customer c  where
                 a.kv=980 and a.nls=:new.NLSA and a.rnk=c.rnk and a.branch=BRA_;
           EXCEPTION WHEN NO_DATA_FOUND THEN null;
           end;
        end if;

        If idb_ is null then
           begin
              select c.okpo into IDb_ from accounts a, customer c  where
                  a.kv=980 and a.nls=:new.NLSB and a.rnk=c.rnk and a.branch=BRA_;
           EXCEPTION WHEN NO_DATA_FOUND THEN null;
           end;
        end if;

        :new.ND := Nvl(:new.ND,'1');

 If :NEW.NLS6 is not null and :new.IR >0 then
           K_:= f_tarif (tar_,        -- код тарифа
                         GL.BASEVAL,  -- валюта операции
                         :new.NLSA ,  -- бух.номер счета
                         s_        ,  -- сумма операции
                         0) ;         -- =1 - сумма тарифа в базовой валюте
--         K_:= round( S_ * :NEW.IR/100,0);

           If K_>0 then
              vob_ := 66;
           end if;
end if;

--потеря пулл - переменных
If :new.NMSA is null or :new.NMSb is null then
   raise_application_error(-20100,'Втрата пул-даних!');
end if;

        GL.REF (REF_);
        GL.IN_DOC3( REF_, tt_,vob_, :new.ND, SYSDATE, GL.BDATE, 1,
           KV_,S_,KV_,S_,  null, GL.BDATE, GL.BDATE,
           :new.NMSA, :new.NLSA, gl.AMFO ,
           :new.NMSb, :new.NLSb, gl.AMFO ,
           :new.NAZN, NULL,IDa_,IDb_,null, null,0,null, null );

        If :new.NLSa_alt is not null then
           insert into operw (ref,tag,value) values (REf_,'ALT_D', :new.NLSa_alt);
        end if;
        If :new.NLSb_alt is not null then
           insert into operw (ref,tag,value) values (REf_,'ALT_K', :new.NLSb_alt);
        end if;
        GL.PAYV(0,REF_,GL.BDATE,TT_,1,KV_,:new.NLSA,S_,KV_,:new.NLSB,S_);
        If K_>0 then
           GL.PAYV(0,REF_,GL.BDATE,TTK_,1,KV_,:new.NLSB,K_,KV_,:new.NLS6,K_);
        end if;

        Insert into operw (ref,tag,value) values (REF_,'SK_ZB',to_char(:new.SK_ZB));

        --ВОССТАНОВЛЕНИЕ ПУСТОЙ ЗАПИСИ
        :new.sos  := NULL;
        :new.ID   := :old.ID;
        :new.ND   := NULL; :new.S    := NULL; :new.DOPR     := NULL;
        :new.NMSA := NULL; :new.NLSA := NULL; :new.NLSA_ALT := NULL;
        :new.NMSB := NULL; :new.NLSB := NULL; :new.NLSB_ALT := NULL;
        :new.NAZN := NULL; :new.S2   := NULL; :new.SOS      := NULL;
        :new.DATD := NULL; :new.SK_ZB:= NULL; :new.NLS6     := NULL;
        :new.IR   := NULL; :new.ND   := NULL;
       end;
   else
      :new.sos      := NULL;
      -- вытяжка счетов
      If :new.NLSA is null and :new.NLSA_alt is null then
         if web_utl.is_web_user = 1 then
            :new.NLSA := barsweb_session.get_varchar2('ALT_NLSA');
            :new.NMSA := barsweb_session.get_varchar2('ALT_NMSA');
         else
            :new.NLSA := Substr(pul.Get_Mas_Ini_Val('NLSA'),1,14);
            :new.NMSA := Substr(pul.Get_Mas_Ini_Val('NMSA'),1,38);
         end if;
      end if;
   end if;

end tbiu_pay_alt;


/
ALTER TRIGGER BARS.TBIU_PAY_ALT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_PAY_ALT.sql =========*** End **
PROMPT ===================================================================================== 
