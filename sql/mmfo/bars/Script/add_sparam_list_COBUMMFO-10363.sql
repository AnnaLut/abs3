--Додавання можливості блокування рахунків на збільшенна через  Accreg.setAccountSParam
begin bc.go('/');
  accreg.set_sparam_list(p_name => 'BLKD',
                         p_semantic => 'Блокировка счета по дебету',
                         p_tab_nm => 'ACCOUNTS',
                         p_type => 'N');
  accreg.set_sparam_list(p_name => 'BLKK',
                         p_semantic => 'Блокировка счета по кредиту',
                         p_tab_nm => 'ACCOUNTS',
                         p_type => 'N');                         
  bc.home;
end ;
/
commit ;
