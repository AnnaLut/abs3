

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_PAYCASHBPK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_PAYCASHBPK ***

  CREATE OR REPLACE TRIGGER BARS.TU_PAYCASHBPK INSTEAD OF UPDATE
  ON v_PAY_CASH_BPK REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
declare
  opr oper%rowtype;
BEGIN
--logger.info('DOX :old.acc_dox =' || :old.acc_dox  );
  If NOT (:old.F_DATA is null and :NEW.F_DATA is not null) then  RETURN; end if;
  ------------------------------------------------------------------------------
  opr.tt    :=  'PKT' ; --Видача гот?вки по БПК через касу банку/ 20-Зняття грошей з рах
  ---------------------
  opr.datd  := :NEW.F_DATA   ;
  opr.s     := :old.ost * 100;
  opr.nlsa  := :old.NLS      ;
  opr.nam_a := substr(:old.nms,1,38);
  opr.id_a  := :old.okpo     ;
  opr.nazn  := 'Компенсацiя вкладу СРСР, що надiйшла з ЦРВ';

begin
  bc.subst_branch(:old.branch);

  opr.nlsb  := (BRANCH_USR.GET_BRANCH_PARAM2('CASH',0));
  opr.nam_b := 'Каса бранчу '|| :old.branch;

		if substr(opr.nlsb,1,3)='100' then
		  opr.sk    := 58;
		  opr.vob   :=   119  ;
		else
		  opr.sk    := null;
		  opr.vob   := 6;
		end if;


  /*
  begin
    select substr(nms,1,38)  into opr.nam_b  from accounts
    where nls = opr.nlsb and kv = gl.baseval and dazs is null;
  exception when no_data_found then
    raise_application_error(-20100,'Не знайдено рах.каси для ' || :old.branch );
  end;
*/
  gl.ref (opr.REF);
  gl.in_doc3(ref_  => opr.REF,
            tt_    => opr.TT ,
            vob_   => opr.VOB,
            nd_    => substr(to_char(opr.REF),1,10),
            pdat_  => SYSDATE ,
            vdat_  => gl.BDATE,
            dk_    => 1,
            kv_    => gl.baseval,
            s_     => opr.s,
            kv2_   => gl.baseval,
            s2_    => opr.s,
            sk_    => opr.sk   ,
            data_  => opr.datd ,
            datp_  => gl.bdate ,
            nam_a_ => opr.nam_a,
            nlsa_  => opr.nlsa ,
            mfoa_  => gl.aMfo  ,
            nam_b_ => opr.nam_b,
            nlsb_  => opr.nlsb ,
            mfob_  => gl.aMfo  ,
            nazn_  => opr.nazn ,
            d_rec_ => null,
            id_a_  => opr.id_a ,
            id_b_  => gl.aOkpo ,
            id_o_  => null,
            sign_  => null,
            sos_   => 1,
            prty_  => null,
            uid_   => null);

   paytt (  flg_  => 0,          -- флаг оплаты
            ref_  => opr.REF,    -- референция
            datv_ => gl.bdate,   -- дата валютировния
            tt_   => opr.tt,     -- тип транзакции
            dk0_  => 1,          -- признак дебет-кредит
            kva_  => gl.baseval, -- код валюты А
            nls1_ => opr.nlsa,   -- номер счета А
            sa_   => opr.s,      -- сумма в валюте А
            kvb_  => gl.baseval, -- код валюты Б
            nls2_ => opr.nlsb  ,  -- номер счета Б
            sb_   => opr.s    -- сумма в валюте Б
           );
  update customerw
     set value = value ||' '|| to_char(:new.f_data,'dd.mm.yyyy')
     where rnk =:old.rnk and tag = 'RVIDT' ;
-----------------------------------------------
exception when others then  -- вернуться в свою область видимости
  bc.set_context;
  -- исключение бросаем дальше
  raise_application_error(-20000,
       sqlerrm || chr(10) || dbms_utility.format_error_backtrace(), true);
end;

bc.set_context;

--  insert into customerw(rnk,tag,value) values (:old.rnk,'RVCSH',to_char(opr.REF));
  ------------------------------------------------
END TU_PAYCASHBPK ;
/
ALTER TRIGGER BARS.TU_PAYCASHBPK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_PAYCASHBPK.sql =========*** End *
PROMPT ===================================================================================== 
