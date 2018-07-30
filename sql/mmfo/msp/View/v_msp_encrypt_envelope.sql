PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_encrypt_envelope.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_encrypt_envelope ***

create or replace view v_msp_encrypt_envelope as
select id, bvalue from table(msp_utl.get_matching2sign(2));

PROMPT *** Create comments on v_msp_encrypt_envelope ***
comment on table v_msp_encrypt_envelope is 'Список конвертів на шифрування файлу квитанції. Для TOSS';
comment on column v_msp_encrypt_envelope.id is 'id конверта';
comment on column v_msp_encrypt_envelope.bvalue is 'Буфер файла квитанції';

PROMPT *** Create  grants  v_msp_encrypt_envelope ***

grant select on v_msp_encrypt_envelope to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_encrypt_envelope.sql =========*** End *** =
PROMPT ===================================================================================== 
