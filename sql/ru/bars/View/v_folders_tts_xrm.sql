prompt create view bars.v_folders_tts_xrm

create or replace view bars.v_folders_tts_xrm
as
select  f.idfo,
		ft.tt,
		f.name 
from folders_tts ft
join folders f on f.idfo = ft.idfo;

grant select,delete,update,insert on bars.v_folders_tts_xrm to bars_access_defrole;