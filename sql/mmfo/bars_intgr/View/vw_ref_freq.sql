prompt view/vw_ref_freq.sql
create or replace force view bars_intgr.vw_ref_freq as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
                                            FREQ, 
                                            t.NAME, 
                                            NAME4DOC, 
                                            ALLOW_TERM 
                                            from bars.FREQ t;

comment on table BARS_INTGR.VW_REF_FREQ is 'Виды периодичности формирования выписок';
comment on column BARS_INTGR.VW_REF_FREQ.FREQ is 'Периодичность всяких событий (рассылка выписок, списани¤ процентов и т.д.)';
comment on column BARS_INTGR.VW_REF_FREQ.NAME is 'Наименование';
comment on column BARS_INTGR.VW_REF_FREQ.NAME4DOC is 'Наименование период-ти дл¤ печати в текстах договоров';
comment on column BARS_INTGR.VW_REF_FREQ.ALLOW_TERM is 'Мин.срок депозита, для которого разрешена период-ть';
