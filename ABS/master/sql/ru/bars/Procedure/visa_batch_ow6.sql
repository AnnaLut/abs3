

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/VISA_BATCH_OW6.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure VISA_BATCH_OW6 ***

  CREATE OR REPLACE PROCEDURE BARS.VISA_BATCH_OW6 (
  grp_ number,
  cnt_ number) is
------------------------------
-- Визирование операций OW6 --
------------------------------
procedure put_ack0(ref_ number) as
  sum_   number;
  ack_   number;
  tt_    char(3);
  chk_   varchar2(80);
  hex_   varchar2(6);
  pay_er exception;
  pragma exception_init(pay_er, -20203);
  pos_   number;
  msg_   varchar2(100);
  dat_   date;
  fli_   number;
  flg_   number;
  refl_  number;
  refa_  varchar2(9);
  prty_  number;
  sos_   number;
  err_   number;    -- Return code
  rec_   number;    -- Record number
  mfoa_  varchar2(12);   -- Sender's MFOs
  nlsa_  varchar2(15);   -- Sender's account number
  mfob_  varchar2(12);   -- Destination MFO
  nlsb_  varchar2(15);   -- Target account number
  dk_    number;         -- Debet/Credit code
  s_     decimal(24);    -- Amount
  vob_   number;         -- Document type
  nd_    varchar2(10);   -- Document number
  kv_    number;         -- Currency code
  datd_  date;           -- Document date
  datp_  date;           -- Posting date
  nam_a_  varchar2(38);  -- Sender's customer name
  nam_b_  varchar2(38);  -- Target customer name
  nazn_   varchar(160);  -- Narrative
  nazns_ char(2);        -- Narrative contens type
  id_a_  varchar2(14);   -- Sender's customer identifier
  id_b_  varchar2(14);   -- Target's customer identifier
  id_o_  varchar2(6);    -- Teller identifier
  sign_  raw(128);       -- Signature
  data_  date;           -- Input file date/time
  d_rec_ varchar2(80);   -- Additional parameters
  L_U_ID number;

procedure to_log (ref_ number, msg_ varchar2, dat_ date) is
      pragma autonomous_transaction;
begin
   insert into tmp_ow6_log (ref,msg,dat_msg) values (ref_, msg_, dat_);
   commit;
end;

begin
   begin
      select o.tt, o.chk, o.refl
        into   tt_, chk_, refl_
        from oper o
       where o.ref=ref_ and o.sos>=0 and o.sos<5 and o.vdat<=gl.bdate
         for update of sos nowait;
   exception
      when no_data_found then return;
   end;

  select t.fli, substr(flags,38,1)
    into fli_, flg_
    from tts t
   where t.tt= tt_;

   begin
      select sum(decode(dk,0,-s,s)) into sum_
        from opldok
       where ref = ref_ and sos < 5 and fdat <= gl.bdate;
   exception
      when no_data_found then sum_ := null;
   end;

   if sum_ = 0 then     -- Check if the document acknowleged

      begin  -- Clear document
         savepoint chk_pay_before;
         hex_:=chk.put_stmp(grp_);

         update oper set chk=rtrim(nvl(chk,''))||hex_ where ref=ref_
             returning chk into chk_;
		begin
				select ID into L_U_ID from staff$base
                                where logname = 'TECH_DA';
			exception
                          when no_data_found then L_U_ID:=20094;
		end;
         insert into oper_visa (ref, dat, userid, groupid, status)
               values (ref_, sysdate, L_U_ID, grp_,    1);
         update oper set id_o='******',
                         sign='0123',
                         ref_a=ref_
          where ref=ref_
            and ( id_o is null or
                  sign is null or
                  ref_a is null);

         chk.doc_ack ( ref_,tt_,chk_,ack_);

         if ack_ = 1 then

            gl.pay ( 2, ref_, gl.bdate);

            if fli_=1 and (flg_=0 or flg_=1 or flg_=3) then

               select mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
                      datd, datp, nam_a, nam_b, nazn, id_a, id_b,
                      id_o, sign, d_rec, sos, ref_a, prty
                 into mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
                      datd_,datp_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
                      id_o_,sign_,d_rec_, sos_, refa_, prty_
                 from oper where ref=ref_;

               if sos_ = 5 then -- Value date arrived

                  if length(trim(nvl(d_rec_,'')))>0 then
                     nazns_ := '11';
                  else
                     nazns_ := '10';
                  end if;

                  data_  := to_date (to_char(datp_,'MM-DD-YYYY')||' '||
                            to_char(sysdate,'HH24:MI'),'MM-DD-YYYY HH24:MI');

                  err_ := -1;
                  rec_ :=  0;

                  sep.in_sep(err_,rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,
                         vob_,nd_,kv_,datd_,datp_,nam_a_,nam_b_,nazn_,
                          null,nazns_,id_a_,id_b_,'******',refa_,0,'00',
                               null,null,data_,d_rec_,0,ref_);

                  if err_=0 then
                     msg_:= 'Оплачен. Передан в СЭП.';
                     if prty_>0 then    -- Set SSP flag
                         update arc_rrp set prty=prty_ where rec=rec_;
                     end if;
                  else
                     rollback to chk_pay_before;
                     msg_:= 'Невозможно передать в СЭП: Ош.'||err_;
                  end if;

               end if;
            end if;
         else
            msg_:= 'Не завизирован';
         end if; -- ack_ = 1

      exception
         when others then rollback to chk_pay_before;

         msg_ := substr(sqlerrm,13,100);
         pos_ := instr(msg_,chr(10));

         if pos_ > 0 then
            msg_ := substr(msg_,1,pos_-1);
         end if;
      end;
   else
      msg_:= 'Нет проводок для оплаты';
   end if;
   deb.trace(1,msg_,ref_);
  --to_log(ref_, msg_, sysdate);
   insert into tmp_ow6_log (ref,msg,dat_msg) values (ref_, msg_,  sysdate);
end put_ack0;

begin
 -- tuda;
  for c in (select *
              from oper
             where tt in ('OW6','P2S')
               and pdat > trunc(sysdate)-12
               and rownum <= cnt_
               and sos between 0 and 3 for update of chk nowait)
   loop
      put_ack0(c.ref);
   end loop;
 -- suda;
 commit;
end visa_batch_ow6;
/
show err;

PROMPT *** Create  grants  VISA_BATCH_OW6 ***
grant EXECUTE                                                                on VISA_BATCH_OW6  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/VISA_BATCH_OW6.sql =========*** En
PROMPT ===================================================================================== 
