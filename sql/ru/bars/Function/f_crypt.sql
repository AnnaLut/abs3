
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_crypt.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CRYPT (p_s in varchar2 -- строка для шифрования
                                   ) return varchar2 is
  /*
  Простий алгоритм шифрування прізвища(алгоритм Цезаря).

  Шифрування:
  1. Визначається кількість символів у вхідній строці, яку потрібно зашифрувати;
  2. Кожен символ в строці заміюється на символ, який утворюється додаванням до ASCII - коду символа
     кількості символів у вхідній строці. Якщо новий ASCII - код виходить за межі кириличних символів,
     то береться символ з початку кирилиці на відповідну різницю виходу за межі.
  */

  l_ifront number := length(p_s);
  l_res    varchar2(4000);
  l_c      varchar2(1);
  l_cnew   varchar2(1);
begin
  for i in 1 .. l_ifront loop
    l_c := substr(p_s, i, 1);
    if (l_c < 'А' or l_c > 'я') then
      l_res := l_res || l_c;
    else
      l_cnew := chr(ascii(l_c) + l_ifront);
      if (l_cnew <= 'я') then
        l_res := l_res || l_cnew;
      else
        l_res := l_res || chr(ascii('А') + ascii(l_cnew) - ascii('я'));
      end if;
    end if;
  end loop;

  return l_res;
end f_crypt;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_crypt.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 