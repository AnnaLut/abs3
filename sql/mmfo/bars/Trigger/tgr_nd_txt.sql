

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TGR_ND_TXT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TGR_ND_TXT ***

  CREATE OR REPLACE TRIGGER BARS.TGR_ND_TXT 
BEFORE INSERT OR UPDATE OR DELETE ON BARS.ND_TXT
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
/******************************************************************************
   NAME:       tgr_nd_txt

   PURPOSE:
 24-11-2015 DAV Добавил автономную Функцию для возможности чтения других значений теговдля договора с этой же таблицы


 28-02-2013 Для реструктуризации договоров Надра добавил возможность смены платежного дня по телу
            :NEW.TAG = 'DAYSS' для других пока не включал и в эталон сс_tag не добавлял.

 26-02-2013 По просьбе УПБ сделал возможность замены кода продукта через доп. параметы,
            TAG - NPROD для других пока не включал и в эталон сс_tag не добавлял.

 14-08-2012 OLGA Добавлен новый тег FREQP - периодичность погашения %%

 26-10-2011 Sta+Olga
            Отключили LIM из спец.парам, т.к. реплицируем автоматом
 23-03-2011  Nov Добавлен контроль за параметром FLAGS
                Добавлен новый тег FREQ - периодичность основного долга


           Для всех банков и типов схем.

               1. Контроль корректности ввода некоторых доп. реквизитов
                   'ZAYxx' - контроль за вводом ТЕГОВ из заявки на КД из веба
                   'FLAGS' - тип и вид погашения см. представление v_cc_flags
                   'FREQ'  - изменение периодичености погашения основного долга
                   'S_SDI' - сумма дисконта
                   'R_CR9' - процентная ставка за неиспользованный лимит
                   'SN8_R' - процентная ставка пени (пусто использовать базовую из
                              гл. параметра SPN_BRI)
                             + Замена проц. ставки пени по уже отрытым
                               счетам  c текущей банковской даты
                             с заполнеными  счетами доходов и расходов  по пене (id=2)
                   'DAYSN' - день погашения %
                   'DATSN' - первая дата погашения %
                   'S260'  - простановка спецпараметра по всем счетам договора


               2. Удалить тригера TIU_ND_TXT_NBU
                                  TIU_ND_TXT_SLV
                  как дублирующие логику

******************************************************************************/

DECLARE


 tmpVar NUMBER(20,4);

 l_new_SN8_R number(20,4):=null;
 l_old_SN8_R number(20,4):=null;
 nTemp int;
 dTemp date;
 SPN_BRI_ int;
 err_ Varchar2(150);
 flg_ boolean;
 i_ int:=0;                      -- переменная для цикла
 l_vidd  number;

 TYPE var_date IS TABLE OF VARCHAR(20);  --   массив для вариантов преобразования в дату
 v_date_ var_date:=var_date(null,'ddmmyyyy','dd.mm.yyyy','ddmmyy','dd.mm.yy','yyyymmdd','yyyy.mm.dd','yymmdd','yyyyddmm','mmddyyyy','DD MONTH YYYY');


 /******************************************************************************/
 --   PRAGMA AUTONOMOUS_TRANSACTION;
 --  Функциядля для вззможности выполнения чтения значений других тегов договора
 --  в пределах одной трансакции

  function  get_nd_txt( p_nd number, -- Номер длговора
                        p_tag1 varchar2, -- Таг, значение которого хотим получить для договора, для дальнейшего использования
                        p_tag2 varchar2, -- Таг для которого хотим получить (ввел что бы не накрутить сам на себя)
                        p_txt varchar2   -- Значение тага для которого хотим получить (ввел что бы не накрутить сам на себя)
                      ) return varchar2
  IS
    pragma autonomous_transaction;
  begin
    if p_tag1<> p_tag2 then
    return (cck_app.Get_ND_TXT(p_nd,p_tag1));
    else
    return p_txt;
    end if;
  end;


BEGIN
  tmpVar := 0;
  flg_:=false;

------------------------------ контроль за вводом ТЕГОВ из заявки на КД из веба-----------------
------------------------------см. cck_dop.cc_open ----------------------------

  if INSERTING OR UPDATING then
   if trim(:NEW.TXT) is not null then

     if :NEW.TAG in ('ZAY0P','ZAY2P','ZAY4P','ZAY6P','ZAY8P') then
       begin
         select pawn into tmpVar from cc_pawn where pawn=:NEW.TXT and pawn not in (select pawn from cc_pawn where nbsz=9031);
       exception when others then raise_application_error(-20100,'Введено не iснуюче значення типу застави!');
       end;
     end if;

     if :NEW.TAG in ('ZAY1P','ZAY3P','ZAY5P','ZAY7P','ZAY9P') then
       begin
         select pawn into tmpVar from cc_pawn where pawn=:NEW.TXT and pawn  in (select pawn from cc_pawn where nbsz=9031);
       exception when others then raise_application_error(-20100,'Введено не iснуюче значення типу поруки!');
       end;
     end if;

     if :NEW.TAG like 'ZAY_S' then
       begin
         select to_number(translate(:NEW.TXT,'.',','),'99999999999D99', ' NLS_NUMERIC_CHARACTERS = '',.''')
           into tmpVar from dual;
       exception when others then raise_application_error(-20100,'Введена не вiрна сума застави = '||:NEW.TXT);
       end;
     end if;

     if :NEW.TAG like 'ZAY_R' then
       begin
         select rnk into tmpVar from customer  where rnk=:NEW.TXT;
       exception when others then raise_application_error(-20100,'Введений не вiрний код заставника = '||:NEW.TXT);
       end;
     end if;

   end if;

  end if;

--------------------------- Периодичность погашения основного долга -----------------------------------------

  if :new.TAG='FREQ' then
     begin
       select freq into tmpVar from freq where freq=to_number(:NEW.TXT);
     EXCEPTION  WHEN OTHERS THEN RAISE_APPLICATION_ERROR (-20000,'Зазначений не вірний код періодичності погашення основного боргу FREQ='||:NEW.TXT);
     end;
     update cc_add set freq=to_number(:new.TXT) where nd=:NEW.ND and adds=0;
  end if;

--------------------------- Периодичность погашения %% -----------------------------------------

  if :new.TAG='FREQP' then
     begin
       select freq into tmpVar from freq where freq=to_number(:NEW.TXT);
     EXCEPTION  WHEN OTHERS THEN RAISE_APPLICATION_ERROR (-20000,'Зазначений не вірний код періодичності погашення %% FREQP='||:NEW.TXT);
     end;
     update int_accn set freq = to_number(:new.TXT)
      where id = 0 and acc = (select a.acc
                                from nd_acc n, accounts a
                               where n.nd = :NEW.ND and n.acc = a.acc and a.tip = 'LIM' and a.nls like '8999%');
  end if;

-------------------------- Флаги ------------------------------------

  if :new.TAG='FLAGS' then
     begin
      select kod into tmpVar from v_cc_flags where kod=:NEW.TXT;
     EXCEPTION  WHEN OTHERS THEN  RAISE_APPLICATION_ERROR (-20000,'Указан неверный код Флагов атрибута  FLAGS='||:NEW.TXT);
     end;
  end if;

-------------------------- Дисконт ------------------------------------

  if :NEW.TAG like 'S_SDI' then
     begin
       select cck_app.to_number2(:NEW.TXT) into tmpVar from dual;
     exception when others then  raise_application_error(-20100,'Введена не вiрна сума комiсiї(дисконту) = '||:NEW.TXT);
     end;
  end if;

-------------------------- Признак траншевости ------------------------------------

  if :NEW.TAG = 'PR_TR' and :NEW.TXT is not null then
     -- проверка перевода безтраншевой в траншевую (НЕЛЬЗЯ!, обратно - можно)
     if :OLD.TXT = 0 and :NEW.TXT = 1 then raise_application_error(-20100,'Неможливе переведення безтраншевої лінії в траншеву!');   end if;
     if :OLD.TXT = 1 and nvl(:NEW.txt,0) = 0 then
         delete from cc_trans where acc in (select acc from nd_acc where nd = :NEW.ND);
     end if;
     select vidd into l_vidd from cc_deal where nd = :NEW.ND;
     begin
     -- проверка корректности ввода
       select cck_app.to_number2(:NEW.TXT) into tmpVar from dual;
     exception when others then  raise_application_error(-20100,'Введена некоректна ознака траншевості '||:NEW.TXT);
     end;
     -- проверка корректности значения
     if tmpVar not in (0,1) then  raise_application_error(-20100,'Введена невiрна ознака траншевості '||:NEW.TXT); end if;
     -- невозможность установки траншевости для стандартного ЮО
     if (tmpVar = 1 and l_vidd = 1) then raise_application_error(-20100,'Неможливо встановити ознаку траншів для стандартного КД ЮО!'); end if;
     -- проверка возобновляемости
     if (tmpVar = 1 and nvl(get_nd_txt(:NEW.ND,'I_CR9',:NEW.TAG, :NEW.TXT),0) = 1) then raise_application_error(-20100,'Неможливо встановити ознаку траншів для непоновлюваної КЛ!'); end if;
  end if;

------------------------- Невикористаний ліміт------------------------------

  if :NEW.TAG like 'R_CR9' and :NEW.TXT is not null then
     begin
       select cck_app.to_number2(:NEW.TXT) into tmpVar from dual;
     exception when others then raise_application_error(-20100,'Введена не вiрна % ставка невикористаного ліміту !'||:NEW.TXT);
     end;
  end if;

------------------------- ПЕНЯ ---------------------------------------------

  if :NEW.TAG = 'SN8_R' or :OLD.TAG = 'SN8_R' then
     begin
       if :NEW.TXT is not null then
            :NEW.TXT:=translate(:NEW.TXT,',-','.');
            select cck_app.to_number2(:NEW.TXT) into l_new_SN8_R from dual;
       end if;
     exception when others then raise_application_error(-20100,'Не вірно вказан відсоток пені = '||:NEW.TXT);
     end;
     begin
       select abs(cck_app.to_number2(:OLD.TXT)) into l_old_SN8_R from dual;
     exception when others then l_old_SN8_R:=null;
     end;
     if nvl(l_new_SN8_R,-1)!=nvl(l_old_SN8_R,-1) then
         SPN_BRI_ := to_number(GetGlobalOption('SPN_BRI')) ; -- Базовая ставка пени;
         if SPN_BRI_ is not null then
            delete from int_ratn i where i.id=2 and i.bdat=gl.bdate and i.acc in
                       (select a.acc from nd_acc n,accounts a,int_accn ia where n.nd=nvl(:OLD.ND,:NEW.ND)
                           and ia.acc=a.acc and ia.id=2 and ia.acra is not null and ia.acrb is not null
                           and n.acc=a.acc and a.tip in ('SP ','SL ','SPN','SLN','SK9'));
            -- если l_new_SN8_R=null тогда ставим базовую ставку
            INSERT INTO INT_RATN (ACC,ID,BDAT,IR,op,br)
                           select a.acc,2,gl.bdate, nvl(l_new_SN8_R,2), decode(l_new_SN8_R,null,3,null),decode(l_new_SN8_R,null,SPN_BRI_,null)
                             from nd_acc n,accounts a,int_accn ia
                             where n.nd=nvl(:OLD.ND,:NEW.ND) and ia.acc=a.acc and ia.id=2
                               and ia.acra is not null and ia.acrb is not null
                               and n.acc=a.acc and a.tip in ('SP ','SL ','SPN','SLN','SK9');
         end if;
     end if;
  end if;


----------------- Контроль ввода и смены  дня  погашения тела  ------------


    if :NEW.TAG = 'DAYSS' and :NEW.TXT is not null  then
     begin
         :NEW.TXT:=translate(:NEW.TXT,',-','.');
         select cck_app.to_number2(:NEW.TXT)
           into nTemp
           from dual;
      if nTemp>31 or nTemp<1 then
         err_:='Не вірно вказано день погашення основного боргу = ';
      else
         :NEW.TXT:=to_char(nTemp);
         update int_accn set s=nTemp where id=0 and acc in ( select a.acc from accounts a, nd_acc na where a.tip='LIM' and a.acc=na.acc and na.nd=:NEW.ND);
      end if;
     exception when others then
      err_:='Не вірно вказано день погашення основного боргу = ';
     end;
    end if;



------------------ Контроль ввода дня и даты первого погашения % ------------

  if :NEW.TAG = 'DAYSN' and :NEW.TXT is not null  then
       begin
         :NEW.TXT:=translate(:NEW.TXT,',-','.');
         select cck_app.to_number2(:NEW.TXT) into nTemp from dual;
         if nTemp>31 or nTemp<1 then err_:='Не вірно вказано день погашення відсотків = ';
         else :NEW.TXT:=to_char(nTemp);
         end if;
       exception when others then err_:='Не вірно вказано день погашення відсотків = ';
       end;
  end if;

  if :NEW.TAG = 'DATSN' and :NEW.TXT is not null  then
       i_:=v_date_.first;
       while flg_=false and i_<=v_date_.last
         loop
            begin
               if v_date_(i_) is null then dTemp:=to_date(:NEW.TXT);
               else dTemp:=to_date(:NEW.TXT,v_date_(i_),'NLS_DATE_LANGUAGE = Russian');
               end if;

               if dTemp>=(nvl(bankdate,sysdate)-100*365) and dTemp<(nvl(bankdate,sysdate)+30*365) then
                  flg_:=true;
                    :NEW.TXT:=to_char(dTemp,'dd/mm/yyyy') ;
               else  select (case when dTemp<=a.bdate then 'Дата погашення не може бути меньше дати видачі! '||:NEW.TXT
                                  when dTemp>=d.wdate then 'Дата погашення не може бути більши дати закінчення договора!'||:NEW.TXT
                                  else null
                             end)
                       into err_
                       from cc_deal d,cc_add a
                      where d.nd=a.nd and d.nd=:NEW.ND;
               end if;
            EXCEPTION WHEN OTHERS THEN null;
            end;
         i_:=v_date_.next(i_);
         end loop;
       if flg_=false then  err_:='Не вірно вказано формат дати першого погашення відсотків. ';
       end if;
  end if;

------------------------- Контроль спецпараметров -------------------------

--------------------------- S260 -----------------------------------------

  if :new.TAG='S260' then
     if :new.TXT is not null then
        :new.TXT:=lpad (:new.TXT,2,'00');
        begin
           select s260 into tmpVar from kl_s260 where s260=:NEW.TXT;
           EXCEPTION  WHEN OTHERS THEN RAISE_APPLICATION_ERROR (-20000,'Указан неверный код справочника S260');
        end;
     end if;
     update specparam set S260=:new.TXT  where acc in (select a.acc from accounts a,nd_acc n
                                                        where n.nd=:NEW.ND and n.acc=a.acc and  a.dazs is null
                                                          and a.tip in ('SS ','SP ','SL ','SN ','SPN','SK0','SK9','CR9','LIM'));
  end if;

--------------------------- Признак стуктурного подразделения  пишем в события по КД -----------------------------------------

  if :new.TAG='SPOK'  then
     Insert into BARS.CC_SOB (     ND,    FDAT,   ID,  ISP,                                                                                  TXT, OTM, FREQ)
                      Values (:new.ND, sysdate, null,  gl.aUID, 'Змінено стуктурний підрозділ,  обсуговуючий кредит з '||:OLD.TXT ||' на '||:NEW.TXT,   6,    2);
  end if;


------------------------- Смена продукта для УПБ ------------------------------

  if :NEW.TAG = 'NPROD' and :NEW.TAG is not null then
    update cc_deal set prod=:NEW.TXT where nd=:NEW.ND;
     Insert into BARS.CC_SOB (     ND,    FDAT,   ID,  ISP,                                                                                  TXT, OTM, FREQ)
                      Values (:new.ND, sysdate, null,user_id, 'Змінено код продукту на '||:NEW.TXT,   6,    2);
  end if;

if err_ is not null then
     raise_application_error(-20100,err_||:NEW.TXT);
end if;

END tgr_nd_txt;


/
ALTER TRIGGER BARS.TGR_ND_TXT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TGR_ND_TXT.sql =========*** End *** 
PROMPT ===================================================================================== 
