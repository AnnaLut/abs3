

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_DEBREGTMP_CCOLOR.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_DEBREGTMP_CCOLOR ***

  CREATE OR REPLACE TRIGGER BARS.TIU_DEBREGTMP_CCOLOR 
before insert or update of eventtype on deb_reg_tmp for each row
--
-- триггер для уточнения раскраски записей Реестра должников
--
declare
	l_summ debreg_res_s.summ%type;
begin
	if :new.eventtype=1 then
		:new.ccolor := 1;
	else
		begin
            -- выбираем сумму последней записи о задолженности(по дате внесения)
			select summ
              into l_summ
              from debreg_res_s
             where debnum = :new.acc
               and regdatetime = (select max(regdatetime)
                                    from debreg_res_s
                                   where debnum = :new.acc
                                 )
               and rownum=1;
            --
			if :new.eventtype=3 then
				if :new.sum<>l_summ then
					:new.ccolor := 2;
				else
					:new.ccolor := 3;
				end if;
			elsif :new.eventtype=2 then
				if :new.sum<>l_summ then
					:new.ccolor := 2;
				end if;
			end if;
		exception when no_data_found then
			null;
		end;
    end if;
end tiu_debregtmp_ccolor;



/
ALTER TRIGGER BARS.TIU_DEBREGTMP_CCOLOR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_DEBREGTMP_CCOLOR.sql =========**
PROMPT ===================================================================================== 
