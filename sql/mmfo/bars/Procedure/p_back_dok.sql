
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/procedure/p_back_dok.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  create or replace procedure bars.p_back_dok (
    ref_          in  number,
    lev_          in  number default 3,
    reasonid_     in  number,
    par2_         out number,
    par3_         out varchar2,
    fullback_         number default 1) 
is
   -----------------------------------
   -- Version 2.4 21/03/2019
   -----------------------------------

  Rec_       number;
  l_sos      number;
  l_tt       varchar2(3);
  l_vdat     date;
  l_fdat     date;
  l_otm      varchar2(1);
  l_stat     number;
  FN_B_      varchar2(12);
  Level_     number;
  RefH_      number;
  RefL_      number;
  Reason_    varchar2(160);
  nRef_      number := null;
  nAccRef_   number;
  BackVisa_  integer;
  NosTt_     varchar2(3);
  Refl_NOS_  number := null;
  l_acc      number(38);
  l_id       number(1);
  l_intdate  date;
  refN_      number;
  x          smallint;
  l_pkk_fn   varchar2(100);
  tt_        varchar2(3);
  i          number;
  l_count_ref number;
  l_fcode    varchar2(100); 
  l_trace    varchar2(1000):= $$plsql_unit ||': ';

BEGIN
   
   bars_audit.info(l_trace||'Старт сторно документа реф='||Ref_||', уровень='||Lev_||', причина='||ReasonId_||', fullback='||FullBack_||', par2='||Par2_||', par3='||Par3_);
 
  begin
     -- флаг операции, которая позволяет красное сальдо
     
     select value into l_fcode from tts_flags where tt = 'BAK' and fcode = 38;
     
     --select '-'||value||'-' from tts_flags where tt = 'BAK' and fcode = 38;
     
     if l_fcode = '1' then
        bars_error.raise_nerror('DOC', 'BAK_CAN_MAKE_REDSALDO', Ref_);
     end if;   
   exception when no_data_found then null;
   end;
   
   begin
     select ref, sos, tt, vdat, refl
       into rec_, l_sos, l_tt, l_vdat, refl_nos_
       from oper where ref = ref_;
	   
   exception when no_data_found then
      bars_error.raise_nerror('DOC', 'REF_NOT_FOUND', Ref_ );
   end;

   
   -- Проверка повторной операции СТОРНО реф № ref_
   begin
      select count(*) into x from opldok where ref = ref_ and tt = 'BAK';
      if x > 0 or l_sos < 0 or l_tt = 'BAK' then
         bars_error.raise_nerror('DOC', 'HAS_BEEN_BACKED_YET', Ref_ );
      end if;
   enD;


   -- Нельзя сторнировать документ в закрытом банковском дне
   IF l_sos = 5 THEN
      -- пользователь работает в текущем банковском дне
      if bankdate() = bankdate_g() then
         -- проверка на закрытый банковский день
         IF nvl(branch_attribute_utl.get_value('/','RRPDAY') ,0) = 0 THEN
            bars_error.raise_nerror('DOC', 'BAK_IN_CLOSED_DAY', Ref_, to_char(bankdate(), 'dd/mm/yyyy') );
         END IF;

      -- пользователь работает в прошлом банковском дне
      else
        -- проверка на закрытый банковский день
        select nvl(max(nvl(stat,0)),9) into l_stat from fdat where fdat = bankdate();
        IF l_stat = 9 THEN
           bars_error.raise_nerror('DOC', 'BAK_IN_CLOSED_DAY', Ref_,to_char(bankdate(), 'dd/mm/yyyy') );
        END IF;

        -- нельзя сторнировать оплаченный документ прошлой датой
        if Bankdate() < l_vdat then
           bars_error.raise_nerror('DOC', 'BAK_IN_PAST', Ref_, to_char(bankdate(), 'dd/mm/yyyy') );
        end if;

		
        select count(*), max(fdat) 
		  into i, l_fdat 
		  from opldok where ref = Ref_ and fdat > gl.bd;
        if i > 0 then
           -- Невозможно сторнировать документ прошлой банковской датой
           bars_error.raise_nerror('DOC', 'BAK_IN_PAST', Ref_, to_char(l_fdat, 'dd/mm/yyyy') );
        end if;
      end if;
   end if;


    -- проверка на блокированный по ФМ документ
    p_fm_intdoccheck(ref_);

    if l_sos < 5 then
       begin
          select otm into i from fm_ref_que where ref = ref_;
       exception when no_data_found then i := 0;
       end;
       if i > 0 then
          bars_error.raise_nerror('DOC', 'FM_STOPVISA',  to_char(ref_));
       end if;
    end if;

    -- непонятный повторяющийся код
    if fullback_ = 1 then
       for c in (select distinct fdat from opldok where ref=ref_ and sos=5)
       loop
          select nvl(max(nvl(stat,0)),9) into l_stat from fdat where fdat=c.fdat;
          if l_stat = 9 then
             bars_error.raise_nerror('DOC', 'BAK_IN_CLOSED_DAY', Ref_,to_char(c.fdat, 'dd/mm/yyyy') );             
          end if;
       end loop;
    end if;

    
	-- Нельзя сторнировать СЕП/ВПС документ, если он уже отобран в файл.
    rec_  := null;
    fn_b_ := '';
    for c in ( select a.rec, a.fn_b
               from arc_rrp a, ( select ref from oper
                                  start with ref = ref_ connect by prior refl=ref) o
              where a.ref=o.ref
                for update of a.blk, a.fn_b nowait )
    loop
       rec_  := c.rec;
       fn_b_ := c.fn_b;
       if fn_b_ is null then
          update arc_rrp set blk=-1 where rec=rec_ and fn_b is null;
          delete from rec_que where rec=rec_;
       else
          bars_error.raise_nerror('DOC', 'BAK_SEP_IN_FILE', Ref_, fn_b_);          
       end if;
    end loop;


    --Невозможно сторнировать нерухомі
    begin
       select count(*) into l_count_ref from asvo_immobile where refout=Ref_;
       if (l_count_ref > 0) then
          bars_error.raise_nerror('DOC', 'BAK_IMMOBILE_DOC', Ref_);         
       end if;
    end;

	-- невозможно сторнировать документ, который уже ушел в депозитарий НБУ
	begin
       select fna into fn_b_ from dcp_p where ref=ref_ ;
    exception when no_data_found then
       fn_b_ := '' ;
    end;
    if fn_b_ is not null then
       bars_error.raise_nerror('DOC', 'BAK_NBU_DCP_DOC', Ref_, fn_b_ );             
    END IF;

    
    -- новый процессинг Way4
    begin
       select f_n into l_pkk_fn from ow_pkk_que where ref = Ref_ and sos = 1;
       if l_pkk_fn is not null then
          bars_error.raise_nerror('DOC', 'BAK_PC_DOC', Ref_, l_pkk_fn );          
       end if;
    exception when no_data_found then null;
    end;


    -- восстановление инф-ции при сторнировании операции по взысканию штрафа
    DPT.revoke_penalty(ref_, l_tt);

  
    -- Проверка на изъятие дочерноего документа
    begin
       select ref into nref_ from oper where refl=ref_ and refl is not null;
    exception when no_data_found then
       nref_ := null;
    end;
    NosTt_ := branch_attribute_utl.get_value('/','NOSTT');
    if nref_ is not null and l_tt <> nostt_ then
       bars_error.raise_nerror('DOC', 'BAK_CHILD_DOC', Ref_, nref_ );
    end if;


	begin
       select reason into reason_ from bp_reason where id=reasonid_;
    exception when no_data_found then
       Reason_ := 'Сторно документа';
    end;

    update operw set value = reason_ where ref = ref_ and tag='BACKR';
    if sql%rowcount=0 then
       insert into operw(ref, tag, value) values (Ref_, 'BACKR', Reason_);
    end if;

    -- Повернення статусу пакета ЦП
	begin 
	    bars.cp_deactive(ref_,l_tt); 
	exception when others then 
       bars_error.raise_nerror('DOC', 'BAK_CPDEACTIVATE_ERROR', Ref_,  dbms_utility.format_error_stack()||chr(13)||chr(10)||dbms_utility.format_error_backtrace() );       
	end;   

 

    -- вычисляем группу контроля для сторнирования
    BackVisa_ := nvl(to_number(branch_attribute_utl.get_value('/','BACKVISA')),0);
  
    chk.PUT_NOS(Ref_,BackVisa_);


    -- Откат начисленных %% (int_reconings)
    begin 
	   interest_utl.on_interest_document_revert(ref_);
	exception when others then
	   bars_error.raise_nerror('DOC', 'BAK_INTRECONINGS_ERROR', Ref_,  dbms_utility.format_error_stack()||chr(13)||chr(10)||dbms_utility.format_error_backtrace());
	end;
	
	   
    
	-- Откат начисленных %% (acr_docs)
	begin
      select acc, id, int_date
        into l_acc, l_id, l_intdate
        from acr_docs
       where int_ref = ref_;
      begin
         bars.acrn.acr_back(l_acc, l_id, l_intdate);
      exception when others then
         bars_error.raise_nerror('DOC', 'BAK_ACRDOCS_ERROR', Ref_,  dbms_utility.format_error_stack()||chr(13)||chr(10)||dbms_utility.format_error_backtrace());         
      end;
      return;
    exception
       when no_data_found then null;
    end;

    -- Сторно операции NOS
    if l_tt = nostt_ then
       -- для плановых операций CVV (CVV-дочерняя, NOS-главная, у NOS refl=Ref_CVV)
       if Refl_NOS_ is not null then
          if l_sos <> 5 Then
             -- у дочернего CVV надо убрать связку, доп. рекв. и вернуть на подбор КС
             update oper set refl=null where ref=Ref_;
             update operw set value='0' where tag='NOS_A' and ref=Refl_NOS_;
             delete from operw where tag='NOS_B' and ref=Refl_NOS_;
             update oper set chk=substr(chk, 1, length(rtrim(chk))-6) where ref=refl_nos_;
             delete from oper_visa where sqnc = (select max(sqnc) from oper_visa where ref=refl_nos_);
           end if;
       else
          begin
             -- для фактич. CVV (CVV-главная, у CVV refl=Ref_NOS_)
             select ref into Refl_NOS_ from oper where refl=Ref_;
             update oper set refl=null where ref=Refl_NOS_;
             update operw set value='0' where tag='NOS_A' and ref=Refl_NOS_;
             delete from operw where tag='NOS_B' and ref=Refl_NOS_;
          exception when no_data_found then null;
          end;
       end if;
    end if;

    
	
	RefH_  := Ref_;
    
	-- Выполнение цыкла сторно для докумнета и его связанных
	loop
       begin
          select refl into refl_ from oper where ref = refh_;
       exception when no_data_found then
          refl_ := null;
       end;

       -- Обработка сторно "Погаш кредитов"
       if lev_>= 5 then
          p_back_cck(refh_,lev_);  -- уст сч.8999*lim pap=3
       end if;

       

       -- Снятие оборотов по эквиваленту по непереоцениваемым счетам
       if lev_ >= 5 then
          for x in (select a.acc,o.fdat,o.sq from accounts a,opldok o where o.ref=refh_ and a.pos=2 and o.acc=a.acc and o.sos=5)
          loop
             update saldob set dos=dos-x.sq,kos=kos-x.sq where acc=x.acc and fdat=x.fdat;
          end loop;
       end if;  

       -- выполнение сторно проводки
       begin 
          gl.bck(RefH_, Lev_);
       exception when others then 
          if sqlerrm like '%\9301 - Broken limit on account%' then 
             bars_error.raise_nerror('DOC', 'BAK_BROKEN_LIMIT', Ref_,  substr(sqlerrm,instr(sqlerrm,'#'), 20) );         
          else raise;
          end if;    
       end;



       delete from ref_que where ref=refh_ ;

       begin
        select count(*) into l_sos from opldok where ref = refh_ and tt = 'BAK';

        IF l_sos > 0 THEN
           -- Окремий сторно ордер
           gl.ref (refN_);

           INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,datd,
                  nam_a,nlsa,mfoa,nam_b,nlsb,mfob,kv,s,kv2,s2,id_a,id_b,nazn,userid,sos)
           SELECT refN_,'BAK',6,substr(refN_,1,10),1-dk,SYSDATE,gl.bDATE,gl.bDATE,
                  nam_a,(CASE WHEN mfoa=gl.aMFO THEN nlsa ELSE NULL END),gl.aMFO,
                  nam_b,(CASE WHEN mfob=gl.aMFO THEN nlsb ELSE NULL END),gl.aMFO,
                  kv,s,kv2,s2,id_a,id_b,
                 'Сторно документу реф.№ '||refH_||','||reason_,gl.aUID,5
             FROM oper WHERE ref=refH_;

           UPDATE opldok SET ref=refN_ WHERE ref=refH_ AND tt='BAK';
 -- COBUSUPABS-6165
             begin
                insert into operw (ref, tag, value)
                values (refN_, 'REF92', refH_);
             exception when dup_val_on_index then
                NULL;
             end;
        END IF;
     END;

     begin
        insert into ref_back (ref, dt)
        values (refH_, gl.bdate);
        if refH_ <> refN_ then
           insert into ref_back (ref, dt)
           values (refN_, gl.bdate);
        end if;
     exception when others then null;
     end;


     IF RefL_ is null THEN
        EXIT;
     END IF;

     RefH_ := RefL_;

  END LOOP;


  -- удаляем в конце, т.к. gl.bck делает обороты и срабатывает триггер
  -- на accounts на вставку в pkk_que
  delete from pkk_que where ref = Ref_;
  delete from ow_pkk_que where ref = Ref_;
  update nlk_ref n
    set n.ref2 = null,
        n.ref2_state= null
    where n.ref2 = ref_;

END p_back_dok;
/
 show err;
 
PROMPT *** Create  grants  P_BACK_DOK ***
grant EXECUTE                                                                on P_BACK_DOK      to ABS_ADMIN;
grant EXECUTE                                                                on P_BACK_DOK      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_BACK_DOK      to CHCK;
grant EXECUTE                                                                on P_BACK_DOK      to INSPECTOR;
grant EXECUTE                                                                on P_BACK_DOK      to PYOD001;
grant EXECUTE                                                                on P_BACK_DOK      to START1;
grant EXECUTE                                                                on P_BACK_DOK      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/procedure/p_back_dok.sql =========*** End **
 PROMPT ===================================================================================== 
 
