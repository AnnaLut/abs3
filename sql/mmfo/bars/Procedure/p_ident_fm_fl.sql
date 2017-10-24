

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_IDENT_FM_FL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_IDENT_FM_FL ***

  CREATE OR REPLACE PROCEDURE BARS.P_IDENT_FM_FL (p_num number ) is
-- ƒанные про последующую идентификацию клиентов дл€ ‘ћ

  G00_ IDENT_FM_FL.G00%type;
  G01_ IDENT_FM_FL.G01%type;
  G02_ IDENT_FM_FL.G02%type;
  G03_ IDENT_FM_FL.G03%type;
  G04_ IDENT_FM_FL.G04%type;
  G05_ IDENT_FM_FL.G05%type;
  G06_ IDENT_FM_FL.G06%type;
  G07_ IDENT_FM_FL.G07%type;
  G08_ IDENT_FM_FL.G08%type;
  G09_ IDENT_FM_FL.G09%type;
  G10_ IDENT_FM_FL.G10%type;
  G11_ IDENT_FM_FL.G11%type;
  G12_ IDENT_FM_FL.G12%type;

  fd_  varchar2(10) := 'DD/MM/YYYY';  -- формат дат
  l_first_dat  date;
  l_last_dat   date;
  l_rnk number;

  mm_   varchar2(2);
  yyyy_ varchar2(4);

begin

  -- подготавливаем даты
-------------------------------------------
-- вариант —бербанка:

 /* SELECT to_char(bankdate,'mm'),
         to_char(bankdate,'yyyy')
    INTO mm_, yyyy_ FROM dual;

  IF to_number(mm_) = 12 THEN
    mm_ := '01';
    yyyy_ := to_number(yyyy_)+1;
  ELSE
    mm_ := to_number(mm_)+1;
  END IF;

  select to_date('01/'||mm_||'/'||yyyy_,fd_) into l_first_dat from dual;  -- перва€ дата следующего мес€ца
  select last_day(to_date('01/'||mm_||'/'||yyyy_,fd_)) into l_last_dat from dual; -- последн€€ дата следующего мес€ца*/
-------------------------------

-- выбирала даты так:
-- select trunc(bankdate+30,'MM') into l_first_dat from dual;    -- перва€ дата следующего мес€ца
-- select last_day(trunc(bankdate+30,'MM')) into l_last_dat from dual;  -- последн€€ дата следующего мес€ца

-- попробуем так:
  select last_day(bankdate)+1 into l_first_dat from dual;    -- перва€ дата следующего мес€ца
  select last_day(last_day(bankdate)+1) into l_last_dat from dual;  -- последн€€ дата следующего мес€ца

-- выбираем тех, дл€ которых доп.реквизит даты последующей идентификации наступает в след.мес€це
for k in
   ( select rnk, nmk, okpo, to_date(f_get_custw_hlist(rnk, 'IDDPL', bankdate),fd_) pldat
       from customer
      where to_date(f_get_custw_hlist(rnk, 'IDDPL', bankdate),fd_) >=  l_first_dat
        and to_date(f_get_custw_hlist(rnk, 'IDDPL', bankdate),fd_) <=  l_last_dat
        and custtype = 3
        and sed not in (91, 34)
    )

  loop

    begin
      select g01 into l_rnk from ident_fm_fl where g01=k.rnk and g05=k.pldat;
    exception when no_data_found then

      begin

      G00_:=l_first_dat;
      G01_:=k.rnk;
      G02_:=null;   -- в будущем сделать k.branch;
      G03_:=k.NMK;
      G04_:=k.OKPO;
      G05_:=k.pldat;

      insert into IDENT_FM_FL
           (G00 , G01 , G02 , G03 , G04 , G05 , G06 , G07 , G08 , G09 , G10 , G11 , G12 )
         values
           (G00_, G01_, G02_, G03_, G04_, G05_, null, null, null, null, null, null, null);

      end;
    end;
  END LOOP;
commit;
end P_IDENT_FM_FL ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_IDENT_FM_FL.sql =========*** End
PROMPT ===================================================================================== 
