CREATE OR REPLACE PACKAGE BARS."SEP_UTL" is
--***************************************************************--
--              Communication with NBU Payment System
--                     (C) Unity-BARS (2000-2015)
--***************************************************************--

g_header_version  constant varchar2(64)  := 'version 1.01 09/03/2017';
g_header_defs     constant varchar2(512) := '';

-- header_version - возвращает версию заголовка пакета
function header_version return varchar2;

-- body_version - возвращает версию тела пакета
function body_version return varchar2;

procedure getT00_902(
                    mfoa_ VARCHAR2, -- Sender's MFOs
                    dk_ SMALLINT, -- Debet/Credit code
                    kv_ SMALLINT, -- Currency code
                    blk_ SMALLINT,  -- Blocking code

                    strNlsT00 out VARCHAR2,
                    strNls902 out VARCHAR2,
                    strTTadd out VARCHAR2);

-- Принять <<До выяснения>>
procedure unlock_sepdocs_to902 (
  p_rec   in number,
  p_blk   in number,
  p_ref  out number );
--Применить бизнес-правила то есть пересоздать процедуру bl_rrp
procedure bp_apply;

-- Процедура розблокування документів по коду блокування
procedure unlock_by_code(p_blk arc_rrp.blk%type,p_kv arc_rrp.kv%type);

-- Процедура розблокування по сумі
procedure unlock_by_sum(p_sum arc_rrp.s%type, p_reclist number_list, p_msg out varchar2);

-- Процедура розблокування по сумі і коду блокування
procedure unlock_by_sum_blk(p_sum number,
                            p_kv  number,
                            p_blk number,
                            p_msg out varchar2);
-- копирование  operw                            
procedure  copy_operw ( p_ref_new operw.ref%TYPE,p_ref_old operw.ref%TYPE);                            
end;
/

CREATE OR REPLACE PACKAGE BODY BARS."SEP_UTL" is
--***************************************************************--
--              Communication with NBU Payment System
--                     (C) Unity-BARS (2000-2015)
--***************************************************************--

--
-- constants
--
g_body_version    constant varchar2(64)  := 'version 1.03 19/04/2018';
g_body_defs       constant varchar2(512) := '';

g_modcode         constant varchar2(3)   := 'SEP';

-------------------------------------------------------------------------------
-- header_version - возвращает версию заголовка пакета
function header_version return varchar2 is
begin
  return 'Package header bars_ow ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_header_defs;
end header_version;

-------------------------------------------------------------------------------
-- body_version - возвращает версию тела пакета
function body_version return varchar2 is
begin
  return 'Package body bars_ow ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_body_defs;
end body_version;

-------------------------------------------------------------------------------
procedure getT00_902(
                    mfoa_ VARCHAR2, -- Sender's MFOs
                    dk_ SMALLINT, -- Debet/Credit code
                    kv_ SMALLINT, -- Currency code
                    blk_ SMALLINT,  -- Blocking code

                    strNlsT00 out VARCHAR2,
                    strNls902 out VARCHAR2,
                    strTTadd out VARCHAR2)
as
    l_mfo VARCHAR2(12);
    u_mfo VARCHAR2(12);
    u_clrtrn VARCHAR2(30);
    u_lst92 VARCHAR2(30);
--
--  Получить номера счетов
--
begin

    begin
        select val into u_mfo from params where par = 'MFO';
        exception when others then null;
    end;
    begin
        select val into u_clrtrn from params where par = 'CLRTRN';
        exception when others then null;
    end;

    begin
        select val into u_lst92 from params where par = 'LST92';
        exception when others then null;
    end;


    if dk_ = 1 then
        strNls902 := '902';
    else
        strNls902 := '90D';
    end if;


    if u_clrtrn is not null and kv_ = 980 then
        if mfoa_ = u_mfo then
            if dk_ = 1 then
                strNlsT00 := 'T00';
            else
                strNlsT00 := 'T0D';
            end if;
        else
            if dk_ = 1 then
                strNlsT00 := 'TO0';
            else
                strNlsT00 := 'TOD';
            end if;

            select mfo into l_mfo
            from banks
            where
                 mfop = u_mfo and
                 (mfo = mfoa_ or mfo = (
                     select mfop from banks
                     where mfop <> u_mfo and mfo = mfoa_));

        end if;
    else
        if dk_ = 1 then
            strNlsT00 := 'T00';
        else
            strNlsT00 := 'T0D';
        end if;
        l_mfo := u_mfo;
    end if;

    for ac in (
        select tip, nls from accounts
        where
            kv = kv_ and (
            tip = strNls902 or
            tip = strNlsT00 and
            acc in ( select acc from bank_acc
                WHERE mfo = l_mfo)
            ))
    loop
        if ac.tip in('T00', 'T0D', 'TO0', 'TOD') then
            strNlsT00 := ac.nls;
        elsif ac.tip in ('902', '90D') then
            strNls902 := ac.nls;
        end if;
    end loop;

    if u_lst92 is not null then
        begin
            select nls,tt into strNls902, strTTadd from t902_acc
            where kv = kv_ and dk = dk_ and blk = blk_;
        exception when others then null;
        end;
    end if;
end;

-------------------------------------------------------------------------------
-- del_inf
-- Удалить запрос
--
procedure del_inf (
  p_rec   in number,
  p_blk   in number,
  p_bis   in number )
is
  l_ref number;
  l_err varchar2(2000) := null;
begin
  begin
     select ref into l_ref
       from arc_rrp
      where rec = p_rec and blk = p_blk
        for update of blk nowait;
     if p_bis > 0 then
        update arc_rrp
           set blk = -1
         where rec in (select rec from rec_que where rec_g = p_rec and rec_g is not null)
           and fn_b is null and bis > 0;
        delete from rec_que where rec_g = p_rec and rec_g is not null;
--        delete from tzapros where rec_g = p_rec and rec_g is not null;
     else
        update arc_rrp
           set blk = -1
         where rec = p_rec
           and fn_b is null;
        delete from rec_que where rec = p_rec;
        delete from tzapros where rec = p_rec;
     end if;
     bars_audit.info('Док #' || l_ref || '(' || p_rec || ') Вилучено. (BLK=' || p_blk || ')');
  exception when no_data_found then
     raise_application_error(-20000, 'Невозможно получить доступ к REC ' || p_rec);
  end;
end del_inf;

-------------------------------------------------------------------------------
-- get_T00_902
-- Получить номера счетов
--
procedure get_T00_902 (
  p_rec       in arc_rrp%rowtype,
  p_nls_T00  out varchar2,
  p_nls_902  out varchar2,
  p_tt_add   out varchar2 )
is
  l_bank_mfo varchar2(6);
  l_mfo      varchar2(6);
  l_tip_902  varchar2(3);
  l_tip_T00  varchar2(3);
begin

  l_bank_mfo := gl.amfo;

  l_tip_902 := case when p_rec.dk = 1 then '902' else '90D' end;

  if getglobaloption('CLRTRN') = '1' and p_rec.kv = 980 then
     if p_rec.mfoa = l_bank_mfo then
        l_tip_T00 := case when p_rec.dk = 1 then 'T00' else 'T0D' end;
     else
        l_tip_T00 := case when p_rec.dk = 1 then 'TO0' else 'TOD' end;
     end if;
     begin
        select mfo into l_mfo
          from banks
         where mfop = l_bank_mfo and (mfo = p_rec.mfoa or mfo = (select mfop from banks where mfop <> l_bank_mfo and mfo = p_rec.mfoa));
     exception when no_data_found then
        l_mfo := null;
     end;
  else
     l_tip_T00 := case when p_rec.dk = 1 then 'T00' else 'T0D' end;
     l_mfo := l_bank_mfo;
  end if;

  for c in ( select tip, nls
               from accounts
              where kv = p_rec.kv
                and ( tip = l_tip_902
                   or tip = l_tip_T00 and acc in (select acc from bank_acc where mfo = l_mfo) ) )
  loop
     if c.tip in ('T00', 'T0D', 'TO0', 'TOD') then
        p_nls_T00 := c.nls;
     elsif c.tip in ('902', '90D') then
        p_nls_902 := c.nls;
     end if;
  end loop;

  if getglobaloption('LST92') = '1' then
     begin
        select nls, tt
          into p_nls_902, p_tt_add
          from t902_acc
         where kv = p_rec.kv and dk = p_rec.dk and blk = p_rec.blk;
     exception when no_data_found then
        p_nls_902 := null;
        p_tt_add  := null;
     end;
  else
     p_tt_add  := null;
  end if;

end get_T00_902;

-------------------------------------------------------------------------------
-- get_trans_sum
-- Трансляция формулы суммы
--
function get_trans_sum (p_formula varchar2, p_s number, p_rec arc_rrp%rowtype) return number
is
  l_s number;
  l_formula tts.s%type;
begin
  l_s := p_s;
  if p_formula is not null then
     l_formula := p_formula;
     l_formula := replace(l_formula, '#(S)',    to_char(p_rec.s));
     l_formula := replace(l_formula, '#(S2)',   to_char(p_rec.s));
     l_formula := replace(l_formula, '#(NLSA)', p_rec.nlsa);
     l_formula := replace(l_formula, '#(NLSB)', p_rec.nlsb);
     l_formula := replace(l_formula, '#(MFOA)', p_rec.mfoa);
     l_formula := replace(l_formula, '#(MFOB)', p_rec.mfob);
     l_formula := replace(l_formula, '#(KVA)',  to_char(p_rec.kv));
     l_formula := replace(l_formula, '#(KVB)',  to_char(p_rec.kv));
     l_formula := replace(l_formula, '#(REF)',  to_char(p_rec.ref));
     begin
        execute immediate 'select round(' || l_formula || ',0) from dual' into l_s;
     exception when others then
        raise_application_error(-20000, 'Ошибка вычисления формулы суммы '|| p_formula);
     end;
  end if;
  return l_s;
end get_trans_sum;

-------------------------------------------------------------------------------
-- unlock_sepdocs_to902
-- Принять <<До выяснения>>
--
procedure unlock_sepdocs_to902 (
  p_rec   in number,
  p_blk   in number,
  p_ref  out number )
is
  l_rec arc_rrp%rowtype;
  l_bdate    date;
  l_nls_T00  varchar2(14);
  l_nls_902  varchar2(14);
  l_tt_add   varchar2(3);
  l_s_add    tts.s%type;
  l_s2_add   tts.s2%type;
  l_s        number;
  l_s2       number;
  l_sos      number;
begin

  -- поиск документа
  begin
     select * into l_rec
       from arc_rrp
      where rec = p_rec and blk = p_blk
        for update of blk nowait;
  exception when no_data_found then
     raise_application_error(-20000, 'Невозможно получить доступ к REC ' || p_rec);
  end;

  -- проверка локумента
  if l_rec.dk not in (0, 1) then
     raise_application_error(-20000, 'Неплатежный документ <<До выяснения>> - не помещаем. Зап:' || p_rec);
  end if;

  l_bdate := bankdate;

  -- получаем номера счетов T00/T902
  get_T00_902(l_rec, l_nls_T00, l_nls_902, l_tt_add);

  -- референс документа
  if l_rec.ref is null then
     gl.ref (l_rec.ref);
  end if;

  -- проводка T00->902 (Д3739 -> К3720)
  gl.payv(0, l_rec.ref, l_bdate, 'R01', l_rec.dk,
     l_rec.kv, l_nls_T00, l_rec.s,
     l_rec.kv, l_nls_902, l_rec.s);

  -- доплата 902 -> NLSB
  if l_tt_add is not null then
     begin
        select s, s2 into l_s_add, l_s2_add from tts where tt = l_tt_add;
     exception when no_data_found then
        raise_application_error(-20000, 'Не описана операция ' || l_tt_add);
     end;
     l_s  := get_trans_sum(l_s_add,  l_rec.s, l_rec);
     l_s2 := get_trans_sum(l_s2_add, l_rec.s, l_rec);
     paytt ( flg_ => 1,
             ref_ => l_rec.ref,
            datv_ => l_bdate,
              tt_ => l_tt_add,
             dk0_ => l_rec.dk,
             kva_ => l_rec.kv,
            nls1_ => l_rec.nlsa,
              sa_ => l_rec.s,
             kvb_ => l_rec.kv,
            nls2_ => l_rec.nlsb,
              sb_ => l_rec.s );
  end if;

  -- RES92 - Вставлять причину помещения на 902
  if getglobaloption('RES92') = '1' then
     insert into operw (ref, tag, value)
     values (l_rec.ref, 'RES92', (select l_rec.blk || '-' || trim(name)
                                from (select nvl(trim(name),'Бізнес правило') name
                                        from bp_rrp
                                       where rule = l_rec.blk
                                       union all
                                      select trim(n_er)
                                        from s_er
                                       where trim(k_er) = substr('0000'||l_rec.blk,-4)
                                       union all
                                      select 'Бізнес правило'
                                        from dual
                                       order by 1 desc)
                               where rownum = 1) );
  end if;

  -- BIS92 - Переносить БИСы на невыясненные
  if getglobaloption('BIS92') = '1' then
     sep.bis2ref(p_rec, l_rec.ref);
  end if;

  -- CLRTRN
  if getglobaloption('CLRTRN') = '1' and l_rec.kv = 980 then
     l_sos := 8;
  else
     l_sos := 5;
  end if;

  if l_rec.bis > 0 then
     update arc_rrp
        set ref = l_rec.ref,
            dat_b = l_bdate,
            sos = l_sos,
            blk = 0
      where rec in (select rec from rec_que where rec_g = p_rec and rec_g is not null)
        and fn_b is null and bis > 0;
     delete from rec_que where rec_g = p_rec and rec_g is not null;
  else
     update arc_rrp
        set ref = l_rec.ref,
            dat_b = l_bdate,
            sos = l_sos,
            blk = 0
      where rec = p_rec and fn_b is null;
     delete from rec_que where rec = p_rec;
  end if;

  insert into t902 (ref, rec, blk)
  values (l_rec.ref, p_rec, case when getglobaloption('BLK92') = '1' then l_rec.blk else null end);

  update oper
     set (nlsa, nlsb, d_rec, id_o, sign) = (select nlsa, nlsb, d_rec, id_o, sign from arc_rrp where rec = p_rec)
   where ref = l_rec.ref;

  p_ref := l_rec.ref;

end unlock_sepdocs_to902;


procedure bp_apply
  is
  l_body clob;
  l_chr varchar2(100):=chr(10);
  l_ru  varchar2(50) := bars_sqnc.ru;
  begin

    l_body:='CREATE OR REPLACE '||l_chr||
    'PROCEDURE bars.bl_rrp_'||l_ru||'( rc IN OUT NUMBER, kv IN NUMBER, '||l_chr||
    'mfoa_p IN VARCHAR2, mfoa IN VARCHAR2, nlsa IN VARCHAR2, '||l_chr||
    'mfob_p IN VARCHAR2, mfob IN VARCHAR2, nlsb IN VARCHAR2, '||l_chr||
    'dk IN NUMBER,  s IN NUMBER, '||l_chr||
    'id_a IN VARCHAR2 DEFAULT NULL, '||l_chr||
    'id_b IN VARCHAR2 DEFAULT NULL, '||l_chr||
    ' ref  IN NUMBER   DEFAULT NULL ) IS '||l_chr||
    'classa NUMBER := 0; '||l_chr||
    'classb NUMBER := 0; '||l_chr||
    'nbsa   VARCHAR2(4); '||l_chr||
    'nbsb   VARCHAR2(4); '||l_chr||
    'erm    VARCHAR2 (80); '||l_chr||
    'ern    CONSTANT POSITIVE := 715; '||l_chr||
    'err    EXCEPTION; '||l_chr||
    'BEGIN '||l_chr ;

    for c in(select b.rule, b.body from bp_rrp b where b.fa='1')
      loop
        l_body:=l_body||'IF '||c.body||' THEN '||l_chr||
        'rc:='||c.rule||'; '||l_chr||
        'RETURN; '||l_chr||
        'END IF; '||l_chr;
        end loop;
    l_body:=l_body||'rc:=0; '||l_chr||
    'END bl_rrp_'||l_ru||';'||l_chr;

    execute immediate l_body;

    end bp_apply;

procedure unlock_by_code(p_blk arc_rrp.blk%type,p_kv arc_rrp.kv%type)
    is
    l_stmt clob;
begin


  l_stmt:='
     update arc_rrp
     set blk=0
     where rec in(
     SELECT V_RECQUE_ARCRRP_DATA.rec
       FROM V_RECQUE_ARCRRP_DATA, bp_rrp, s_er
      WHERE     V_RECQUE_ARCRRP_DATA.blk = bp_rrp.rule(+)
            AND V_RECQUE_ARCRRP_DATA.blk = S_ER.K_ER(+)
            AND V_RECQUE_ARCRRP_DATA.blk='||p_blk||'
            AND V_RECQUE_ARCRRP_DATA.KV='||p_kv||')';

    execute immediate l_stmt;

end unlock_by_code;

procedure unlock_by_sum(p_sum arc_rrp.s%type, p_reclist number_list, p_msg out varchar2)
    is
      l_distinct_kv number;
      l_total_amount number:=0;
      x number:=0;
    begin

       select count(*) into l_distinct_kv from(select distinct kv from arc_rrp where rec in(select column_value from table(p_reclist))) t;

       if (l_distinct_kv>1) then

        p_msg:='Розблокування по сумі не може бути використано для різних валют!';

        return;

        end if;

       for i in (select *
                    from   (select t.s s1, sum(t.s) over (order by t.rec) cumulative_amount, t.*
                            from   arc_rrp t
                            where  rec in (select column_value
                                           from   table(p_reclist)
                                           where  s<=p_sum
                                           ))
                    where cumulative_amount <= p_sum)
        loop
            update arc_rrp
            set blk=0
            where rec=i.rec;
            l_total_amount:=i.cumulative_amount;
            x:=x+1;
        end loop;

         p_msg:='Розблоковано '||to_char(x)||' документів на суму '||to_char(l_total_amount/100,'999999990D00');

    end unlock_by_sum;

procedure unlock_by_sum_blk(p_sum number,
                            p_kv  number,
                            p_blk number,
                            p_msg out varchar2) is
  l_distinct_kv  number;
  l_total_amount number := 0;
  x              number := 0;
begin

  for i in (select *
              from (select a.rec, a.s, a.kv, dat_a, blk,
                            sum(s) over(order by dat_a, rec rows unbounded preceding) accrual_sum,
                            sum(s) over() total_sum
                       from arc_rrp a
                      where a.blk = p_blk and a.kv = p_kv and
                            a.dat_a > sysdate - 30 and a.s <= p_sum)
             where accrual_sum <= p_sum)
  loop
    update arc_rrp set blk = 0 where rec = i.rec;

    bars_audit.info(p_msg => 'Розблоковано документ Rec = ' || i.rec ||
                             ' на суму = ' || i.s || '(' || i.kv || ')');

    l_total_amount := i.accrual_sum;
    x              := x + 1;
  end loop;

  p_msg := 'Розблоковано ' || to_char(x) || ' документів на суму ' ||
           to_char(l_total_amount / 100, '999999990D00');

end;
---------
procedure copy_operw(p_ref_new operw.ref%TYPE, p_ref_old operw.ref%TYPE) is
l_mfob_new  oper.mfob%TYPE;
begin
  insert into operw
    select p_ref_new, w.tag, w.value, w.kf
      from operw w
     where w.ref = p_ref_old;
begin 
select mfob into l_mfob_new from oper where ref= p_ref_new;
exception
      when no_data_found then
        l_mfob_new:=null;
end;
  for i in (select *
              from oper o
              join t902 t
                on t.ref = o.ref
             where o.ref = p_ref_old
               and o.d_rec like ('%#fMT%')
               and t.otm = 0) loop
   if l_mfob_new ='300465' then
    begin
          insert into operw
        (ref, tag, value)
      values
        (p_ref_new, 'NOS_A', '0');
    exception
      when dup_val_on_index then
        null;
    end;
   end if;
    begin
      insert into operw
        (ref, tag, value)
      values
        (p_ref_new, 'f', SUBSTR(i.d_rec, 7, 6));
    exception
      when dup_val_on_index then
        null;
    end;
  end loop;
end;

end;
/