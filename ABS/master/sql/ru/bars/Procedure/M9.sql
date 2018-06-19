create or replace procedure M9 ( p_mode int, --  0= только обнуление на 01.01.2018,  
                                             --  1= только помесячно: Cжатие + Переклассификация + Накат SNA+SDI+SDM+SDA+SDF+SRR+REZ
                                             --  9= Все
                                 p_Mfo varchar2,
                                 p_dat1 date,
                                 p_dat6 date 
                               ) is
 Beg_Dat01 date := NVL( p_dat1, to_date('01.01.2018','dd.mm.yyyy') );  
 End_Dat01 date := NVL( p_dat6, to_date('01.06.2018','dd.mm.yyyy') );
 ------------------------------------------------------------------------
 l_Dat01   date ;  l_msg1 varchar (200); l_msg2 varchar (200);  s_Dat01 char(10);

 procedure SEND_MSG( p_txt varchar2 ) is
 begin  --  if getglobaloption('BMS')='1'  then bms.enqueue_msg( p_txt, dbms_aq.no_delay, dbms_aq.never, gl.aUid );  end if;-- -- BMS Признак: 1-установлена рассылка сообщений
   bars_audit.info( p_txt );
 end SEND_MSG;

begin --Перевод КП 39 =>  9:
  --1) Обнуление REZ + SNA+SDI
  For k in (select b.* from  BANKS_RU b, mv_kf f where f.KF = b.MFO  and  b.MFO = NVL( p_MFO, b.MFO)  order by b.mfo ) 
  loop bc.GO( k.MFO ); l_msg1 := '(MSFZ9)'||k.MFO ||':'||K.name ;
       -------------------------------------------------------------------------------
       If p_mode in ( 0,9) then 
          l_Msg2 := '*ОБНУЛЕННЯ REZ + SNA + SDI' ;
          SeND_MSG (p_txt => 'BEG:' || l_Msg1 || l_Msg2 );
          Trans39.DEFORM ( p_acc => 0) ; commit;                  -- расформирование на 01.01.2018 по всем (p_acc=0) или по одному счету (p_acc = АСС)
          SeND_MSG (p_txt => 'END:' || l_Msg1 || l_Msg2 ); 
       end if ;
       -------------------------------------------------------------------------------

       If p_mode in ( 1, 9 ) then 
          -- 2) Помесячно  :
                l_Dat01 := Beg_Dat01 ;
          WHILE l_Dat01 <= End_Dat01    -- по месяцам
          LOOP  s_Dat01 := to_char (l_Dat01, 'dd.mm.yyyy') ;
                -------------------------------------------------------------------------------
                If gl.aMfo = '300465'  then
                   l_Msg2 := '*Перекласифікація КД за період з ' || CASE  WHEN l_Dat01 = Beg_Dat01  THEN '..........'  else  to_char( add_months(l_Dat01,-1), 'dd.mm.yyyy')  end  ||' по ' || s_Dat01 ;
                   SeND_MSG (p_txt => 'BEG:'  ||l_Msg1 || l_Msg2 );  
                   Trans39.AMOVE (l_Dat01 ) ;     commit; 
                   SeND_MSG (p_txt => 'END:'  ||l_Msg1 || l_Msg2 ); 
                end if ; 
                -------------------------------------------------------------------------------
                l_Msg2 := '*FV_МСФЗ9 => АБС: Обробка Вітрини, дата = '||s_Dat01 ;
                SeND_MSG (p_txt => 'BEG:' || l_Msg1 || l_Msg2 );     PUL_DAT(s_Dat01,null); 

                l_Msg2 := '*OSA: Прийом та стиснення інформації від FINEVARE, дата = '||s_Dat01 ;
                SeND_MSG (p_txt => 'BEG:' || l_Msg1 || l_Msg2 );     PRVN_FLOW.div39(1,l_Dat01);     commit; SeND_MSG (p_txt => 'END:' ||l_Msg1 || l_Msg2 ); 
                l_Msg2 := '*IRR: Формування проводок по SNA+SDI+SDM+SDA+SDF+SRR, дата = '||s_Dat01 ;
                SeND_MSG (p_txt => 'BEG:' || l_Msg1 || l_Msg2 );  Trans39.REFORM(l_Dat01,null,null); commit; SeND_MSG (p_txt => 'END:' ||l_Msg1 || l_Msg2 ); 

                --- --	  3) CR-351: *Пере-Формування Кредитного ризику НБУ-351			ONCE	Підтвердіть ЗВІТНУ дату !
                --	  4) RR-351:  Тільки Розподіл + Рівчачок для проводок			ONCE 	Підтвердіть ЗВІТНУ дату !
                --	  4.1 для ЦА =  Тільки ПЕРЕ-Розподіл ручних + Рівчачок			ONCE	Робимо ?
                --	  5) MAK: Створити/Переглянути Макет проводок по "Резерв-МСФЗ"			ONCE	Створити МАКЕТ ?
                --	  2902 - Звіт-помилки при формуванні резерву			ONCE	
                --	  6) ARE: Формування проводок по "Резерв-МСФЗ"			ONCE	Проводки виконуються по ФАКТУ. Сформувати ПРОВОДКИ = "ARE"  ?
                -------------------------------------------------------------------------------
               l_Dat01 := add_months(l_Dat01,+1) ;
               -------------------------------------------------------------------------------
          END LOOP  ;  -- по месяцам

       end if ; -- p_mode in ( 1, 9 )

   end loop ;  -- по МФО

end M9 ;
/

/*
begin  dbms_scheduler.drop_job(job_name => 'JOB_STA');
exception when others then  if sqlcode = -27475 then null; else raise; end if;
end;    
/

begin
  dbms_scheduler.create_job( job_name   => 'JOB_M9',
                             job_type   => 'PLSQL_BLOCK',
                             job_action => 'begin  bars.M9(p_mode=>1 , p_Mfo=>''300465'',p_dat1 => Null, p_dat6=> Null ) ; end ; ',
                             start_date => sysdate,
                             enabled    => true,
                             comments   => 'M9:Міграція з МСФЗ-39 на МСФЗ-9'
                           );
end;  
/

commit;

