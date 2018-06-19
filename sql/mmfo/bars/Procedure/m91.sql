create or replace procedure M91 ( p_Mfo varchar2,       p_dat1 date      ) is
 ------------------------------------------------------------------------
 l_msg2 varchar (200);  s_Dat01 char(10);

 procedure SEND_MSG( p_txt varchar2 ) is
 begin  if getglobaloption('BMS')='1'  then bms.enqueue_msg( p_txt, dbms_aq.no_delay, dbms_aq.never, gl.aUid );  end if;-- -- BMS �������: 1-����������� �������� ���������
   bars_audit.info( p_txt );
 end SEND_MSG;

begin --������� �� 39 =>  9:

       s_Dat01 := to_char (P_Dat1, 'dd.mm.yyyy') ;
       PUL_DAT(s_Dat01,null); 
       PUL_DAT(s_Dat01,null); 

       L_Msg2 := '*OSA: ������ �� ��������� ���������� �� FINEVARE, ���� = '||s_Dat01 ;
       SeND_MSG (p_txt => 'BEG:' || l_Msg2 );    
       rez9.div9_old(1, p_dat1);
       commit; 
       SeND_MSG (p_txt => 'END:' || l_Msg2 ); 

       l_Msg2 := '*IRR: ���������� �������� �� SNA+SDI+SDM+SDA+SDF+SRR, ���� = '||s_Dat01 ;
       SeND_MSG (p_txt => 'BEG:' || l_Msg2 );  
       Trans39.REFORM(p_dat1,0,3); 
       commit; 
       SeND_MSG (p_txt => 'END:' || l_Msg2 ); 
 
       l_Msg2 := '*������I� �������, ���� = '||s_Dat01 ;
       SeND_MSG (p_txt => 'BEG:' || l_Msg2 );  
       rez9.div9     (2, p_dat1 );   
       commit ;
       SeND_MSG (p_txt => 'END:' || l_Msg2 );  

       l_Msg2 := '*�������� �� �������, ���� = '||s_Dat01 ;
       SeND_MSG (p_txt => 'BEG:' || l_Msg2 );  
       rez9.PAY_23     ( p_dat1, 0, null, 0) ; 
       commit;
       SeND_MSG (p_txt => 'END:' || l_Msg2 );  


       l_Msg2 := '*̲������ �Ͳ���, ���� = '||s_Dat01 ;
       SeND_MSG (p_txt => 'BEG:' || l_Msg2 );  
       Trans39.snap9   ( p_dat1, gl.BD) ;   
       commit;
       SeND_MSG (p_txt => 'END:' || l_Msg2 );  
end M91 ;
/

SHOW ERR;