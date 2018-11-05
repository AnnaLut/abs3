

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_asvo_immobile_history.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view v_asvo_immobile_history ***

create or replace view v_asvo_immobile_history as
select decode(tag
              ,'FIO','ПІБ'
              ,'IDCODE','Ідентифікаційний код'
              ,'DOCTYPE','Документ'
              ,'PASP_S','Серія'
              ,'PASP_N','Номер'
              ,'PASP_W','Ким видано'
              ,'PASP_D','Коли видано'
              ,'BIRTHDAT','Дата народження'
              ,'BIRTHPL','Місце народження'
              ,'REGION','Область'
              ,'DISTRICT','Район'
              ,'CITY','Місто'
              ,'ADDRESS','Адреса'
              ,'PHONE_H','Телефон №1'
              ,'PHONE_J','Телефон №2'
              ,'FL','Статус'
              ,tag) tag, --Параметр
       key,
       old, --Старе значення
       new, --Нове значення
       chgdate, --Дата зміни
       donebuy, --Вніс зміни
       (select fio from staff$base where id = donebuy) fio --ПІБ користувача
  from asvo_immobile_history
;

PROMPT *** Create  grants  v_asvo_immobile_history ***
grant SELECT                                                                 on v_asvo_immobile_history        to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_asvo_immobile_history.sql =========*** End *** =====
PROMPT ===================================================================================== 
