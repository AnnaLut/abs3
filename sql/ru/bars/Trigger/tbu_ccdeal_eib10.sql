

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_CCDEAL_EIB10.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_CCDEAL_EIB10 ***

CREATE OR REPLACE TRIGGER TBU_CCDEAL_EIB10
  before update of sos ON CC_DEAL
  for each row
  WHEN (old.sos < 10 and new.sos = 10 and new.vidd in (1,2,3))
declare
  l_cc_deal  cc_deal%rowtype;
  l_cprod    nd_txt.txt%type;
  l_cig_d13  varchar2(250);
  l_eibis    fm_yesno.id%type;
  l_nd_txt   nd_txt.nd%type;
  l_tag      nd_txt.tag%type;
  l_cusstype customer.custtype%type;
  l_sed      customer.sed%type;
begin
  select c.custtype, c.k050
    into l_cusstype, l_sed
    from customer c
   where c.rnk = :new.rnk;

  if (l_cusstype = 2 or (l_cusstype = 3 and l_sed = '910')) and
     :new.VIDD <> 26 then
    begin
      select value
        into l_cig_d13
        from mos_operw
       where nd = :new.nd
         and tag = 'CIG_D13';
    exception
      when no_data_found then
        bars_error.raise_nerror('CCK',
                                'NOT_FILLED_PARAM ',
                                'CIG_D13',
                                'CIG_D13 Статус договору');
    end;
    begin
      select txt
        into l_cprod
        from nd_txt
       where nd = :new.nd
         and tag = 'CPROD';
    exception
      when no_data_found then
        bars_error.raise_nerror('CCK',
                                'NOT_FILLED_PARAM ',
                                'CPROD',
                                'Кредитний продукт');
    end;
    begin
      select fyn.id
        into l_eibis
        from nd_txt nt, fm_yesno fyn
       where nt.txt = fyn.name
         and nd = :new.nd
         and tag = 'EIBIS';
    exception
      when no_data_found then
        bars_error.raise_nerror('CCK',
                                'NOT_FILLED_PARAM ',
                                'EIBIS',
                                'ЄІБ: Приналежність до ЄІБ');
    end;
  
    if l_eibis = 'YES' then
      for c in (select *
                  from cc_tag
                 where tag in ('EIBCW',
                               'EIBTV',
                               'EIBCR',
                               'EIBCE',
                               'EIBND',
                               'EIBNE',
                               'EIBIE',
                               'EIBCS',
                               'EIBSF',
                               'EIBPF',
                               'EIBCB')) loop
        begin
          select tag
            into l_tag
            from nd_txt
           where nd = :new.nd
             and tag = c.tag;
        exception
          when no_data_found then
            bars_error.raise_nerror('CCK',
                                    'NOT_FILLED_PARAM ',
                                    c.tag,
                                    c.name);
        end;
      end loop;
    end if;
  end if;

end tbu_ccdeal_eib10;

/
ALTER TRIGGER BARS.TBU_CCDEAL_EIB10 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_CCDEAL_EIB10.sql =========*** En
PROMPT ===================================================================================== 
