create or replace view v_mfo_ru as
	select '%' id, '�� ���' name from dual
	union all
	select br.mfo id, br.name name from BANKS_RU br;
