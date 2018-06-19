declare     l_type int := 39;   l_App varchar2(15) := '$RM_METO';   l_rw varchar2(5) := 'RW' ; l_name varchar2(15) := 'MSFZ-9';
 procedure ADD1 (l_Tabname varchar2 ) is   l_tabid int := bars_metabase.get_tabid(l_Tabname);
 begin
   update TYPEREF    set name =l_name where type =l_type ;                   IF SQL%ROWCOUNT=0 THEN Insert into TYPEREF      (name , type)                  values (l_name ,l_type);       end if ;
   update REFERENCES set type =l_type where tabid=l_tabid;                   IF SQL%ROWCOUNT=0 THEN Insert into REFERENCES   (TABID, TYPE)                  Values (l_tabid,l_type);       end if ;
   update REFERENCES set type =l_type where tabid=l_tabid;                   IF SQL%ROWCOUNT=0 THEN Insert into REFERENCES   (TABID, TYPE)                  Values (l_tabid,l_type);       end if ;
   update REFapp     set acode=l_rw   where tabid=l_tabid and codeapp=l_app; IF SQL%ROWCOUNT=0 THEN Insert into REFAPP(TABID,CODEAPP,ACODE,APPROVE,REVOKED) values (l_tabid,l_APP,l_RW,1,0); end if ;
 end ;
   -------------------------------
begin
    SELECT CODEAPP INTO l_App FROM APPLIST WHERE CODEAPP LIKE '%METO%'  ;

    ADD1 ( l_Tabname => 'BUS_MOD'       );  --
    ADD1 ( l_Tabname => 'IFRS'          );  --
    ADD1 ( l_Tabname => 'SPPI'          );
    ADD1 ( l_Tabname => 'K9'            ); --
    ADD1 ( l_Tabname => 'CCK_OB22'      );
    ADD1 ( l_Tabname => 'CCK_OB22_9'    );
    ADD1 ( l_Tabname => 'RECLASS9');
    ADD1 ( l_Tabname => 'NBS_SS_SD');
    ADD1 ( l_Tabname => 'RECLASS9_SPEC');
end;
/
commit;
-----------
