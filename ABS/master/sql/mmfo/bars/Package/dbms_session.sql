
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dbms_session.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DBMS_SESSION AUTHID CURRENT_USER is
  ------------
  --  OVERVIEW
  --
  --  This package provides access to SQL "alter session" statements, and
  --  other session information from, stored procedures.

  ----------------------------
  --  PROCEDURES AND FUNCTIONS
  --
  procedure set_role(role_cmd varchar2);
  --  Equivalent to SQL "SET ROLE ...".
  --  Input arguments:
  --    role_cmd
  --      This text is appended to "set role " and then executed as SQL.
  procedure set_sql_trace(sql_trace boolean);
  --  Equivalent to SQL "ALTER SESSION SET SQL_TRACE ..."
  --  Input arguments:
  --    sql_trace
  --      TRUE or FALSE.  Turns tracing on or off.
  procedure set_nls(param varchar2, value varchar2);
  --  Equivalent to SQL "ALTER SESSION SET <nls_parameter> = <value>"
  --  Input arguments:
  --    param
  --      The NLS parameter. The parameter name must begin with 'NLS'.
  --    value
  --      The value to set the parameter to.  If the parameter is a
  --      text literal then it will need embedded single-quotes.  For
  --      example "set_nls('nls_date_format','''DD-MON-YY''')"
  procedure close_database_link(dblink varchar2);
  --  Equivalent to SQL "ALTER SESSION CLOSE DATABASE LINK <name>"
  --  Input arguments:
  --    name
  --      The name of the database link to close.
  procedure reset_package;
  --  Deinstantiate all packages in this session.  In other words, free
  --    all package state.  This is the situation at the beginning of
  --    a session.

  --------------------------------------------------------------------
  --  action_flags (bit flags) for MODIFY_PACKAGE_STATE  procedure ---
  --------------------------------------------------------------------
  FREE_ALL_RESOURCES   constant PLS_INTEGER := 1;
  REINITIALIZE         constant PLS_INTEGER := 2;

  procedure modify_package_state(action_flags IN PLS_INTEGER);
  --  The MODIFY_PACKAGE_STATE procedure can be used to perform
  --  various actions (as specified by the 'action_flags' parameter)
  --  on the session state of ALL PL/SQL program units active in the
  --  session. This takes effect only after the PL/SQL call that
  --  made the current invokation finishes running.
  --
  --  Parameter(s):
  --   action_flags:
  --     Determines what action is taken on the program units.
  --     The following action_flags are supported:
  --
  --     * DBMS_SESSION.FREE_ALL_RESOURCES:
  --         This frees all the memory associated with each of the
  --         previously run PL/SQL programs from the session, and,
  --         consequently, clears the current values of any package
  --         globals and closes any cached cursors. On subsequent use,
  --         the PL/SQL program units are re-instantiated and package
  --         globals are reinitialized. This is essentially the
  --         same as DBMS_SESSION.RESET_PACKAGE() interface.
  --
  --     * DBMS_SESSION.REINITIALIZE:
  --         In terms of program semantics, the DBMS_SESSION.REINITIALIZE
  --         flag is similar to the DBMS_SESSION.FREE_ALL_RESOURCES flag
  --         in that both have the effect of re-initializing all packages.
  --
  --         However, DBMS_SESSION.REINITIALIZE should exhibit much better
  --         performance than the DBMS_SESSION.FREE_ALL_RESOURCES option
  --         because:
  --
  --           - packages are reinitialized without actually being freed
  --           and recreated from scratch. Instead the package memory gets
  --           reused.
  --
  --           - any open cursors are closed, semantically speaking. However,
  --           the cursor resource is not actually freed. It is simply
  --           returned to the PL/SQL cursor cache. And more importantly,
  --           the cursor cache is not flushed. Hence, cursors
  --           corresponding to frequently accessed static SQL in PL/SQL
  --           will remain cached in the PL/SQL cursor cache and the
  --           application will not incur the overhead of opening, parsing
  --           and closing a new cursor for those statements on subsequent use.
  --
  --           - the session memory for PL/SQL modules without global state
  --           (such as types, stored-procedures) will not be freed and
  --           recreated.
  --
  --
  --  Usage Example:
  --    begin
  --      dbms_session.modify_package_state(DBMS_SESSION.REINITIALIZE);
  --    end;
  --

  function unique_session_id return varchar2;
  pragma restrict_references(unique_session_id,WNDS,RNDS,WNPS);
  --  Return an identifier that is unique for all sessions currently
  --    connected to this database.  Multiple calls to this function
  --    during the same session will always return the same result.
  --  Output arguments:
  --    unique_session_id
  --      can return up to 24 bytes.
  function is_role_enabled(rolename varchar2) return boolean;
  --  Determine if the named role is enabled for this session.
  --  Input arguments:
  --    rolename
  --      Name of the role.
  --  Output arguments:
  --    is_role_enabled
  --      TRUE or FALSE depending on whether the role is enabled.
  function is_session_alive(uniqueid varchar2) return boolean;
  --  Determine if the specified session is alive.
  --  Input arguments:
  --    uniqueid
  --      Uniqueid of the session.
  --  Output arguments:
  --    is_session_alive
  --      TRUE or FALSE depending on whether the session is alive.
  procedure set_close_cached_open_cursors(close_cursors boolean);
  --  Equivalent to SQL "ALTER SESSION SET CLOSE_CACHED_OPEN_CURSORS ..."
  --  Input arguments:
  --    close_cursors
  --      TRUE or FALSE.  Turns close_cached_open_cursors on or off.
  procedure free_unused_user_memory;
  --  Procedure for users to reclaim unused memory after performing operations
  --  requiring large amounts of memory (where large is >100K).  Note that
  --  this procedure should only be used in cases where memory is at a
  --  premium.
  --
  --  Examples operations using lots of memory are:
  --
  --     o  large sorts where entire sort_area_size is used and
  --        sort_area_size is hundreds of KB
  --     o  compiling large PL/SQL packages/procedures/functions
  --     o  storing hundreds of KB of data within PL/SQL indexed tables
  --
  --  One can monitor user memory by tracking the statistics
  --  "session uga memory" and "session pga memory" in the
  --  v$sesstat/v$statname fixed views.  Monitoring these statistics will
  --  also show how much memory this procedure has freed.
  --
  --  The behavior of this procedure depends upon the configuration of the
  --  server operating on behalf of the client:
  --
  --     o  dedicated server - returns unused PGA memory and session memory
  --          to the OS (session memory is allocated from the PGA in this
  --          configuration)
  --     o  MTS server       - returns unused session memory to the
  --          shared_pool (session memory is allocated from the shared_pool
  --          in this configuration)
  --
  --  In order to free memory using this procedure, the memory must
  --  not be in use.
  --
  --  Once an operation allocates memory, only the same type of operation can
  --  reuse the allocated memory.  For example, once memory is allocated
  --  for sort, even if the sort is complete and the memory is no longer
  --  in use, only another sort can reuse the sort-allocated memory.  For
  --  both sort and compilation, after the operation is complete, the memory
  --  is no longer in use and the user can invoke this procedure to free the
  --  unused memory.
  --
  --  An indexed table implicitly allocates memory to store values assigned
  --  to the indexed table's elements.  Thus, the more elements in an indexed
  --  table, the more memory the RDBMS allocates to the indexed table.  As
  --  long as there are elements within the indexed table, the memory
  --  associated with an indexed table is in use.
  --
  --  The scope of indexed tables determines how long their memory is in use.
  --  Indexed tables declared globally are indexed tables declared in packages
  --  or package bodies.  They allocate memory from session memory.  For an
  --  indexed table declared globally, the memory will remain in use
  --  for the lifetime of a user's login (lifetime of a user's session),
  --  and is freed after the user disconnects from ORACLE.
  --
  --  Indexed tables declared locally are indexed tables declared within
  --  functions, procedures, or anonymous blocks.  These indexed tables
  --  allocate memory from PGA memory.  For an indexed table declared
  --  locally, the memory will remain in use for as long as the user is still
  --  executing the procedure, function, or anonymous block in which the
  --  indexed table is declared.  After the procedure, function, or anonymous
  --  block is finished executing, the memory is then available for other
  --  locally declared indexed tables to use (i.e., the memory is no longer
  --  in use).
  --
  --  Assigning an uninitialized, "empty," indexed table to an existing index
  --  table is a method to explicitly re-initialize the indexed table and the
  --  memory associated with the indexed table.  After this operation,
  --  the memory associated with the indexed table will no longer be in use,
  --  making it available to be freed by calling this procedure.  This method
  --  is particularly useful on indexed tables declared globally which can grow
  --  during the lifetime of a user's session, as long as the user no
  --  longer needs the contents of the indexed table.
  --
  --  The memory rules associated with an indexed table's scope still apply;
  --  this method and this procedure, however, allow users to
  --  intervene and to explictly free the memory associated with an
  --  indexed table.
  --
  --  The PL/SQL fragment below illustrates the method and the use
  --  of procedure free_unused_user_memory.
  --
  --  create package foobar
  --     type number_idx_tbl is table of number indexed by binary_integer;
  --
  --     store1_table  number_idx_tbl;     --  PL/SQL indexed table
  --     store2_table  number_idx_tbl;     --  PL/SQL indexed table
  --     store3_table  number_idx_tbl;     --  PL/SQL indexed table
  --     ...
  --  end;            --  end of foobar
  --
  --  declare
  --     ...
  --     empty_table   number_idx_tbl;     --  uninitialized ("empty") version
  --
  --  begin
  --     for i in 1..1000000 loop
  --       store1_table(i) := i;           --  load data
  --     end loop;
  --     ...
  --     store1_table := empty_table;      --  "truncate" the indexed table
  --     ...
  --     -
  --     dbms_session.free_unused_user_memory;  -- give memory back to system
  --
  --     store1_table(1) := 100;           --  index tables still declared;
  --     store2_table(2) := 200;           --  but truncated.
  --     ...
  --  end;
  --
  --  Performance Implication:
  --     This routine should be used infrequently and judiciously.
  --
  --  Input arguments:
  --     n/a
  procedure set_context(namespace varchar2, attribute varchar2, value varchar2, username varchar2 default null, client_id varchar2 default null);
  --  Input arguments:
  --    namespace
  --      Name of the namespace to use for the application context
  --    attribute
  --      Name of the attribute to be set
  --    value
  --      Value to be set
  --    username
  --      username attribute for application context . default value is null.
  --    client_id
  --      client identifier that identifies a user session for which we need
  --      to set this context.
  --
  --
  procedure clear_context(namespace varchar2 ,client_id varchar2 , attribute varchar2 default null );
  -- Input parameters:
  --   namespace
  --     namespace where the application context is to be cleared
  --   client_id
  --      all ns contexts associated with this client id are cleared.
  --   attribute
  --     attribute to clear .
  --
  procedure list_context(list OUT sys.dbms_session.AppCtxTabTyp, lsize OUT number);
  --  Input arguments:
  --    list
  --      buffer to store a list of application context set in current
  --      session
  --  Output arguments:
  --    list
  --      contains a list of of (namespace,attribute,values) set in current
  --      session
  --    size
  --      returns the number of entries in the buffer returned
  procedure switch_current_consumer_group(new_consumer_group IN VARCHAR2,
                                          old_consumer_group OUT VARCHAR2,
					  initial_group_on_error IN BOOLEAN);
  -- Input arguments:
  -- new_consumer_group
  --    name of consumer group to switch to
  -- old_consumer_group
  --    name of the consumer group just switched out from
  -- initial_group_on_error
  --   If TRUE, sets the current consumer group of the invoker to his/her
  --   initial consumer group in the event of an error.
  --
end;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.DBMS_SESSION is

  procedure set_role(role_cmd varchar2) is
  begin
    sys.dbms_session.set_role(role_cmd);
  end;

  procedure set_sql_trace(sql_trace boolean) is
  begin
    sys.dbms_session.set_sql_trace(sql_trace);
  end;

  procedure set_nls(param varchar2, value varchar2) is
  begin
    sys.dbms_session.set_nls(param, value);
  end;

  procedure close_database_link(dblink varchar2) is
  begin
    sys.dbms_session.close_database_link(dblink);
  end;

  procedure reset_package is
  begin
    sys.dbms_session.reset_package;
  end;

  procedure modify_package_state(action_flags IN PLS_INTEGER) is
  begin
    sys.dbms_session.modify_package_state(action_flags);
  end;

  function unique_session_id return varchar2 is
  begin
    return sys.dbms_session.unique_session_id;
  end;

  function is_role_enabled(rolename varchar2) return boolean is
  begin
    return sys.dbms_session.is_role_enabled(rolename);
  end;

  function is_session_alive(uniqueid varchar2) return boolean is
  begin
    return sys.dbms_session.is_session_alive(uniqueid);
  end;

  procedure set_close_cached_open_cursors(close_cursors boolean) is
  begin
    sys.dbms_session.set_close_cached_open_cursors(close_cursors);
  end;

  procedure free_unused_user_memory is
  begin
    sys.dbms_session.free_unused_user_memory;
  end;

  procedure set_context(namespace varchar2, attribute varchar2, value varchar2, username varchar2 default null, client_id varchar2 default null) is
  begin
    sys.dbms_session.set_context(namespace, attribute, value, username, client_id);
  end;

  procedure clear_context(namespace varchar2, client_id varchar2, attribute varchar2 default null ) is
  begin
    sys.dbms_session.clear_context(namespace, client_id, attribute);
  end;

  procedure list_context(list OUT sys.dbms_session.AppCtxTabTyp, lsize OUT number) is
  begin
    sys.dbms_session.list_context(list, lsize);
  end;

  procedure switch_current_consumer_group(new_consumer_group IN VARCHAR2,
                                          old_consumer_group OUT VARCHAR2,
					  initial_group_on_error IN BOOLEAN) is
  begin
    sys.dbms_session.switch_current_consumer_group(new_consumer_group, old_consumer_group, initial_group_on_error);
  end;

end;
/
 show err;
 
PROMPT *** Create  grants  DBMS_SESSION ***
grant EXECUTE                                                                on DBMS_SESSION    to ABS_ADMIN;
grant EXECUTE                                                                on DBMS_SESSION    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DBMS_SESSION    to PUBLIC;
grant EXECUTE                                                                on DBMS_SESSION    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dbms_session.sql =========*** End **
 PROMPT ===================================================================================== 
 