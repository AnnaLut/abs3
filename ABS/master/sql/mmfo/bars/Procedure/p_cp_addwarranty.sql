

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CP_ADDWARRANTY.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CP_ADDWARRANTY ***

CREATE OR REPLACE PROCEDURE P_CP_ADDWARRANTY (p_mode    IN INT,                     -- 0-вставка, 1-изменение
                                                  p_ref     IN cp_deal.ref%type,        -- референс сделки с ЦП
                                                  p_pawn    IN CC_PAWN.pawn%type,       -- вид обеспечения                                                   |
                                                  p_kv      IN accounts.kv%type,        -- валюта                                                            | для открытия счета гарантии
                                                --p_ob22    IN accounts.ob22%type,      -- OB22                                                              |
                                                  p_CP_WAR  IN VARCHAR2,                -- параметр вида изменения гарантии при частичном погашении/продаже  |
                                                  p_rnk     IN customer.rnk%type,       -- РНК третьего лица, дающего гарантии
                                                  p_s       IN NUMBER,                  -- сумма гарантии
                                                  p_ccnd    IN pawn_acc.cc_idz%type,    -- номер договора гарантии
                                                  p_sdate   IN pawn_acc.SDATZ%type,     -- дата договора гарантии
                                                  p_nls     IN accounts.nls%type default null,     -- счет 9 класса
                                                  p_valdate IN oper.vdat%type default null) --потрібно при переводі на МСФЗ 9
IS
 /*version 4 2018/06/24*/
   /*
   Процедура открывает счет гарантии, вставляет данные в cc_accp, водит документ на оприходование гарантии на 9 класс
   */
   title   CONSTANT VARCHAR2 (50) := 'cp_addwarranty:';
   l_accs           NUMBER;
   l_nlss           NUMBER; --VARCHAR2 (15);
   l_acc            NUMBER;
   l_rnk            NUMBER;
   l_nmss           ACCOUNTS.NMS%TYPE;
   l_ref            NUMBER;
   l_nbs            VARCHAR2(4);
   l_ob22           VARCHAR2(2);
   l_id             INT;
   l_cp_id          INT;
   oo               oper%rowtype;
   oo2              oper%rowtype;
   l_refcp          NUMBER;
   l_rnk_emi        customer.rnk%type;
   l_nmk_emi        customer.nmk%type;
   l_ISIN           cp_kod.cp_id%type;
   l_kol            NUMBER;
   l_SUMBN          NUMBER;
   l_pawn_name      cc_pawn.name%type;
   l_pawn_pap       ps.pap%type;
   l_same_pawn      int := 0;

   type t_cp_warrantyrec is record (REF_    cp_deal.ref%type,
                                    PAWN    CC_PAWN.pawn%type,
                                    NLS     accounts.nls%type,
                                    KV      accounts.kv%type,
                                    acc     cc_accp.acc%type,
                                    accs    cc_accp.accs%type,
                                    S       oper.s%type,
                                    IDZ     pawn_acc.idz%type,
                                    CC_IDZ  pawn_acc.cc_idz%type,
                                    SDATZ   DATE,
                                    RNK     customer.rnk%type,
                                    CP_WAR  varchar2(200));
   l_cp_warrantyset     t_cp_warrantyrec;

 procedure check_params (   p_ref     IN cp_deal.ref%type,      -- проверяется
                            p_pawn    IN CC_PAWN.pawn%type,     -- проверяется
                            p_kv      IN accounts.kv%type,
                            p_ob22    IN accounts.ob22%type,    -- НЕ проверяется
                            p_CP_WAR  IN VARCHAR2,              -- проверяется
                            p_rnk     IN customer.rnk%type,     -- проверяется
                            p_s       IN NUMBER,
                            p_ccnd    IN pawn_acc.cc_idz%type,
                            p_sdate   IN pawn_acc.SDATZ%type)
 is
  begin
    -- проверка на референс договора
    IF p_ref IS NOT NULL
        THEN
            BEGIN
               SELECT REF, ID
                 INTO l_refcp, l_cp_id
                 FROM cp_deal
                WHERE REF = p_ref AND dazs IS NULL;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN raise_application_error (-20001,'ERR:  Вказаний референс пакету ЦП не існує або пакет закритий',TRUE);
            END;
        ELSE
         l_refcp := to_number(pul.Get_Mas_Ini_Val('WARR_REF'));
         if l_refcp is null then raise_application_error(-20001, 'ERR:  Не вказано референс пакету ЦП', TRUE); end if;
    END IF;

   -- проверка на балансовый счет из p_pawn
    IF p_pawn IS NOT NULL
    THEN
        BEGIN
           SELECT cc_pawn.nbsz, cc_pawn.name, ps.pap
             INTO l_nbs, l_pawn_name, l_pawn_pap
             FROM cc_pawn, ps
            WHERE cc_pawn.nbsz = ps.nbs
              AND PS.D_CLOSE is null
              AND cc_pawn.pawn = p_pawn;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN raise_application_error (-20001,'ERR:  Вказаний вид забезпечення не існує',TRUE);
        END;
    ELSE raise_application_error (-20001,'ERR:  Вид забезпечення вказан',TRUE);
    END IF;

   -- проверка на наличие ОБ22 в справочнике, для указанного балансового счета
   /*
   IF l_nbs IS NOT NULL
    THEN
        BEGIN
        SELECT ob22
          INTO l_ob22
          FROM SB_OB22
         WHERE     r020 = l_nbs
               AND (d_close >= gl.bd OR d_close IS NULL)
               AND d_open <= gl.bd and rownum = 1;
        EXCEPTION
        WHEN NO_DATA_FOUND
        THEN raise_application_error (-20001,'ERR:  Вказаний OB22 не описаний для бал.рах'|| l_nbs, TRUE);
        END;
    ELSE raise_application_error (-20001,'ERR:  OB22 не вказано',TRUE);
    END IF;
    */

    -- проверка РНК клиента
    IF p_rnk IS NOT NULL
    THEN
        BEGIN
        SELECT rnk
          INTO l_rnk
          FROM customer
         WHERE rnk = p_rnk
           AND date_off is null;
        EXCEPTION
        WHEN NO_DATA_FOUND
        THEN raise_application_error (-20001,'ERR:  Вказаний РНК клієнта не існує або закритий'|| l_rnk, TRUE);
        END;
    ELSE raise_application_error (-20001,'ERR:  РНК клієнта не вказано',TRUE);
    END IF;

    --проверка на корректность заполнения p_CP_WAR
    IF p_CP_WAR IS NOT NULL
    THEN
        BEGIN
        SELECT id
          INTO l_id
          FROM cp_warranty_method
         WHERE id = p_CP_WAR
           AND DATE_OFF is null;
        EXCEPTION
        WHEN NO_DATA_FOUND
        THEN raise_application_error (-20001,'ERR:  Вказаний метод не існує або закритий'|| p_CP_WAR, TRUE);
        END;
    ELSE raise_application_error (-20001,'ERR:  Метод зміни гарантії не вказано',TRUE);
    END IF;

    -- проверка АСС пакета ЦБ
    begin
     select acc
     into l_acc
     from cp_deal
     where ref = l_refcp;
    exception
         when no_data_found
         then raise_application_error (-20001,'ERR:  Номер рахунку пакета ЦП не знайдено' || to_char(l_refcp), TRUE);
    end;
  end check_params;
  PROCEDURE prep_doc (p_oo    IN OUT oper%ROWTYPE,
                    p_kv    IN     accounts.kv%TYPE,
                    p_acc   IN     accounts.acc%TYPE DEFAULT NULL,
                    p_nls   IN     accounts.nls%TYPE DEFAULT NULL)
  is
  begin
   -- собираем реквизиты проводки
       p_oo.tt    := 'CPG';
       p_oo.vob   := 6;
       p_oo.pdat  := gl.bd;
       p_oo.vdat  := nvl(p_valdate, p_oo.pdat);

       p_oo.kv    := p_kv;
       p_oo.kv2   := p_kv;

       p_oo.sk    := null;
       p_oo.datd  := p_oo.pdat;
       p_oo.datp  := p_oo.pdat;

       begin
          SELECT Substr(tobopack.GetTOBOParam('NLS_9900'),1,15),getglobaloption ('MFO')
            into p_oo.nlsa, p_oo.mfoa
            from dual;
       exception
            when no_data_found
            then raise_application_error (-20001,'ERR:  Номер рахунку .GetTOBOParam(NLS_9900) не знайдено', TRUE);
       end;

       p_oo.mfob := p_oo.mfoa;
       begin
          select a.nms, c.okpo, substr(C.NMK,1,38)
            into p_oo.nam_a, p_oo.id_a, p_oo.nam_a
            from accounts a, customer c
           where a.rnk = c.rnk
             and a.nls = p_oo.nlsa
             and a.kv = p_kv;
       exception
            when no_data_found
            then raise_application_error (-20001,'ERR:  Реквізити рахунку '||p_oo.nlsa || ' не знайдені для кода валюти ' || to_char(p_kv), TRUE);
       end;

       if p_acc is not null
       then
           begin
              select c.okpo, a.nls,substr(C.NMK,1,38)
                into p_oo.id_b, p_oo.nlsb, p_oo.nam_b
                from accounts a, customer c
               where a.rnk = c.rnk
                 and a.acc = p_acc--l_accs
                 and a.kv = p_kv;
           exception
                when no_data_found
                then raise_application_error (-20001,'ERR:  Реквізити рахунку '|| p_oo.nlsb || ' не знайдені для кода валюти ' || to_char(p_kv), TRUE);
           end;
       end if;

       if p_nls is not null
       then
           begin
              select c.okpo, a.nls,substr(C.NMK,1,38)
                into p_oo.id_b, p_oo.nlsb, p_oo.nam_b
                from accounts a, customer c
               where a.rnk = c.rnk
                 and a.nls = p_nls
                 and a.kv = p_kv;
           exception
                when no_data_found
                then raise_application_error (-20001,'ERR:  Реквізити рахунку '|| p_oo.nlsb || ' не знайдені для кода валюти ' || to_char(p_kv), TRUE);
           end;
       end if;
       p_oo.d_rec := null;
       p_oo.id_o  := null;
       p_oo.sign  := null;
       p_oo.sos   := 1;
       p_oo.prty  := null;
       p_oo.USERID:= null;
  end prep_doc;

  function pay_doc (p_oo IN oper%rowtype)
  return number
  is
   l_ref    number;
  begin
    gl.ref(l_ref);
    GL.IN_DOC3
    (  ref_    => l_ref,
       tt_     => p_oo.tt,
       vob_    => p_oo.vob,
       nd_     => case p_valdate when null then substr(l_ref, 1, 10) else 'FRS9$'||substr(l_ref, -5) end,
       pdat_   => p_oo.pdat,
       vdat_   => p_oo.vdat,
       dk_     => p_oo.dk,
       kv_     => p_oo.kv,
       s_      => p_oo.s,
       kv2_    => p_oo.kv2,
       s2_     => p_oo.s2,
       sk_     => p_oo.sk,
       data_   => p_oo.datd,
       datp_   => p_oo.datp,
       nam_a_  => p_oo.nam_a,
       nlsa_   => p_oo.nlsa,
       mfoa_   => p_oo.mfoa,
       nam_b_  => p_oo.nam_b,
       nlsb_   => p_oo.nlsb,
       mfob_   => p_oo.mfob,
       nazn_   => p_oo.nazn,
       d_rec_  => p_oo.d_rec,
       id_a_   => p_oo.id_a,
       id_b_   => p_oo.id_b,
       id_o_   => p_oo.id_o,
       sign_   => p_oo.sign,
       sos_    => p_oo.sos,
       prty_   => p_oo.prty,
       uid_    => p_oo.userid);

    paytt(      flg_ => null,       -- флаг оплаты
                ref_ => l_ref,      -- референция
               datv_ => p_oo.vdat,  -- дата валютировния
                 tt_ => p_oo.tt,    -- тип транзакции
                dk0_ => p_oo.dk,    -- признак дебет-кредит
                kva_ => p_oo.kv,    -- код валюты А
               nls1_ => p_oo.nlsa,  -- номер счета А
                 sa_ => p_oo.s,     -- сумма в валюте А
                kvb_ => p_oo.kv2,   -- код валюты Б
               nls2_ => p_oo.nlsb,  -- номер счета Б
                 sb_ => p_oo.s2     -- сумма в валюте Б
                 );

  return l_ref;
  end;

BEGIN
 bars_audit.trace('%s Start', title);

  -- проверка на референс договора
    IF p_ref IS NOT NULL
        THEN
            BEGIN
               SELECT REF, ID
                 INTO l_refcp, l_cp_id
                 FROM cp_deal
                WHERE REF = p_ref AND dazs IS NULL;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN raise_application_error (-20001,'ERR:  Вказаний референс пакету ЦП не існує або пакет закритий',TRUE);
            END;
        ELSE
         l_refcp := to_number(pul.Get_Mas_Ini_Val('WARR_REF'));
         if l_refcp is null
         then raise_application_error(-20001, 'ERR:  Не вказано референс пакету ЦП', TRUE);
         else
            BEGIN
               SELECT cd.ID, -a.ostb
                 INTO l_cp_id, l_SUMBN
                 FROM cp_deal cd, accounts a
                WHERE cd.acc = a.acc
                  AND cd.REF = l_refcp AND cd.dazs IS NULL;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN raise_application_error (-20001,'ERR:  Вказаний референс пакету ЦП не існує або пакет закритий',TRUE);
            END;
         end if;
    END IF;
   -- счет 9-го класса должен быть открыт в РНК эмитента ЦБ.
    BEGIN
       SELECT ck.rnk, c.nmk, ck.cp_id, l_sumbn/ck.CENA
         INTO l_rnk_emi, l_nmk_emi, l_ISIN, l_kol
         FROM cp_kod ck, customer c
        WHERE c.rnk = ck.rnk
          AND ck.id = l_cp_id;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN raise_application_error ( -20001, 'ERR:  RNK емітента не визначено в cp_kod.rnk', TRUE);
    END;

    bars_audit.trace('%s l_cp_id = %s', title, to_char(l_cp_id));

 IF NVL(p_mode,0) = 0 -- Добавление гарантии к сделке
  THEN
   -- 1. рассчитать номер счета гарантии и открыть счет
   begin
    check_params ( p_ref     =>    p_ref,     -- проверяется
                   p_pawn    =>    p_pawn,    -- проверяется
                   p_kv      =>    p_kv,
                   p_ob22    =>    null,--p_ob22,    -- проверяется
                   p_CP_WAR  =>    p_CP_WAR,  -- проверяется
                   p_rnk     =>    p_rnk,     -- проверяется
                   p_s       =>    p_s,
                   p_ccnd    =>    p_ccnd,
                   p_sdate   =>    p_sdate);

      l_nlss := BARS.F_NEWNLS2( NULL , 'ZAL',l_nbs, l_rnk_emi, l_refcp);

      bars_audit.info(to_char(l_nlss));
      if l_nlss is not null
      then
          --?«Гарантия КМУ по облигациям НАК Нафтогаз, исин…»
          l_nmss := SUBSTR(substr(l_pawn_name, INSTR(l_pawn_name,'.')+1,70)
                    ||' по обл. '|| l_ISIN
                    ||','|| to_char(l_refcp),1,70);

          Op_Reg(2      , -- счет залога
              null      , -- номера договора нет для ценных бумаг
              p_pawn    , -- вид залога
              1         , -- место нахождения залога (1 у заставодавця)
              l_refcp   , -- номер договора залога (пишем ref сделки ценной бумаги)
              l_rnk_emi , -- РНК эмитента
              l_nlss    , -- номер счета,
              p_kv      , -- код валюты (980),
              l_nmss    , -- Наименование счета
              'ZAL'     , -- Тип счета
              user_id   , -- исполнитель
              l_accs);    -- acc счета
      end if;
   end;

   -- 2. вставить записи в таблицы cp_accp, cc_accp
   IF l_acc IS NOT NULL AND l_accs IS NOT NULL
   THEN
        BEGIN
           INSERT INTO cp_accounts (cp_ref, cp_acctype, cp_acc)
              SELECT l_refcp, 'GAR', l_accs FROM DUAL;
        EXCEPTION
           WHEN DUP_VAL_ON_INDEX
           THEN null; -- счет уже привязан к сделке
        END;

        BEGIN
           INSERT INTO cc_accp (ACCS, ACC, RNK, ND)
              SELECT l_acc, l_accs, p_rnk, l_refcp FROM DUAL;
        EXCEPTION
           WHEN DUP_VAL_ON_INDEX
           THEN BARS_AUDIT.TRACE ('%s Для сделки ref= %s ужесуществует сделка с указанными параметрами',title,TO_CHAR (p_ref));
        END;

        begin
         insert into accountsw(ACC, TAG, VALUE)
         select l_accs, 'CP_WARR', p_CP_WAR from dual;
        exception
             when dup_val_on_index
             then update accountsw
                     set value = p_cp_war
                   where acc = l_accs
                     and tag = 'CP_WARR';
        end;

        begin
         insert into accountsw(ACC, TAG, VALUE)
         select l_accs, 'CP_W_ND', p_ccnd from dual;
        exception
             when dup_val_on_index
             then update accountsw
                     set value = p_ccnd
                   where acc = l_accs
                     and tag = 'CP_W_ND';
        end;

        begin
         insert into accountsw(ACC, TAG, VALUE)
         select l_accs, 'CP_W_DAT', p_sdate from dual;
        exception
             when dup_val_on_index
             then update accountsw
                     set value = p_sdate
                   where acc = l_accs
                     and tag = 'CP_W_DAT';
        end;

   ELSE raise_application_error (-20001,'ERR:  Номер рахунку пакета ЦП або рахунку гарантії не знайдено', TRUE);
   END IF;

   prep_doc(oo, p_kv, l_accs, null);
   oo.dk := case when l_pawn_pap = 1 then 0 else 1 end;
   oo.s     := 100*p_s;
   oo.s2    := 100*p_s;
      --  «Оприбуткування вартості забезпечення по облігаціям …. (назва ємітента),UA4000…., пакет…, договір…
   oo.nazn  := 'Оприбуткування вартості забезп. по обл. '|| l_nmk_emi
                ||','||l_ISIN
                --||', пакет №'||l_refcp
                --||','||to_char(l_kol)||'шт.'
                ||' за дог.№' || p_ccnd
                || ' від ' ||to_char(p_sdate,'dd.mm.yyyy');

   --3. Сформировать документ по оприходованию гарантии на открытый счет
   l_ref := pay_doc(oo);
   if (l_ref is not null)
   then
    begin
     insert into cp_payments (cp_ref, op_ref)
     values (l_refcp, l_ref);
    exception when dup_val_on_index then null;
    end;
   end if;
   bars_audit.trace('%s l_cp_id = %s', title, to_char(l_cp_id));

   --4. зафиксировать операцию в архиве сделок с номером 5 (Приход гарантии по сделке ЦБ)
   insert into cp_arch (REF, ID, DAT_UG, ACC, SUMB, OP, REF_MAIN, STR_REF)
   values (l_ref, l_cp_id, GL.BD, l_accs, p_s*100, 5, l_refcp, l_ref);

   bars_audit.trace('%s l_accs = %s, l_cp_id = %s', title, to_char(l_accs),to_char(l_cp_id));
     begin
      update pawn_acc
         set CC_IDZ = p_ccnd, SDATZ = p_sdate
       where acc = l_accs;
     exception when dup_val_on_index then null;
     end;

 ELSIF NVL(p_mode,0) = 1 -- Изменение параметров или суммы гарантии к сделке
  THEN

   check_params(p_ref     =>    p_ref,     -- проверяется
                p_pawn    =>    p_pawn,    -- проверяется
                p_kv      =>    p_kv,
                p_ob22    =>    null, --p_ob22,    -- проверяется
                p_CP_WAR  =>    p_CP_WAR,  -- проверяется
                p_rnk     =>    p_rnk,     -- проверяется
                p_s       =>    p_s,
                p_ccnd    =>    p_ccnd,
                p_sdate   =>    p_sdate);

   select cd.REF,
          sz.pawn,
          A.nls,
          A.kv,
          p.acc,
          p.accs,
          ABS (A.ostB) S,
          SZ.idz,
          SZ.cc_idz,
          SZ.sdatz,
          C.rnk,
          AW.VALUE
    into l_cp_warrantyset
    FROM cc_accp P,
         pawn_acc SZ,
         accounts A,
         accountsw aw,
         customer C,
         cp_deal cd
   WHERE SZ.acc = p.acc
     AND p.rnk = C.rnk
     AND a.acc = aw.acc
     AND aw.tag = 'CP_WARR'
     AND a.acc = P.acc
     AND cd.acc = p.accs
     AND cd.ref = p.nd
     AND cd.ref = l_refcp
     AND a.nls = p_nls
     AND a.kv = p_kv;

    begin
     select 1
       into l_same_pawn
       from cc_pawn t1, cc_pawn t2
      where t1.pawn = p_pawn
        and t2.pawn = l_cp_warrantyset.PAWN
        and t1.nbsz = t2.nbsz;
    exception when no_data_found then l_same_pawn := 0;
    end;
    if l_same_pawn = 1
    then
        update pawn_acc
           set pawn = p_pawn
         where acc =  l_cp_warrantyset.acc;
    end if;
    -- проверка, какие реквизиты изменились
    if      l_cp_warrantyset.ref_   != l_refcp
         or (l_cp_warrantyset.PAWN  != p_pawn and l_same_pawn = 0)
         or l_cp_warrantyset.KV     != p_kv
    then raise_application_error (-20001,'ERR:  Зміни первинних реквізитів гарантії заборонені, угода' || to_char(l_ref) || ' Видаліть гарантію і заведіть нову.', TRUE);

    elsif   l_cp_warrantyset.S      != p_s*100     -- вставка проводки на разницу суммы
    then
      bars_audit.trace(' %s l_cp_warrantyset.S = %s,  p_s*100 = %s', title, to_char(l_cp_warrantyset.S), to_char(p_s*100));
        begin
         prep_doc(oo, p_kv, null, p_nls);
           if l_cp_warrantyset.S < p_s*100 -- увеличение суммы залога
           then
            begin
              oo.s     := (100*p_s - l_cp_warrantyset.S);
              oo.s2    := oo.s;
              oo.dk := case when l_pawn_pap = 1 then 0 else 1 end;
              --Збільшення вартості забезпечення по облігаціям
              oo.nazn  := 'Збільшення вартості забезп. по обл. '|| l_nmk_emi
                    ||','||l_ISIN
                    ||', пакет №'||l_refcp
                    --||','||to_char(l_kol)||'шт.'
                    ||' за дог.№' || p_ccnd
                    || ' від ' ||to_char(p_sdate,'dd.mm.yyyy');
            end;
           else                            -- уменьшение суммы залога
            begin
              oo.s     := (abs(100*p_s - l_cp_warrantyset.S));
              oo.s2    := oo.s;
              oo.dk := case when l_pawn_pap = 1 then 0 else 1 end;
              oo.nazn  := 'Зменшення вартості забезп. по обл. '|| l_nmk_emi
                    ||','||l_ISIN
                    ||', пакет №'||l_refcp
                    --||','||to_char(l_kol)||'шт.'
                    ||' за дог.№' || p_ccnd
                    || ' від ' ||to_char(p_sdate,'dd.mm.yyyy');
            end;
           end if;
           --3. Сформировать документ по оприходованию гарантии на открытый счет
           l_ref := pay_doc(oo);
          if (l_ref is not null)
           then
            begin
             insert into cp_payments (cp_ref, op_ref)
             values (l_refcp, l_ref);
            exception when dup_val_on_index then null;
            end;
           end if;
           --4. зафиксировать операцию в архиве сделок с номером 6 (Изменения гарантии по сделке ЦБ)
           insert into cp_arch (REF, ID, DAT_UG, ACC, SUMB, OP, REF_MAIN, STR_REF)
           values (l_ref, l_cp_id, GL.BD, l_accs, p_s*100, 6, l_refcp, l_ref);
        end;

    elsif   l_cp_warrantyset.CC_IDZ != p_ccnd
         or l_cp_warrantyset.SDATZ  != p_sdate
    then
      begin
        begin
         update pawn_acc
            set CC_IDZ = p_ccnd, SDATZ = p_sdate
          where acc = l_cp_warrantyset.acc;
        exception when dup_val_on_index then null;
        end;

        begin
         insert into accountsw(ACC, TAG, VALUE)
         select l_cp_warrantyset.acc, 'CP_W_ND', p_ccnd from dual;
        exception
             when dup_val_on_index
             then update accountsw
                     set value = p_ccnd
                   where acc = l_cp_warrantyset.acc
                     and tag = 'CP_W_ND';
        end;

        begin
         insert into accountsw(ACC, TAG, VALUE)
         select l_cp_warrantyset.acc, 'CP_W_DAT', p_sdate from dual;
        exception
             when dup_val_on_index
             then update accountsw
                     set value = p_sdate
                   where acc = l_cp_warrantyset.acc
                     and tag = 'CP_W_DAT';
        end;
      end;

    elsif   l_cp_warrantyset.RNK    != p_rnk
    then
     begin
      update cc_accp
         set rnk = p_rnk
       where rnk = l_cp_warrantyset.RNK
         and nd = l_cp_warrantyset.ref_
         and accs = l_cp_warrantyset.accs
         and acc = l_cp_warrantyset.acc;

       bars_audit.trace('old_rnk = '||to_char(l_cp_warrantyset.RNK)||'new_rnk = '|| to_char(p_rnk)||', p_ref = '||to_char(p_ref));
     end;

    elsif   l_cp_warrantyset.CP_WAR != p_cp_war
    then
       begin
         insert into accountsw(ACC, TAG, VALUE)
         select l_cp_warrantyset.acc, 'CP_WARR', p_CP_WAR from dual;
        exception
             when dup_val_on_index
             then update accountsw
                     set value = p_cp_war
                   where acc = l_cp_warrantyset.acc
                     and tag = 'CP_WARR';
       end;
    end if;

 ELSIF NVL(p_mode,0) = 2 -- удаление гарантии
  THEN
    bars_audit.trace('%s удаление гарантии для пакета ЦП ref = %s', title, to_char(l_refcp));
    check_params ( p_ref     =>    p_ref,     -- проверяется
                   p_pawn    =>    p_pawn,    -- проверяется
                   p_kv      =>    p_kv,
                   p_ob22    =>    null, --p_ob22,    -- проверяется
                   p_CP_WAR  =>    p_CP_WAR,  -- проверяется
                   p_rnk     =>    p_rnk,     -- проверяется
                   p_s       =>    p_s,
                   p_ccnd    =>    p_ccnd,
                   p_sdate   =>    p_sdate);
    -- 1. сделать обратную проводку по удалению гарантии
    select cd.REF,
          sz.pawn,
          A.nls,
          A.kv,
          p.acc,
          p.accs,
          ABS(A.ostb) S,
          SZ.idz,
          SZ.cc_idz,
          SZ.sdatz,
          C.rnk,
          AW.VALUE
    into l_cp_warrantyset
    FROM  cc_accp P,
          pawn_acc SZ,
          accounts A,
          accountsw aw,
          customer C,
          cp_deal cd
    WHERE     SZ.acc = p.acc
          AND p.rnk = C.rnk
          AND a.acc = aw.acc
          AND aw.tag = 'CP_WARR'
          AND a.acc = P.acc
          AND cd.acc = p.accs
          and cd.ref = p.nd
          and cd.ref = p_ref
          and a.nls = p_nls
          and a.kv = p_kv;

        prep_doc(oo, p_kv, null, p_nls);
          oo.s     := l_cp_warrantyset.S;
          oo.s2    := oo.s;
          oo.dk := case when l_pawn_pap = 1 then 1 else 0 end;
          oo.nazn  := 'Списання вартості забезп. по обл. '|| l_nmk_emi
                    ||','||l_ISIN
                    ||', пакет №'||l_refcp
                    --||','||to_char(l_kol)||'шт.'
                    ||' за дог.№' || p_ccnd
                    || ' від ' ||to_char(p_sdate,'dd.mm.yyyy');

       --2. Сформировать документ по оприходованию гарантии на открытый счет
       if oo.s != 0
       then
        l_ref := pay_doc(oo);
        if (l_ref is not null)
        then
         begin
          insert into cp_payments (cp_ref, op_ref)
          values (l_refcp, l_ref);
         exception when dup_val_on_index then null;
         end;
        end if;
       end if;
       --3. зафиксировать операцию в архиве сделок с номером 7 (Удаление гарантии по сделке ЦБ)
       insert into cp_arch (REF, ID, DAT_UG, ACC, SUMB, OP, REF_MAIN, STR_REF)
       values (l_ref, l_cp_id, GL.BD, l_accs, p_s*100, 7, p_ref, l_ref);
       --4. Удалить связь
       begin
           delete from cc_accp
           where accs = l_cp_warrantyset.accs
           and acc = l_cp_warrantyset.acc;
       exception when others then raise;
       end;

 ELSIF NVL(p_mode,0) = 3 -- уменьшение гарантии в удельном весе cp_warranty_method.id = 2
 THEN
    bars_audit.trace('%s p_mode = %s', title, to_char(p_mode));

    bars_audit.trace('%s p_ref = %s, p_nls = %s, p_kv = %s', title, to_char(p_ref), p_nls, to_char(p_kv));
    check_params ( p_ref     =>    p_ref,     -- проверяется
                   p_pawn    =>    p_pawn,    -- проверяется
                   p_kv      =>    p_kv,
                   p_ob22    =>    null, --p_ob22,    -- проверяется
                   p_CP_WAR  =>    p_CP_WAR,  -- проверяется
                   p_rnk     =>    p_rnk,     -- проверяется
                   p_s       =>    p_s,
                   p_ccnd    =>    p_ccnd,
                   p_sdate   =>    p_sdate);

    select cd.REF,
          sz.pawn,
          A.nls,
          A.kv,
          p.acc,
          p.accs,
          ABS (A.ostB) S,
          SZ.idz,
          SZ.cc_idz,
          SZ.sdatz,
          C.rnk,
          AW.VALUE
    into l_cp_warrantyset
    FROM cc_accp P,
          pawn_acc SZ,
          accounts A,
          accountsw aw,
          customer C,
          cp_deal cd
    WHERE     SZ.acc = p.acc
          AND p.rnk = C.rnk
          AND a.acc = aw.acc
          AND aw.tag = 'CP_WARR'
          AND a.acc = P.acc
          AND cd.acc = p.accs
          and cd.ref = p.nd
          and cd.ref = p_ref
          and a.nls = p_nls
          and a.kv = p_kv;

      bars_audit.trace(' %s l_cp_warrantyset.S = %s,  p_s = %s', title, to_char(l_cp_warrantyset.S), to_char(p_s));

      -- собираем реквизиты проводки
      prep_doc(oo, p_kv, null, p_nls);

     -- уменьшение суммы залога
       oo.s     := abs(p_s);
       oo.s2    := oo.s;
       oo.dk := case when l_pawn_pap = 1 then 1 else 0 end;
       oo.nazn  := 'Зменшення вартості забезп. по обл. '|| l_nmk_emi
                    ||','||l_ISIN
                    ||', пакет №'||l_ref
                    --||','||to_char(l_kol)||'шт.'
                    ||' за дог.№' || p_ccnd
                    || ' від ' ||to_char(p_sdate,'dd.mm.yyyy');
       --3. Сформировать документ по оприходованию гарантии на открытый счет
       l_ref := pay_doc(oo);
       if (l_ref is not null)
       then
        begin
         insert into cp_payments (cp_ref, op_ref)
         values (l_refcp, l_ref);
        exception when dup_val_on_index then null;
        end;
       end if;
       --4. зафиксировать операцию в архиве сделок с номером 6 (Изменения гарантии по сделке ЦБ)
       insert into cp_arch (REF, ID, DAT_UG, ACC, SUMB, OP, REF_MAIN, STR_REF)
       values (l_ref, l_cp_id, GL.BD, l_accs, p_s*100, 6, p_ref, l_ref);
 END IF;

END p_cp_addwarranty;
/
show err;

PROMPT *** Create  grants  P_CP_ADDWARRANTY ***
grant EXECUTE                                                                on P_CP_ADDWARRANTY to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CP_ADDWARRANTY.sql =========*** 
PROMPT ===================================================================================== 
