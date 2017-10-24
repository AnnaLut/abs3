

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAYPAY_MIN.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAYPAY_MIN ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAYPAY_MIN (p_date date)
IS
  --
  -- взаиморасчеты между ГОУ и Казначейством за купленую/проданую валюту клиентов
  -- version 2.0   09/11/2007
  --
  l_module    varchar2(3)        := 'ZAY';
  l_title     varchar2(60)       := 'p_zaypay_min: ';
  l_userid    staff.id%type      := gl.aUID;
  l_mfo       banks.mfo%type     := gl.aMfo;
  l_okpo      customer.okpo%type := gl.aOKPO;
  l_nccode    tabval.kv%type     := gl.baseval;
  l_date      date               := gl.bdate;
  l_param     params.par%type    := 'MBK_VZAL';
  l_tt        tts.tt%type        := 'GO6';
  l_ncvob     vob.vob%type;
  l_fcvob     vob.vob%type;
  l_nazntt    tts.nazn%type;
  l_mask29    tts.nlsk%type;
  l_mask18    tts.nlsa%type;
  type acc_rec is record (accid    accounts.acc%type,
                          accnum   accounts.nls%type,
                          acccur   accounts.kv%type,
                          accname  accounts.nms%type);
  l_accA      acc_rec;
  l_accB      acc_rec;
  l_nazn      oper.nazn%type;
  l_delta     number;
  l_eqvamount number;
  l_maxrate   number;
  l_minrate   number;
  l_rate      number;
  l_amount    number;
  --------
  function get_acc
    (p_accmask  accounts.nls%type,
     p_acccurr  accounts.kv%type)
  return acc_rec
  is
    acc_ acc_rec;
  begin

    bars_audit.trace('%s маска счета = %s, валюта = %s', l_title, p_accmask, to_char(p_acccurr));

    begin
      select nls, kv, substr(nms, 1, 38)
        into acc_.accnum, acc_.acccur, acc_.accname
        from accounts
       where nls = p_accmask
         and kv = p_acccurr
	 and dazs is null;
    exception
      when no_data_found then
        bars_error.raise_nerror(l_module, 'ACC_DOESNT_EXIST', p_accmask, p_acccurr);
    end;
    bars_audit.trace('%s найден счет %s / %s', l_title, acc_.accnum, to_char(acc_.acccur));

    return acc_;

  end get_acc;
  ---------
  procedure pay_doc
    (l_accA   in acc_rec,
     l_accB   in acc_rec,
     l_amount in number,
     l_iso    in tabval.lcv%type,
     l_nazn   in oper.nazn%type)
  is
    l_payed number;
    l_ref   oper.ref%type;
    l_vob   vob.vob%type;
  begin

    bars_audit.trace('%s перечисление с %s на %s = %s / %s', l_title,
	             l_accA.accnum, l_accB.accnum,
		     to_char(l_amount), to_char(l_accA.acccur));

    if l_accA.acccur = l_nccode then
       l_vob := l_ncvob;
    else
       l_vob := l_fcvob;
    end if;
    bars_audit.trace('%s вид обработки = %s', l_title, to_char(l_vob));

    gl.ref (l_ref);

    insert into oper
      (ref, tt, vob, nd, dk, pdat, vdat, datd,
       nam_a, nlsa, mfoa, id_a, kv, s,
       nam_b, nlsb, mfob, id_b, kv2, s2,
       nazn, userid, sos)
    values
      (l_ref, l_tt, l_vob, to_char(l_ref), 1, sysdate, l_date, l_date,
       l_accA.accname, l_accA.accnum, l_mfo, l_okpo, l_accA.acccur, l_amount,
       l_accB.accname, l_accB.accnum, l_mfo, l_okpo, l_accB.acccur, l_amount,
       l_nazn, l_userid, 1);

    paytt (null, l_ref, l_date, l_tt, 1,
           l_accA.acccur, l_accA.accnum, l_amount,
	   l_accB.acccur, l_accB.accnum, l_amount);

    bars_audit.trace('%s референс документа = %s', l_title, to_char(l_ref));

  end pay_doc;

BEGIN

  bars_audit.trace('%s старт с датой = %s', l_title, to_char(p_date, 'dd.mm.yyyy'));

  BEGIN
    SELECT vob INTO l_ncvob FROM tts_vob WHERE tt = l_tt;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN l_ncvob := 6;
    WHEN TOO_MANY_ROWS THEN l_ncvob := 6;
  END;
  bars_audit.trace('%s вид обработки для грн.платежей = %s', l_title, to_char(l_ncvob));

  BEGIN
    SELECT to_number(val) INTO l_fcvob FROM params WHERE par = l_param;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN l_fcvob := 6;
  END;
  bars_audit.trace('%s вид обработки для вал.платежей = %s', l_title, to_char(l_fcvob));

  BEGIN
    SELECT nazn INTO l_nazntt FROM tts WHERE tt = l_tt;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(l_module, 'TT_NOT_FOUND', l_tt);
  END;
  l_nazntt := NVL(l_nazntt, 'Розрахунки за купівлю-продаж валюти');
  bars_audit.trace('%s маска назначения платежа = %s', l_title, l_nazntt);

  BEGIN
    SELECT nlsk INTO l_mask29 FROM tts WHERE tt = 'GO1';
  EXCEPTION WHEN NO_DATA_FOUND THEN
    bars_error.raise_nerror(l_module, 'ACC29_NOT_FOUND');
  END;
  bars_audit.trace('%s транз.счет 2900 = %s', l_title, l_mask29);

  BEGIN
    SELECT nlsa INTO l_mask18 FROM tts WHERE tt = 'GO2';
  EXCEPTION WHEN NO_DATA_FOUND THEN
    bars_error.raise_nerror(l_module, 'ACC18_NOT_FOUND');
  END;
  bars_audit.trace('%s транз.счет 1819 = %s', l_title, l_mask18);

  -- расчет нетто валют
  FOR netto IN
     (SELECT kv2 kv, lcv iso, sum(decode(dk, 1, s2, -s2)) s
        FROM v_zay_queue
       WHERE sos = 1
         AND vdate = p_date
       GROUP BY kv2, lcv
      HAVING sum(decode(dk, 1, s2, -s2)) <> 0)
  LOOP
     bars_audit.trace('%s нетто валюты = %s %s', l_title, to_char(netto.s), netto.iso);

     l_eqvamount := 0;
     l_delta     := abs(netto.s);
     l_minrate   := 0;
     l_maxrate   := 9999999999;

     l_nazn      := l_nazntt
                 ||' ('
                 ||ltrim(to_char(abs(netto.s)/100, '999999999.99'))
                 ||' '
                 ||netto.iso
                 ||')';
     bars_audit.trace('%s назначение = %s', l_title, l_nazn);

     IF netto.s > 0 THEN

        WHILE l_delta > 0 LOOP

          SELECT kurs_f, sum(s2)
	    INTO l_rate, l_amount
            FROM v_zay_queue
           WHERE sos = 1
	     AND vdate  = p_date
             AND dk = 1
             AND kv2 = netto.kv
	     AND kurs_f < l_maxrate
             AND kurs_f = (SELECT max(kurs_f)
                             FROM v_zay_queue
                            WHERE sos = 1
	                      AND vdate  = p_date
			      AND dk = 1
                              AND kv2 = netto.kv
			      AND kurs_f < l_maxrate)
           GROUP BY kurs_f;
          bars_audit.trace('%s курс(i) = %s, сумма (і) = %s', l_title,
                           to_char(l_rate), to_char(l_amount));

          IF l_delta - l_amount <= 0 THEN
             l_eqvamount := l_eqvamount + abs(l_delta) * l_rate;
          ELSE
             l_eqvamount := l_eqvamount + l_amount * l_rate;
          END IF;
          bars_audit.trace('%s эквивалент = %s', l_title, to_char(l_eqvamount));

          l_delta    := l_delta - l_amount;
          l_maxrate  := l_rate;
          bars_audit.trace('%s дельта = %s, макс.курс = %s', l_title,
                           to_char(l_delta), to_char(l_maxrate));

        END LOOP;

        -- ГОУ отдает Бэк-офису гривну за купленную валюту
        l_accA   := get_acc (l_mask29, l_nccode);
        l_accB   := get_acc (l_mask18, l_nccode);
        pay_doc (l_accA, l_accB, l_eqvamount, netto.iso, l_nazn);

        -- Бэк-офис отдает ГОУ купленную валюту
        l_accA   := get_acc (l_mask18, netto.kv);
        l_accB   := get_acc (l_mask29, netto.kv);
        pay_doc (l_accA, l_accB, abs(netto.s), netto.iso, l_nazn);

     ELSE

        WHILE l_delta > 0 LOOP

          SELECT kurs_f, sum(s2)
	    INTO l_rate, l_amount
            FROM v_zay_queue
           WHERE sos = 1
	     AND vdate = p_date
             AND dk = 2
             AND kv2 = netto.kv
	     AND kurs_f > l_minrate
             AND kurs_f = (SELECT min(kurs_f)
                             FROM v_zay_queue
                            WHERE sos = 1
	                      AND vdate  = p_date
			      AND dk = 2
                              AND kv2 = netto.kv
			      AND kurs_f > l_minrate)
           GROUP BY kurs_f;
          bars_audit.trace('%s курс(i) = %s, сумма (і) = %s', l_title,
                           to_char(l_rate), to_char(l_amount));

          IF l_delta - l_amount <= 0 THEN
             l_eqvamount := l_eqvamount + abs(l_delta)*l_rate;
          ELSE
             l_eqvamount := l_eqvamount + l_amount*l_rate;
          END IF;
          bars_audit.trace('%s эквивалент = %s', l_title, to_char(l_eqvamount));

          l_delta   := l_delta - l_amount;
          l_minrate := l_rate;
          bars_audit.trace('%s дельта = %s, миним.курс = %s', l_title,
                           to_char(l_delta), to_char(l_minrate));

        END LOOP;

        -- ГОУ отдает Бэк-офису проданную валюту
        l_accA   := get_acc (l_mask29, netto.kv);
        l_accB   := get_acc (l_mask18, netto.kv);
        pay_doc (l_accA, l_accB, abs(netto.s), netto.iso, l_nazn);

        -- Бэк-офис отдает ГОУ гривну за проданную валюту
        l_accA   := get_acc (l_mask18, l_nccode);
        l_accB   := get_acc (l_mask29, l_nccode);
        pay_doc (l_accA, l_accB, l_eqvamount, netto.iso, l_nazn);

     END IF;

  END LOOP;

  bars_audit.trace('%s выполнено', l_title);

END;
/
show err;

PROMPT *** Create  grants  P_ZAYPAY_MIN ***
grant EXECUTE                                                                on P_ZAYPAY_MIN    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ZAYPAY_MIN    to WR_ALL_RIGHTS;
grant EXECUTE                                                                on P_ZAYPAY_MIN    to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAYPAY_MIN.sql =========*** End 
PROMPT ===================================================================================== 
