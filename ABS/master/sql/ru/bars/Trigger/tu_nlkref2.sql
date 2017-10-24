

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_NLKREF2.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_NLKREF2 ***

  CREATE OR REPLACE TRIGGER BARS.TU_NLKREF2 
after update of ref2 ON BARS.NLK_REF for each row
 WHEN (
new.ref2 is not null and old.ref2 is null
      ) declare
  l_cnt number;
  l_aa accounts%rowtype;
begin
/*
  15-05-2017 Викинув допреквізит 'W4MSG'  так як дубль спричинив невірну відправку перекредитованого документиа. 
  09-06-2004 Sta+Юрченко
  Наслед.доп.рекв - в курсоре.
  Было одним Select и теряли из-за exception when dup_val_on_index

  29-09-2009 Sta
  установить REF92 для прошлых операций.
  Триггер для наследования доп.реквизитов из первичного док
  при разработке картотеки кредиторов
  а также ссылка на перв реф.

  22-04-2013 mom
  Наследование BIS при перекредитовке на перекредитовку
*/

  l_cnt := 0;
  for c in (select *
            from   operw
            where  ref=:old.ref1 
			  and  tag not in ('W4MSG')
			)
  loop
    begin
      if c.tag='C01  ' then
        l_cnt := 1;
      end if;
      insert
      into   operw (ref,
                    tag,
                    value)
            values (:new.ref2,
                    c.tag    ,
                    c.value);
    exception when dup_val_on_index then
      null;
    end;
  end loop;

--begin
--  insert
--  into    operw (ref,
--                 tag,
--                 value)
--          select :new.ref2,
--                 tag      ,
--                 value
--          from   operw
--          where  ref=:old.ref1;
--exception when dup_val_on_index then
--  null;
--end;

--наследование доп. реквизитов (БИС) для внешних докумнетов
  for c in (select bis-1                      bis,
                   ltrim(rtrim(nazn,'#'),'#') nazn
            from   arc_rrp
            where  ref=:old.ref1 and bis>1)
  loop
    begin
      l_cnt := 1;
      insert
      into   operw (ref,
                    tag,
                    value)
            values (:new.ref2             ,
                    'C'||lpad(c.bis,2,'0'),
                    c.nazn);
    exception when dup_val_on_index then
      null;
    end;
  end loop;
  if l_cnt>0 then
    update oper
    set    bis=1
    where  ref=:new.ref2;
  end if;

end;
/
ALTER TRIGGER BARS.TU_NLKREF2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_NLKREF2.sql =========*** End *** 
PROMPT ===================================================================================== 
