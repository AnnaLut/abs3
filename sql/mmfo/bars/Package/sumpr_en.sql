
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sumpr_en.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.SUMPR_EN is

type ta_number is table of number;
type ta_integer is table of integer;
type ta_vc_32 is table of varchar2(32);


  -- function ToWords форматирут число прописью
  function ToWord(number_ in number) return varchar2;
  function ToWord_currency(number_ in number,  kv tabval.kv%type) return varchar2;

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.SUMPR_EN is

  s_zero_en constant varchar2(32) :=   'zero';
  s_minus_en constant varchar2(32) :=  'negative';
  s_hundred_en constant varchar2(32) :='hundred';

  nw_eed constant ta_vc_32 := ta_vc_32('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine');  -- единицы (от 1 до 9)
  nw_eds constant ta_vc_32 := ta_vc_32('eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen',
                                       'seventeen', 'eighteen', 'nineteen');  -- от 11 до 19:
  nw_dds constant ta_vc_32 := ta_vc_32('ten', 'twenty', 'thirty', 'forty', 'fifty', 'sixty',
                                       'seventy', 'eighty', 'ninety');  -- десятки (10, 20 .. 90)
  nw_trs constant ta_vc_32 := ta_vc_32('thousand', 'million', 'billion', 'trillion', 'quadrillion', 'quintillion',
                                       'sextillion', 'septillion', 'octillion', 'nonillion', 'decillion', 'undecillion', '');  -- триады (по короткой шкале)
  nw_triads ta_integer := ta_integer(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

 function append(left_ in varchar2, delim_ in varchar2, right_ in varchar2) return varchar2 is
   begin
     if left_ is null then
       return right_;
     elsif right_ is null then
       return left_;
     else
       return left_||delim_||right_;
     end if;
    end;

 procedure lappend(dest_ in out varchar2, src_ in varchar2, delim_ in varchar2) is
   begin
     if dest_ is null then
      dest_ := src_;
     elsif src_ is not null then
      dest_ := src_||delim_||dest_;
    end if;
   end;

  procedure rappend(dest_ in out varchar2, src_ in varchar2, delim_ in varchar2) is
  begin
    if dest_ is null then
      dest_ := src_;
    elsif src_ is not null then
      dest_ := dest_||delim_||src_;
    end if;
  end;

  function ToWord (number_ in number) return varchar2
  is
    result  varchar2(4000);
    num     number(38, 0);
    tmp     number(38, 0);
    cnt     integer;
    triada  integer;

    e integer;
    d integer;
    h integer;
  begin
    if number_ is null then
      return null;
    elsif number_ = 0 then
      return s_zero_en;
    elsif number_ > 0 then
      num := number_;
      result := null;
    else
      num := -number_;
      result := s_minus_en;
    end if;

    -- разбиваем число на триады:
    cnt := 1;
    loop
      -- HINT: mod - дорогостоящая операция, поэтому здесь и далее вместо mod используется
      -- деление и вычитание с умножением
      --nw_triads(cnt) := num mod 1000;
      tmp := trunc(num / 1000);
      nw_triads(cnt) := num - tmp * 1000;
      exit when tmp = 0;
      num := tmp;
      cnt := cnt + 1;
    end loop;

    --  формируем строку слева направо:
    for i in reverse 1 .. cnt loop
      triada := nw_triads(i);

      if triada > 0 then
        --h := trunc(triada / 100);
        --d := trunc(triada / 10) mod 10;
        --e := triada mod 10;
        h := trunc(triada / 100);
        tmp := triada - h * 100;
        d := trunc(tmp / 10);
        e := tmp - d * 10;

        -- добавляем сотни
        if h > 0 then
          rappend(result, nw_eed(h) || ' ' || s_hundred_en, ' ');
        end if;

        -- добавляем десятки:
        if d > 0 then
          if d = 1 and e > 0 then
            rappend(result, nw_eds(e), ' ');
            e := 0;
          else
            rappend(result, nw_dds(d), ' ');
          end if;
        end if;

        -- добавляем единицы:
        if e > 0 then
          rappend(result, nw_eed(e), ' ');
        end if;

        -- добавляем полное наименование триады:
        if i > 1 then
          tmp := i - 1;
          rappend(result, nw_trs(tmp), ' ');
        end if;
      end if;
    end loop;

    return result;
  end;


 function ToWord_Currency (number_ in number, kv tabval.kv%type)
        return varchar2
is
l_int number :=0;
l_dec number :=0;
begin


l_int := trunc(number_);
l_dec := (number_- l_int)*100;

case kv
   when 840 then  return ToWord(l_int)||' dollars ' ||(l_dec)||' cents' ;
   when 978 then  return ToWord(l_int)||' euros ' ||l_dec||' cents' ;
   when 980 then  return ToWord(l_int)||' hryvnia ' ||l_dec||' kop' ;
else  return ToWord(l_int)||' ' ||ToWord(l_dec);
end case;

end;
end;
/
 show err;
 
PROMPT *** Create  grants  SUMPR_EN ***
grant EXECUTE                                                                on SUMPR_EN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SUMPR_EN        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/sumpr_en.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 