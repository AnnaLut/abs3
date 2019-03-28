

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_DATE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_DATE ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_DATE ( dat_ IN DATE DEFAULT NULL) 
  IS
    ----------------------------------------------------
	-- функция доплаты документов по дате валютировнаия
	---------------------------------------------
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
    G_sepnum         INTEGER  DEFAULT NULL;  -- используемая версия СЭП(по параметру 'SEPNUM')
    title            constant varchar2(32) := 'zbd.pay_date: ';
    l_error_message  varchar2(4000);
    l_msg   varchar2(2000);
    l_msg2  varchar2(4000);
 
 BEGIN

   bars_audit.info(title||'Начало процедуры оплаты докмунтов по требованию');
   g_sepnum := branch_attribute_utl.get_attribute_value('/', 'SEPNUM');
   
   for c in (select o.ref, o.tt, o.chk, t.fli, substr(flags,38,1) flg
               from tts t, oper o, ref_que q
              where o.ref=q.ref and t.tt=o.tt
                and o.sos between 1 and 4 and o.vdat <= gl.bdate
                and o.ref not in (select refl from oper
                                   where refl is not null
                                     and sos between 1 and 4)
              order by ref, vdat)
   loop

      msg_:= 'Оплачен';
      
	  begin
         select sum(decode(dk,0,-s,s)) into sum_
           from opldok
          where ref = c.ref and sos < 5 and fdat <= gl.bdate;
      exception
         when no_data_found then sum_ := null;
      end;

      -- Check if the document acknowleged
	  if sum_ = 0 then     
         
		 chk.doc_ack ( c.ref,c.tt,c.chk,ack_);
         -- если на документ поставили последнюю визу
		 if ack_ = 1 then
            begin  -- clear document
               savepoint pay_before;

               select
                  mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
                  datd, datp, nam_a, nam_b, nazn, id_a, id_b,
                  id_o, sign, d_rec, sos, ref_a, prty
               into
                  mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
                  datd_,datp_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
                  id_o_,sign_,d_rec_, sos_, refa_, prty_
               from oper where ref = c.ref for update nowait;
			   
               if datd_ < gl.bd - 30 then 
			      bars_error.raise_nerror('DOC','DATD_MORE_THAN_30', c.ref, to_char(datd_,'dd/mm/yy'), to_char(gl.bd,'dd/mm/yy'));
			   end if;

			   -- оплата докумнета текущей банковской датой
               gl.pay( 2, c.ref, gl.bdate);
              

               if c.tt='R01' and sos_=5 and mfob_ = gl.amfo then
                  delete from tdval where ref=c.ref;
               end if;
               
			   -- СЕП/ВПС документы
               if c.fli=1 and (c.flg=0 or c.flg=1 or c.flg=3) then
                  if sos_ = 5 then 
                     if length(trim(nvl(d_rec_,'')))>0 then
                        nazns_ := '11';
                     else
                        nazns_ := '10';
                     end if;
                     if vob_ not in (1, 2, 6, 33, 81) then
                        vob_ := 1;
                     end if;
                     data_  := to_date (to_char(datp_,'mm-dd-yyyy')||' '||to_char(sysdate,'hh24:mi'),'mm-dd-yyyy hh24:mi');
                     err_ := -1;
                     rec_ :=  0;
                     sep.in_sep(err_,rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,
                                vob_,nd_,kv_,datd_,datp_,nam_a_,nam_b_,nazn_,
                                null,nazns_,id_a_,id_b_,id_o_,refa_,0,sign_,
                                null,null,data_,d_rec_,0,c.ref);

                     if err_=0 then
                        msg_:= 'Оплачен. Передан в СЭП.';
                     else
                        rollback to pay_before;
                        msg_:= 'Невозможно передать в СЭП';
                     end if;
                     -- Set SSP flag
					 if prty_>0 then    
                        update arc_rrp set prty=prty_ where rec=rec_;
                     end if;

                  end if;
               end if;
			   bars_audit.info(title||' реф='||c.ref||' успешно оплачен процедурой доплаты');
            exception when others then  
			      rollback to pay_before;
				  bars_audit.error(title||' реф='||c.ref||' не удалось оплатить по причине ошибки: '||substr(sqlerrm||dbms_utility.format_error_backtrace(), 1, 4000));			  
                  msg_ := substr(sqlerrm,13,100);
                  pos_ := instr(msg_,chr(10));
                  if pos_ > 0 then
                     msg_ := substr(msg_,1,pos_-1);
                  end if;
            end;
         else  --ack_ = 1
            msg_:= 'Не завизирован';
         end if;
		 
		 
      else --sum_ = 0 
         msg_:= 'Нет проводок для оплаты';
      end if;
      
       l_msg := 'ref-'||c.ref||' '||msg_;      
       l_msg2 := substr(l_msg2|| chr(10) ||l_msg, 1, 4000);         

   end loop;
	 
	 if l_msg2 is not null then  
			bars_audit.info( title||l_msg2);	 
	 end if ;
 
     bars_audit.info( title||'Окончание процедуры оплаты документов по требованию');
	 
exception when others then 
    bars_audit.error( title||'Ошибка выполнения ф-ции доплаты по требованию: '|| chr(10) ||substr(sqlerrm||dbms_utility.format_error_backtrace(), 1, 4000));
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
