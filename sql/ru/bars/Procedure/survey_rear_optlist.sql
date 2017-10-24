

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SURVEY_REAR_OPTLIST.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SURVEY_REAR_OPTLIST ***

  CREATE OR REPLACE PROCEDURE BARS.SURVEY_REAR_OPTLIST (list_id_ number)
is
   num_ number;
   max_ number;
   ibeg_ number;
   old_ number;
begin
   select count(opt_id) into num_ from survey_answer_opt where list_id=list_id_;
   select max(opt_id) into max_ from survey_answer_opt;
   -- дизейблим констрейнты, чтобы потом спокойно менять индексы ответов
   execute immediate 'ALTER TABLE survey_quest_dep DISABLE CONSTRAINT FK_SURVEYQDEP_SURVEYANSWOPT';
   -- добавляем ко всем номерам вопросов (этой анкеты) удвоенный макс.номер
   -- при этом связанность сохраняется
   update survey_quest_dep
      set opt_id = opt_id + 2*max_ + 1
    where quest_id in (select quest_id from survey_quest where list_id=list_id_);
   update survey_answer_opt
      set opt_id = opt_id + 2*max_ + 1
    where list_id=list_id_;
   -- теперь ищем ближайшую к началу "дыру" размером с то количество ответов, которое нам надо
   select min(o1.opt_id) into ibeg_ from survey_answer_opt o1
    where not exists(select o2.opt_id from survey_answer_opt o2 where o2.opt_id>o1.opt_id and o2.opt_id<o1.opt_id+num_+1);
   -- и перемещаем ответы (уже по порядку, а не ID) в эту дыру
   for i in 1..num_ loop
       select opt_id into old_ from survey_answer_opt where opt_ord=i and list_id=list_id_;
       update survey_quest_dep
          set opt_id = ibeg_ + i
        where opt_id=old_;
       update survey_answer_opt
          set opt_id = ibeg_ + i
        where opt_id=old_;
   end loop;
   -- и вернуть констрейнт
   execute immediate 'ALTER TABLE survey_quest_dep ENABLE CONSTRAINT FK_SURVEYQDEP_SURVEYANSWOPT';
--   commit;
exception
 when others then
   rollback;
end Survey_rear_optlist;
/
show err;

PROMPT *** Create  grants  SURVEY_REAR_OPTLIST ***
grant EXECUTE                                                                on SURVEY_REAR_OPTLIST to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SURVEY_REAR_OPTLIST.sql =========*
PROMPT ===================================================================================== 
