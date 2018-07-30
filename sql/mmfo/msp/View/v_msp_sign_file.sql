PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_sign_file.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_sign_file ***

create or replace view v_msp_sign_file as
select id, bvalue from table(msp_utl.get_matching2sign(1,1));

PROMPT *** Create comments on v_msp_sign_file ***
comment on table v_msp_sign_file is 'Список конвертів для формування підпису файлу квитанції. Для TOSS';
comment on column v_msp_sign_file.id is 'id конверта';
comment on column v_msp_sign_file.bvalue is 'Буфер файла квитанції';


PROMPT *** Create  grants  v_msp_sign_file ***

grant select on v_msp_sign_file to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_sign_file.sql =========*** End *** =
PROMPT ===================================================================================== 
