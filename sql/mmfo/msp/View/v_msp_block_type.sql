PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_block_type.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_block_type ***

create or replace view v_msp_block_type as
select id, name from msp_block_type;

PROMPT *** Create comments on v_msp_block_type ***

comment on table v_msp_block_type is 'Типи блокувань особи';
comment on column v_msp_block_type.id is 'id типу блокування';
comment on column v_msp_block_type.name is 'Тип блокування';


PROMPT *** Create  grants  v_msp_block_type ***

grant select on v_msp_block_type to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_block_type.sql =========*** End *** =
PROMPT ===================================================================================== 
