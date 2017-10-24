

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/LDAP_SEARCH_EXAMPLE_PROC.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure LDAP_SEARCH_EXAMPLE_PROC ***

  CREATE OR REPLACE PROCEDURE BARS.LDAP_SEARCH_EXAMPLE_PROC IS

/******************************************************************************
    NAME:       LDAP_SEARCH_EXAMPLE_PROC
    PURPOSE:

    REVISIONS:
    Ver        Date        Author           Description
    ---------  ----------  ---------------  ------------------------------------
    1.0        8/15/2012   jhunter          Created initial procedure.

    NOTE:
    Starting with Oracle Database 11g Release 2 (11.2.0.2), a network ACL for
    external network services will need to be created when binding to an LDAP
    server using DBMS_LDAP. This is part of Oracle's "Fine-Grained Access to
    External Network Services" which was introduced in Oracle Database 11g
    Release 1.

******************************************************************************/

    ldap_host       VARCHAR2(512);          -- The LDAP Directory Host
    ldap_port       VARCHAR2(512);          -- The LDAP Directory Port
    ldap_user       VARCHAR2(512);          -- The LDAP Directory User
    ldap_passwd     VARCHAR2(512);          -- The LDAP Directory Password
    ldap_baseDN     VARCHAR2(512);          -- The starting (base) DN
    retval          PLS_INTEGER;            -- Used for all API return values.
    my_session      DBMS_LDAP.SESSION;      -- Used to store our LDAP Session
    res_attrs       DBMS_LDAP.STRING_COLLECTION;    -- A String Collection used
                                                    --   to specify which
                                                    --   attributes to return
                                                    --   from the search.
    search_filter   VARCHAR2(512);          -- A simple character string used to
                                            --   store the filter (criteria) for
                                            --   the search.
    res_message     DBMS_LDAP.MESSAGE;      -- Used to store the message
                                            --   (results) of the search.
    temp_entry      DBMS_LDAP.MESSAGE;      -- Used to store entries retrieved
                                            --   from the LDAP search to print
                                            --   out at a later time.
    entry_index     PLS_INTEGER;            -- Used as a counter while looping
                                            --   through each entry. As we
                                            --   retrieve an entry from the LDAP
                                            --   directory, we increase the
                                            --   counter by one.
    temp_dn         VARCHAR2(512);          -- After each entry is retrieved
                                            --   from the LDAP directory (from
                                            --   the search), we want to use
                                            --   this variable to extract, store
                                            --   and print out the DN for each
                                            --   entry.
    temp_attr_name  VARCHAR2(512);          -- After retrieving an entry from
                                            --   LDAP directory, we will want to
                                            --   walk through all of the
                                            --   returned attributes. This
                                            --   variable will be used to store
                                            --   each attribute name as we loop
                                            --   through them.
    temp_ber_elmt   DBMS_LDAP.BER_ELEMENT;
    attr_index      PLS_INTEGER;            -- Used as a counter variable for
                                            --   each entry returned for each
                                            --   entry.
    temp_vals       DBMS_LDAP.STRING_COLLECTION;    -- Used to extract, store,
                                                    --   and print each of the
                                                    --   values from each
                                                    --   attribute.

BEGIN

    DBMS_OUTPUT.ENABLE(1000000);

    retval := -1;

    -- -------------------------------------------------------------------------
    -- Customize the following variables as needed.
    -- -------------------------------------------------------------------------
    ldap_host    := '';
    ldap_port    := '389';
    ldap_user    := 'YurchenkoArtemV';
    ldap_passwd  := 'zzz';
    ldap_baseDN  := 'dc=oschadbank,dc=ua';

    -- -------------------------------------------------------------------------
    -- Print out variables.
    -- -------------------------------------------------------------------------
    DBMS_OUTPUT.PUT_LINE('DBMS_LDAP Search Example');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE(RPAD('LDAP Host ', 25, ' ') || ': ' || ldap_host);
    DBMS_OUTPUT.PUT_LINE(RPAD('LDAP Port ', 25, ' ') || ': ' || ldap_port);
    DBMS_OUTPUT.PUT_LINE(RPAD('LDAP User ', 25, ' ') || ': ' || ldap_user);
    DBMS_OUTPUT.PUT_LINE(RPAD('LDAP Base ', 25, ' ') || ': ' || ldap_baseDN);

    -- -------------------------------------------------------------------------
    -- We want all exceptions from DBMS_LDAP to be raised.
    -- -------------------------------------------------------------------------
    DBMS_LDAP.USE_EXCEPTION := TRUE;

    -- -------------------------------------------------------------------------
    -- Obtain an LDAP session. The init() function initializes a session with an
    -- LDAP server. This actually establishes a connection with the LDAP server
    -- and returns a handle to the session which can be used for further
    -- calls into the API.
    -- -------------------------------------------------------------------------
    my_session := DBMS_LDAP.INIT(ldap_host, ldap_port);

    DBMS_OUTPUT.PUT_LINE (
        RPAD('LDAP Session ', 25, ' ') || ': ' ||
        RAWTOHEX(SUBSTR(my_session, 1, 16)) ||
        ' - (returned from init)'
    );

    -- -------------------------------------------------------------------------
    -- Bind to the directory. The function simple_bind_s can be used to perform
    -- simple username/password based authentication to the directory server.
    -- The username is a directory distinguished name. This function can be
    -- called only after a valid LDAP session handle is obtained from a call to
    -- DBMS_LDAP.init(). If the connection was successful, it will return:
    -- DBMS_LDAP.SUCCESS. This function can raise the following exceptions:
    --      invalid_session : Raised if the session handle ld is invalid.
    --      general_error   : For all other errors. The error string associated
    --                        with this exception will explain the error in
    --                        detail.
    -- -------------------------------------------------------------------------
    retval := DBMS_LDAP.SIMPLE_BIND_S(my_session, ldap_user, ldap_passwd);

    DBMS_OUTPUT.PUT_LINE(
        RPAD('simple_bind_s Returned ', 25, ' ') || ': '|| TO_CHAR(retval)
    );

    -- -------------------------------------------------------------------------
    -- Before actually performing the sort, I want to setup the attributes I
    -- would like returned. To do this, I declared a "String Collection" that
    -- will be used to store all of the attributes I would like returned.
    --
    --      If I wanted to return all attributes, I would specify:
    --          res_attrs(1) := '*';
    --
    --      If I wanted multiple (specified) attributes, I would specify:
    --          res_attrs(1) := 'cn';
    --          res_attrs(2) := 'loginShell';
    -- -------------------------------------------------------------------------
/*
    res_attrs(1) := 'uid';
    res_attrs(2) := 'cn';
    res_attrs(3) := 'loginShell';
*/
    res_attrs(1) := '*';
    -- -------------------------------------------------------------------------
    -- Finally, before performing the actual search, I want to specify the
    -- criteria I want to search on. This will be passed as the "filter"
    -- parameter to the actual search.
    --
    --      If you wanted all of the entries in the directory to be returned,
    --      you could simply specify:
    --          search_filter   := 'objectclass=*';
    --
    --      You could also refine your search my specify a criteria like the
    --      following:
    --          search_filter   := 'cn=*Hunter*';
    -- -------------------------------------------------------------------------
    search_filter   := '(|(userPrincipalName=artem.iurchenko@unity-bars.com.ua)(cn=public))';

    -- -------------------------------------------------------------------------
    -- Finally, let's issue the search. The function search_s performs a
    -- synchronous search in the LDAP server. It returns control to the PL/SQL
    -- environment only after all of the search results have been sent by the
    -- server or if the search request is 'timed-out' by the server.
    --
    -- Let's first explain some of the incoming parameters:
    --      ld       : A valid LDAP session handle.
    --      base     : The dn of the entry at which to start the search.
    --      scope    : One of SCOPE_BASE     (0x00)
    --                        SCOPE_ONELEVEL (0x01)
    --                        SCOPE_SUBTREE  (0x02)
    --                 indicating the scope of the search.
    --      filter   : A character string representing the search filter. The
    --                 value NULL can be passed to indicate that the filter
    --                 "(objectclass=*)" which matches all entries is to be
    --                 used.
    --      attrs    : A collection of strings indicating which attributes to
    --                 return for each matching entry. Passing NULL for this
    --                 parameter causes all available user attributes to be
    --                 retrieved. The special constant string NO_ATTRS ("1.1")
    --                 MAY be used as the only string in the array to indicate
    --                 that no attribute types are to be returned by the server.
    --                 The special constant string ALL_USER_ATTRS ("*") can be
    --                 used in the attrs array along with the names of some
    --                 operational attributes to indicate that all user
    --                 attributes plus the listed operational attributes are to
    --                 be returned.
    --      attronly : A boolean value that MUST be zero if both attribute types
    --                 and values are to be returned, and non-zero if only types
    --                 are wanted.
    --      res      : This is a result parameter which will contain the results
    --                 of the search upon completion of the call. If no results
    --                 are returned, res is set to NULL.
    --
    -- Now let's look at the two output parameters:
    --      PLS_INTEGER
    --      (function return)   : DBMS_LDAP.SUCCESS if the search operation
    --                            succeeded. An exception is raised in all other
    --                            cases.
    --      res (OUT parameter) : If the search succeeded and there are entries,
    --                            this parameter is set to a NON-NULL value
    --                            which can be used to iterate through the
    --                            result set.
    -- -------------------------------------------------------------------------
    retval := DBMS_LDAP.SEARCH_S(
          ld         =>  my_session
        , base       =>  ldap_baseDN
        , scope      =>  DBMS_LDAP.SCOPE_SUBTREE
        , filter     =>  search_filter
        , attrs      =>  res_attrs
        , attronly   =>  0
        , res        =>  res_message
    );

    DBMS_OUTPUT.PUT_LINE(
        RPAD('search_s Returned ', 25, ' ') || ': ' || TO_CHAR(retval)
    );
    DBMS_OUTPUT.PUT_LINE (
        RPAD('LDAP Message ', 25, ' ') || ': ' ||
        RAWTOHEX(SUBSTR(res_message, 1, 16)) ||
        ' - (returned from search_s)'
    );

    -- -------------------------------------------------------------------------
    -- After the search is performed, the API stores the count of the number of
    -- entries returned.
    -- -------------------------------------------------------------------------
    retval := DBMS_LDAP.COUNT_ENTRIES(my_session, res_message);
    DBMS_OUTPUT.PUT_LINE(
        RPAD('Number of Entries ', 25, ' ') || ': ' || TO_CHAR(retval)
    );
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------');


    -- -------------------------------------------------------------------------
    -- Retrieve the first entry.
    -- -------------------------------------------------------------------------
    temp_entry := DBMS_LDAP.FIRST_ENTRY(my_session, res_message);
    entry_index := 1;

    -- -------------------------------------------------------------------------
    -- Loop through each of the entries one by one.
    -- -------------------------------------------------------------------------
    WHILE temp_entry IS NOT NULL LOOP

        -- ---------------------------------------------------------------------
        -- Print out the current entry.
        -- ---------------------------------------------------------------------
        temp_dn := DBMS_LDAP.GET_DN(my_session, temp_entry);
        DBMS_OUTPUT.PUT_LINE (' dn: ' || temp_dn);

        temp_attr_name := DBMS_LDAP.FIRST_ATTRIBUTE(
              my_session
            , temp_entry
            , temp_ber_elmt
        );
        attr_index := 1;
        WHILE temp_attr_name IS NOT NULL LOOP

            temp_vals := DBMS_LDAP.GET_VALUES(my_session, temp_entry, temp_attr_name);
            IF temp_vals.COUNT > 0 THEN
                FOR i IN temp_vals.FIRST..temp_vals.LAST LOOP
                    DBMS_OUTPUT.PUT_LINE(
                        RPAD('   ' || temp_attr_name, 25, ' ') ||
                        ': ' || SUBSTR(temp_vals(i), 1, 200)
                    );
                END LOOP;
            END IF;
            temp_attr_name := DBMS_LDAP.NEXT_ATTRIBUTE(   my_session
                                                        , temp_entry
                                                        , temp_ber_elmt);
            attr_index := attr_index + 1;

        END LOOP;

        temp_entry := DBMS_LDAP.NEXT_ENTRY(my_session, temp_entry);
        DBMS_OUTPUT.PUT_LINE('=======================================================================');
        entry_index := entry_index + 1;
    END LOOP;

    -- -------------------------------------------------------------------------
    -- Unbind from the directory
    -- -------------------------------------------------------------------------
    retval := DBMS_LDAP.UNBIND_S(my_session);
    DBMS_OUTPUT.PUT_LINE(RPAD(
        'unbind_res Returned ', 25, ' ') || ': ' ||
        TO_CHAR(retval)
    );

    -- -------------------------------------------------------------------------
    -- Handle Exceptions
    -- -------------------------------------------------------------------------
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE('Exception Encountered');
            DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE('  Error code    : ' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('  Error code    : ' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('  Error Message : ' || SQLERRM);
            DBMS_OUTPUT.PUT_LINE('  Exiting.');

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/LDAP_SEARCH_EXAMPLE_PROC.sql =====
PROMPT ===================================================================================== 
