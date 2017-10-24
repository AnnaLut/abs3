

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SURVEY_REARRANGE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SURVEY_REARRANGE ***

  CREATE OR REPLACE PROCEDURE BARS.SURVEY_REARRANGE (surv_id_ number)
is
   num_ number;
   max_ number;
   ibeg_ number;
   old_ number;
begin
   -- проверим, что эта анкета редактируемая
   begin
      select survey_id into old_ from survey
       where survey_id=surv_id_ and activity=0;
   exception
    when no_data_found then
      return;
   end;
-- сначала отсортировать ГРУППЫ!!!
   select count(grp_id) into num_ from survey_qgrp where survey_id=surv_id_;
   select max(grp_id) into max_ from survey_qgrp;
   -- дизейблим констрейнты, чтобы потом спокойно менять индексы вопросов
   execute immediate 'ALTER TABLE survey_quest DISABLE CONSTRAINT FK_SURVEYQUEST_SURVEYQGRP';
   -- добавляем ко всем номерам вопросов (этой анкеты) удвоенный макс.номер
   -- при этом связанность сохраняется
   update survey_qgrp
      set grp_id = grp_id + 2*max_ + 1
    where survey_id=surv_id_;
   update survey_quest
      set qgrp_id = qgrp_id + 2*max_ + 1
    where survey_id=surv_id_;
   -- теперь ищем ближайшую к началу "дыру" размером с то количество групп, которое нам надо
   select min(g1.grp_id) into ibeg_ from survey_qgrp g1
    where not exists(select g2.grp_id from survey_qgrp g2 where g2.grp_id>g1.grp_id and g2.grp_id<g1.grp_id+num_+1);
   -- и перемещаем группы (уже по порядку, а не ID) в эту дыру
   for i in 1..num_ loop
       select grp_id into old_ from survey_qgrp where grp_ord=i and survey_id=surv_id_;
       update survey_quest
          set qgrp_id = ibeg_ + i
        where qgrp_id=old_;
       update survey_qgrp
          set grp_id = ibeg_ + i
        where grp_id=old_;
   end loop;
   -- и вернуть констрейнт
   execute immediate 'ALTER TABLE survey_quest ENABLE CONSTRAINT FK_SURVEYQUEST_SURVEYQGRP';

-- теперь отсортировать вопросы внутри групп
   select count(quest_id) into num_ from survey_quest where survey_id=surv_id_;
   select max(quest_id) into max_ from survey_quest;
   -- дизейблим констрейнты, чтобы потом спокойно менять индексы вопросов
   execute immediate 'ALTER TABLE survey_quest_dep DISABLE CONSTRAINT FK_SURVEYQDEP_SURVEYQUEST';
   execute immediate 'ALTER TABLE survey_quest_dep DISABLE CONSTRAINT FK_SURVEYQDEP_SURVEYQUEST2';
   -- добавляем ко всем номерам вопросов (этой анкеты) удвоенный макс.номер
   -- при этом связанность сохраняется
   update survey_quest_dep
      set quest_id = quest_id+2*max_+1
    where quest_id in (select quest_id from survey_quest where survey_id=surv_id_);
   update survey_quest_dep
      set child_id = child_id+2*max_+1
    where child_id in (select quest_id from survey_quest where survey_id=surv_id_);
   update survey_quest
      set quest_id = quest_id+2*max_+1
    where survey_id=surv_id_;
   -- теперь ищем ближайшую к началу "дыру" размером с то количество вопросов, которое нам надо
   select min(q1.quest_id) into ibeg_ from survey_quest q1
    where not exists(select q2.quest_id from survey_quest q2 where q2.quest_id>q1.quest_id and q2.quest_id<q1.quest_id+num_+1);
   -- и перемещаем вопросы (уже по порядку, а не ID) в эту дыру
   -- двойной цикл - по группам и по вопросам в группах
   for i in (select grp_id from survey_qgrp where survey_id=surv_id_ order by grp_id) loop
       -- по группам
       for j in (select quest_ord from survey_quest where survey_id=surv_id_ and qgrp_id=i.grp_id order by quest_ord) loop
           -- по ордам
           select quest_id into old_ from survey_quest where qgrp_id=i.grp_id and quest_ord=j.quest_ord;
           ibeg_ := ibeg_ + 1;
           update survey_quest_dep
              set quest_id = ibeg_
            where quest_id=old_;
           update survey_quest_dep
              set child_id = ibeg_
            where child_id=old_;
           update survey_quest
              set quest_id=ibeg_
            where quest_id=old_;
       end loop;
   end loop;
   -- и вернуть констрейнты
   execute immediate 'ALTER TABLE survey_quest_dep ENABLE CONSTRAINT FK_SURVEYQDEP_SURVEYQUEST';
   execute immediate 'ALTER TABLE survey_quest_dep ENABLE CONSTRAINT FK_SURVEYQDEP_SURVEYQUEST2';
   commit;
exception
 when no_data_found then
   -- если анкета не редактируемая или еще что
   NULL;
end Survey_rearrange;
/
show err;

PROMPT *** Create  grants  SURVEY_REARRANGE ***
grant EXECUTE                                                                on SURVEY_REARRANGE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SURVEY_REARRANGE to DPT_ADMIN;
grant EXECUTE                                                                on SURVEY_REARRANGE to DPT_ROLE;
grant EXECUTE                                                                on SURVEY_REARRANGE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SURVEY_REARRANGE.sql =========*** 
PROMPT ===================================================================================== 
