SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET TRIMSPOOL    ON
SET TIMING       OFF

spool log\install.log

prompt ..........................................
prompt ... loading params
prompt ..........................................

@params.sql

prompt ..........................................
prompt ... dbname     = &&dbname
prompt ... bars_pass  = &&bars_pass
prompt ..........................................

prompt ..........................................
prompt ...
prompt ... Conecting as BARS to database &&dbname
prompt ...
prompt ..........................................

WHENEVER SQLERROR EXIT
conn bars/&&bars_pass@&&dbname
WHENEVER SQLERROR CONTINUE

prompt ...Модуль XOZ => Деб.заборг. за госп. діяльністю банку
select 'Інсталяція модуля XOZ '|| to_char(sysdate,'DD/MM/YYYY HH24:MI:SS') "Start at"   from dual;
@bars\Data\xoz_dat.sql 
-------------------------------------------------
prompt 1. Створення/Модифікація таблиць
@bars\Table\xoz_OB22_CL.sql 
@bars\Table\xoz_OB22.sql 

prompt 2. Функция бізнес-логіки 
@bars\Function\xoz_mdate.sql 
@bars\Data\xoz_mdat.sql
------------------------------------------

@bars\Table\xoz_PRG.sql 
@bars\Table\xoz_REF.sql 
@bars\Table\xoz_RU_CA.sql 
@bars\Table\xoz7_CA.sql 
-------------------------------
prompt 3. Триггер бизнес-логики
@bars\Trigger\tbu_accounts_xoz.sql 
-----------------------------------------------------------------------
prompt 4. Вюшки-гляделки 
@bars\View\v_xozref.sql
@bars\View\v_xozref2.sql
@bars\View\v_xozref_add.sql
@bars\View\v_xozacc.sql
@bars\View\v_xozkwt.sql
@bars\View\v_xoz_idz.sql
@bars\View\v_xozref_inv.sql
@bars\View\v_xoz_ru_ca.sql
@bars\View\v_xoz7_ca.sql
@bars\View\oper_xoz.sql
@bars\View\oper_xoz_nls.sql
@bars\View\oper_xoz_add.sql
@bars\View\v_xozob22_nls.sql
--------------------------------------------
@bars\Grant\grant_xoz.sql
--------------------------------------------
prompt 5. пакедж бізнес-логіки 
@bars\Package\xoz.sql 
----------------------------------
prompt 6. Опис Вюх-таблиць в БМД (ВЕБ) 
@bars\Data\bmd\xoz_ob22_cl.bmd 
@bars\Data\bmd\xoz_ob22.bmd 
@bars\Data\bmd\xoz_prg.bmd 
@bars\Data\bmd\v_xozref.bmd 
@bars\Data\bmd\v_xozrefi.bmd 
@bars\Data\bmd\v_xozref2.bmd 
@bars\Data\bmd\v_xozref_add.bmd
@bars\Data\bmd\v_xozacc.bmd 
@bars\Data\bmd\v_xozkwt.bmd
@bars\Data\bmd\v_xoz_idz.bmd
@bars\Data\bmd\v_xozref_inv.bmd 
@bars\Data\bmd\v_xoz_ru_ca.bmd 
@bars\Data\bmd\v_xoz7_ca.bmd 
@bars\Data\bmd\oper_xoz.bmd 
@bars\Data\bmd\oper_xoz_nls.bmd 
@bars\Data\bmd\oper_xoz_add.bmd 
@bars\Data\bmd\v_xozob22_nls.bmd 
----------------------------------------------------------------------
prompt 7. Створення ВЕБ-функцій та включення їх в ВЕБ-Арм XOZD = АРМ Деб.заборг. за госп. діяльністю банку
@bars\Data\xoz_adm_MONO_MFO_RU.sql 
-----------------------------------------------------------------------
prompt 8. Наповнення базов. довідників 
@bars\Data\xoz_w4.sql
-----------------------------------------------------------------------
prompt 9. Карточка спец.операції 441   
@bars\Data\tts\et_441.sql
--------------------------------

select to_char(sysdate,'DD/MM/YYYY HH24:MI:SS') "End at"   from dual;

spool off

quit
    