begin
delete from ps_tts where nbs in('2620', '2600', '2650');
end;
/

begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''M19'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''0_5'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''0_5'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''0_6'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''0_6'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''0_6'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''059'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä06'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''SC0'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''SC1'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä14'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä14'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä17'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä17'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä18'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä18'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä19'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä19'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä20'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä20'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä21'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä21'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä22'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä22'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä23'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä23'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä06'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''F80'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''F80'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''K69'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''K24'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''K24'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''405'', ''2600'', 1, ''01'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''405'', ''2620'', 1, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''315'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''K20'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''K20'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''PKR'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''BR4'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''BR4'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00D'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00D'', ''2620'', 0, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00D'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''807'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''807'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''BRP'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''BRP'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DM0'', ''2620'', 1, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''KC0'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''KC0'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''KC0'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DMA'', ''2620'', 1, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''178'', ''2600'', 1, ''01'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''178'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DUM'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DP9'', ''2620'', 0, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''425'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''510'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''510'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''K0H'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00H'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00H'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''328'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''328'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''329'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''424'', ''2620'', 1, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''GOR'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''GOR'', ''2620'', 0, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''GOR'', ''2620'', 0, ''28'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''GOR'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''F10'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''F10'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''001'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''001'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''001'', ''2620'', 0, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''001'', ''2620'', 1, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''001'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''001'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''215'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''W43'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''K26'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''D26'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''ST1'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''191'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV7'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV7'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV7'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''W43'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV7'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV7'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV7'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''ST2'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''MUT'', ''2620'', 0, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''PPF'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''W4E'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä37'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä38'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä44'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''Ä45'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DM1'', ''2620'', 0, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DBF'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''K0F'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''075'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''064'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''065'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''002'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''002'', ''2620'', 0, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''002'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00F'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''005'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''005'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''0_8'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00C'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00C'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''190'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''190'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''190'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''100'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''100'', ''2620'', 0, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''100'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''100'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''100'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DMB'', ''2620'', 0, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DMI'', ''2620'', 0, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DMI'', ''2620'', 1, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DMJ'', ''2620'', 0, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DML'', ''2620'', 1, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DMP'', ''2620'', 0, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''C65'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''079'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''MM2'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''MM2'', ''2620'', 0, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''MM2'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''302'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''302'', ''2620'', 1, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''BR2'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''066'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''BR2'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''PK!'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''0_9'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''MUZ'', ''2620'', 1, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''PKB'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''PKB'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''006'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''006'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''006'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CNU'', ''2620'', 1, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV0'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV0'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV0'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''072'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''073'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''074'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV0'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''MUJ'', ''2620'', 1, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''MUU'', ''2620'', 1, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''003'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''K66'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''435'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''023'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''W2P'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''P2W'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV6'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV6'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV6'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV6'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV6'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''USM'', ''2620'', 0, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00F'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''C07'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DPO'', ''2620'', 0, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''USV'', ''2620'', 0, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''MIL'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''MIL'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DPE'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''GO8'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''02A'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''02A'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''K62'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''OW4'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''PKD'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''PKD'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''428'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''429'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''445'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''445'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''445'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''OW4'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00E'', ''2620'', 0, ''32'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''100'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''470'', ''2600'', 1, ''01'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''470'', ''2620'', 1, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''471'', ''2600'', 1, ''01'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''471'', ''2620'', 1, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''472'', ''2600'', 1, ''01'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''472'', ''2620'', 1, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CL5'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CL5'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CL5'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''BM6'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''BM7'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''101'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''101'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''101'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''101'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''101'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''101'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''8V0'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''010'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''010'', ''2620'', 0, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''010'', ''2620'', 0, ''28'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''010'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''PKR'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''PKR'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DU0'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DU0'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''085'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DU5'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DU5'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DU5'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''DU5'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''K0G'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''MUC'', ''2620'', 1, ''05'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''MUN'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''MUO'', ''2620'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV3'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV3'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV3'', ''2600'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''CV3'', ''2650'', 1, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00G'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00G'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''011'', ''2620'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''067'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''01D'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''01D'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''BR1'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''BR1'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''BR3'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''BR3'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''01A'', ''2600'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''01A'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''03C'', ''2650'', 0, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into PS_TTS (ID, TT, NBS, DK, OB22)
values (s_ps_tts.nextval, ''00E'', ''2620'', 0, ''07'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 
begin
  for i in (select s_ps_tts.nextval id,
                   t.tt,
                   decode(t.nbs,
                          '2625',
                          '2620',
                          '2605',
                          '2600',
                          '2655',
                          '2650') nbs,
                   t.dk,
                   decode(t.nbs, '2625', '36', '2605', '14', '2655', '12') ob22
              from ps_tts t
             where t.nbs in (2625, 2605, 2655)
               and not exists (select 1
                      from ps_tts tt
                     where tt.tt = t.tt
                       and tt.nbs = decode(t.nbs,
                                           '2625',
                                           '2620',
                                           '2605',
                                           '2600',
                                           '2655',
                                           '2650')
                       and t.dk = tt.dk)) loop
    begin
      insert into ps_tts(id,
                         tt,
                         nbs,
                         dk,
                         ob22) values (i.id, i.tt,i.nbs, i.dk, i.ob22);
    exception 
      when others then null;
    end;
  end loop;
  commit;
end;
/             
