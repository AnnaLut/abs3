begin

  begin 
  execute immediate 'ALTER TRIGGER barsaq.tu_oper_guard DISABLE';
  execute immediate 'ALTER TRIGGER tu_oper_guard DISABLE';  
  exception
    when others then null;
  end;

  bc.go(300465);

  update oper set nd = '4027'  where ref = 161220891901 and nd = 'FRS9$91901';
  update oper set nd = '5317/1886'  where ref = 161220892301 and nd = 'FRS9$92301';
  update oper set nd = '6060'  where ref = 161220892701 and nd = 'FRS9$92701';
  update oper set nd = '4088'  where ref = 161220893001 and nd = 'FRS9$93001';
  update oper set nd = '4029'  where ref = 161220893401 and nd = 'FRS9$93401';
  update oper set nd = '5315/1885'  where ref = 161220893701 and nd = 'FRS9$93701';
  update oper set nd = '633/1797'  where ref = 161212215201 and nd = 'FRS9$15201';
  update oper set nd = '633/1797'  where ref = 161212215401 and nd = 'FRS9$15401';
  update oper set nd = '633/1797'  where ref = 161212214801 and nd = 'FRS9$14801';
  update oper set nd = '633/1797'  where ref = 161212215601 and nd = 'FRS9$15601';
  update oper set nd = '31/КМУ'  where ref = 161212215301 and nd = 'FRS9$15301';
  update oper set nd = '31/КМУ'  where ref = 161212214901 and nd = 'FRS9$14901';
  update oper set nd = '156/6102'  where ref = 161212215801 and nd = 'FRS9$15801';
  update oper set nd = '55/КМУ'  where ref = 161212215101 and nd = 'FRS9$15101';
  update oper set nd = '122/КМУ'  where ref = 161212215701 and nd = 'FRS9$15701';
  commit;  
  bc.home;
  exception when others 
    then 
      bc.home;
      
      begin
      execute immediate 'ALTER TRIGGER barsaq.tu_oper_guard enable';
      execute immediate 'ALTER TRIGGER tu_oper_guard enable';      
      exception
        when others then null;
      end;


      bars_audit.error('CP: Перенумерація по заявці COBUMMFO-10041 впала.  '||SQLERRM||','||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      dbms_output.put_line('CP: Перенумерація по заявці COBUMMFO-10041 впала.  '||SQLERRM||','||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
end;
/
