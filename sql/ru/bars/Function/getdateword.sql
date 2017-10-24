
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getdateword.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETDATEWORD 
    ( i_dt in date, i_mode in number , i_dt_from date default null
    )
    RETURN VARCHAR2
    is
    l_str varchar2(100);
    l_str_month varchar2(100);
    l_str_year varchar2(100);
    l_str_decade varchar2(100);
    l_str_century varchar2(100);

    l_day number;
    l_month number;
    l_year number;
    l_century number;

    begin
    --l_str :=to_char(i_dt,'DD/MM/YYYY');
    if (i_mode in (1,2)) then
    select substr(to_char(i_dt, 'DD/MM/YYYY'),1,2), substr(to_char(i_dt, 'DD/MM/YYYY'),4,2),substr(to_char(i_dt, 'DD/MM/YYYY'),7,2) ,substr(to_char(i_dt, 'DD/MM/YYYY'),9,2)
    into l_day,l_month, l_century ,l_year
     from dual;
    else
    if (i_mode <>3) or (i_dt_from is null) then return l_str; end if;
    select trunc(mod(MONTHS_BETWEEN(i_dt, i_dt_from),1)*31),  trunc(mod(MONTHS_BETWEEN(i_dt, i_dt_from),12)), trunc(MONTHS_BETWEEN(i_dt, i_dt_from)/12)
    into l_day,l_month,l_year
    from dual;
    if i_dt_from>i_dt then l_str := 'Ќев≥рно задан≥ параметри: "ƒата з" б≥льше за "дата по" '; return l_str;  end if;
    if l_year>99 then l_str := 'Ќев≥рно задан≥ параметри: р≥зниц€ м≥ж датами б≥льше 100 рок≥в'; return l_str;  end if;
    end if;



    case
    when (l_day=1) then
     if (i_mode = 1) then l_str :='ѕершого'; else if (i_mode = 2) then  l_str :='ѕерше'; else l_str :='один день'; end if ; end if ;
    when (l_day=2) then
     if (i_mode = 1) then l_str :='ƒругого'; else if (i_mode = 2) then l_str :='ƒруге'; else l_str :='два дн≥'; end if ; end if ;
    when (l_day=3) then
     if (i_mode = 1) then l_str :='“ретього'; else if (i_mode = 2) then l_str :='“рете';  else l_str :='три дн≥'; end if ; end if ;
    when (l_day=4) then
     if (i_mode = 1) then l_str :='„етвертого'; else if (i_mode = 2) then l_str :='„етверте';  else l_str :='чотири дн≥'; end if ; end if ;
    when (l_day=5) then
     if (i_mode = 1) then l_str :='ѕ''€того'; else if (i_mode = 2) then l_str :='ѕ''€те';  else l_str :='п''€ть дн≥в'; end if ; end if ;
    when (l_day=6) then
     if (i_mode = 1) then l_str :='Ўостого'; else if (i_mode = 2) then l_str :='Ўосте';  else l_str :='ш≥сть дн≥в'; end if ; end if ;
    when (l_day=7) then
     if (i_mode = 1) then l_str :='—ьомого'; else if (i_mode = 2) then l_str :='—ьоме';  else l_str :='с≥м дн≥в'; end if ; end if ;
    when (l_day=8) then
     if (i_mode = 1) then l_str :='¬осьмого'; else if (i_mode = 2) then l_str :='¬осьме';   else l_str :='в≥с≥м дн≥в'; end if ; end if ;
    when (l_day=9) then
     if (i_mode = 1) then l_str :='ƒев''€того'; else if (i_mode = 2) then l_str :='ƒев''€те';  else l_str :='дев''€ть дн≥в'; end if ; end if ;
    when (l_day=10) then
     if (i_mode = 1) then l_str :='ƒес€того'; else if (i_mode = 2) then l_str :='ƒес€те'; else l_str :='дес€ть дн≥в'; end if ; end if ;
    when (l_day=11) then
     if (i_mode = 1) then l_str :='ќдинадц€того'; else if (i_mode = 2) then l_str :='ќдинадц€те';  else l_str :='одинадц€ть дн≥в'; end if ; end if ;
    when (l_day=12) then
     if (i_mode = 1) then l_str :='ƒванадц€того'; else if (i_mode = 2) then l_str :='ƒванадц€те';  else l_str :='дванадц€ть дн≥в'; end if ; end if ;
    when (l_day=13) then
     if (i_mode = 1) then l_str :='“ринадц€того'; else if (i_mode = 2) then l_str :='“ринадц€те';  else l_str :='тринадц€ть дн≥в'; end if ; end if ;
    when (l_day=14) then
     if (i_mode = 1) then l_str :='„отирнадц€того'; else if (i_mode = 2) then l_str :='„отирнадц€те'; else l_str :='чотирнадц€ть дн≥в'; end if ; end if ;
    when (l_day=15) then
     if (i_mode = 1) then l_str :='ѕ''€тнадц€того'; else if (i_mode = 2) then l_str :='ѕ''€тнадц€те';  else l_str :='п''€тнадц€ть дн≥в'; end if ; end if ;
    when (l_day=16) then
     if (i_mode = 1) then l_str :='Ў≥стнадц€того'; else if (i_mode = 2) then l_str :='Ў≥стнадц€те';  else l_str :='ш≥стнадц€ть дн≥в'; end if ; end if ;
    when (l_day=17) then
     if (i_mode = 1) then l_str :='—≥мнадц€того'; else if (i_mode = 2) then l_str :='—≥мнадц€те';  else l_str :='с≥мнадц€ть дн≥в'; end if ; end if ;
    when (l_day=18) then
     if (i_mode = 1) then l_str :='¬≥с≥мнадц€того'; else if (i_mode = 2) then l_str :='¬≥с≥мнадц€те';  else l_str :='в≥с≥мнадц€ть дн≥в'; end if ;end if ;
    when (l_day=19) then
     if (i_mode = 1) then l_str :='ƒев''€тнадц€того'; else if (i_mode = 2) then l_str :='ƒев''€тнадц€те';  else l_str :='дев''€тнадц€ть дн≥в'; end if ;end if ;
    when (l_day=20) then
     if (i_mode = 1) then l_str :='ƒвадц€того'; else if (i_mode = 2) then l_str :='ƒвадц€те';  else l_str :='двадц€ть дн≥в'; end if ; end if ;
    when (l_day=21) then
     if (i_mode = 1) then l_str :='ƒвадц€ть першого'; else if (i_mode = 2) then l_str :='ƒвадц€ть перше';  else l_str :='двадц€ть один день'; end if ;end if ;
    when (l_day=22) then
     if (i_mode = 1) then l_str :='ƒвадц€ть другого'; else if (i_mode = 2) then l_str :='ƒвадц€ть друге';   else l_str :='двадц€ть два дн≥'; end if ; end if ;
     when (l_day=23) then
     if (i_mode = 1) then l_str :='ƒвадц€ть третього'; else if (i_mode = 2) then l_str :='ƒвадц€ть трете';  else l_str :='двадц€ть три дн≥'; end if ; end if ;
    when (l_day=24) then
     if (i_mode = 1) then l_str :='ƒвадц€ть четвертого'; else if (i_mode = 2) then l_str :='ƒвадц€ть четверте';  else l_str :='двадц€ть чотири дн≥'; end if ; end if ;
    when (l_day=25) then
     if (i_mode = 1) then l_str :='ƒвадц€ть п''€того'; else if (i_mode = 2) then l_str :='ƒвадц€ть п''€те';  else l_str :='двадц€ть п''€ть дн≥в'; end if ; end if ;
    when (l_day=26) then
     if (i_mode = 1) then l_str :='ƒвадц€ть шостого'; else if (i_mode = 2) then l_str :='ƒвадц€ть шосте';  else l_str :='двадц€ть ш≥сть дн≥в'; end if ; end if ;
    when (l_day=27) then
     if (i_mode = 1) then l_str :='ƒвадц€ть сьомого'; else if (i_mode = 2) then l_str :='ƒвадц€ть сьоме';  else l_str :='двадц€ть с≥м дн≥в'; end if ; end if ;
    when (l_day=28) then
     if (i_mode = 1) then l_str :='ƒвадц€ть восьмого'; else if (i_mode = 2) then l_str :='ƒвадц€ть восьме';  else l_str :='двадц€ть в≥с≥м дн≥в'; end if ; end if ;
    when (l_day=29) then
     if (i_mode = 1) then l_str :='ƒвадц€ть дев''€того'; else if (i_mode = 2) then l_str :='ƒвадц€ть дев''€те';  else l_str :='двадц€ть дев''€ть дн≥в'; end if ; end if ;
    when (l_day=30) then
     if (i_mode = 1) then l_str :='“ридц€того'; else if (i_mode = 2) then l_str :='“ридц€те';  else l_str :='тридц€ть дн≥в'; end if ; end if ;
    when (l_day=31) then
     if (i_mode = 1) then l_str :='“ридц€ть першого'; else if (i_mode = 2) then l_str :='“ридц€ть перше';  else l_str :='тридц€ть один день'; end if ; end if ;
    else  l_str :='';
    end case;

    case
    when (l_month=1) then
     if (i_mode in (1,2)) then l_str_month :='с≥чн€'; else  l_str_month :='один м≥с€ць'; end if ;
    when (l_month=2) then
     if (i_mode in (1,2)) then l_str_month :='лютого'; else  l_str_month :='два м≥с€ц≥'; end if ;
    when (l_month=3) then
     if (i_mode in (1,2)) then l_str_month :='березн€'; else  l_str_month :='три м≥с€ц≥'; end if ;
    when (l_month=4) then
     if (i_mode in (1,2)) then l_str_month :='кв≥тн€'; else  l_str_month :='чотири м≥с€ц≥'; end if ;
    when (l_month=5) then
     if (i_mode in (1,2)) then l_str_month :='травн€'; else  l_str_month :='п''€ть м≥с€ц≥в'; end if ;
    when (l_month=6) then
     if (i_mode in (1,2)) then l_str_month :='червн€'; else  l_str_month :='ш≥сть м≥с€ц≥в'; end if ;
    when (l_month=7) then
     if (i_mode in (1,2)) then l_str_month :='липн€'; else  l_str_month :='с≥м м≥с€ц≥в'; end if ;
    when (l_month=8) then
     if (i_mode in (1,2)) then l_str_month :='серпн€'; else  l_str_month :='в≥с≥м м≥с€ц≥в'; end if ;
    when (l_month=9) then
     if (i_mode in (1,2)) then l_str_month :='вересн€'; else  l_str_month :='дев''€ть м≥с€ц≥в'; end if ;
    when (l_month=10) then
     if (i_mode in (1,2)) then l_str_month :='жовтн€'; else  l_str_month :='дес€ть м≥с€ц≥в'; end if ;
    when (l_month=11) then
     if (i_mode in (1,2)) then l_str_month :='листопада'; else  l_str_month :='одинадц€ть м≥с€ц≥в'; end if ;
    when (l_month=12) then
     if (i_mode in (1,2)) then l_str_month :='грудн€'; else  l_str_month :='дваданц€ть м≥с€ц≥в'; end if ;
    else l_str_month :='';
    end case;

     if (i_mode in (1,2)) then l_str := l_str|| ' ' || l_str_month; else  l_str := l_str_month|| ' ' || l_str ; end if ;

     if (i_mode in (1,2)) then
     case
     when (l_century=19) then
     l_str_century := 'одна тис€ча дев''€тсот';
     when (l_century=20) then
     l_str_century := 'дв≥ тис€ч≥';
     when (l_century=21) then
     l_str_century := 'дв≥ тис€ц≥ сто';
     end case;
     end if;

    case
    when ((l_year >20) and (l_year <30)) then  l_str_decade := 'двадц€ть'; l_year := substr(l_year,2);
    when ((l_year >30) and (l_year <40)) then  l_str_decade := 'тридц€ть'; l_year := substr(l_year,2);
    when ((l_year >40) and (l_year <50)) then  l_str_decade := 'сорок'; l_year := substr(l_year,2);
    when ((l_year >50) and (l_year <60)) then  l_str_decade := 'п''€тдес€т'; l_year := substr(l_year,2);
    when ((l_year >60) and (l_year <70)) then  l_str_decade := 'ш≥стдес€т'; l_year := substr(l_year,2);
    when ((l_year >70) and (l_year <80)) then  l_str_decade := 'с≥мдес€т'; l_year := substr(l_year,2);
    when ((l_year >80) and (l_year <90)) then  l_str_decade := 'в≥с≥мдес€т'; l_year := substr(l_year,2);
    when ((l_year >90) and (l_year <100)) then l_str_decade := 'дев''€носто'; l_year := substr(l_year,2);
    when (l_year =0 ) then l_str_century := 'двотис€чного'; l_year := substr(l_year,2);
    when (l_year =20) then l_str_decade := 'двадц€того'; l_year := substr(l_year,2);
    when (l_year =30) then l_str_decade := 'тридц€того'; l_year := substr(l_year,2);
    when (l_year =40) then l_str_decade := 'сорокового'; l_year := substr(l_year,2);
    when (l_year =50) then l_str_decade := 'п''€тидес€того'; l_year := substr(l_year,2);
    when (l_year =60) then l_str_decade := 'шестидес€того'; l_year := substr(l_year,2);
    when (l_year =70) then l_str_decade := 'семидес€того'; l_year := substr(l_year,2);
    when (l_year =80) then l_str_decade := 'восьмидес€того'; l_year := substr(l_year,2);
    when (l_year =90) then l_str_decade := 'дев''€ностого'; l_year := substr(l_year,2);

    else l_str_decade :='';
    end case;


     case
     when (l_year=1) then
     if (i_mode in ( 1,2))  then l_str_year :='першого'; else l_str_year :='один р≥к'; end if ;
    when (l_year=2) then
     if (i_mode in ( 1,2)) then l_str_year :='другого';  else l_str_year :='два роки'; end if ;
    when (l_year=3) then
     if (i_mode in ( 1,2)) then l_str_year :='третього';   else l_str_year :='три роки'; end if ;
    when (l_year=4) then
     if (i_mode in ( 1,2)) then l_str_year :='четвертого';   else l_str_year :='чотири роки'; end if ;
    when (l_year=5) then
     if (i_mode in ( 1,2)) then l_str_year :='п''€того'; else l_str_year :='п''€ть рок≥в'; end if ;
    when (l_year=6) then
     if (i_mode in ( 1,2)) then l_str_year :='шостого';  else l_str_year :='ш≥сть рок≥в'; end if ;
    when (l_year=7) then
     if (i_mode in ( 1,2)) then l_str_year :='сьомого';  else l_str_year :='с≥м рок≥в'; end if ;
    when (l_year=8) then
     if (i_mode in ( 1,2)) then l_str_year :='восьмого';  else l_str_year :='в≥с≥м рок≥в'; end if ;
    when (l_year=9) then
     if (i_mode in ( 1,2)) then l_str_year :='дев''€того';  else l_str_year :='дев''€ть рок≥в'; end if ;
    when (l_year=10) then
     if (i_mode in ( 1,2)) then l_str_year :='дес€того';  else l_str_year :='дес€ть рок≥в'; end if ;
    when (l_year=11) then
     if (i_mode in ( 1,2)) then l_str_year :='одинадц€того';  else l_str_year :='одинадц€ть рок≥в'; end if ;
    when (l_year=12) then
     if (i_mode in ( 1,2)) then l_str_year :='дванадц€того';   else l_str_year :='дванадц€ть рок≥в'; end if ;
    when (l_year=13) then
     if (i_mode in ( 1,2)) then l_str_year :='тринадц€того';   else l_str_year :='тринадц€ть рок≥в'; end if ;
    when (l_year=14) then
     if (i_mode in ( 1,2)) then l_str_year :='чотирнадц€того';  else l_str_year :='чотирнадц€ть рок≥в'; end if ;
    when (l_year=15) then
     if (i_mode in ( 1,2)) then l_str_year :='п''€тнадц€того';   else l_str_year :='п''€тнадц€ть рок≥в'; end if ;
    when (l_year=16) then
     if (i_mode in ( 1,2)) then l_str_year :='ш≥стнадц€того';   else l_str_year :='ш≥стнадц€ть рок≥в'; end if ;
    when (l_year=17) then
     if (i_mode in ( 1,2)) then l_str_year :='с≥мнадц€того';  else l_str_year :='с≥мнадц€ть рок≥в'; end if ;
    when (l_year=18) then
     if (i_mode in ( 1,2)) then l_str_year :='в≥с≥мнадц€того';   else l_str_year :='в≥с≥мнадц€ть рок≥в'; end if ;
    when (l_year=19) then
     if (i_mode in ( 1,2)) then l_str_year :='дев''€тнадц€того';   else l_str_year :='дев''€тнадц€ть рок≥в'; end if ;
    else l_str_year := '';
     end case;

     if (i_mode in ( 1,2)) then l_str_year := l_str_decade || ' ' || l_str_year|| ' року'; end if;

     if (i_mode in ( 1,2)) then
     l_str := l_str || ' ' || l_str_century || ' ' ||l_str_year;
     else
     l_str := l_str_year  || ' ' ||  l_str;
     end if;


    select replace(l_str,'  ', ' ') into l_str from dual;
    return l_str;
        END;
/
 show err;
 
PROMPT *** Create  grants  GETDATEWORD ***
grant EXECUTE                                                                on GETDATEWORD     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETDATEWORD     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getdateword.sql =========*** End **
 PROMPT ===================================================================================== 
 