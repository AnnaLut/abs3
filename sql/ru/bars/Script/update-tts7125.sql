delete  from chklist_tts where idchk=1 and  tt  in ('BMY','BNY');
update tts set nlsa=null where tt ='TO8';
commit; 
