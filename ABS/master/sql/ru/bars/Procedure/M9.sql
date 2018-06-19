create or replace procedure M9 ( p_mode int, --  0= ������ ��������� �� 01.01.2018,  
                                             --  1= ������ ���������: C����� + ����������������� + ����� SNA+SDI+SDM+SDA+SDF+SRR+REZ
                                             --  9= ���
                                 p_Mfo varchar2,
                                 p_dat1 date,
                                 p_dat6 date 
                               ) is
 Beg_Dat01 date := NVL( p_dat1, to_date('01.01.2018','dd.mm.yyyy') );  
 End_Dat01 date := NVL( p_dat6, to_date('01.06.2018','dd.mm.yyyy') );
 ------------------------------------------------------------------------
 l_Dat01   date ;  l_msg1 varchar (200); l_msg2 varchar (200);  s_Dat01 char(10);

 procedure SEND_MSG( p_txt varchar2 ) is
 begin  --  if getglobaloption('BMS')='1'  then bms.enqueue_msg( p_txt, dbms_aq.no_delay, dbms_aq.never, gl.aUid );  end if;-- -- BMS �������: 1-����������� �������� ���������
   bars_audit.info( p_txt );
 end SEND_MSG;

begin --������� �� 39 =>  9:
  --1) ��������� REZ + SNA+SDI
  For k in (select b.* from  BANKS_RU b, mv_kf f where f.KF = b.MFO  and  b.MFO = NVL( p_MFO, b.MFO)  order by b.mfo ) 
  loop bc.GO( k.MFO ); l_msg1 := '(MSFZ9)'||k.MFO ||':'||K.name ;
       -------------------------------------------------------------------------------
       If p_mode in ( 0,9) then 
          l_Msg2 := '*��������� REZ + SNA + SDI' ;
          SeND_MSG (p_txt => 'BEG:' || l_Msg1 || l_Msg2 );
          Trans39.DEFORM ( p_acc => 0) ; commit;                  -- ��������������� �� 01.01.2018 �� ���� (p_acc=0) ��� �� ������ ����� (p_acc = ���)
          SeND_MSG (p_txt => 'END:' || l_Msg1 || l_Msg2 ); 
       end if ;
       -------------------------------------------------------------------------------

       If p_mode in ( 1, 9 ) then 
          -- 2) ���������  :
                l_Dat01 := Beg_Dat01 ;
          WHILE l_Dat01 <= End_Dat01    -- �� �������
          LOOP  s_Dat01 := to_char (l_Dat01, 'dd.mm.yyyy') ;
                -------------------------------------------------------------------------------
                If gl.aMfo = '300465'  then
                   l_Msg2 := '*���������������� �� �� ����� � ' || CASE  WHEN l_Dat01 = Beg_Dat01  THEN '..........'  else  to_char( add_months(l_Dat01,-1), 'dd.mm.yyyy')  end  ||' �� ' || s_Dat01 ;
                   SeND_MSG (p_txt => 'BEG:'  ||l_Msg1 || l_Msg2 );  
                   Trans39.AMOVE (l_Dat01 ) ;     commit; 
                   SeND_MSG (p_txt => 'END:'  ||l_Msg1 || l_Msg2 ); 
                end if ; 
                -------------------------------------------------------------------------------
                l_Msg2 := '*FV_����9 => ���: ������� ³�����, ���� = '||s_Dat01 ;
                SeND_MSG (p_txt => 'BEG:' || l_Msg1 || l_Msg2 );     PUL_DAT(s_Dat01,null); 

                l_Msg2 := '*OSA: ������ �� ��������� ���������� �� FINEVARE, ���� = '||s_Dat01 ;
                SeND_MSG (p_txt => 'BEG:' || l_Msg1 || l_Msg2 );     PRVN_FLOW.div39(1,l_Dat01);     commit; SeND_MSG (p_txt => 'END:' ||l_Msg1 || l_Msg2 ); 
                l_Msg2 := '*IRR: ���������� �������� �� SNA+SDI+SDM+SDA+SDF+SRR, ���� = '||s_Dat01 ;
                SeND_MSG (p_txt => 'BEG:' || l_Msg1 || l_Msg2 );  Trans39.REFORM(l_Dat01,null,null); commit; SeND_MSG (p_txt => 'END:' ||l_Msg1 || l_Msg2 ); 

                --- --	  3) CR-351: *����-���������� ���������� ������ ���-351			ONCE	ϳ�������� �²��� ���� !
                --	  4) RR-351:  ҳ���� ������� + г������ ��� ��������			ONCE 	ϳ�������� �²��� ���� !
                --	  4.1 ��� �� =  ҳ���� ����-������� ������ + г������			ONCE	������ ?
                --	  5) MAK: ��������/����������� ����� �������� �� "������-����"			ONCE	�������� ����� ?
                --	  2902 - ���-������� ��� ��������� �������			ONCE	
                --	  6) ARE: ���������� �������� �� "������-����"			ONCE	�������� ����������� �� �����. ���������� �������� = "ARE"  ?
                -------------------------------------------------------------------------------
               l_Dat01 := add_months(l_Dat01,+1) ;
               -------------------------------------------------------------------------------
          END LOOP  ;  -- �� �������

       end if ; -- p_mode in ( 1, 9 )

   end loop ;  -- �� ���

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
                             comments   => 'M9:̳������ � ����-39 �� ����-9'
                           );
end;  
/

commit;

