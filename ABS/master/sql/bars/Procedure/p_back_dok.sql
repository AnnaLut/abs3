

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BACK_DOK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BACK_DOK ***

  CREATE OR REPLACE PROCEDURE BARS.P_BACK_DOK (
    Ref_        IN  Number,
    Lev_        IN  Number default 3,
    ReasonId_   IN  Number,
    Par2_       OUT Number,
    Par3_       OUT Varchar2,
    FullBack_       Number default 1)
IS

/*
 ************************************************************************* --
                (C) BARS. Back Document
                Version 2.39 12.06/2015
 D:\SVN\Products\Bars\Modules\gl\Sql\Procedure\p_back_dok.sql

12.06.2015 Sta Для TT = 'W4Y'  - определение КД и откат его ГПК

*/

-- CCK - Обработка сторно "Погаш кредитов". Кредиты ЮЛ+ФЛ (для всех КБ)
-- BPK - для Сбербанка - запрет сторно документов БПК, отправленных в ПЦ
-- ACR_DAT - сторно документов по начислению процентов
-- NRV - Снятие оборотов по эквиваленту по непереоцениваемым счетам
-- DPT - восстановление инф-ции при сторнировании операции по взысканию штрафа
-- ORD - Сторно отдельным мемордером
-- SBER - для Сбербанка (пишем ref_back)
-- RU_IMM - для нерухомих(Ощадбанк)
-- FM - с проверкой блокированных по ФМ документов
-- ************************************************************************* --

  err        EXCEPTION;
  erm        VARCHAR2(30);
  par1       VARCHAR2(2000);

  Rec_       number;
  l_sos      number;
  l_tt       varchar2(3);
  l_vdat     date;
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
  l_sql      varchar2(512);
  l_name     varchar2(50);

BEGIN

  BEGIN
     SELECT ref, sos, tt, vdat, refl
       INTO Rec_, l_sos, l_tt, l_vdat, Refl_NOS_
       FROM oper WHERE ref=Ref_;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     -- '9251 - Документ не найден: REF=#'||Ref_ ;
     erm := 'REF_NOT_FOUND';
     par1 := to_char(Ref_);
     raise err;
  END;

  NosTt_ := GetGlobalOption('NOSTT');

  BEGIN
     SELECT count(*) INTO x FROM opldok WHERE ref=ref_ AND tt='BAK';
     IF x > 0 OR l_sos < 0 OR l_tt = 'BAK' THEN
        -- Попытка повторной операции СТОРНО реф № ref_
        erm := 'BACK_BACK';
        par1 := TO_CHAR(ref_);
        RAISE err;
     END IF;
  END;

  -- Нельзя сторнировать документ в закрытом банковском дне
  IF l_sos = 5 THEN

     -- пользователь работает в текущем банковском дне
     IF Bankdate() = Bankdate_g() THEN

        -- проверка на закрытый банковский день
        IF nvl(GetGlobalOption('RRPDAY'),0) = 0 THEN
           -- '9250 - День закрыт! Невозможно выполнить операцию!';
           erm := 'DAY_IS_CLOSED';
           raise err;
        END IF;

     -- пользователь работает в прошлом банковском дне
     ELSE

        -- проверка на закрытый банковский день
        SELECT nvl(max(nvl(stat,0)),9) INTO l_stat FROM fdat WHERE fdat=Bankdate();
        IF l_stat = 9 THEN
           -- '9250 - День закрыт! Невозможно выполнить операцию!';
           erm := 'DAY_IS_CLOSED';
           raise err;
        END IF;

        -- нельзя сторнировать оплаченный документ прошлой датой
        if Bankdate() < l_vdat then
           -- Невозможно сторнировать документ прошлой банковской датой
           erm := 'PAST_DAY';
           raise err;
        end if;
        select count(*) into i from opldok where ref = Ref_ and fdat > gl.bd;
        if i > 0 then
           -- Невозможно сторнировать документ прошлой банковской датой
           erm := 'PAST_DAY';
           raise err;
        end if;

     END IF;

  END IF;

  -- проверка на блокированный по ФМ документ
  if l_sos < 5 then
     begin
        select otm into i from fm_ref_que where ref = ref_;
     exception when no_data_found then i := 0;
     end;
     if i > 0 then
        -- ФИНАНСОВЫЙ МОНИТОРИНГ: оплата документа Ref_ приостановлена!;
        bars_error.raise_nerror('DOC', 'FM_STOPVISA', '$REF', to_char(ref_));
        raise err;
     end if;
  end if;

  IF FullBack_ = 1 THEN
     FOR c IN (SELECT distinct fdat FROM opldok WHERE ref=Ref_ AND sos=5)
     LOOP
        SELECT nvl(max(nvl(stat,0)),9) INTO l_stat FROM fdat WHERE fdat=c.fdat;
        IF l_stat = 9 THEN
           -- '9253 - Документ за закрытую банковскую дату: DAT=#'||c.fdat ;
           erm := 'DOC_CLOSED_DAY';
           par1 := to_char(c.fdat, 'dd/MM/yyyy');
           raise err;
        END IF;
     END LOOP;
  END IF;

  -- переписано с учетом БИСов
  Rec_  := null;
  FN_B_ := '';
  FOR c IN ( SELECT a.rec, a.fn_b
               FROM arc_rrp a, ( SELECT ref FROM oper
                                  START WITH ref=Ref_ CONNECT BY PRIOR refl=ref) o
              WHERE a.ref=o.ref
                FOR UPDATE OF a.BLK NOWAIT )
  LOOP
     Rec_  := c.rec;
     FN_B_ := c.fn_b;
     IF FN_B_ is null THEN
        UPDATE arc_rrp SET blk=-1 WHERE rec=Rec_ and fn_b is null;
        DELETE FROM rec_que WHERE rec=Rec_;
     ELSE
        -- '9252 -  Нельзя ИЗЪЯТЬ документ: отправлен из банка в файле #' || FN_B_ ;
        erm := 'BACK_FNB';
        par1 := FN_B_;
        raise err;
     END IF;
  END LOOP;
	--Нерухомі
  begin
   select count(*) into l_count_ref from asvo_immobile where refout=Ref_;
     if (l_count_ref>0) then
	    erm := 'BACK_IMM';
        par1 := to_char(Ref_);
        raise err;
	 end if;
	end;

  -- БПК: операция для ПЦ
  -- старый процессинг
  begin
    select f_n into l_pkk_fn from pkk_que where ref = Ref_ and sos = 1;
    if l_pkk_fn is not null then
       -- '9252 -  Нельзя ИЗЪЯТЬ документ: отправлен из банка в файле #' || l_pkk_fn ;
       erm := 'BACK_FNB';
       par1 := l_pkk_fn;
       raise err;
    end if;
  exception when no_data_found then null;
  end;
  -- новый процессинг Way4
  begin
    select f_n into l_pkk_fn from ow_pkk_que where ref = Ref_ and sos = 1;
    if l_pkk_fn is not null then
       -- '9252 -  Нельзя ИЗЪЯТЬ документ: отправлен из банка в файле #' || l_pkk_fn ;
       erm := 'BACK_FNB';
       par1 := l_pkk_fn;
       raise err;
    end if;
  exception when no_data_found then null;
  end;

  If l_TT = 'W4Y' then
     --1.операция W4Y имеет визу контролер подразделения при снятии документа с визы, откат ГПК
     --2.Документ W4Y отправленныйна ПЦ. После получении квитанции от ПЦ о невозможности проведения транзакции (недостаточность средств на ПЦ )-
     --  Документв в АБС сторнирован, откат ГПК
     EXECUTE IMMEDIATE  'begin CCK_DPK.RET_GPK (null, ' || Ref_ ||' , null );   end; ' ;   -- определение КД и откат его ГПК
  end if;



  -- восстановление инф-ции при сторнировании операции по взысканию штрафа
  DPT.revoke_penalty(ref_, l_tt);

  BEGIN
     SELECT ref INTO nRef_ FROM oper WHERE refl=Ref_ AND refl is not null;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     nRef_ := null;
  END;
  IF nRef_ IS NOT NULL AND l_tt <> NosTt_ THEN
     -- '9254 -  Нельзя ИЗЪЯТЬ дочерний документ REF=#'||Ref_ ;
     erm := 'BACK_REFL';
     par1 := to_char(Ref_);
     raise err;
  END IF;

  BEGIN
     SELECT reason INTO Reason_ FROM bp_reason WHERE id=ReasonId_;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     Reason_ := 'Сторно документа';
  END;
  UPDATE operw SET value=Reason_ WHERE ref=Ref_ AND tag='BACKR';
  IF SQL%ROWCOUNT=0 THEN
     INSERT INTO operw(ref, tag, value)
     VALUES (Ref_, 'BACKR', Reason_);
  END IF;

 -- Повернення статусу пакета ЦП
  l_name:='CP_DEACTIVE';
  begin
    for r in (select object_name from sys.all_objects  where owner='BARS' and object_name = l_name)
    loop
    l_sql:='begin BARS.'||l_name||'(:ref,:tt); end;';
      begin
      EXECUTE IMMEDIATE l_sql USING ref_,l_tt;
      --logger.info('P_BACK_DOK '||l_name||' executed ref='||ref_);
      exception when others then NULL;
      logger.info('P_BACK_DOK '||l_name||' not exists or ???');
      END;
    end loop;
  end;

  -- вычисляем группу контроля для сторнирования
  begin
     select to_number(val) into BackVisa_
       from params
      where par='BACKVISA';
  exception when no_data_found then
     BackVisa_ := 0;
  end;
  chk.PUT_NOS(Ref_,BackVisa_);

-- Откат начисленных %%
  begin
      select acc, id, int_date
        into l_acc, l_id, l_intdate
        from acr_docs
       where int_ref = ref_;
      begin
         acrn.acr_back(l_acc, l_id, l_intdate);
      exception when others then
         erm := 'BACK_INT';
         par1 := to_char(Ref_);
         raise err;
      end;
      RETURN;
  exception
      when NO_DATA_FOUND then null;
  end;
  -- Сторно операции NOS
  IF l_tt = NosTt_ THEN
     -- для плановых операций CVV (CVV-дочерняя, NOS-главная, у NOS refl=Ref_CVV)
     if Refl_NOS_ is not null then
        if l_sos <> 5 Then
           -- у дочернего CVV надо убрать связку, доп. рекв. и вернуть на подбор КС
           update oper set refl=null where ref=Ref_;
           update operw set value='0' where tag='NOS_A' and ref=Refl_NOS_;
           delete from operw where tag='NOS_B' and ref=Refl_NOS_;
           UPDATE oper SET chk=substr(chk, 1, length(rtrim(chk))-6) WHERE ref=Refl_NOS_;
           DELETE FROM oper_visa WHERE sqnc = (SELECT max(sqnc) FROM oper_visa WHERE ref=Refl_NOS_);
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
  END IF;

  RefH_  := Ref_;

  LOOP
     BEGIN
        SELECT refl INTO RefL_ FROM oper WHERE ref=RefH_;
     EXCEPTION WHEN NO_DATA_FOUND THEN
        RefL_ := null;
     END;

     -- Обработка сторно "Погаш кредитов"
     IF lev_>=5 THEN
        p_back_CCK(refH_,lev_);  -- уст сч.8999*LIM pap=3
     END IF;

   -- Конец обработки сторно "Погаш кредитов"

     -- Снятие оборотов по эквиваленту по непереоцениваемым счетам
     IF lev_>=5 THEN
        FOR x IN (SELECT a.acc,o.fdat,o.sq FROM accounts a,opldok o WHERE o.ref=refH_ AND a.pos=2 AND o.acc=a.acc AND o.sos=5)
        LOOP
           UPDATE saldob SET dos=dos-x.sq,kos=kos-x.sq WHERE acc=x.acc AND fdat=x.fdat;
        END LOOP;
     END IF;


-- ************************************************************************* --
     gl.bck(RefH_, Lev_);
-- ************************************************************************* --

     DELETE FROM ref_que WHERE ref=RefH_ ;

     BEGIN
        SELECT count(*) INTO l_sos FROM opldok WHERE ref = refH_ AND tt='BAK';

        IF l_sos > 0 THEN
           -- Окремий сторно ордер
           gl.ref (refN_);

           INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,datd,
                  nam_a,nlsa,mfoa,nam_b,nlsb,mfob,kv,s,kv2,s2,id_a,id_b,nazn,userid,sos)
           SELECT refN_,'BAK',6,refN_,1-dk,SYSDATE,gl.bDATE,gl.bDATE,
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

EXCEPTION
  WHEN err THEN
    bars_error.raise_nerror('DOC', erm, par1);
END p_back_dok;
/
show err;

PROMPT *** Create  grants  P_BACK_DOK ***
grant EXECUTE                                                                on P_BACK_DOK      to ABS_ADMIN;
grant EXECUTE                                                                on P_BACK_DOK      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_BACK_DOK      to CHCK;
grant EXECUTE                                                                on P_BACK_DOK      to PYOD001;
grant EXECUTE                                                                on P_BACK_DOK      to START1;
grant EXECUTE                                                                on P_BACK_DOK      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BACK_DOK.sql =========*** End **
PROMPT ===================================================================================== 
