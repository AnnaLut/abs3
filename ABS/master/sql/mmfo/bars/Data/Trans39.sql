prompt ---------------------------------------------------------------
prompt 13. dannye tts  TIPS
prompt ---------------------------------------------------------------

exec BC.GO ('/');
update tts set flags = substr(flags,1,38) ||'1'|| substr(flags,40,38) where tt in ('ARE','IRR') ;
commit;

update tts set S3800 = '#(nbs_ob22(''3800'',IIF_S(#(NLSB),''6224'',''03'','''',''31'')))' WHERE TT= 'IRR';

COMMIT;

declare tt TIPS%Rowtype;
begin   tt.tip := 'SDI'; tt.name :='*SDI �/� "��������"~GENERAL' ; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;
        tt.tip := 'SDF'; tt.name :='*SDF �/� �� ��������~FV_ADJ' ; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;
        tt.tip := 'SDM'; tt.name :='*SDM �/� �� �������~MODIF'  ; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;
        tt.tip := 'SDA'; tt.name :='*SDA �/� "���������"~ACCRUAL'; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;
        tt.tip := 'SNA'; tt.name :='*SNA ������.���~AIRC_CC'     ; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;
        tt.tip := 'SRR'; tt.name :='*SRR ������.~� XLS'          ; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;

        tt.tip := 'XDI'; tt.name :='*SDI �� 2018' ; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;        ---------------------------------
        tt.tip := 'XN '; tt.name :='*SN  �� 2018' ; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;        ---------------------------------
        tt.tip := 'XNA'; tt.name :='*SNA �� 2018' ; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;        ---------------------------------
        tt.tip := 'XNO'; tt.name :='*SNO �� 2018' ; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;        ---------------------------------
        tt.tip := 'XP '; tt.name :='*SP  �� 2018' ; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;        ---------------------------------
        tt.tip := 'XPN'; tt.name :='*SPN �� 2018' ; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;        ---------------------------------
        tt.tip := 'XS '; tt.name :='*SS  �� 2018' ; update tips set name=tt.name where tip=tt.tip; if SQL%rowcount=0 then Insert into tips values tt ;  end if;        ---------------------------------
end;
/
COMMIT;
