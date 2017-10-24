CREATE OR REPLACE PROCEDURE MGW_AGENT.omg_notify(
  context  IN  RAW,
  reginfo  IN  SYS.AQ$_REG_INFO,
  descr    IN  SYS.AQ$_DESCRIPTOR,
  payload  IN  RAW,
  payloadl IN  NUMBER)
is
-- version 2.1  12/05/2017
  l_queue_name_val varchar2(100);
  l_dequeue_options dbms_aq.DEQUEUE_OPTIONS_T;
  l_buf_size constant binary_integer := 10;
  l_msgs sys.aq$_jms_text_messages;
  l_msg_props DBMS_AQ.message_properties_array_t;
  l_msg_ids DBMS_AQ.msgid_array_t;
  l_retval PLS_INTEGER;
  l_clob clob;
  l_msgid raw(16);
  l_ori_msgid varchar2(64);
  l_text varchar2(4000);
  l_recid number;
  no_messages           exception;
  pragma exception_init (no_messages, -25228);
begin
  l_queue_name_val := 'MGW_AGENT.OMG_IN_QUEUE';
  l_dequeue_options.wait :=  dbms_aq.NO_WAIT;
  l_dequeue_options.dequeue_mode := DBMS_AQ.REMOVE;

  insert into mgw_agent.deq_data(msg) values ('omg_notify: dequeue messages...');

  l_retval := DBMS_AQ.DEQUEUE_ARRAY(
   queue_name               => l_queue_name_val,
   dequeue_options          => l_dequeue_options,
   array_size               => l_buf_size,
   message_properties_array => l_msg_props,
   payload_array            => l_msgs,
   msgid_array              => l_msg_ids);

  for i in 1..l_retval loop
    begin
      savepoint s;
      l_msgs(i).get_text(l_clob);
      l_msgid := l_msg_ids(i);
      l_ori_msgid := l_msgs(i).get_string_property('OracleMGW_OriginalMessageID');
      mgw_agent.omg_enqueue_str(bars.mway_mgr.get_response(l_clob), l_ori_msgid);
      l_text := l_ori_msgid || ' enqueuing...';
      insert into mgw_agent.deq_data(msg) values ('omg_notify: '||l_text);
    exception when others then
      rollback to savepoint s;
      insert into mgw_agent.deq_data(msg) values('omg_notify: '||chr(13)||chr(10)||dbms_utility.format_error_stack()||chr(10)|| dbms_utility.format_error_backtrace());
    end;
  end loop;
  insert into mgw_agent.deq_data(msg) values ('omg_notify: '||l_retval||' records handled');
  commit work;
exception
  when no_messages then
    commit work;
  when others then
    l_text := sqlerrm;
    --insert into mgw_agent.deq_data(msg) values ('omg_notify: '||l_text);
    insert into mgw_agent.deq_data (msg) values ('omg_notify: ' || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace());
    commit work;
end;
/
