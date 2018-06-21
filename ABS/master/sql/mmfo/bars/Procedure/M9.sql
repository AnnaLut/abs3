CREATE OR REPLACE procedure BARS.M9 ( p_Mfo varchar2) is 

 Beg_Dat01 date := to_date('01.01.2018','dd.mm.yyyy') ;  
 End_Dat01 date := to_date('01.06.2018','dd.mm.yyyy') ;
 ------------------------------------------------------------------------
 l_Dat01   date ;  l_msg1 varchar (200); l_msg2 varchar (200);  s_Dat01 char(10);

 procedure SEND_MSG( p_txt varchar2 ) is
 begin  --  if getglobaloption('BMS')='1'  then bms.enqueue_msg( p_txt, dbms_aq.no_delay, dbms_aq.never, gl.aUid );  end if;-- -- BMS �������: 1-����������� �������� ���������
   bars_audit.info( p_txt );
 end SEND_MSG;

begin --������� �� 39 =>  9:
  --1) ��������� REZ + SNA+SDI
  For k in (select b.* from  BANKS_RU b, mv_kf f where f.KF = b.MFO  and  b.MFO = p_MFO  order by b.mfo ) 
  loop bc.GO( k.MFO ); l_msg1 := '(MSFZ9)'||k.MFO ||':'||K.name ;
       --- 1) ���� ��� 
        l_Msg2 := '*��������� REZ + SNA + SDI' ;
        SeND_MSG (p_txt => 'BEG:' || l_Msg1 || l_Msg2 );
        Trans39.DEFORM ( p_acc => 0) ; commit;                  -- ��������������� �� 01.01.2018 �� ���� (p_acc=0) ��� �� ������ ����� (p_acc = ���)
        SeND_MSG (p_txt => 'END:' || l_Msg1 || l_Msg2 ); 
        
        l_Msg2 := '* SNA = XNA' ;
        SeND_MSG (p_txt => 'BEG:' || l_Msg1 || l_Msg2 );
        RET9; COMMIT;
        SeND_MSG (p_txt => 'END:' || l_Msg1 || l_Msg2 ); 
                    
        l_Msg2 := '*������ ���.�� POCI' ;
        SeND_MSG (p_txt => 'BEG:' || l_Msg1 || l_Msg2 );
        REZ9.POCI ( to_date ('01-07-2018','dd-mm-yyyy') ) ; commit; 
        SeND_MSG (p_txt => 'END:' || l_Msg1 || l_Msg2 );
  
      -- 2) ���������  :
            l_Dat01 := Beg_Dat01 ;
      WHILE l_Dat01 <= End_Dat01    -- �� �������
      LOOP  s_Dat01 := to_char (l_Dat01, 'dd.mm.yyyy') ;
            l_Msg2 := '*FV_����9 => ���: ������� ³�����, ���� = '||s_Dat01 ;
            SeND_MSG (p_txt => 'BEG:' || l_Msg1 || l_Msg2 );     
            bc.GO( k.MFO ); 
            M91 ( p_Mfo,l_Dat01); 
            SeND_MSG (p_txt => 'END:' || l_Msg1 || l_Msg2 );
            l_dat01:= add_months( l_dat01, +1);
      END LOOP  ;  -- �� �������   
            
   end loop ;  -- �� ���

end M9 ;
/
