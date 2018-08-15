prompt grants to BARSOS (file system)

begin
/* minimum grants: UPLD, ARCD dirs */
    dbms_java.grant_permission( 'BARSOS', 'SYS:java.io.FilePermission', '<<ALL FILES>>', 'execute' );
    dbms_java.grant_permission( 'BARSOS', 'SYS:java.io.FilePermission', '<<ALL FILES>>', 'read' );
    dbms_java.grant_permission( 'BARSOS', 'SYS:java.io.FilePermission', '<<ALL FILES>>', 'write' );
    dbms_java.grant_permission( 'BARSOS', 'SYS:java.io.FilePermission', '<<ALL FILES>>', 'delete' );
end;
/


