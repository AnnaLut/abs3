
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bpk_tip_psys.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BPK_TIP_PSYS (acc_tip_ VARCHAR2, acc_kv_ NUMBER, mode_ NUMBER)
RETURN varchar2 IS Result_ VARCHAR2(20);
  --
  -- возвращает : тип БПК или наименование платежной системы или сумму депозита
  -- в зависимости от пераданного параметра MODE_
  -- (функция используется в значении SSQL для переменных DOC_ATTR.ACC_BPK_PSYS,
  -- DOC_ATTR.ACC_BPK_DPT_S_NUM, DOC_ATTR.ACC_BPK_DPT_S_LIT)
  --
BEGIN
  IF mode_ = 1 THEN -- возвращаем тип БПК
    CASE acc_tip_
      WHEN 'PK0' THEN Result_ := ' ';
      WHEN 'PK1' THEN Result_ := ' ';
      WHEN 'PK2' THEN Result_ := 'MASS';
      WHEN 'PK3' THEN Result_ := 'ELECTRONIC';
      WHEN 'PK4' THEN Result_ := 'GOLD';
      WHEN 'PK5' THEN Result_ := 'ELECTRON';
      WHEN 'PK6' THEN Result_ := 'CLASSIC';
      WHEN 'PK7' THEN Result_ := 'BUSINESS';
      WHEN 'PK8' THEN Result_ := 'GOLD';
      WHEN 'PK9' THEN Result_ := 'CLASSIC Domestic';
      WHEN 'PKA' THEN Result_ := 'GOLD';
      WHEN 'PKB' THEN Result_ := 'GOLD';
      WHEN 'PKC' THEN Result_ := 'PLATINUM';
      else null;
    END CASE;
  END IF;
  IF mode_ = 2 THEN -- возвращаем наименование платежной системы
    CASE acc_tip_
      WHEN 'PK0' THEN Result_ := 'VISA';
      WHEN 'PK1' THEN Result_ := 'CIRUS/MAESTRO';
      WHEN 'PK2' THEN Result_ := 'MASTERCARD';
      WHEN 'PK3' THEN Result_ := 'MASTERCARD';
      WHEN 'PK4' THEN Result_ := 'MASTERCARD';
      WHEN 'PK5' THEN Result_ := 'VISA';
      WHEN 'PK6' THEN Result_ := 'VISA';
      WHEN 'PK7' THEN Result_ := 'VISA';
      WHEN 'PK8' THEN Result_ := 'VISA';
      WHEN 'PK9' THEN Result_ := 'VISA';
      WHEN 'PKA' THEN Result_ := 'VISA';
      WHEN 'PKB' THEN Result_ := 'MASTERCARD';
      WHEN 'PKC' THEN Result_ := 'MASTERCARD';
      WHEN 'PKY' THEN Result_ := 'MASTERCARD';
      else null;
    END CASE;
  END IF;
  IF mode_ = 4 THEN
    case acc_tip_
      when 'PK0' then Result_ := '6';  -- VISA Classic
      when 'PK1' then Result_ := '3';  -- MC. Cirrus
      when 'PK2' then Result_ := '0';  -- MC. Mass
      when 'PK3' then Result_ := '1';  -- MC. Electronic
      when 'PK4' then Result_ := '2';  -- MC. Gold
      when 'PK5' then Result_ := '4';  -- VISA Electron
      when 'PK6' then Result_ := '6';  -- VISA Classic
      when 'PK7' then Result_ := '7';  -- VISA Business
      when 'PK8' then Result_ := '8';  -- VISA Gold
      when 'PK9' then Result_ := '5';  -- VISA Domestic
      when 'PKA' then Result_ := '8';  -- VISA Gold
      when 'PKB' then Result_ := '2';  -- MC Gold
      when 'PKC' then Result_ := 'A';  -- MC Platinum
      when 'PKY' then Result_ := 'A';  -- MC Platinum
      else null;
    end case;
  END IF;
  IF mode_ = 3 THEN -- возвращаем сумму депозита
    CASE acc_tip_
      WHEN 'PK0' THEN Result_ := '';
      WHEN 'PK1' THEN Result_ := '';
      WHEN 'PK2' THEN Result_ := '';
        CASE acc_kv_
          WHEN 980 THEN Result_ := '500.00';
          WHEN 840 THEN Result_ := '100.00';
          ELSE          Result_ := '';
        END CASE;
      WHEN 'PK3' THEN Result_ := '';
      WHEN 'PK4' THEN Result_ := '';
        CASE acc_kv_
          WHEN 980 THEN Result_ := '8000.00';
          WHEN 840 THEN Result_ := '1600.00';
          ELSE          Result_ := '';
        END CASE;
      WHEN 'PK5' THEN Result_ := '';
      WHEN 'PK6' THEN
        CASE acc_kv_
          WHEN 980 THEN Result_ := '500.00';
          WHEN 840 THEN Result_ := '100.00';
          ELSE          Result_ := '';
        END CASE;
      WHEN 'PK7' THEN Result_ := '';
      WHEN 'PK8' THEN Result_ := '';
        CASE acc_kv_
          WHEN 980 THEN Result_ := '8000.00';
          WHEN 840 THEN Result_ := '1600.00';
          ELSE          Result_ := '';
        END CASE;
      WHEN 'PK9' THEN Result_ := '';
      WHEN 'PKA' THEN Result_ := '';
      WHEN 'PKB' THEN Result_ := '';
      WHEN 'PKC' THEN Result_ := '';
        CASE acc_kv_
          WHEN 980 THEN Result_ := '25000.00';
          WHEN 840 THEN Result_ := '5000.00';
          ELSE          Result_ := '';
        END CASE;
      WHEN 'PKY' THEN Result_ := '';
    END CASE;
  END IF;
  RETURN Result_;
end BPK_TIP_PSYS; 
/
 show err;
 
PROMPT *** Create  grants  BPK_TIP_PSYS ***
grant EXECUTE                                                                on BPK_TIP_PSYS    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bpk_tip_psys.sql =========*** End *
 PROMPT ===================================================================================== 
 