begin
 insert into dpt_vidd_flags(ID, NAME, DESCRIPTION, MAIN_TT, ONLY_ONE, MOD_PROC, ACTIVITY, REQUEST_TYPECODE, USED_EBP)
 values (38, 'ЗАЯВКА ПРО ВІДКРИТТЯ ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7', 'Формується для депозитів, відкритих в онлайн банкінгу', null, 1, null, 1, null, 1);
exception when dup_val_on_index then
 update dpt_vidd_flags
    set NAME = 'ЗАЯВКА ПРО ВІДКРИТТЯ ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7',
        DESCRIPTION='Формується для депозитів, відкритих в онлайн банкінгу', 
        MAIN_TT = null,
        ONLY_ONE = 1, 
        MOD_PROC = null, 
        ACTIVITY = 1, 
        REQUEST_TYPECODE = null, 
        USED_EBP = 1
  where id = 38;
end;
/  
 
begin
 insert into dpt_vidd_flags(ID, NAME, DESCRIPTION, MAIN_TT, ONLY_ONE, MOD_PROC, ACTIVITY, REQUEST_TYPECODE, USED_EBP)
 values (39, 'ЗАЯВКА ПРО ЗМІНУ РАХУНКУ ВИПЛАТИ ТІЛА ТА ВІДСОТКІВ ПО ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7', 'Формується для депозитів, відкритих в онлайн банкінгу', null, 1, null, 1, null, 1);
exception when dup_val_on_index then
 update dpt_vidd_flags
    set NAME = 'ЗАЯВКА ПРО ЗМІНУ РАХУНКУ ВИПЛАТИ ТІЛА ТА ВІДСОТКІВ ПО ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7',
        DESCRIPTION='Формується для депозитів, відкритих в онлайн банкінгу', 
        MAIN_TT = null,
        ONLY_ONE = 1, 
        MOD_PROC = null, 
        ACTIVITY = 1, 
        REQUEST_TYPECODE = null, 
        USED_EBP = 1
  where id = 39;
end;
/  

begin
 insert into dpt_vidd_flags(ID, NAME, DESCRIPTION, MAIN_TT, ONLY_ONE, MOD_PROC, ACTIVITY, REQUEST_TYPECODE, USED_EBP)
 values (40, 'ЗАЯВКА ПРО ВІДМОВУ ВІД АВТОМАТИЧНОЇ ПРОГОЛОНГАЦІЇ ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7', 'Формується для депозитів, відкритих в онлайн банкінгу', null, 1, null, 1, null, 1);
exception when dup_val_on_index then
 update dpt_vidd_flags
    set NAME = 'ЗАЯВКА ПРО ВІДМОВУ ВІД АВТОМАТИЧНОЇ ПРОГОЛОНГАЦІЇ ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7',
        DESCRIPTION='Формується для депозитів, відкритих в онлайн банкінгу', 
        MAIN_TT = null,
        ONLY_ONE = 1, 
        MOD_PROC = null, 
        ACTIVITY = 1, 
        REQUEST_TYPECODE = null, 
        USED_EBP = 1
  where id = 40;
end;
/  
commit;
/